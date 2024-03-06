package com.basic.team.controller.admin;

import java.io.IOException;

import com.basic.team.DAO.UserDAO;
import com.basic.team.controller.frontController.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class userPenaltyController implements Controller {

	@Override
	public String requestHandler(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		int no = Integer.parseInt(req.getParameter("no"));
		int penalty = Integer.parseInt(req.getParameter("penalty"));
		int status = 0;
		if(penalty >= 3) {
			status = 4;
		}
		
		System.out.println(no);
		System.out.println(penalty);
		
		
		UserDAO.getInstance().setPenalty(no,penalty,status);
		
		return null;
	}

}
