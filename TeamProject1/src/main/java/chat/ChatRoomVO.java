package chat;

import product.ProductDAO;

public class ChatRoomVO {
    private String product_img;
    private int product_no;
    private int sender_no;
    private int receiver_no;
    private String title;
    private int status;

    public ChatRoomVO() { }

    public ChatRoomVO(int product_no, int sender_no, int receiver_no) {
        this.product_no = product_no;
        this.sender_no = sender_no;
        this.receiver_no = receiver_no;

        this.product_img = new ProductDAO().getProductImg(product_no);
        this.title = new ProductDAO().getProductTitle(product_no);
        this.status = new ProductDAO().getProductStatus(product_no);
    }

    public String getProduct_img() {
        return product_img;
    }
    public void setProduct_img(String product_img) {
        this.product_img = product_img;
    }
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }
    public int getStatus() {
        return status;
    }
    public void setStatus(int status) {
        this.status = status;
    }
    public int getProduct_no() {
        return product_no;
    }
    public void setProduct_no(int product_no) {
        this.product_no = product_no;
    }
    public int getSender_no() {
        return sender_no;
    }
    public void setSender_no(int sender_no) {
        this.sender_no = sender_no;
    }
    public int getReceiver_no() {
        return receiver_no;
    }
    public void setReceiver_no(int receiver_no) {
        this.receiver_no = receiver_no;
    }
}
