package frontcontorller;

import java.util.HashMap;
import product.ProductAddController;
import product.ProductListController;
import product.ProductSearchListController;
import search.NaverSerach;
import user.MainController;

public class HandlerMapping {
	private HashMap<String, Controller> mappings;
	
	public HandlerMapping() {
		 mappings=new HashMap<String, Controller>();
	//메인
	mappings.put("/main.do", new MainController());	
		
	//상품등록
	mappings.put("/productAdd.do", new ProductAddController());
		
	
	
	
	//검색체크
	mappings.put("/productSearch.do", new ProductSearchListController());
	
	
	//상품리스트
	mappings.put("/productList.do" ,new ProductListController());
	
	
	
	//경매
}
	
	
	public Controller getController(String key) {
		return mappings.get(key);
	}
	
	
	
	
	
}
