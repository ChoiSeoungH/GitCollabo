package controller.User;

import dao.UserDAO;
import frontcontorller.Controller;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vo.User;

import java.io.IOException;

public class kakaoLoginController implements Controller {

  @Override
  public String requestHandler(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

    if (req.getParameter("id") == null) {
      return "user/selfLogin";
    }
    String ctx = req.getContextPath();
    String id = req.getParameter("id");
    String pw = "SNSPw";
    String nickname = req.getParameter("nickname");

    String nextPage = "user/MyPage";
    User user = UserDAO.getInstance().checkLogin(id, pw);

    System.out.println(user);

    if (user == null) {
      String name = nickname;
      String phone = "010-0000-0000";
      User u = new User(id, pw, name, phone, nickname);

      int cnt = UserDAO.getInstance().userInsert(u);
      if(cnt == 0) {
        nextPage = "Main";
      }

      user = UserDAO.getInstance().checkLogin(id, pw);
    }

    user.setRegDate(user.getRegDate().substring(0,10));
    HttpSession session = req.getSession();
    session.setAttribute("user", user);

    res.getWriter().print(nextPage);
    //return "redirect:" + ctx + "/main.do";
    //return "user/MyPage";
    return null;
  }

}
