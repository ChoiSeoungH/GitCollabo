package frontcontorller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;

public interface Controller {
	public String requestHandler(HttpServletRequest req,HttpServletRequest resopnse) throws ServletException, IOException;
	
}
