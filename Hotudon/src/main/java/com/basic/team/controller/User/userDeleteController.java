package com.basic.team.controller.User;

import java.io.IOException;

import com.basic.team.controller.frontController.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class userDeleteController implements Controller {

	@Override
	public String requestHandler(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		String pw = req.getParameter("pw");
		if(pw == null || pw == "SNSPw") {
			
		}
		
		return null;
	}

}
