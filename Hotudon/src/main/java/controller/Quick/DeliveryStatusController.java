package controller.Quick;

import dao.DeliveryDAO;
import dao.UserDAO;
import frontcontorller.Controller;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class DeliveryStatusController implements Controller {
  @Override
  public String requestHandler(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {

    // 요청에서 사용자 번호와 새 상태 값을 가져옵니다.
    int productNo = Integer.parseInt(request.getParameter("no"));
    int newStatus = Integer.parseInt(request.getParameter("status"));



    // DAO 인스턴스를 가져와서 상태 업데이트 메소드를 호출합니다.
    DeliveryDAO ddao = DeliveryDAO.getInstance();
    int cnt = ddao.updateDeliveryStatus(productNo, newStatus);

    System.out.println(newStatus);

    // 성공적으로 업데이트 되었는지 확인합니다.
    if (cnt > 0) {

      switch (newStatus) {
        case 0:
          response.getWriter().print("배송 준비중");
          break;
        case 1:
          response.getWriter().print("배송중");
          break;
        case 2:
          response.getWriter().print("배송완료");
          break;
      }
    } else {
      throw new ServletException();
    }

    return null;
  }
}
