package dao;


import org.apache.ibatis.session.SqlSession;
import util.MybatisConfig;
import vo.Product;

import java.util.List;

public class ProductDao {

  private ProductDao() {
  }
  static private ProductDao instance = new ProductDao();

  static public ProductDao getInstance() {
    return instance;
  }

  public List<Product> productList() {
    // 컨넥션 객체 + sql 쿼리문 실행해주는 객체
    SqlSession session = MybatisConfig.getInstance().openSession();
    List<Product> list = session.selectList("productList");
    session.close();
    return list;
  }

  public List<Product> getProductsByLocation(String location) {
    SqlSession session = MybatisConfig.getInstance().openSession();
    List<Product> list = session.selectList("getProductsByLocation", location);
    session.close();
    return list;
  }
}


  public List<Product> getDeliveryProductsByLocation(String location) {
    SqlSession session = MybatisConfig.getInstance().openSession();
    List<Product> list = session.selectList("getDeliveryProductsByLocation", location);
    session.close();
    return list;
  }

