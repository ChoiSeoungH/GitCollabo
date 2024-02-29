package controller.search;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;


import com.fasterxml.jackson.databind.ObjectMapper;
import frontcontorller.Controller;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class NaverSerach implements Controller {

	@Override
	public String requestHandler(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
	    String clientId = "13_wgGKv5DSSkXmuqLvJ"; //애플리케이션 클라이언트 아이디
	    String clientSecret = "7NDxx6guwd"; //애플리케이션 클라이언트 시크릿
	    String ctx = request.getContextPath();
	    // 쿼리 파라미터에서 검색어 가져오기
	    String text = request.getParameter("query");
	    if (text != null && !text.isEmpty()) {
	      text = URLEncoder.encode(text, "UTF-8");
	    } else {
	      response.getWriter().write("검색어를 입력해주세요.");
	      return "redirect:"+ctx+"/main.do";  
	    }

	    String apiURL = "https://openapi.naver.com/v1/datalab/shop?query=" + text +"&display=5" + "&sort=dsc"; // JSON 결과

	    Map<String, String> requestHeaders = new HashMap<>();
	    requestHeaders.put("X-Naver-Client-Id", clientId);
	    requestHeaders.put("X-Naver-Client-Secret", clientSecret);
	    String responseBody = get(apiURL, requestHeaders); // ApiExamSearchBlog.get 메소드 활용

	    response.setContentType("text/html;charset=UTF-8");
	    response.getWriter().write(responseBody); // API 응답 결과 출력
	    System.out.println(responseBody);
	    ObjectMapper objectMapper = new ObjectMapper();
	    try {
	    	 Map<String, Object> responseMap = objectMapper.readValue(responseBody, Map.class);
	            System.out.println(responseMap);
	    }catch(IOException e){
	    	throw new RuntimeException("Failed to parse JSON response", e);
	    }
	    
	    
	    return "/main.do";    
	  }
	
	  private static String get(String apiUrl, Map<String, String> requestHeaders){
	    HttpURLConnection con = connect(apiUrl);
	    try {
	      con.setRequestMethod("GET");
	      for(Map.Entry<String, String> header :requestHeaders.entrySet()) {
	        con.setRequestProperty(header.getKey(), header.getValue());
	      }


	      int responseCode = con.getResponseCode();
	      if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
	        return readBody(con.getInputStream());
	      } else { // 오류 발생
	        return readBody(con.getErrorStream());
	      }
	    } catch (IOException e) {
	      throw new RuntimeException("API 요청과 응답 실패", e);
	    } finally {
	      con.disconnect();
	    }
	  }
	  private static HttpURLConnection connect(String apiUrl){
	    try {
	      URL url = new URL(apiUrl);
	      return (HttpURLConnection)url.openConnection();
	    } catch (MalformedURLException e) {
	      throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
	    } catch (IOException e) {
	      throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
	    }
	  }


	  private static String readBody(InputStream body){
	    InputStreamReader streamReader = new InputStreamReader(body);


	    try (BufferedReader lineReader = new BufferedReader(streamReader)) {
	      StringBuilder responseBody = new StringBuilder();


	      String line;
	      while ((line = lineReader.readLine()) != null) {
	        responseBody.append(line);
	      }


	      return responseBody.toString();
	    } catch (IOException e) {
	      throw new RuntimeException("API 응답을 읽는 데 실패했습니다.", e);
	    }
	  }
	}