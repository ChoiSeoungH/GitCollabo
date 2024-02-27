package vo;

public class ProductImg {
	private int no;
	private int productNo;
	private String imageUrl;
	private String regDate;
	public ProductImg(int product_no, String image_url, String reg_date) {
		super();
		this.productNo = product_no;
		this.imageUrl = image_url;
		this.regDate = reg_date;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getProduct_no() {
		return productNo;
	}
	public void setProduct_no(int product_no) {
		this.productNo = product_no;
	}
	public String getImage_url() {
		return imageUrl;
	}
	public void setImage_url(String image_url) {
		this.imageUrl = image_url;
	}
	public String getReg_date() {
		return regDate;
	}
	public void setReg_date(String reg_date) {
		this.regDate = reg_date;
	}
}
