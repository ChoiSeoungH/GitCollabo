package chat;

public class ChatVO {
    private int product_no;
    private int sender_no;
    private int receiver_no;
    private String content;
    private String send_date;

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
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }
    public String getSend_date() {
        return send_date;
    }
    public void setSend_date(String send_date) {
        this.send_date = send_date;
    }
}
