package com.basic.team.controller.User;

import java.io.IOException;

import com.basic.team.DAO.UserDAO;
import com.basic.team.VO.User;
import com.basic.team.controller.frontController.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class userContentController implements Controller {

	@Override
	public String requestHandler(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		
		int log = -1;
		log = (int) session.getAttribute("no");
		
		if(log == -1) {
			req.removeAttribute("center");
			return "main";
		}
		
		User user = UserDAO.getInstance().getOneUser(log);
		System.out.println(user);
		req.setAttribute("user", user);
		return "user/userContent";
		
//		req.setAttribute("center", "user/userInfo");
	}

}
