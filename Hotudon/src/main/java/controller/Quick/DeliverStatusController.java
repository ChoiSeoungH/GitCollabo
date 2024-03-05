package controller.Quick;

import com.google.gson.Gson;
import dao.UserDAO;
import frontcontorller.Controller;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class DeliverStatusController implements Controller {
  @Override
  public String requestHandler(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {

    // 요청에서 사용자 번호와 새 상태 값을 가져옵니다.
    int userNo = Integer.parseInt(request.getParameter("no"));
    int newStatus = Integer.parseInt(request.getParameter("status"));
    int cash;

    // DAO 인스턴스를 가져와서 상태 업데이트 메소드를 호출합니다.
    UserDAO dao = UserDAO.getInstance();
    int cnt;

    // "오프라인" 상태와 cash 값을 포함하는 Map 객체 생성
    Map<String, Object> responseData = new HashMap<>();

    System.out.println("newStatus : "+newStatus);
    System.out.println("Integer.parseInt(request.getParameter(\"cash\")) : "+Integer.parseInt(request.getParameter("cash")));
    if (Integer.parseInt(request.getParameter("cash")) == 0) {
      cnt = dao.updateUserStatus(userNo, newStatus);

    } else {
      cash = Integer.parseInt(request.getParameter("cash"));
      cnt = dao.updateUserStatus(userNo, newStatus, cash);
    }

    System.out.println("newStatus : "+newStatus);







    // 성공적으로 업데이트 되었는지 확인합니다.
    if (cnt > 0) {
      switch (newStatus) {
        case 0:
          responseData.put("status", "오프라인");
          break;
        case 1:
          responseData.put("status", "휴식");
          break;
        case 2:
          responseData.put("status", "대기");
          break;
        case 3:
          responseData.put("status", "배송중");
          break;
        case 4:
          responseData.put("status", "비활성화");
          break;
        default:
      }
    } else {
      throw new ServletException();
    }
    responseData.put("cash", dao.getOneUser(userNo).getCash());


  // 응답의 컨텐트 타입을 JSON으로 설정
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");

    // Map 객체를 JSON 문자열로 변환
    Gson gson = new Gson();
    String jsonResponse = gson.toJson(responseData);

    // 응답으로 JSON 데이터 보내기
    response.getWriter().print(jsonResponse);
    return null;
  }
}
