package controller.User;

import java.io.IOException;

import dao.UserDAO;
import frontcontorller.Controller;
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
		int no = UserDAO.getInstance().checkLogin(id, pw);
		System.out.println(no);
		
		if (no == 0) {
			return "redirect:" + ctx + "/main.do";
		} else {
			HttpSession session = req.getSession();
			session.setAttribute("log", no);
//			return "redirect:" + ctx + "/main.do";
			return "user/MyPage";
			
		}
	}

}
