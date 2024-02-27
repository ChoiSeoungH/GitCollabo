package vo;

public class Category {
	private int no;
	private String name;
	public Category(int no, String name) {
		super();
		this.no = no;
		this.name = name;
	}
	public int getCategory_no() {
		return no;
	}
	public void setCategory_no(int no) {
		this.no = no;
	}
	public String getCategory_name() {
		return name;
	}
	public void setCategory_name(String name) {
		this.name = name;
	}

}
