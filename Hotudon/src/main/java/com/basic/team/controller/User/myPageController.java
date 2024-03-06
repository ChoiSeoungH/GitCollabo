package com.basic.team.controller.User;

import java.io.IOException;

import com.basic.team.DAO.UserDAO;
import com.basic.team.VO.User;
import com.basic.team.controller.frontController.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class myPageController implements Controller {

	@Override
	public String requestHandler(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		int no = Integer.parseInt(req.getParameter("no"));
		
		User user = UserDAO.getInstance().getOneUser(no); 
		
		user.setRegDate(user.getRegDate().substring(0,10));
		String temp = user.getLocation().split("/")[0];
		user.setLocation(temp);
		HttpSession session = req.getSession();
		session.setAttribute("user", user);
		
		return "user/MyPage";
	}

}
