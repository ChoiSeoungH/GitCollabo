package model.alarm;

import model.Connector;

public class AlarmDAO {

    Connector connector = new Connector(); // conn, ps, rs, getConnect(), dbClose()

    public AlarmDAO() { connector.getConnect(); }
}
