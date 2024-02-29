package vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Auction {
  private int productNo;        // 상품 번호
  private int lastPrice;        // 마지막 입찰가
  private String lastBidDate;// 마지막 입찰일
  private int lastBidderNo;     // 마지막 입찰자 번호
}
