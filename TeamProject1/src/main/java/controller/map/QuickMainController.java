package controller.map;


import com.google.gson.Gson;
import dao.UserDAO;
import frontcontorller.Controller;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vo.Product;
import dao.ProductDAO;
import vo.User;

import java.io.IOException;
import java.util.ArrayList;

public class QuickMainController implements Controller {
  @Override
  public String requestHandler(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    ProductDAO pdao = ProductDAO.getInstance();
    UserDAO udao = UserDAO.getInstance();

    int no = 5;
    User user = udao.getOneUser(no);

    ArrayList<Product> list = (ArrayList<Product>) pdao.getDeliveryProductsByLocation("역삼동");
    ArrayList<User> buyerList = new ArrayList<>();
    for (Product product : list) {
      buyerList.add(udao.getOneUser(product.getBuyerNo()));
    }

//    for (Product product : list) {
//      System.out.println(product);
//    }

    for (User u : buyerList) {
      System.out.println(u);
    }

    Gson gson = new Gson();
    String json = gson.toJson(list); // User 객체 리스트를 JSON 형식으로 변환
    System.out.println(json);
    request.setAttribute("json", json); // JSON 데이터를 "json" 속성으로 설정하여 JSP로 전달

    String deliver = gson.toJson(user);
    System.out.println(user);
    request.setAttribute("deliver", deliver); // JSON 데이터를 "json" 속성으로 설정하여 JSP로 전달
    request.setAttribute("user", user);

    return "quick/quickMain";
  }
}

