package vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Delivery {
  private int no;              // 배송 번호
  private int productNo;       // 상품 번호
  private int deliverNo;       // 배송 기사 번호
  private int price;           // 배송비
  private int status;          // 배송 상태
  private String regDate;   // 배송 신청일
  private String location;         // 도착 장소
}