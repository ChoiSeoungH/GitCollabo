package model.product;

import model.Connector;

public class ProductImageDAO {

    Connector connector = new Connector(); // conn, ps, rs, getConnect(), dbClose()

    public ProductImageDAO() { connector.getConnect(); }
}
