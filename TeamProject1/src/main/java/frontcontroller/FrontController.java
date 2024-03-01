package frontcontroller;

import controller.Controller;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("*.do")
public class FrontController extends HttpServlet {

    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String url = request.getRequestURI();
        String ctx = request.getContextPath();
        String command = url.substring(ctx.length());

        Controller controller;
        String nextPage = null;

        HandlerMapping mapping = new HandlerMapping();
        controller = mapping.getController(command);

        try {
            nextPage = controller.requestHandler(request, response);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        System.out.println("nextPage: " + nextPage);

        if (nextPage != null) {
            if (nextPage.contains("redirect:")) {
                response.sendRedirect(nextPage.split(":")[1]);
            } else {
                RequestDispatcher rd = request.getRequestDispatcher(ViewResolver.makeView(nextPage));
                rd.forward(request, response);
            }
        }
    }
}
