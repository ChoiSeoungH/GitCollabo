package vo;

public class Auction {
	private int productNo; // 상품번호
	private int lastPrice; // 마지막 입찰가
	private String lastBidDate; //마지막입찰일
	private int  lastBidderNo;  //마지막입찰자 유저
	public Auction(int product_no, int last_price, String last_bid_date, int last_bidder_no) {
		super();
		this.productNo = product_no;
		this.lastPrice = last_price;
		this.lastBidDate = last_bid_date;
		this.lastBidderNo = last_bidder_no;
	}
	public int getProduct_no() {
		return productNo;
	}
	public void setProduct_no(int product_no) {
		this.productNo = product_no;
	}
	public int getLast_price() {
		return lastPrice;
	}
	public void setLast_price(int last_price) {
		this.lastPrice = last_price;
	}
	public String getLast_bid_date() {
		return lastBidDate;
	}
	public void setLast_bid_date(String last_bid_date) {
		this.lastBidDate = last_bid_date;
	}
	public int getLast_bidder_no() {
		return lastBidderNo;
	}
	public void setLast_bidder_no(int last_bidder_no) {
		this.lastBidderNo = last_bidder_no;
	}
	
	
}
