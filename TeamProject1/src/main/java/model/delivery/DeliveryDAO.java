package model.delivery;

import model.Connector;

public class DeliveryDAO {

    Connector connector = new Connector(); // conn, ps, rs, getConnect(), dbClose()

    public DeliveryDAO() { connector.getConnect(); }
}
