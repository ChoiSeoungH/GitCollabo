package dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import util.MybatisConfig;
import vo.User;

public class UserDAO {
	
	private UserDAO() {}

	static private UserDAO instance = new UserDAO();


  static public UserDAO getInstance() {
    return instance;
  }


  public ArrayList<User> getUserList() {
    SqlSession session = MybatisConfig.getInstance().openSession(true);
    ArrayList<User> list = (ArrayList) session.selectList("selectAllUsers");
    session.close();
    return list;
  }

  public int userInsert(User vo) {
    System.out.println(vo);
    SqlSession session = MybatisConfig.getInstance().openSession(true);
    int cnt = session.insert("userInsert", vo);
    session.commit();
    session.close();
    return cnt;
  }

  public boolean isValidId(String id) {
    SqlSession session= MybatisConfig.getInstance().openSession(true);
    String checkId = session.selectOne("validId", id);
    session.close();
    return checkId == null? true : false;
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
    SqlSession session = MybatisConfig.getInstance().openSession(true);
    int cnt = session.update("userUpdate", vo);
    session.commit();
    session.close();
    return cnt;
  }

  public int cashUpdate(int no, int cash) {
    SqlSession session = MybatisConfig.getInstance().openSession(true);
    User vo = new User();
    vo.setNo(no);
    vo.setCash(cash);
    int cnt = session.update("cashUpdate", vo);
    session.commit();
    session.close();
    return 1;
  }

  public int setPenalty(int no, int penalty, int status) {
    SqlSession session = MybatisConfig.getInstance().openSession(true);
    User vo = new User();
    vo.setNo(no);
    vo.setPenalty(penalty);
    vo.setStatus(status);
    int cnt = session.update("penaltyUpdate", vo);
    session.commit();
    session.close();
    return 1;
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


  public int updateUserStatus(int userNo, int status) {
    SqlSession session = MybatisConfig.getInstance().openSession();
    User user = new User();
    user.setNo(userNo);
    user.setStatus(status);
    int cnt = session.update("updateUserStatus", user);
    session.commit();
    session.close();
    return cnt;
  }
  public int updateUserStatus(int userNo, int status, int cash) {
    SqlSession session = MybatisConfig.getInstance().openSession();
    User user = new User();
    user.setNo(userNo);
    user.setStatus(status);
    user.setCash(cash);
    System.out.println("cash : "+cash);
    int cnt = session.update("updateUserStatus", user);
    session.commit();
    session.close();
    return cnt;
  }

}
