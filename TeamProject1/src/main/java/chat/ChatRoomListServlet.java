package chat;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/ChatRoomListServlet")
public class ChatRoomListServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws SecurityException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String user_no = request.getParameter("user_no");
        if (user_no == null || user_no.isEmpty()) response.getWriter().write("");
        else response.getWriter().write(getChatRoomList(user_no));

        try {
            Integer.parseInt(user_no);
            response.getWriter().write(getChatRoomList(user_no));
        } catch (Exception e) {
            response.getWriter().write("");
        }
    }

    public String getChatRoomList(String user_no) {
        StringBuffer result = new StringBuffer("");
        result.append("{\"result\":[");

        ArrayList<ChatRoomVO> chatRoomList = new ChatDAO().getChatRoomList(Integer.parseInt(user_no));

        for (int i = 0; i < chatRoomList.size(); i++) {
            result.append("[{\"value\": \"" + chatRoomList.get(i).getProduct_no() + "\"},");
            result.append("{\"value\": \"" + chatRoomList.get(i).getSender_no() + "\"},");
            result.append("{\"value\": \"" + chatRoomList.get(i).getReceiver_no() + "\"}]");
            if (i != chatRoomList.size() - 1) result.append(",");
        }
        result.append("]}");
        return result.toString();
    }
}
