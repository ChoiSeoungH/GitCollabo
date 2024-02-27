package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.mysql.cj.Session;

import util.MybatisConfig;
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
		
		
		//상품 검색 조회
		public List<Product> getSearchList(String title){
			SqlSession session = MybatisConfig.getInstance().openSession();
			List<Product> list = session.selectList("mapper.product.getSearchProduct",title);
			session.close();
			return list;
		}
		
		// 상품검색했을떄 이미지도 불러오기		
		public List<Product> getSearchListImg(String title){
			SqlSession session = MybatisConfig.getInstance().openSession();
			List<Product> list = session.selectList("mapper.product.selectAllProductImg",title);
			session.close();
			return list;
		}
		// 상품등록		
		public List<Product> insertOneProduct(Product product){
			SqlSession session = MybatisConfig.getInstance().openSession();
			List<Product> list = session.selectList("mapper.product.productInsert",product);
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
	public List<Product> getProductsByLocation(String location) {
		SqlSession session = MybatisConfig.getInstance().openSession();
		List<Product> list = session.selectList("getProductsByLocation", location);
		session.close();
		return list;
	}

		
}
