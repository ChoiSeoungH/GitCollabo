package com.basic.team.controller.admin;

import java.io.IOException;
import java.util.ArrayList;

import com.basic.team.DAO.UserDAO;
import com.basic.team.VO.User;
import com.basic.team.controller.frontController.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class userListController implements Controller {

	@Override
	public String requestHandler(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		ArrayList<User> list = UserDAO.getInstance().getUserList();
		
		for(User user : list) {
			user.setRegDate(user.getRegDate().substring(0,10));
		}
		req.setAttribute("list", list);
		
		return "admin/userList";
		
	}

}
