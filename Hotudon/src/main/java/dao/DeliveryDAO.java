package dao;

import org.apache.ibatis.session.SqlSession;
import vo.Delivery;

import util.MybatisConfig;

import java.util.HashMap;

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

}
