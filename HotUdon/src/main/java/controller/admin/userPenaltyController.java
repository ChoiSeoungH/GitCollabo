package controller.admin;

import dao.UserDAO;
import frontcontorller.Controller;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class userPenaltyController implements Controller {

  @Override
  public String requestHandler(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

    int no = Integer.parseInt(req.getParameter("no"));
    int penalty = Integer.parseInt(req.getParameter("penalty"));
    int status = 0;
    if (penalty >= 3) {
      status = 4;
    }

    System.out.println(no);
    System.out.println(penalty);


    UserDAO.getInstance().setPenalty(no, penalty, status);

    return null;
  }

}
