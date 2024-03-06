package frontcontorller;


import controller.Product.*;
import controller.Quick.*;
import controller.User.*;
import controller.admin.userListController;
import controller.admin.userPenaltyController;
import controller.main.MainController;
import controller.map.InsertAddressController;
import controller.map.MapController;
import controller.search.ProductSearchListController;

import java.util.HashMap;

public class HandlerMapping {
	private HashMap<String, Controller> mappings;
	
	public HandlerMapping() {
		mappings = new HashMap<String, Controller>();
		//quick
		mappings.put("/quickMain.do", new QuickMainController());
		mappings.put("/deliverStatus.do", new DeliverStatusController());
		mappings.put("/deliveryStatus.do", new DeliveryStatusController());
		mappings.put("/quickEnd.do", new QuickEndController());
		mappings.put("/deliverySet.do", new DeliverySetController());

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
		mappings.put("/productContent.do", new ProductContentController());

		// main
		mappings.put("/main.do", new MainController());

		// user
		mappings.put("/selfLogin.do", new selfLoginController());
		mappings.put("/selfJoin.do", new selfJoinController());
		mappings.put("/naverLogin.do", new naverLoginController());
		mappings.put("/naverCallback.do", new naverCallbackController());
		mappings.put("/kakaoLogin.do", new kakaoLoginController());
		mappings.put("/googleLogin.do", new googleLoginContoller());
		mappings.put("/vaildIdAjax.do", new VaildIdAjaxController());
		mappings.put("/userContent.do", new userContentController());
		mappings.put("/userUpdate.do", new userUpdateController());
		mappings.put("/userLogOut.do", new userLogOutController());
		mappings.put("/cashUpdate.do", new userCashUpdateController());
		mappings.put("/purHistory.do", new PurchaseHistoryController());
		mappings.put("/saleHistory.do", new SalesHistoryController());

		// admin
		mappings.put("/userList.do", new userListController());
		mappings.put("/userPenalty.do", new userPenaltyController());


		//경매
		mappings.put("/auctionBid.do", new ProductAuctionBidController());  //  << 옥션이랑 구매할떄 이쪽으로 넘김
	}
	public Controller getController(String key) {
		return mappings.get(key);
	}
	
	
	
	
	
}
