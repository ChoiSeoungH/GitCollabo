package controller.User;

import dao.UserDAO;
import frontcontorller.Controller;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vo.User;

import java.io.IOException;

public class selfLoginController implements Controller {

	@Override
	public String requestHandler(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		HttpSession session = req.getSession();


		if (req.getParameter("id") == null) {
			return "user/selfLogin";
		}
		
		String ctx = req.getContextPath();
		System.out.println(ctx);
		String id = req.getParameter("id");
		String pw = req.getParameter("pw");
		User user = UserDAO.getInstance().checkLogin(id, pw);
		String temp;
		System.out.println(user);
		
		if (user == null) {
			return "redirect:" + ctx + "/main.do";
		} else {
			user.setRegDate(user.getRegDate().substring(0,10));
			if (user.getLocation()!=null) {
				temp = user.getLocation().split("/")[0];
				user.setLocation(temp);
			}
			session.setAttribute("user", user);
			System.out.println("user : "+user);
//			return "redirect:" + ctx + "/main.do";
			return "Main";
		}
	}

}
