package controller.Product;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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

public class ProductUpdateController implements Controller{

	@Override
	public String requestHandler(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		System.out.println(request.getParameter("productNo"));
		int productNo = Integer.parseInt(request.getParameter("productNo"));
		Date now =  new Date();
		 SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		 String  current = dateFormat.format(now);
		
		if(request.getParameter("title") == null) {
		String check = request.getParameter("check");
				if(check.equals("1")) {  // 수정
					Product vo = ProductDAO.getInstance().getProductNoContent(productNo);
					List<ProductImg> img = ProductImgDAO.getInstance().getOneProductImg(productNo);
					ProductImg images =img.get(0);
					String h = images.getImageUrl();
					request.setAttribute("img", h);
					request.setAttribute("vo", vo);
					return "product/productUpdate";
				}else if(check.equals("2")) { // 재등록 경매 유찰일경우만 실행  실행이 안됨
					int ReAdd = AuctionDAO.getInstance().UpdateReAddProduct(productNo, current);
					
					
						ProductDAO.getInstance().updateDate(productNo);
					return "user/MyPage";
				} /*
					 * //삭제 int remove = ProductDAO.getInstance().sellerRemoveOne(productNo);
					 * 
					 * 
					 * return "user/MyPage";
					 */
			
		}
		// 밑에는 상품이 수정 완료된 곳 
		String saveDirectory = request.getServletContext().getRealPath("/img");
		dao.UtilDAO.newFolder(request);
		ArrayList <String> images = dao.UtilDAO.multipleFile(request, saveDirectory);
		System.out.println("imgs"+images);
		
		String image = String.join(",", images);
		String title = request.getParameter("title");	
		int price =Integer.parseInt(request.getParameter("productPrice"));
		int method = Integer.parseInt(request.getParameter("method"));
		int category = Integer.parseInt(request.getParameter("category"));
		String sellLocation = request.getParameter("sellLocation");
		String productContent = request.getParameter("productContent");
		Product vo = new Product(productNo,category,0,title,price,productContent,current,false,sellLocation,method,0,null);
		ProductImgDAO.getInstance().getOneUpdageImg(productNo, image);
		ProductDAO.getInstance().getOneUpdate(vo);
		
		return "user/MyPage";
	}

}
