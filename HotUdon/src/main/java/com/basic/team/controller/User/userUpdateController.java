package com.basic.team.controller.User;

import java.io.IOException;

import com.basic.team.DAO.UserDAO;
import com.basic.team.VO.User;
import com.basic.team.controller.frontController.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class userUpdateController implements Controller {

	@Override
	public String requestHandler(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		if(req.getParameter("no")== null) {
	    	return "memberContent";
	    }
		int no = Integer.parseInt(req.getParameter("no"));
		String pw = req.getParameter("pw");
		
		String name = req.getParameter("name");
		String phone = req.getParameter("phone");
		String nickname = req.getParameter("nickname");

		User u = new User();
		u.setNo(no);
		u.setPw(pw);
		u.setName(name);
		u.setNickname(nickname);
		u.setPhone(phone);
		
		String ctx=req.getContextPath();
		int cnt=UserDAO.getInstance().userUpdate(u);
		
		if(cnt>0) {
			User user = UserDAO.getInstance().getOneUser(no);
			
			user.setRegDate(user.getRegDate().substring(0,10));
			user.setLocation(user.getLocation().split("/")[0]);
			HttpSession session = req.getSession();
			session.setAttribute("user", user);
			//return "redirect:"+ctx+"/List.do";
			return "user/MyPage"; 
		} else {
		    	throw new ServletException("not update");	    	
		}	
	}
	
	
	
}
