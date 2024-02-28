package controller.map;


import com.google.gson.Gson;
import dao.ProductDao;
import frontcontorller.Controller;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vo.Product;

import java.io.IOException;
import java.util.ArrayList;

public class QuickMainController implements Controller {
  @Override
  public String requestHandler(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    ProductDao pdao = ProductDao.getInstance();
    ArrayList<Product> list = (ArrayList<Product>) pdao.getProductsByLocation("역삼동");
//    for (User user : list) {
//      System.out.println(user);
//    }

//    request.setAttribute("list",list);
    Gson gson = new Gson();
    String json = gson.toJson(list); // User 객체 리스트를 JSON 형식으로 변환
//    System.out.println(json);
    request.setAttribute("json", json); // JSON 데이터를 "json" 속성으로 설정하여 JSP로 전달

    return "quick/quickMain";
  }
}

