package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import util.MybatisConfig;
import vo.ProductImg;

public class ProductImgDAO {
	private ProductImgDAO() {}
	private static ProductImgDAO instance = new ProductImgDAO();
	public static ProductImgDAO getInstance() {
		return instance;
	}
	// 전체 상품 이미지 불러오기
	public List<ProductImg> getAllProductImg(){
		SqlSession session = MybatisConfig.getInstance().openSession();
		List<ProductImg> list = session.selectList("mapper.product.getAllProductImg");
		session.close();
		return list;
	}
	// 상품 추가시 이미지 추가하기
	public List<ProductImg> addOneProductImg(ProductImg vo){
		SqlSession session = MybatisConfig.getInstance().openSession();
		List<ProductImg> list =session.selectList("mapper.product.insertProductImg",vo);
		session.commit();
		session.close();
		return list;
	}
	// 상품선택시 상품이미지 뺴오기 
	public List<ProductImg> getOneProductImg(int no){
		SqlSession session = MybatisConfig.getInstance().openSession();
		List<ProductImg> list = session.selectList("mapper.product.getOneImage",no);
		session.close();
		return list;
	}
	
		public List<ProductImg> getOneUpdageImg(int productNo,String imgurl) {
		SqlSession session = MybatisConfig.getInstance().openSession();
		ProductImg vo = new ProductImg();
		vo.setImageUrl(imgurl);
		vo.setProductNo(productNo);
		List<ProductImg> list =  session.selectList("mapper.product.getOneUpdateImg",vo);
		session.commit();
		session.close();
		return list;
	}
}
