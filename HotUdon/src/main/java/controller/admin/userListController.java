package controller.admin;

import dao.UserDAO;
import frontcontorller.Controller;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vo.User;

import java.io.IOException;
import java.util.ArrayList;

public class userListController implements Controller {

  @Override
  public String requestHandler(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

    ArrayList<User> list = UserDAO.getInstance().getUserList();

    for (User user : list) {
      user.setRegDate(user.getRegDate().substring(0, 10));
      if (user.getLocation() != null) {
        user.setLocation(user.getLocation().split("/")[0]);
      }
    }
    req.setAttribute("list", list);

    return "admin/userList";

  }

}
