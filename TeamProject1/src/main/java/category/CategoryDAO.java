package category;

import model.Connector;

public class CategoryDAO {

    Connector connector = new Connector(); // conn, ps, rs, getConnect(), dbClose()

    public CategoryDAO() { connector.getConnect(); }
}
