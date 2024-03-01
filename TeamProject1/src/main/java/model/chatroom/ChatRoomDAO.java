package model.chatroom;

import model.Connector;

public class ChatRoomDAO {

    Connector connector = new Connector(); // conn, ps, rs, getConnect(), dbClose()

    public ChatRoomDAO() { connector.getConnect(); }
}
