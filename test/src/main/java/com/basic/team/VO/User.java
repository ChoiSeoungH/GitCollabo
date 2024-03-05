package com.basic.team.VO;

public class User {
    
    private int no;				// 유저 번
    private String id;			// 아이디 (이메일 형)
    private String imgUrl;		// 프로필 이미
    private String pw;			// 비밀번
    private String name;		// 이름
    private String nickname;	// 닉네임	
    private int cash;			// 보유 캐시
    private String phone;		// 전화번호
    private String location;	// 지역	
    private String regDate;		// 가입일
    private int penalty;		// 패널티
    private boolean deliver;	// 배달 기사 등록 여부
    private int status;			// 0 : 오프라인, 1 : 휴식, 2 : 대기, 3 : 배송중, 4 : 비활성화(탈퇴)
	
    public User() {}
    public User(String id, String pw, String name, String phone, String nickname) {
		super();
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.phone = phone;
		this.nickname = nickname;
	}
    
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getImgUrl() {
		return imgUrl;
	}
	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public int getCash() {
		return cash;
	}
	public void setCash(int cash) {
		this.cash = cash;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public int getPenalty() {
		return penalty;
	}
	public void setPenalty(int penalty) {
		this.penalty = penalty;
	}
	public boolean isDeliver() {
		return deliver;
	}
	public void setDeliver(boolean deliver) {
		this.deliver = deliver;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	@Override
	public String toString() {
		return "User [no=" + no + ", id=" + id + ", imgUrl=" + imgUrl + ", pw=" + pw + ", name=" + name + ", nickname="
				+ nickname + ", cash=" + cash + ", phone=" + phone + ", location=" + location + ", regDate=" + regDate
				+ ", penalty=" + penalty + ", deliver=" + deliver + ", status=" + status + "]";
	}
    
    
}
