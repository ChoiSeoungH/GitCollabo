package controller.Product;

import java.io.IOException;
import java.util.List;

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

public class ProductContentController implements Controller {

	@Override
	public String requestHandler(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int ProductNo = Integer.parseInt(request.getParameter("productNo"));
		String isAuction = request.getParameter("auction");
		System.out.println(isAuction);
		System.out.println(ProductNo);
		
		
		//옥션 리스트 가져오기
		List<Auction> au = (List<Auction>) AuctionDAO.getInstance().getOneAuction(ProductNo);
		//이미지 파일 가져오기
		List<ProductImg> image = ProductImgDAO.getInstance().getOneProductImg(ProductNo);
 		request.setAttribute("au", au);
 		request.setAttribute("img", image);
 		System.out.println(image.toString());
		List<Product> vo = (List<Product>) ProductDAO.getInstance().getProductNoContent(ProductNo);
		request.setAttribute("auction", isAuction); // 옥션 값던지기
		request.setAttribute("vo", vo);
		return "product/productContent";
	}

}
