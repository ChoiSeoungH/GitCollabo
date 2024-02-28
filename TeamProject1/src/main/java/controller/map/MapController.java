package controller.map;


import frontcontorller.Controller;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class MapController implements Controller {
  @Override
  public String requestHandler(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    return "map/map";
  }
}
