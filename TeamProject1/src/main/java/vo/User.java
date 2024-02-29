package vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {
  private int no;           // 유저 번호
  private String id;            // 아이디
  private String imgUrl;        // 프로필 이미지 URL
  private String pw;            // 비밀번호
  private String name;          // 이름
  private String nickname;      // 닉네임
  private int cash;         // 보유 캐시
  private String phone;         // 전화번호
  private String location;      // 주소
  private String regDate; // 가입일
  private int penalty;      // 패널티
  private Boolean deliver;      // 배달 기사 여부
  private int status;       // 상태 (0: 오프라인, 1: 휴식, 2: 대기, 3: 배송중, 4: 비활성화(탈퇴))
}
