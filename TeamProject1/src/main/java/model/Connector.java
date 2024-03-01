package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class Connector {

    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    public void getConnect() {
        String URL = "jdbc:mysql://localhost:3306/team?characterEncoding=UTF-8&serverTimezone=UTC&useSSL=false";
        String user = "root";
        String password = "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL, user, password);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void dbClose() {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Getters and Setters


    public Connection getConn() {
        return conn;
    }

    public PreparedStatement getPs() {
        return ps;
    }

    public ResultSet getRs() {
        return rs;
    }

    public void setConn(Connection conn) {
        this.conn = conn;
    }

    public void setPs(PreparedStatement ps) {
        this.ps = ps;
    }

    public void setRs(ResultSet rs) {
        this.rs = rs;
    }
}
