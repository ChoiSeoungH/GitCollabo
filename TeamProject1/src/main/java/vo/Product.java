package vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
public class Product {
  private int no;                // 상품 번호
  private int category;          // 카테고리 번호
  private int sellerNo;          // 판매자 번호
  private String title;              // 상품명
  private int price;             // 가격
  private String description;        // 상품 설명
  private String regDate;     // 등록일
  private Boolean isAuction;         // 경매 여부
  private String sellLocation;       // 희망 거래 위치
  private int productMethod;     // 거래 방식
  private int buyerNo;           // 구매자 번호
  private String endDate;     // 판매 종료일
}

