package vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Alarm {
  private int no;              // 알람 번호
  private int userNo;          // 유저 번호
  private int type;            // 알람 유형
  private Boolean alarmStatus;     // 알람 상태 (읽음/안읽음)
  private String regDate;   // 알람 날짜
  private String content;          // 알람 내용
}
