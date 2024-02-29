package com.basic.team.controller.frontController;

import java.util.HashMap;

import com.basic.team.controller.User.VaildIdAjaxController;
import com.basic.team.controller.User.googleLoginContoller;
import com.basic.team.controller.User.kakaoLoginController;
import com.basic.team.controller.User.naverLoginController;
import com.basic.team.controller.User.selfJoinController;
import com.basic.team.controller.User.selfLoginController;
import com.basic.team.controller.User.userContentController;
import com.basic.team.controller.User.userLogOutController;
import com.basic.team.controller.User.userUpdateController;
import com.basic.team.controller.admin.userListController;




public class HandlerMapping {
	
	private HashMap<String, Controller> mappings;
	
	public HandlerMapping() {
		mappings = new HashMap<String, Controller>(); 
		
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
		mappings.put("/userLogOut.do", new userLogOutController());

		// admin
		mappings.put("/userList.do", new userListController());
		
	}
	
	public Controller getController(String key) {
		return mappings.get(key);
	}
}
