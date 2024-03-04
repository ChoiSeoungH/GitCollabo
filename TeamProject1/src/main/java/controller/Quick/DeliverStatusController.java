package controller.Quick;

import dao.UserDAO;
import frontcontorller.Controller;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class DeliverStatusController implements Controller {
  @Override
  public String requestHandler(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {

    // 요청에서 사용자 번호와 새 상태 값을 가져옵니다.
    int userNo = Integer.parseInt(request.getParameter("no"));
    int newStatus = Integer.parseInt(request.getParameter("status"));

    // DAO 인스턴스를 가져와서 상태 업데이트 메소드를 호출합니다.
    UserDAO dao = UserDAO.getInstance();
    int cnt = dao.updateUserStatus(userNo, newStatus);

    // 성공적으로 업데이트 되었는지 확인합니다.
    if (cnt > 0) {
      response.getWriter().print(newStatus);
    } else {
      throw new IOException();
    }

    return null; // AJAX 요청이므로 뷰를 반환할 필요가 없습니다.
  }
}
