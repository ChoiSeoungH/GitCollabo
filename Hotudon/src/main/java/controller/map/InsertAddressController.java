package controller.map;


import dao.UserDAO;
import frontcontorller.Controller;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.json.JSONException;
import org.json.JSONObject;
import vo.User;

import java.io.BufferedReader;
import java.io.IOException;

public class InsertAddressController implements Controller {
  @Override
  public String requestHandler(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    // 요청 본문에서 JSON 문자열 읽기
    BufferedReader reader = request.getReader();
    StringBuilder json = new StringBuilder();
    String line;
    while ((line = reader.readLine()) != null) {
      json.append(line);
    }

    HttpSession session = request.getSession();
    UserDAO uDao = UserDAO.getInstance();
//    int no = 1;
//    if (session.getAttribute("user") != null) {
//      no = (int) session.getAttribute("no");
//    }
//    System.out.println("no : "+no);
//    System.out.println("user : "+uDao.userList().get(no));
//    User vo = uDao.userList().get(no + 1);
    User vo = (User) session.getAttribute("user");
    System.out.println(vo);
    String combinedAddress = null;

    try {
      JSONObject jsonObject = new JSONObject(json.toString());

      // 각 주소 정보 추출
      String roadAddress = jsonObject.getString("roadAddress");
      String jibunAddress = jsonObject.getString("jibunAddress");
      String detailAddress = jsonObject.getString("detailAddress");
      combinedAddress = roadAddress + "/" + jibunAddress + "/" + detailAddress;
    } catch (JSONException e) {
      throw new RuntimeException(e);
    }

//    System.out.println("combinedAddress"+ combinedAddress);
    vo.setLocation(combinedAddress);
    int cnt = uDao.locationUpdate(vo);

    // 성공 응답 보내기
    if (cnt > 0) {
      response.setContentType("application/json");
      response.setCharacterEncoding("UTF-8");
      response.getWriter().write("{\"message\":\"주소 업데이트 성공\"}");

    } else {
      throw new ServletException("not update");
    }

    return null; // AJAX 요청이므로 JSP로 포워딩할 필요
  }
}
