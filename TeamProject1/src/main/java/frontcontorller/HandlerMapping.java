package frontcontorller;



import controller.User.*;
import controller.main.MainController;
import controller.map.InsertAddressController;
import controller.map.MapController;
import controller.map.QuickMainController;

import java.util.HashMap;
import product.ProductAddController;
import product.ProductListController;
import product.ProductSearchListController;
import controller.Product.ProductMainController;

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
		mappings.put("/productMain.do", new ProductMainController());

		//상품등록
		mappings.put("/productAdd.do", new ProductAddController());


		//검색체크
		mappings.put("/productSearch.do", new ProductSearchListController());


		//상품리스트
		mappings.put("/productList.do" ,new ProductListController());

		// main
		mappings.put("/main.do", new MainController());

		// user
		mappings.put("/selfLogin.do", new selfLoginController());
		mappings.put("/selfJoin.do", new selfJoinController());
		mappings.put("/naverLogin.do", new naverLoginController());
		mappings.put("/kakaoLogin.do", new kakaoLoginController());
		mappings.put("/googleLogin.do", new googleLoginContoller());
		mappings.put("/vaildIdAjax.do", new VaildIdAjaxController());
		mappings.put("/userContent.do", new userContentController());
		mappings.put("/userUpdate.do", new userUpdateController());

	}

	public Controller getController(String key) {
		return mappings.get(key);
	}
}
