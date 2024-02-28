package com.basic.team.controller.User;

import java.io.IOException;

import com.basic.team.DAO.UserDAO;
import com.basic.team.VO.User;
import com.basic.team.controller.frontController.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class userUpdateController implements Controller {

	@Override
	public String requestHandler(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		if(req.getParameter("no")== null) {
	    	return "memberContent";
	    }
		int no = Integer.parseInt(req.getParameter("no"));
		String pw = req.getParameter("pw");
		String phone = req.getParameter("phone");
		String nickname = req.getParameter("nickname");

		User u = new User();
		u.setNo(no);
		u.setPw(pw);
		u.setNickname(nickname);
		u.setPhone(phone);
		
		String ctx=req.getContextPath();
		int cnt=UserDAO.getInstance().userUpdate(u);
		
		if(cnt>0) {
			return "redirect:"+ctx+"/memberList.do";
			 
		} else {
		    	throw new ServletException("not update");	    	
		}	
	}
	
	
	
}
