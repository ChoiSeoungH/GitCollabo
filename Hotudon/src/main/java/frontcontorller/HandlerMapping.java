package frontcontorller;

import java.util.HashMap;
import product.ProductAddController;
import product.ProductAuctionBidController;
import product.ProductContentController;
import product.ProductListController;
import product.ProductSearchListController;
import user.MainController;
import user.PurchaseHistoryController;
import user.VaildIdAjaxController;
import user.selfJoinController;
import user.selfLoginController;
import user.userCashUpdateController;
import user.userContentController;
import user.userLogOutController;
import user.userUpdateController;

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
	mappings.put("/productContent.do", new ProductContentController());

	
	//경매
	mappings.put("/auctionBid.do", new ProductAuctionBidController());  //  << 옥션이랑 구매할떄 이쪽으로 넘김
	

	
	// user
	mappings.put("/selfLogin.do", new selfLoginController());
	mappings.put("/selfJoin.do", new selfJoinController());
	mappings.put("/vaildIdAjax.do", new VaildIdAjaxController());
	mappings.put("/userContent.do", new userContentController());
	mappings.put("/userUpdate.do", new userUpdateController());
	mappings.put("/userLogOut.do", new userLogOutController());
	mappings.put("/cashUpdate.do", new userCashUpdateController());
	mappings.put("/purHistory.do", new PurchaseHistoryController());
    
	// admin
	/*
	 * mappings.put("/userList.do", new userListController());
	 * mappings.put("/userPenalty.do", new userPenaltyController())
	 */;
	
	
	
	
	}	
	public Controller getController(String key) {
		return mappings.get(key);
	}
	
	
	
	
	
}
