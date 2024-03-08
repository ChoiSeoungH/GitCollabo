package controller.map;


import dao.UserDAO;
import frontcontorller.Controller;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vo.User;

import java.io.IOException;

public class MapController implements Controller {
  @Override
  public String requestHandler(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    HttpSession session = request.getSession();
    UserDAO uDao = UserDAO.getInstance();
    User vo = (User) session.getAttribute("user");

    request.setAttribute("user",vo);

    return "map/map";
  }
}
