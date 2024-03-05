package product;

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

public class ProductListController implements Controller {

	@Override
	public String requestHandler(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String saveDirectory = request.getServletContext().getRealPath("/img");
		
		
		
		//일반상품 리스트 가져오기
		List<Product> list = ProductDAO.getInstance().getAllProduct();
	
		//이미지 파일 불러오기
		List<ProductImg> imgList = ProductImgDAO.getInstance().getAllProductImg(); 
		//옥션 상품들만 가져오기 
		List<Auction> auList = AuctionDAO.getInstance().getAllAuction();
	
		request.setAttribute("imgList", imgList);
		List<Product> latestList = ProductDAO.getInstance().getLatestProduct();
		System.out.println(request.getParameter("auction"));
		//전체 상품 불러오기
		if(request.getParameter("auction") == null || request.getParameter("auction").equals("")) {
			//최신상품 3개 가져오기
		request.setAttribute("latest", latestList);	
		request.setAttribute("list", list);
		return "product/productList";
		// 옥션 상품들만 불러오기
		}else if (request.getParameter("auction").equals("2")) {
			request.setAttribute("au", auList);
			request.setAttribute("latest", latestList);	
			request.setAttribute("list", list);
			
		return "product/productList";
		}
		// 일반상품들만 가져오기
		request.setAttribute("list", list);
		return "product/productList";
		
	}

}
