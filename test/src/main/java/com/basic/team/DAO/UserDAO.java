package com.basic.team.DAO;

import org.apache.ibatis.session.SqlSession;

import com.basic.team.VO.User;
import com.basic.team.util.MybatisConfig;


public class UserDAO {
	
	private UserDAO() {}

	static private UserDAO instance = new UserDAO();

	static public UserDAO getInstance() {
		return instance;
	}
	
	public int checkLogin(String id, String pw) {
		int no = 0; 
		
		User vo = new User();
		vo.setId(id);
		vo.setPw(pw);
		
		SqlSession session = MybatisConfig.getInstance().openSession(true);
		no = session.selectOne("userLogin", vo);
		session.close();
		
		return no;
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
	
	public int userUpdate(User vo) {
		SqlSession session= MybatisConfig.getInstance().openSession(true);
		int cnt = session.update("userUpdate", vo);
		session.commit();
		session.close();
		return cnt;
	}
}
