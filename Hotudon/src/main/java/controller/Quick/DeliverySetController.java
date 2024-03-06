package controller.Quick;

import dao.DeliveryDAO;
import frontcontorller.Controller;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vo.Delivery;

import java.io.IOException;

public class DeliverySetController implements Controller {
  @Override
  public String requestHandler(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    int productNo = Integer.parseInt(request.getParameter("productNo"));
    int deliverNo = Integer.parseInt(request.getParameter("deliverNo"));
    int deliveryFee = Integer.parseInt(request.getParameter("deliveryFee"));
    String productAddress = request.getParameter("productAddress");

    Delivery vo = new Delivery();
    vo.setDeliverNo(deliverNo);
    vo.setProductNo(productNo);
    vo.setPrice(deliveryFee);
    vo.setLocation(productAddress);

    DeliveryDAO ddao = DeliveryDAO.getInstance();


    ddao.insertDelivery(vo);


    return null;
  }
}
