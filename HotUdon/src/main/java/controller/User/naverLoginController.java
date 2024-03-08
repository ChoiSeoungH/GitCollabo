package controller.User;

import frontcontorller.Controller;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigInteger;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.security.SecureRandom;

public class naverLoginController implements Controller {

  @Override
  public String requestHandler(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

    String clientId = "XgSWLhZ3ruY679duMXeW";//애플리케이션 클라이언트 아이디값";
    String redirectURI = URLEncoder.encode("http://localhost:8080/Hotudon/naverCallback.do", "UTF-8");
    SecureRandom random = new SecureRandom();
    String state = new BigInteger(130, random).toString();
    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code"
        + "&client_id=" + clientId
        + "&redirect_uri=" + redirectURI
        + "&state=" + state;
    HttpSession session = req.getSession();
    session.setAttribute("state", state);

    res.getWriter().print(apiURL);
    return null;
  }

}
