package vo;

public class ProductImg {
	private int no;
	private int productNo;
	private String imageUrl;
	private String regDate;
	@Override
	public String toString() {
		return "ProductImg [no=" + no + ", productNo=" + productNo + ", imageUrl=" + imageUrl + ", regDate=" + regDate
				+ "]";
	}
	public ProductImg() {}
	public ProductImg(int no, int productNo, String imageUrl, String regDate) {
		super();
		this.no = no;
		this.productNo = productNo;
		this.imageUrl = imageUrl;
		this.regDate = regDate;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getProductNo() {
		return productNo;
	}
	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}
	public String getImageUrl() {
		return imageUrl;
	}
	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
}