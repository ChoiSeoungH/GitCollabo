package user;


import java.io.IOException;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class VaildIdAjaxController implements frontcontorller.Controller {

	@Override
	public String requestHandler(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// $.ajax();
		System.out.println(req.getParameter("id"));
		String id = req.getParameter("id"); // { "id" : id  }
		System.out.println("1 ="+id);
		String passData = UserDAO.getInstance().isValidId(id)? "valid" : "notValid";
		System.out.println(passData);
		// ajax() 함수에 만들어놓은 callback함수 응답
		req.setAttribute("date", passData);
		return "user/selfJoin";
	}

}
