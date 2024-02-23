package frontcontorller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;

public interface Controller {
	public String requestHandler(HttpServletRequest req,HttpServletRequest resopnse) throws ServletException, IOException;
	// 조웅재 추가함
}
