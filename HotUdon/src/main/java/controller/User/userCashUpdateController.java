package controller.User;

import dao.UserDAO;
import frontcontorller.Controller;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vo.User;

import java.io.IOException;

public class userCashUpdateController implements Controller {

  @Override
  public String requestHandler(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
    String ctx = req.getContextPath();

//    HttpSession session = req.getSession();
//    User user = (User)session.getAttribute("user");
    String type = (String)req.getParameter("type");

    int no = Integer.parseInt(req.getParameter("no"));
    User user = UserDAO.getInstance().getOneUser(no);
    int cash = 0;

    if(type.equals("deposit")) {
      cash = user.getCash() + Integer.parseInt(req.getParameter("cash_update"));
    } else if(type.equals("withdraw")) {
      cash = user.getCash() - Integer.parseInt(req.getParameter("cash_update"));
    }
    System.out.println(cash);

    int cnt = UserDAO.getInstance().cashUpdate(no,cash);
    if(cnt>0) {
      return "redirect:" + ctx + "/userMyPage.do?no=" + no;
//			return "user/MyPage";

//			return "redirect:" + ctx + "/userContent.do";
//			req.removeAttribute("center");
    } else {
      return "user/MyPage";
//			req.setAttribute("center", "user/join");
    }

  }

}
