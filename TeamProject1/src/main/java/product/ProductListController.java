package product;

import java.io.IOException;
import java.util.List;

import dao.ProductDAO;
import dao.ProductImgDAO;
import frontcontorller.Controller;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vo.Product;
import vo.ProductImg;

public class ProductListController implements Controller {

	@Override
	public String requestHandler(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String saveDirectory = request.getServletContext().getRealPath("/img");
		
		//일반상품 리스트 가져오기
		List<Product> list = ProductDAO.getInstance().getAllProduct();
		//최신상품 3개 가져오기
		List<Product> latestList = ProductDAO.getInstance().getLatestProduct();
		//이미지 파일 불러오기
		List<ProductImg> imgList = ProductImgDAO.getInstance().getAllProductImg(); 
		System.out.println(imgList.toString());
		System.out.println(latestList.toString());
		request.setAttribute("latest", latestList);
		request.setAttribute("imgList", imgList);
		request.setAttribute("list", list);
		return "product/productList";
	}

}
