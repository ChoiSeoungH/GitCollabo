package dao;


import org.apache.ibatis.session.SqlSession;
import util.MybatisConfig;
import vo.Product;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

public class ProductDAO {

  private ProductDAO() {
  }
  private static ProductDAO instance = new ProductDAO();
  public static ProductDAO getInstance() {
    return instance;
  }
  // 전체상품 가져오기
  public List<Product> getAllProduct(){

    SqlSession session =MybatisConfig.getInstance().openSession();
    List<Product> list = session.selectList("selectAllProduct");
    session.close();
    return list;
  }

  //카테고리 리스트 조회하기
  public List<Product> getCategoryList(int category){
    SqlSession session =MybatisConfig.getInstance().openSession();
    List<Product> list = session.selectList("getCateProductList", category);
    session.close();
    return list;
  }


  //상품 검색 조회
  public List<Product> getSearchList(String title){
    SqlSession session = MybatisConfig.getInstance().openSession();
    List<Product> list = session.selectList("getSearchProduct",title);
    session.close();
    return list;
  }

  //최신상품 3개 가져오기
  public List<Product> getLatestProduct(){
    SqlSession session = MybatisConfig.getInstance().openSession();
    List<Product> list = session.selectList("latestProductThree");
    session.close();
    return list;

  }

  // 상품검색했을떄 이미지도 불러오기
  public List<Product> getSearchListImg(String title){
    SqlSession session = MybatisConfig.getInstance().openSession();
    List<Product> list = session.selectList("getSearchProduct",title);
    session.close();
    return list;
  }
  // 상품등록
  public List<Product> insertOneProduct(Product product){
    SqlSession session = MybatisConfig.getInstance().openSession();
    List<Product> list = session.selectList("productInsert",product);
    session.commit();
    session.close();
    return list;
  }
  public int getselectAucton() {
    SqlSession session = MybatisConfig.getInstance().openSession();
    int no = session.selectOne("getProductNo");
    session.close();
    return no;
  }
  // 상품클릭시 상품 제품 가지고 오기
  public List<Product> getProductNoContent(int no){
    SqlSession session = MybatisConfig.getInstance().openSession();
    List<Product> list = session.selectList("getOneProduct",no);
    session.close();
    return list;

  }
  public List<Product> getProductsByLocation(String location) {
    SqlSession session = MybatisConfig.getInstance().openSession();
    List<Product> list = session.selectList("getProductsByLocation", location);
    session.close();
    return list;
  }

  public Object getDeliveryProductsByLocation(String location) {
    SqlSession session = MybatisConfig.getInstance().openSession();
    List<Product> list = session.selectList("getDeliveryProductsByLocation", location);
    session.close();
    return list;
  }

  public void updateEndDate(int productNo, Date newEndDate) {
    SqlSession session = MybatisConfig.getInstance().openSession();
    HashMap<String, Object> params = new HashMap<>();
    params.put("no", productNo);
    params.put("endDate", newEndDate);
    System.out.println(params);
    session.update("productEnd", params);
    session.commit();
    session.close();
  }
}



