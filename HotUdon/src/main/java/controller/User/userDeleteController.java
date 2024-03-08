package controller.User;

import java.io.IOException;


import dao.UserDAO;
import frontcontorller.Controller;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vo.User;

public class userDeleteController implements Controller {

	@Override
	public String requestHandler(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		String ctx = req.getContextPath();
		
		if(req.getParameter("no") == null) {
			return "user/checkPwPage";
		} else {
			int no = Integer.parseInt(req.getParameter("no"));
			User user = UserDAO.getInstance().getOneUser(no);

			//유저 삭제 시 상품에서 해당 유저no 삭제해야함.
			
			String id = user.getId();
			UserDAO.getInstance().removeUser(id);
			
			HttpSession session = req.getSession();
			session.removeAttribute("user");
		}
		
		
		
		
		return "redirect:" + ctx + "/main.do";
	}

}
