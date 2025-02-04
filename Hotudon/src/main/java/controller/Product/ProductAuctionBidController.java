package controller.Product;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import dao.AuctionDAO;
import dao.ProductDAO;
import dao.UserDAO;
import frontcontorller.Controller;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vo.Auction;


public class ProductAuctionBidController implements Controller {

	@Override
	public String requestHandler(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		//일반상품구매
		if(request.getParameter("bidAmount")==null) {
			int productNo = Integer.parseInt(request.getParameter("product"));
			int buyerNo = Integer.parseInt(request.getParameter("no"));
			Date current = new Date();
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String now = formatter.format(current);
			int buyMoney = Integer.parseInt(request.getParameter("productPrice"));
			int sellerNo =  Integer.parseInt(request.getParameter("seller"));
			UserDAO.getInstance().bidFail(sellerNo, buyMoney); //판매자한테 금액이 넘어감
			UserDAO.getInstance().bidSuccess(buyerNo, buyMoney); //구매자한테서 돈을 뺴감
			int buyEndProduct = ProductDAO.getInstance().buyProductOne(productNo, buyerNo, now);
			return "product/productList";
		}
		
		//경매입찰
		int bid = Integer.parseInt(request.getParameter("bidAmount"));
		System.out.println("bid "+ bid);
		int productNo = Integer.parseInt(request.getParameter("product"));
		int lastBidNo = Integer.parseInt(request.getParameter("no"));
		Date current = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String now = formatter.format(current);
		// 기존옥션 값 다시 유저한테 넘겨주기 
		Auction ret = AuctionDAO.getInstance().getOneAuction(productNo);
		int money = ret.getLastPrice();
		int userNo= ret.getLastBidderNo();
		UserDAO.getInstance().bidFail(userNo, money);//유저값넘기기 
		
		
		
		//public Auction(int productNo, int lastPrice, String lastBidDate, int lastBidderNo)
		Auction vo = new Auction(productNo,bid,now,lastBidNo);
		AuctionDAO.getInstance().updateAuctionBid(vo);
		UserDAO.getInstance().bidSuccess(lastBidNo, bid);
		
		System.out.println("체크용");
		
		return "product/productList";
	}
	
}
