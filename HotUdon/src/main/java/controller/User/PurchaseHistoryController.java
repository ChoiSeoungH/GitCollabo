package controller.User;

import dao.AuctionDAO;
import dao.ProductDAO;
import dao.ProductImgDAO;
import frontcontorller.Controller;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vo.Auction;
import vo.Product;
import vo.ProductImg;

import java.io.IOException;
import java.util.List;

public class PurchaseHistoryController implements Controller {
	@Override
	public String requestHandler(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String myPage = request.getParameter("myPage");

		List<ProductImg> image = ProductImgDAO.getInstance().getAllProductImg();
		if(myPage.equals("1")) {  // 1일경우 판매페이지 2일경우 구매페이지
			int no = Integer.parseInt(request.getParameter("no"));
			List<Auction> au = AuctionDAO.getInstance().getAllAuction();
			List<Product> list = ProductDAO.getInstance().getAllMyProduct(no);
			System.out.println("list" + list.toString());
			System.out.println("no"+ no);
			request.setAttribute("au", au);
			request.setAttribute("img", image);
			request.setAttribute("list", list);
			return "product/myPageSell";
		}
		int no = Integer.parseInt(request.getParameter("no"));
		List<Product> list = ProductDAO.getInstance().getAllProduct();
		List<Auction> au = AuctionDAO.getInstance().getAllBidUserNo(no);
		System.out.println(au.toString());
		request.setAttribute("au", au);
		request.setAttribute("img", image);
		request.setAttribute("list", list);
		return "product/myPageBuy";
	}

}


