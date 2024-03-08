package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.mysql.cj.Session;

import util.MybatisConfig;
import vo.Auction;
import vo.Product;

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
			List<Product> list = session.selectList("mapper.product.selectAllProduct");
			session.close();
			return list;
		}
		
		//카테고리 리스트 조회하기
		public List<Product> getCategoryList(int category){
			SqlSession session =MybatisConfig.getInstance().openSession();
			List<Product> list = session.selectList("mapper.product.getCateProductList", category);
			session.close();
			return list;
		}
		
		//최신상품 3개 가져오기
		public List<Product> getLatestProduct(){
			SqlSession session = MybatisConfig.getInstance().openSession();
			List<Product> list = session.selectList("mapper.product.latestProductThree");
			session.close();
			return list;
			
		}
		
		// 상품검색했을떄 이미지도 불러오기		
		public List<Product> getSearchListImg(String title){
			SqlSession session = MybatisConfig.getInstance().openSession();
			List<Product> list = session.selectList("mapper.product.getSearchProduct",title);
			session.close();
			return list;
		}
		// 상품등록		
		public Product insertOneProduct(Product product){
			SqlSession session = MybatisConfig.getInstance().openSession();
			Product list = session.selectOne("mapper.product.productInsert",product);
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
		// 상품클릭시 상품 제품 가지고 오기		
		public Product getProductNoContent(int no){
			SqlSession session = MybatisConfig.getInstance().openSession();
			Product list = session.selectOne("mapper.product.getOneProduct",no);
			session.close();
			return list;
		
		}
		//경매상품에 관한 연관된 카테고리 제품들 가져오기
		public List<Product> getAboutCategory(int no){
			SqlSession session = MybatisConfig.getInstance().openSession();
			List<Product> list =session.selectList("mapper.product.getAboutCategory", no);
			session.close();
			return list;
		}
		// 나의 판매 상품 다가져오기		
		public List<Product> getAllMyProduct(int no){
		SqlSession session = MybatisConfig.getInstance().openSession();
		List<Product> list = session.selectList("mapper.product.getSellUserProductList",no);
		session.close();
		return list;
		}
		//내가 구매한 상품들 가져오기
		public List<Product> getAllBuyProduct(int no){
			SqlSession session = MybatisConfig.getInstance().openSession();
			List<Product> list =session.selectList("mapper.product.getBuyUserProductList",no); 
			session.close();
			return list;
		}
		// 판매하는 제품 삭제하기		
		public int sellerRemoveOne(int no) {
			SqlSession session = MybatisConfig.getInstance().openSession();
			int check = session.update("mapper.product.SellproductDelete",no);
			session.commit();
			session.close();
			return check;
		}
		//상품 업데이트 하기
		public int getOneUpdate(Product vo) {
			SqlSession session = MybatisConfig.getInstance().openSession();
			int check = session.update("mapper.product.updateProduct",vo);
			session.commit();
			session.close();
			return check;
		}
		public int updateDate(int no) {
			SqlSession session =MybatisConfig.getInstance().openSession();
			int check = session.update("mapper.product.updateEndDate",no);
			session.commit();
			session.close();
			return check;
		}
	
		

		

		
}
