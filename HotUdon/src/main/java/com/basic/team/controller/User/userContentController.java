package com.basic.team.controller.User;

import java.io.IOException;

import com.basic.team.DAO.UserDAO;
import com.basic.team.VO.User;
import com.basic.team.controller.frontController.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class userContentController implements Controller {

	@Override
	public String requestHandler(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		int no = -1;
		
		no = Integer.parseInt(req.getParameter("no"));
		
		if(no == -1) {
			req.removeAttribute("center");
			return "main";
		}
		
		User user = UserDAO.getInstance().getOneUser(no);
		System.out.println(user);
		
		req.setAttribute("user", user);
		return "user/userContent";
		
//		req.setAttribute("center", "user/userInfo");
	}

}
