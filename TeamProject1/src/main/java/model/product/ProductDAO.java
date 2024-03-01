package model.product;

import model.Connector;

public class ProductDAO {

    Connector connector = new Connector(); // conn, ps, rs, getConnect(), dbClose()
    public ProductDAO() { connector.getConnect(); }
}
