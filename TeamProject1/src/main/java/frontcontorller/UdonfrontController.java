package frontcontorller;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("*.do")
public class UdonfrontController extends HttpServlet{
		protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			
			request.setCharacterEncoding("utf-8");
			String url=request.getRequestURI();
			String ctx=request.getContextPath();
			String command=url.substring(ctx.length());
			System.out.println(command); 
			Controller controller=null;
			String nextPage=null;
		    HandlerMapping mapping=new HandlerMapping();
		    controller=mapping.getController(command);
		    System.out.println("");
		    nextPage=controller.requestHandler(request, response);
		
			if(nextPage!=null) {
				if(nextPage.indexOf("redirect:")!=-1) {
					response.sendRedirect(nextPage.split(":")[1]); 
				}else {
					RequestDispatcher rd=request.getRequestDispatcher(ViewResolver.makeView(nextPage)); 
					rd.forward(request, response);
				}
			}		
		}
	}



