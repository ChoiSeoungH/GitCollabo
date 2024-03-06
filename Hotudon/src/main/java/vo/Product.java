package vo;

public class Product {
	private int no;
	private int category;
	private int sellerNo;
	private String title;
	private int price;
	private String description;
	private String regDate;
	private boolean auction;
	private String sellLocation;
	private int productMethod;
	private int buyerNo;
	private String endDate;
	@Override
	public String toString() {
		return "Product [no=" + no + ", category=" + category + ", sellerNo=" + sellerNo + ", title=" + title
				+ ", price=" + price + ", description=" + description + ", regDate=" + regDate + ", auction=" + auction
				+ ", sellLocation=" + sellLocation + ", productMethod=" + productMethod + ", buyerNo=" + buyerNo
				+ ", endDate=" + endDate + "]";
	}
	public Product(int no, int category, int sellerNo, String title, int price, String description, String regDate,
			boolean auction, String sellLocation, int productMethod, int buyerNo, String endDate) {
		super();
		this.no = no;
		this.category = category;
		this.sellerNo = sellerNo;
		this.title = title;
		this.price = price;
		this.description = description;
		this.regDate = regDate;
		this.auction = auction;
		this.sellLocation = sellLocation;
		this.productMethod = productMethod;
		this.buyerNo = buyerNo;
		this.endDate = endDate;
	}
    public boolean isAuction() {
        return auction;
    }
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getCategory() {
		return category;
	}
	public void setCategory(int category) {
		this.category = category;
	}
	public int getSellerNo() {
		return sellerNo;
	}
	public void setSellerNo(int sellerNo) {
		this.sellerNo = sellerNo;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public boolean auction() {
		return auction;
	}
	public void setAuction(boolean auction) {
		this.auction =auction;
	}
	public String getSellLocation() {
		return sellLocation;
	}
	public void setSellLocation(String sellLocation) {
		this.sellLocation = sellLocation;
	}
	public int getProductMethod() {
		return productMethod;
	}
	public void setProductMethod(int productMethod) {
		this.productMethod = productMethod;
	}
	public int getBuyerNo() {
		return buyerNo;
	}
	public void setBuyerNo(int buyerNo) {
		this.buyerNo = buyerNo;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public Product() {}
	
	public Product(int no, String endDate) {

		this.no = no;
		this.endDate =endDate;// TODO Auto-generated constructor stub
	}
	//autoend check용



}