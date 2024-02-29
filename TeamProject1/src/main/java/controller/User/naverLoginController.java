package controller.User;

import java.io.IOException;

import frontcontorller.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class naverLoginController implements Controller {

	@Override
	public String requestHandler(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		System.out.println("naverLogin");
		
		
		return null;
	}

}
