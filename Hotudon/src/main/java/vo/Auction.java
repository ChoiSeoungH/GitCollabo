package vo;

public class Auction {
	private int productNo; // 상품번호
	private int lastPrice; // 마지막 입찰가
	private String lastBidDate; //마지막입찰일
	private int  lastBidderNo;  //마지막입찰자 유저
	@Override
	public String toString() {
		return "Auction [productNo=" + productNo + ", lastPrice=" + lastPrice + ", lastBidDate=" + lastBidDate
				+ ", lastBidderNo=" + lastBidderNo + "]";
	}
	public Auction(int productNo, int lastPrice, String lastBidDate, int lastBidderNo) {
		super();
		this.productNo = productNo;
		this.lastPrice = lastPrice;
		this.lastBidDate = lastBidDate;
		this.lastBidderNo = lastBidderNo;
	}
	public int getProductNo() {
		return productNo;
	}
	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}
	public int getLastPrice() {
		return lastPrice;
	}
	public void setLastPrice(int lastPrice) {
		this.lastPrice = lastPrice;
	}
	public String getLastBidDate() {
		return lastBidDate;
	}
	public void setLastBidDate(String lastBidDate) {
		this.lastBidDate = lastBidDate;
	}
	public int getLastBidderNo() {
		return lastBidderNo;
	}
	public void setLastBidderNo(int lastBidderNo) {
		this.lastBidderNo = lastBidderNo;
	}
	public Auction() {}
	public Auction(int no) {
		this.productNo= no;
	}
	
}
