package controller.main;

import java.io.IOException;


import frontcontorller.Controller;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class MainController implements Controller {

	@Override
	public String requestHandler(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		req.removeAttribute("center");
		
		Object log = req.getAttribute("log");
		
		System.out.println("main-log="+log);
		
		return "Main";
	}

}
