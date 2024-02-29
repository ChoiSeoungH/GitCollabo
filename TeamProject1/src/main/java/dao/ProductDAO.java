package dao;


import org.apache.ibatis.session.SqlSession;
import util.MybatisConfig;
import vo.Product;

import java.util.List;
public class ProductDAO {

  private ProductDAO() {
  }
  static private ProductDAO instance = new ProductDAO();

  static public ProductDAO getInstance() {
    return instance;
  }

  public List<Product> getAllProduct() {
    // 컨넥션 객체 + sql 쿼리문 실행해주는 객체
    SqlSession session = MybatisConfig.getInstance().openSession();
    List<Product> list = session.selectList("productList");
    session.close();
    return list;
  }

  //상품 검색 조회
  public List<Product> getSearchList(String title){
    SqlSession session = MybatisConfig.getInstance().openSession();
    List<Product> list = session.selectList("mapper.product.getSearchProduct",title);
    session.close();
    return list;
  }

  // 상품검색했을떄 이미지도 불러오기
  public List<Product> getSearchListImg(String title){
    SqlSession session = MybatisConfig.getInstance().openSession();
    List<Product> list = session.selectList("mapper.product.selectAllProductImg",title);
    session.close();
    return list;
  }
  // 상품등록
  public List<Product> insertOneProduct(Product product){
    SqlSession session = MybatisConfig.getInstance().openSession();
    List<Product> list = session.selectList("mapper.product.productInsert",product);
    session.commit();
    session.close();
    return list;
  }
  public int getselectAucton() {
    SqlSession session = MybatisConfig.getInstance().openSession();
    int no = session.selectOne("mapper.product.getProductNo");
    session.close();
    return no;
  }
  public List<Product> getProductsByLocation(String location) {
    SqlSession session = MybatisConfig.getInstance().openSession();
    List<Product> list = session.selectList("getProductsByLocation", location);
    session.close();
    return list;
  }
  public List<Product> getDeliveryProductsByLocation(String location) {
    SqlSession session = MybatisConfig.getInstance().openSession();
    List<Product> list = session.selectList("getDeliveryProductsByLocation", location);
    session.close();
    return list;
  }
}








