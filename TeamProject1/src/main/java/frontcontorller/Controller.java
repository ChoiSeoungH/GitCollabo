package frontcontorller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

public interface Controller {
	public String requestHandler(HttpServletRequest req, HttpServletRequest resopnse) throws ServletException, IOException;
	// 김태하
}
