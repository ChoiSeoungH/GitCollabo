package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import util.MybatisConfig;
import vo.ProductImage;

public class ProductImgDAO {
	private ProductImgDAO() {}
	private static ProductImgDAO instance = new ProductImgDAO();
	public static ProductImgDAO getInstance() {
		return instance;
	}
	// 전체 상품 이미지 불러오기
	public List<ProductImage> getAllProductImg(){
		SqlSession session = MybatisConfig.getInstance().openSession();
		List<ProductImage> list = session.selectList("getAllProductImage");
		session.close();
		return list;
	}
	// 상품 추가시 이미지 추가하기
	public List<ProductImage> addOneProductImg(ProductImage vo){
		SqlSession session = MybatisConfig.getInstance().openSession();
		List<ProductImage> list =session.selectList("insertProductImg",vo);
		session.commit();
		session.close();
		return list;
	}
	// 상품선택시 상품이미지 뺴오기 
	public List<ProductImage> getOneProductImg(int no){
		SqlSession session = MybatisConfig.getInstance().openSession();
		List<ProductImage> list = session.selectList("getOneImage",no);
		session.close();
		return list;
	}
}
