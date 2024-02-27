package user;

import java.io.IOException;

import frontcontorller.Controller;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class MainController implements Controller{

	@Override
	public String requestHandler(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String saveDirectory = request.getServletContext().getRealPath("/img");
		System.out.println(saveDirectory);
			
		return "main";
	}

}
