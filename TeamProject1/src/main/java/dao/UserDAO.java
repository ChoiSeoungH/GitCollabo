package dao;


import org.apache.ibatis.session.SqlSession;

import util.MybatisConfig;
import vo.User;

import java.util.List;

public class UserDAO {

  private UserDAO() {
  }

  static private UserDAO instance = new UserDAO();

  static public UserDAO getInstance() {
    return instance;
  }


  public List<User> userList() {
    // 컨넥션 객체 + sql 쿼리문 실행해주는 객체
    SqlSession session = MybatisConfig.getInstance().openSession();
    List<User> list = session.selectList("userList");
    session.close();
    return list;
  }

  public int userInsert(User vo) {
    SqlSession session = MybatisConfig.getInstance().openSession();
    int cnt = session.insert("userInsert", vo);
    session.commit();
    session.close();
    return cnt;
  }

  public boolean isValidId(String id) {
    SqlSession session = MybatisConfig.getInstance().openSession();
    int cnt = session.selectOne("validuserId", id);
    session.close();
    return cnt == 0? true : false;
  }

  public User checkLogin(String id, String pw) {
    User vo = new User();
    vo.setId(id);
    vo.setPw(pw);
    SqlSession session = MybatisConfig.getInstance().openSession();
    User u = session.selectOne("checkLogin", vo);
    session.close();
    return u;
  }

  public int getuserNo(String id) {
    SqlSession session = MybatisConfig.getInstance().openSession();
    int cnt = session.insert("getuserNo", id);
    session.close();
    return cnt;
  }

  public int userDelete(String id) {
    SqlSession session = MybatisConfig.getInstance().openSession();
    int cnt = session.delete("userDelete", id);
    session.commit();
    session.close();
    return cnt;
  }

  public User userContent(int num) {
    SqlSession session = MybatisConfig.getInstance().openSession();
    User vo = session.selectOne("userContent", num);
    session.close();
    return vo;
  }

  public User getOneUser(int no) {
    SqlSession session= MybatisConfig.getInstance().openSession(true);
    User user = session.selectOne("getOneUser",no);
    session.close();
    return user;
  }

  public int userUpdate(User vo) {
    SqlSession session = MybatisConfig.getInstance().openSession();
    int cnt = session.update("userUpdate", vo);
    session.commit();
    session.close();
    return cnt;
  }

  public int locationUpdate(User vo) {
    SqlSession session = MybatisConfig.getInstance().openSession();
    int cnt = session.update("locationUpdate", vo);
    session.commit();
    session.close();
    return cnt;
  }

  public List<User> getUsersByLocation(String location) {
    SqlSession session = MybatisConfig.getInstance().openSession();
    List<User> list = session.selectList("getUserByLocation", location);
    session.close();
    return list;
  }

}
