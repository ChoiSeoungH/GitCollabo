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

    System.out.println(newStatus);



    // 성공적으로 업데이트 되었는지 확인합니다.
    if (cnt > 0) {

      switch (newStatus) {
        case 0:
          response.getWriter().print("오프라인");
          break;
        case 1:
          response.getWriter().print("휴식");
          break;
        case 2:
          response.getWriter().print("대기");
          break;
        case 3:
          response.getWriter().print("배송중");
          break;
        case 4:
          response.getWriter().print("비활성화");
          break;
        default:
      }
    } else {
      throw new ServletException();
    }

    return null;
  }
}
