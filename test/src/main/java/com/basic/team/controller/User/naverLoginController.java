package com.basic.team.controller.User;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigInteger;
import java.net.URLEncoder;
import java.security.SecureRandom;

import com.basic.team.controller.frontController.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class naverLoginController implements Controller {

	@Override
	public String requestHandler(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		System.out.println("여기 => naverLogin");
		
		String clientId = "XgSWLhZ3ruY679duMXeW";//애플리케이션 클라이언트 아이디값";
	    String redirectURI = URLEncoder.encode("http://localhost:8080/test/naverCallback.do", "UTF-8");
	    SecureRandom random = new SecureRandom();
	    String state = new BigInteger(130, random).toString();
	    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code"
	         + "&client_id=" + clientId
	         + "&redirect_uri=" + redirectURI
	         + "&state=" + state;
	    HttpSession session = req.getSession();
	    session.setAttribute("state", state);
	    
//	    try {
//	    	System.out.println("들어옴?");
//	        res.setContentType("text/html; charset=utf-8");
//	        PrintWriter w = res.getWriter();
//	        w.write("<script>location.href='<%=apiURL%>';</script>");
//	        w.flush();
//	        w.close();
//	    } catch(Exception e) {
//	        e.printStackTrace();
//	    }
	    res.getWriter().print(apiURL);
		return null;
	}

}
