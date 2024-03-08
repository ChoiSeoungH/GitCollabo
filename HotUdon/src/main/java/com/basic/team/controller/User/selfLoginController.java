package com.basic.team.controller.User;

import java.io.IOException;

import com.basic.team.DAO.UserDAO;
import com.basic.team.VO.User;
import com.basic.team.controller.frontController.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class selfLoginController implements Controller {

	@Override
	public String requestHandler(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		
		if (req.getParameter("id") == null) {
			return "user/selfLogin";
		}
		
		String ctx = req.getContextPath();
		String id = req.getParameter("id");
		String pw = req.getParameter("pw");
		User user = UserDAO.getInstance().checkLogin(id, pw);
		System.out.println(user);
		
		if (user == null) {
			return "redirect:" + ctx + "/main.do";
		} else {
			user.setRegDate(user.getRegDate().substring(0,10));
			HttpSession session = req.getSession();
			session.setAttribute("user", user);
//			return "redirect:" + ctx + "/main.do";
			return "Main";
		}
	}

}
