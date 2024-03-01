package product;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ProductDAO {

    private Connection conn;

    public ProductDAO() {
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

    public ArrayList<ProductVO> getAllProductList() {
        ArrayList<ProductVO> productList = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String SQL = "SELECT * FROM product";

        try {
            ps = conn.prepareStatement(SQL);
            rs = ps.executeQuery();
            productList = new ArrayList<ProductVO>();
            while (rs.next()) {
                ProductVO product = new ProductVO();
                product.setProduct_no(rs.getInt("product_no"));
                product.setCategory(rs.getInt("category"));
                product.setSeller_no(rs.getInt("seller_no"));
                product.setTitle(rs.getString("title"));
                product.setPrice(rs.getInt("price"));
                product.setContent(rs.getString("content"));
                if (rs.getString("img") != null) {
                    product.setImg(rs.getString("img"));
                }
                product.setReg_date(rs.getString("reg_date"));
                product.setAuction(rs.getInt("auction"));
                product.setSell_location(rs.getString("sell_location"));
                product.setProduct_method(rs.getInt("product_method"));
                product.setBuyer_no(rs.getInt("buyer_no"));
                product.setEnd_date(rs.getString("end_date"));
                productList.add(product);
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
        return productList;
    }

    public ArrayList<ProductVO> getProductListBySellerNo(int seller_no) {
        ArrayList<ProductVO> productList = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String SQL = "SELECT * FROM product WHERE seller_no = ?";

        try {
            ps = conn.prepareStatement(SQL);
            ps.setInt(1, seller_no);
            rs = ps.executeQuery();
            productList = new ArrayList<ProductVO>();
            while (rs.next()) {
                ProductVO product = new ProductVO();
                product.setProduct_no(rs.getInt("product_no"));
                product.setCategory(rs.getInt("category"));
                product.setSeller_no(rs.getInt("seller_no"));
                product.setTitle(rs.getString("title"));
                product.setPrice(rs.getInt("price"));
                product.setContent(rs.getString("content"));
                if (rs.getString("img") != null) {
                    product.setImg(rs.getString("img"));
                }
                product.setReg_date(rs.getString("reg_date"));
                product.setAuction(rs.getInt("auction"));
                product.setSell_location(rs.getString("sell_location"));
                product.setProduct_method(rs.getInt("product_method"));
                product.setBuyer_no(rs.getInt("buyer_no"));
                product.setEnd_date(rs.getString("end_date"));
                productList.add(product);
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
        return productList;
    }

    public String getProductImg(int product_no) {
        String SQL = "SELECT img FROM product WHERE product_no = ?";
        String img = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = conn.prepareStatement(SQL);
            ps.setInt(1, product_no);
            rs = ps.executeQuery();
            if (rs.next()) {
                img = rs.getString("img");
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
        return img;
    }

    public String getProductTitle(int product_no) {
        String SQL = "SELECT title FROM product WHERE product_no = ?";
        String title = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = conn.prepareStatement(SQL);
            ps.setInt(1, product_no);
            rs = ps.executeQuery();
            if (rs.next()) {
                title = rs.getString("title");
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
        return title;
    }

    public int getProductStatus(int product_no) {
        String SQL = "SELECT buyer_no FROM product WHERE product_no = ?";
        int status = 0;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = conn.prepareStatement(SQL);
            ps.setInt(1, product_no);
            rs = ps.executeQuery();
            if (rs.next()) {
                if (rs.getInt("buyer_no") == 0) {
                    status = 0;
                } else {
                    status = rs.getInt("buyer_no");
                }
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
        return status;
    }
}
