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
	public List<ProductImg> getAllProductImg(){
		SqlSession session = MybatisConfig.getInstance().openSession();
		List<ProductImg> list = session.selectList("mapper.product.getAllProductImg");
		session.close();
		return list;
	}
	
	public List<ProductImg> addOneProductImg(ProductImg vo){
		SqlSession session = MybatisConfig.getInstance().openSession();
		List<ProductImg> list =session.selectList("mapper.product.insertProductImg",vo);
		session.commit();
		session.close();
		return list;
	}
}
