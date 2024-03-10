package controller.Quick;

import dao.DeliveryDAO;
import frontcontorller.Controller;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vo.Delivery;

import java.io.IOException;

public class DeliveryUpdateController implements Controller {
  @Override
  public String requestHandler(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    int productNo = Integer.parseInt(request.getParameter("productNo"));
    int deliverNo = Integer.parseInt(request.getParameter("deliverNo"));
    int deliveryFee = Integer.parseInt(request.getParameter("deliveryFee"));

    Delivery vo = new Delivery();
    vo.setDeliverNo(deliverNo);
    vo.setProductNo(productNo);
    vo.setPrice(deliveryFee);

    DeliveryDAO ddao = DeliveryDAO.getInstance();

    ddao.updateDelivery(vo);


    return null;
  }
}
