package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.mysql.cj.Session;

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
	public Auction getOneAuction(int no){
		SqlSession session = MybatisConfig.getInstance().openSession();
		Auction list = session.selectOne("mapper.product.getOneAuction",no);
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
	//옥션 최신상품 3개 가져오기
	public List<Auction> auctionLatestThree(){
		SqlSession session = MybatisConfig.getInstance().openSession();
		List<Auction> list = session.selectList("mapper.product.auctionLatestThree");
		session.close();
		return list;
	}
	// 해당 경매중이거나 경매종료된 유저 가져오기
	public List<Auction> getAllBidUserNo(int no){
	SqlSession session = MybatisConfig.getInstance().openSession();
	List<Auction> list = session.selectList("mapper.product.getAllBidUserNo", no);
	session.close();
	return list;
	}
	//경매상품 재등록
	public int UpdateReAddProduct(int productNo,String regDate) {
		SqlSession session =MybatisConfig.getInstance().openSession();
		Auction vo = new Auction();
		vo.setProductNo(productNo);
		vo.setLastBidDate(regDate);
		int i =session.update("mapper.product.updateAuctionProduct",vo);
		session.commit();
		session.close();
		return 1;
	}
	public String getOneAuctioBidNo(int productNo) {
		SqlSession session = MybatisConfig.getInstance().openSession();
		String getNo = session.selectOne("mapper.product.getOneAuctionNo",productNo);
		session.close();
		return getNo;
	}

	
	
}
