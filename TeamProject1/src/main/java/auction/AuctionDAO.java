package auction;

import model.Connector;

public class AuctionDAO {

    Connector connector = new Connector(); // conn, ps, rs, getConnect(), dbClose()

    public AuctionDAO() { connector.getConnect(); }
}
