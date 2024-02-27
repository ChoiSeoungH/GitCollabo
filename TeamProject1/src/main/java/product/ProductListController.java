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
		
		List<Product> list = ProductDAO.getInstance().getAllProduct();
		List<ProductImg> imgList = ProductImgDAO.getInstance().getAllProductImg(); 
		System.out.println(imgList);
		request.setAttribute("imgList", imgList);
		request.setAttribute("list", list);
		return "product/productList";
	}

}
