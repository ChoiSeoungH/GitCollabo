package com.basic.team.controller.User;

import java.io.IOException;

import com.basic.team.DAO.UserDAO;
import com.basic.team.VO.User;
import com.basic.team.controller.frontController.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class userCashUpdateController implements Controller {

	@Override
	public String requestHandler(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String ctx = req.getContextPath();
		
		HttpSession session = req.getSession();
		User user = (User)session.getAttribute("user");
		
		int no = Integer.parseInt(req.getParameter("no"));
		int cash = user.getCash() + Integer.parseInt(req.getParameter("cash_update"));
		
		System.out.println(cash);
		
		int cnt = UserDAO.getInstance().cashUpdate(no,cash);
		if(cnt>0) {
			return "redirect:" + ctx + "/userContent.do?no=" + no;

//			return "redirect:" + ctx + "/userContent.do";
//			req.removeAttribute("center");
		} else {
			return "user/MyPage"; 
//			req.setAttribute("center", "user/join");
		}
		
	}

}
