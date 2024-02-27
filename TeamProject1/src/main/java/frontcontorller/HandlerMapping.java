package frontcontorller;



import controller.map.InsertAddressController;
import controller.map.MapController;
import controller.map.QuickMainController;

import java.util.HashMap;
import product.ProductAddController;
import product.ProductListController;
import product.ProductSearchListController;
import search.NaverSerach;
import user.MainController;

public class HandlerMapping {
	private HashMap<String, Controller> mappings;

	public HandlerMapping() {
		mappings = new HashMap<String, Controller>();
		//quick
		mappings.put("/quickMain.do", new QuickMainController());

		//map
		mappings.put("/map.do", new MapController());
		mappings.put("/insertAddress.do", new InsertAddressController());

		//메인
		mappings.put("/main.do", new MainController());

		//상품등록
		mappings.put("/productAdd.do", new ProductAddController());


		//검색체크
		mappings.put("/productSearch.do", new ProductSearchListController());


		//상품리스트
		mappings.put("/productList.do" ,new ProductListController());


	}

	public Controller getController(String key) {
		return mappings.get(key);
	}
}
