package product;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import dao.ProductDAO;
import frontcontorller.Controller;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vo.Product;

public class ProductUpdateController implements Controller{

	@Override
	public String requestHandler(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int no = Integer.parseInt(request.getParameter("no"));
		int productNo = Integer.parseInt(request.getParameter("productNo"));
		  Date now =  new Date();
		  SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		  String  current = dateFormat.format(now);
		if(request.getParameter("title") == null) {
		String check = request.getParameter("check");
				if(check.equals("1")) {  // 수정
					Product vo = ProductDAO.getInstance().getProductNoContent(productNo);
					request.setAttribute("vo", vo);
					
					return "product/productUpdate";
				}else if(check.equals("2")) { // 재등록
				
					
					return "product/mypageSell";
				}
			   //삭제 
				int remove = ProductDAO.getInstance().sellerRemoveOne(productNo);
			
				
				return "product/myPageSell";
			
		}
		// 밑에는 상품이 수정 완료된 곳 
		String title = request.getParameter("title");	
		
		return null;
	}

}
