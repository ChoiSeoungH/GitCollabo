package vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Category {
  private int no;       // 카테고리 번호
  private String name;      // 카테고리 이름
}
