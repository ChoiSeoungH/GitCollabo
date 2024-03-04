package com.basic.team.controller.frontController;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;



@WebServlet("*.do")
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
    	String url = req.getRequestURI();
    	String ctx = req.getContextPath();
    	String command = url.substring(ctx.length());
    	System.out.println("command = "+command);
    	
    	Controller controller = null;
    	String nextPage = null;
    	
    	HandlerMapping mapping = new HandlerMapping();
    	controller = mapping.getController(command);
    	
    	nextPage = controller.requestHandler(req, res);
    	System.out.println("nextPage = "+nextPage);
    	
    	if(nextPage != null) {
    		if(nextPage.indexOf("redirect:") != -1) {
    			res.sendRedirect(nextPage.split(":")[1]);
    		} else {
    			RequestDispatcher rd = req.getRequestDispatcher(ViewResolver.makeView(nextPage));
    			rd.forward(req, res);
    		}
    	}
    }

}
