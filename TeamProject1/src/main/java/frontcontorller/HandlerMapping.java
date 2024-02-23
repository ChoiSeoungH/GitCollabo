package frontcontorller;

import java.util.HashMap;

public class HandlerMapping {
	private HashMap<String, Controller> mappings;
	//유저
	
	
	
	//상품등록
	
	
	
	
	//상품리스트
	
	
	
	//경매
	
	
	
	public Controller getController(String key) {
		return mappings.get(key);
	}
	
	
	
	
	
}
