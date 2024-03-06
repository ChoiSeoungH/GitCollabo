package controller.Quick;

import dao.ProductDAO;
import frontcontorller.Controller;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class QuickEndController implements Controller {

  @Override
  public String requestHandler(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    ProductDAO pdao = ProductDAO.getInstance();
    System.out.println(request.getParameter("no"));
    int productNo = Integer.parseInt(request.getParameter("no"));
    System.out.println(productNo);
    Date endDate = new Date(); // 현재 날짜와 시간을 생성
    System.out.println(endDate);
    pdao.updateEndDate(productNo,endDate);

    return null;
  }
}
