package com.basic.team.DAO;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;

import com.basic.team.VO.User;
import com.basic.team.util.MybatisConfig;


public class UserDAO {
	
	private UserDAO() {}

	static private UserDAO instance = new UserDAO();

	static public UserDAO getInstance() {
		return instance;
	}
	
	public User checkLogin(String id, String pw) {
		
		User vo = new User();
		vo.setId(id);
		vo.setPw(pw);
		
		SqlSession session = MybatisConfig.getInstance().openSession(true);
		User u = session.selectOne("userLogin", vo);
		session.close();
		
		return u;
	}
	
	public boolean isValidId(String id) {
		SqlSession session= MybatisConfig.getInstance().openSession(true);
		String checkId = session.selectOne("validId", id);
		session.close();
		return checkId == null? true : false;
	}
	
	public int userInsert(User vo) {
		System.out.println(vo);
		SqlSession session= MybatisConfig.getInstance().openSession(true);
		int cnt = session.insert("userInsert", vo);
		session.commit();
		session.close();
		return cnt;
	}
	
	public User getOneUser(int no) {
		SqlSession session= MybatisConfig.getInstance().openSession(true);
		User user = session.selectOne("getOneUser",no);
		session.close();
		return user;
	}
	
	public ArrayList<User> getUserList() {
		SqlSession session= MybatisConfig.getInstance().openSession(true);
		ArrayList<User> list= (ArrayList)session.selectList("selectAllUsers");
		session.close();
		return list;
	}
	
	public int userUpdate(User vo) {
		SqlSession session= MybatisConfig.getInstance().openSession(true);
		int cnt = session.update("userUpdate", vo);
		session.commit();
		session.close();
		return cnt;
	}
	
	public int cashUpdate(int no, int cash) {
		SqlSession session= MybatisConfig.getInstance().openSession(true);
		User vo = new User();
		vo.setNo(no);
		vo.setCash(cash);
		int cnt = session.update("cashUpdate", vo);
		session.commit();
		session.close();
		return 1;
	}

}
