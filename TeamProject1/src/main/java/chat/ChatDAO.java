package chat;

import product.ProductDAO;
import product.ProductVO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ChatDAO {
    private Connection conn;

    public ChatDAO() {
        try {
            String URL = "jdbc:mysql://localhost:3306/team?characterEncoding=UTF-8&serverTimezone=UTC&useSSL=false";
            String user = "root";
            String password = "";
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL, user, password);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public ArrayList<ChatVO> getChatList(int product_no, int sender_no, int receiver_no) {
        ArrayList<ChatVO> chatList = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String SQL = "SELECT * FROM chat WHERE product_no = ? AND ((sender_no = ? AND receiver_no = ?) OR (sender_no = ? AND receiver_no = ?)) ORDER BY send_date";

        try {
            ps = conn.prepareStatement(SQL);
            ps.setInt(1, product_no);
            ps.setInt(2, sender_no);
            ps.setInt(3, receiver_no);
            ps.setInt(4, receiver_no);
            ps.setInt(5, sender_no);
            rs = ps.executeQuery();
            chatList = new ArrayList<ChatVO>();
            while (rs.next()) {
                ChatVO chat = new ChatVO();
                chat.setProduct_no(rs.getInt("product_no"));
                chat.setSender_no(rs.getInt("sender_no"));
                chat.setReceiver_no(rs.getInt("receiver_no"));
                chat.setContent(rs.getString("content").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
                chat.setSend_date(rs.getString("send_date"));
                chatList.add(chat);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return chatList;
    }

    public ArrayList<ChatRoomVO> getChatRoomList(int user_no) {
        ArrayList<ProductVO> productList = new ProductDAO().getProductListBySellerNo(user_no); // 판매자로서의 상품 목록
        ArrayList<ChatVO> chatList = getChatListByProductNo(productList); // 상품 목록에 대한 채팅 목록

        ArrayList<ChatRoomVO> chatRoomList = new ArrayList<>();
        ChatRoomVO chatRoom = new ChatRoomVO();

        chatRoom.setProduct_no(chatList.get(0).getProduct_no()); // 첫 번째 채팅의 상품 번호
        chatRoom.setSender_no(chatList.get(0).getSender_no()); // 첫 번째 채팅의 발신자 번호
        chatRoom.setReceiver_no(chatList.get(0).getReceiver_no()); // 첫 번째 채팅의 수신자 번호
        chatRoomList.add(chatRoom); // 첫 번째 채팅의 채팅방 추가

        for (ChatVO c : chatList) {
            for (ChatRoomVO cr : chatRoomList) {
                if (c.getProduct_no() == cr.getProduct_no() && c.getSender_no() == cr.getSender_no() && c.getReceiver_no() == cr.getReceiver_no()) {
                    continue;
                }
                ChatRoomVO newChatRoom = new ChatRoomVO();
                newChatRoom.setProduct_no(c.getProduct_no());
                newChatRoom.setSender_no(c.getSender_no());
                newChatRoom.setReceiver_no(c.getReceiver_no());
                chatRoomList.add(newChatRoom);
            }
        }
        return chatRoomList;
    }

    private ArrayList<ChatVO> getChatListByProductNo(ArrayList<ProductVO> productList) {
        ArrayList<ChatVO> allChatList = getAllChatList();
        ArrayList<ChatVO> chatList = new ArrayList<>();

        for (ProductVO p : productList) {
            for (ChatVO c : allChatList) {
                if (p.getProduct_no() == c.getProduct_no()) {
                    chatList.add(c);
                }
            }
        }

        return chatList;
    }

    private ArrayList<ChatVO> getAllChatList() {
        ArrayList<ChatVO> chatList = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String SQL = "SELECT * FROM chat";
        try {
            ps = conn.prepareStatement(SQL);
            rs = ps.executeQuery();
            chatList = new ArrayList<ChatVO>();
            while (rs.next()) {
                ChatVO chat = new ChatVO();
                chat.setProduct_no(rs.getInt("product_no"));
                chat.setSender_no(rs.getInt("sender_no"));
                chat.setReceiver_no(rs.getInt("receiver_no"));
                chat.setContent(rs.getString("content").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
                chat.setSend_date(rs.getString("send_date"));
                chatList.add(chat);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return chatList;
    }
}
