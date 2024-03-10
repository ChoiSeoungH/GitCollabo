package dao;

import org.apache.ibatis.session.SqlSession;
import vo.Delivery;

import util.MybatisConfig;
import vo.Product;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DeliveryDAO {

  private DeliveryDAO() {
  }

  private static DeliveryDAO instance = new DeliveryDAO();

  public static DeliveryDAO getInstance() {
    return instance;
  }

  public int insertDelivery(Delivery vo) {
    SqlSession session = MybatisConfig.getInstance().openSession();

    int cnt = session.insert("insertDelivery", vo);
    session.commit();
    session.close();
    return cnt;
  }


  public int updateDeliveryStatus(int productNo, int newStatus) {
    SqlSession session = MybatisConfig.getInstance().openSession();
    HashMap<String, Object> params = new HashMap<>();
    params.put("productNo", productNo);
    params.put("newStatus", newStatus);
    int cnt = session.update("updateDeliveryStatus", params);
    session.commit();
    session.close();
    return cnt;
  }

  public int updateDelivery(Delivery vo) {
    SqlSession session = MybatisConfig.getInstance().openSession();

    int cnt = session.update("updateDelivery", vo);
    session.commit();
    session.close();
    return cnt;
  }

  public Object getDeliveryByLocation(String location) {
    SqlSession session = MybatisConfig.getInstance().openSession();
    List<Delivery> list = session.selectList("getDeliveryByLocation", location);
    session.close();
    return list;
  }
  public List<Map<String, Object>> getIncome(int deliverNo) {
    SqlSession session = MybatisConfig.getInstance().openSession();
    List<Map<String, Object>> income = session.selectList("getIncome", deliverNo);
    session.close();
    return income;
  }

}
