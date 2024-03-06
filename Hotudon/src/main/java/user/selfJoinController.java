package user;

import java.io.IOException;

import dao.UserDAO;
import frontcontorller.Controller;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vo.User;

public class selfJoinController implements Controller {

	@Override
	public String requestHandler(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		String id = req.getParameter("id");
		System.out.println(id);
		if(id == null) {
			return "user/selfJoin";
		}
		String pw = req.getParameter("pw");
		String name = req.getParameter("name");
		String phone = req.getParameter("phone");
		String nickname = req.getParameter("nickname");
		
		User u = new User(id, pw, name, phone, nickname);
		
		int cnt = UserDAO.getInstance().userInsert(u);
		if(cnt>0) {
			return "user/MyPage";
//			req.removeAttribute("center");
		} else {
			return "user/selfJoin";
//			req.setAttribute("center", "user/join");
		}
		
	}

}
