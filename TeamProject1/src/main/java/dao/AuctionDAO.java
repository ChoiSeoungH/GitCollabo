package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import util.MybatisConfig;
import vo.Auction;

public class AuctionDAO {
	private AuctionDAO() {
	}
	private static AuctionDAO instance = new AuctionDAO();
	
	public static AuctionDAO getInstance() {
			return instance;
	}
	
//	경매추가일시
	public List<Auction> addAuction(Auction vo){
		SqlSession session = MybatisConfig.getInstance().openSession();
		List<Auction> list = session.selectList("mapper.product.addOneAuction",vo);
		session.commit();
		session.close();
		return list;
	}
	//전체 옥션상품 가져오기
	public List<Auction> getAllAuction(){
		SqlSession session = MybatisConfig.getInstance().openSession();
		List<Auction> list = session.selectList("mapper.product.selectAllAuction");
		session.close();
		return list;
	}
	

	//하나의 옥션 가져오기
	public List<Auction> getOneAuction(int no){
		SqlSession session = MybatisConfig.getInstance().openSession();
		List<Auction> list = session.selectList("mapper.product.getOneAuction",no);
		session.close();
		return list;
	}
	//옥션 입찰했을 때 업뎃
	public List<Auction> updateAuctionBid(Auction vo) {
		SqlSession session = MybatisConfig.getInstance().openSession();
		List<Auction> list = session.selectList("mapper.product.addBidAuction",vo);
		session.commit();
		session.close();
		return list;
	}
	
	
	
}
