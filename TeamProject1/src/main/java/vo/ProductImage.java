package vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductImage {
  private int no;               // 이미지 번호
  private int productNo;        // 상품 번호
  private String imageUrl;          // 이미지 URL
  private String regDate;    // 등록일
}

