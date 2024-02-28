package vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Chat {
  private int productNo;       // 상품 번호
  private int senderNo;        // 보낸 사람 번호
  private int receiverNo;      // 받는 사람 번호
  private String content;          // 채팅 내용
  private String sendDate;  // 보낸 날짜
}
