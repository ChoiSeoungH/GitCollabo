package controller.Quick;


import com.google.gson.Gson;
import dao.DeliveryDAO;
import dao.ProductDAO;
import dao.UserDAO;
import frontcontorller.Controller;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vo.Delivery;
import vo.Product;

import vo.User;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class QuickMainController implements Controller {
  @Override
  public String requestHandler(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    ProductDAO pdao = ProductDAO.getInstance();
    UserDAO udao = UserDAO.getInstance();
    DeliveryDAO ddao = DeliveryDAO.getInstance();
    int no = Integer.parseInt(request.getParameter("no"));
    HttpSession session = request.getSession();
//    User vo = (User) session.getAttribute("user");
//    User user = udao.getOneUser(5);
    User user = udao.getOneUser(no);
    String dong = "";

    // User 객체의 location 필드에서 '동'을 추출하기 위한 정규 표현식

    System.out.println(user.getLocation());
    String regex = "([가-힣]+동)";
    Pattern pattern = Pattern.compile(regex);
    Matcher matcher = pattern.matcher(user.getLocation());

    if (matcher.find()) {
      dong = matcher.group(1); // '동'에 해당하는 첫 번째 그룹을 반환
    } else {
      return "동 정보 없음"; // 매칭되는 '동'이 없을 경우 반환될 메시지
    }


    ArrayList<Product> list = (ArrayList<Product>) pdao.getDeliveryProductsByLocation(dong);
    ArrayList<User> buyerList = new ArrayList<>();
    for (Product product : list) {
      buyerList.add(udao.getOneUser(product.getBuyerNo()));

      Delivery delivery = new Delivery();
      delivery.setDeliverNo(user.getNo());
      delivery.setProductNo(product.getNo());
      delivery.setLocation(product.getSellLocation());

      ddao.insertDelivery(delivery);
    }

//    for (Product product : list) {
//      System.out.println(product);
//    }

    System.out.println("buyerList");
    for (User u : buyerList) {
      System.out.println(u);
    }


    Gson gson = new Gson();
    String json = gson.toJson(list); // Product 객체 리스트를 JSON 형식으로 변환
    System.out.println("productList"+json);
    request.setAttribute("json", json); // JSON 데이터를 "json" 속성으로 설정하여 JSP로 전달

    json = gson.toJson(buyerList); // User 객체 리스트를 JSON 형식으로 변환
    System.out.println(json);
    request.setAttribute("buyerJson", json); // JSON 데이터를 "json" 속성으로 설정하여 JSP로 전달

    String deliver = gson.toJson(user);
    System.out.println(user);
    request.setAttribute("deliver", deliver); // JSON 데이터를 "json" 속성으로 설정하여 JSP로 전달
    request.setAttribute("user", user);

    String buyerJson = gson.toJson(buyerList);
    request.setAttribute("buyerJson",buyerJson);

    // 데이터를 Map에 저장
    Map<String, Object> dataMap = new HashMap<>();
    dataMap.put("productList", json);
    dataMap.put("deliver", deliver);
    dataMap.put("buyerList", buyerJson);

    // Map을 JSON으로 변환
    String mapJson = gson.toJson(dataMap);

    // JSON 문자열을 응답으로 전송
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    response.getWriter().write(mapJson);

    return "quick/quickMain";
  }
}

