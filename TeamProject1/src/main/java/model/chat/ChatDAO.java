package model.chat;

import model.Connector;

public class ChatDAO {

    Connector connector = new Connector(); // conn, ps, rs, getConnect(), dbClose()

    public ChatDAO() { connector.getConnect(); }
}
