package product;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import dao.AuctionDAO;
import frontcontorller.Controller;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vo.Auction;


public class ProductAuctionBidController implements Controller {

	@Override
	public String requestHandler(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int bid = Integer.parseInt(request.getParameter("bidAmount"));
		System.out.println("bid "+ bid);
		int productNo = Integer.parseInt(request.getParameter("no"));
		int lastBidNo = Integer.parseInt(request.getParameter("id"));
		Date current = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String now = formatter.format(current);
		
		//public Auction(int productNo, int lastPrice, String lastBidDate, int lastBidderNo)
		Auction vo = new Auction(productNo,bid,now,lastBidNo);
		AuctionDAO.getInstance().updateAuctionBid(vo);
		
		System.out.println("체크용");
		
		return "product/productList";
	}
	
}
