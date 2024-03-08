package controller.User;

import dao.UserDAO;
import dao.UtilDAO;
import frontcontorller.Controller;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vo.User;

import java.io.IOException;
import java.util.ArrayList;

public class userUpdateController implements Controller {

	@Override
	public String requestHandler(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		if(req.getParameter("no")== null) {
	    	return "user/MyPage";
	    }
		String saveDirectory = req.getServletContext().getRealPath("/img");
		UtilDAO.newFolder(req);
		ArrayList<String> images = UtilDAO.multipleFile(req, saveDirectory);
		String imgUrl = String.join(",", images);
		System.out.println(imgUrl);
		
		if(imgUrl.equals("")) {
			imgUrl = "default.jpg";
		}
		
		HttpSession session = req.getSession();
		User preU = (User)session.getAttribute("user");
		String img = req.getParameter("img");
		String file = req.getParameter("files[]");
		System.out.println(img);
		System.out.println(file);
		
		
		int no = Integer.parseInt(req.getParameter("no"));
		String pw = req.getParameter("pw");
		String name = req.getParameter("name");
		String phone = req.getParameter("phone");
		String nickname = req.getParameter("nickname");
		String pre_img = preU.getImgUrl();
		
		User u = new User();
		u.setNo(no);
		if(imgUrl.equals("")) {
			u.setImgUrl(imgUrl);
		} else {
			u.setImgUrl(imgUrl);
		}
		u.setPw(pw);
		u.setName(name);
		u.setNickname(nickname);
		u.setPhone(phone);
		
		String ctx=req.getContextPath();
		int cnt = UserDAO.getInstance().userUpdate(u);
		
		if(cnt>0) {
			User user = UserDAO.getInstance().getOneUser(no);

			user.setRegDate(user.getRegDate().substring(0,10));
			if(user.getLocation() != null) {
				user.setLocation(user.getLocation().split("/")[0]);
			}
			session.setAttribute("user", user);
			//return "redirect:"+ctx+"/List.do";
			return "user/MyPage";
		} else {
		    	throw new ServletException("not update");	    	
		}	
	}

	
}
