package com.basic.team.controller.User;

import java.io.IOException;

import com.basic.team.controller.frontController.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class userLogOutController implements Controller {

	@Override
	public String requestHandler(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String ctx = req.getContextPath();
		System.out.println("1111");
		
		HttpSession session = req.getSession();
		session.removeAttribute("user");
		
		return "redirect:" + ctx + "/main.do";
	}

}
