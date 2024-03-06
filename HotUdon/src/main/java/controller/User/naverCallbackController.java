package controller.User;

import dao.UserDAO;
import frontcontorller.Controller;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import vo.User;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

public class naverCallbackController implements Controller {

  public static void setToken(String Atoken, HttpServletRequest req) throws UnsupportedEncodingException {

    String token = Atoken; // 네이버 로그인 접근 토큰;
    String header = "Bearer " + token; // Bearer 다음에 공백 추가

    String apiURL = "https://openapi.naver.com/v1/nid/me";

    Map<String, String> requestHeaders = new HashMap<>();
    requestHeaders.put("Authorization", header);
    String responseBody = get(apiURL, requestHeaders);


    System.out.println("body=" + responseBody);

    JSONParser parser = new JSONParser();
    JSONObject jsonResponse = null;

    try {
      jsonResponse = (JSONObject) parser.parse(responseBody);
    } catch (ParseException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }

    System.out.println("json= " + jsonResponse.toString());
    Map<String, String> response = (Map) jsonResponse.get("response");


    System.out.println(response);
    String id = response.get("id");
    String pw = "SNSPw";
    String name = response.get("name");
    String phone = response.get("mobile");
    String nickname = response.get("nickname");

    User user = UserDAO.getInstance().checkLogin(id, pw);

    System.out.println(user);

    if (user == null) {
      User u = new User(id, pw, name, phone, nickname);

      int cnt = UserDAO.getInstance().userInsert(u);
      if (cnt == 0) {
//				req.setAttribute("center", "user/join");
      }
    }

    user.setRegDate(user.getRegDate().substring(0, 10));
    HttpSession session = req.getSession();
    session.setAttribute("user", user);
  }

  private static String get(String apiUrl, Map<String, String> requestHeaders) {
    HttpURLConnection con = connect(apiUrl);
    try {
      con.setRequestMethod("GET");
      for (Map.Entry<String, String> header : requestHeaders.entrySet()) {
        con.setRequestProperty(header.getKey(), header.getValue());
      }


      int responseCode = con.getResponseCode();
      if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
        return readBody(con.getInputStream());
      } else { // 에러 발생
        return readBody(con.getErrorStream());
      }
    } catch (IOException e) {
      throw new RuntimeException("API 요청과 응답 실패", e);
    } finally {
      con.disconnect();
    }
  }

  private static HttpURLConnection connect(String apiUrl) {
    try {
      URL url = new URL(apiUrl);
      return (HttpURLConnection) url.openConnection();
    } catch (MalformedURLException e) {
      throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
    } catch (IOException e) {
      throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
    }
  }

  private static String readBody(InputStream body) {
    InputStreamReader streamReader = new InputStreamReader(body);


    try (BufferedReader lineReader = new BufferedReader(streamReader)) {
      StringBuilder responseBody = new StringBuilder();


      String line;
      while ((line = lineReader.readLine()) != null) {
        responseBody.append(line);
      }


      return responseBody.toString();
    } catch (IOException e) {
      throw new RuntimeException("API 응답을 읽는데 실패했습니다.", e);
    }
  }

  @Override
  public String requestHandler(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

    String clientId = "XgSWLhZ3ruY679duMXeW";//애플리케이션 클라이언트 아이디값";
    String clientSecret = "sBfEH5az6y";//애플리케이션 클라이언트 시크릿값";
    String code = req.getParameter("code");
    String state = req.getParameter("state");
    String redirectURI = URLEncoder.encode("http://localhost:8080/Hotudon/naverCallback.do", StandardCharsets.UTF_8);
    String apiURL;
    apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
    apiURL += "client_id=" + clientId;
    apiURL += "&client_secret=" + clientSecret;
    apiURL += "&redirect_uri=" + redirectURI;
    apiURL += "&code=" + code;
    apiURL += "&state=" + state;
    String access_token = "";
    String refresh_token = "";
    System.out.println("apiURL=" + apiURL);
    try {
      URL url = new URL(apiURL);
      HttpURLConnection con = (HttpURLConnection) url.openConnection();
      con.setRequestMethod("GET");
      int responseCode = con.getResponseCode();
      BufferedReader br;
      System.out.println("responseCode=" + responseCode);
      if (responseCode == 200) { // 정상 호출
        br = new BufferedReader(new InputStreamReader(con.getInputStream()));
      } else {  // 에러 발생
        br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
      }
      String inputLine;
      StringBuffer resp = new StringBuffer();
      while ((inputLine = br.readLine()) != null) {
        resp.append(inputLine);
      }
      br.close();
      if (responseCode == 200) {
        System.out.println(resp);

        String[] temp1 = resp.toString().split(",");
        String[] temp2 = temp1[0].split(":");
        String token = temp2[1];

        setToken(token, req);

      }
    } catch (Exception e) {
      System.out.println(e);
    }

    return "user/MyPage";
  }
}
