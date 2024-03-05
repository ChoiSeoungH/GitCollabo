<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 카카오 스크립트 -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
Kakao.init('00ad72e29796cba962a38d1cdb07c5e5'); //발급받은 키 중 javascript키를 사용해준다.
console.log(Kakao.isInitialized()); // sdk초기화여부판단
//카카오로그인
function kakaoLogin() {
    Kakao.Auth.login({
        success: function (response) {
            Kakao.API.request({
                url: '/v2/user/me',
                success: function (response) {
                    console.log(response);

                    fetch("kakaoLogin.do", {
                        method: "POST",
                        headers: {"Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"},
                        body: "id=" + response['id']+"&nickname="+response.properties.nickname,
                    })
                    .then(response => {
                        // 요청 성공 시 처리할 코드
                        console.log("요청 성공:", response);
                    })
                    .then(getResult)
                    .catch(error => {
                        // 요청 실패 시 처리할 코드
                        console.error("요청 실패:", error);
                    });
                    
                    function getResult(nextPage) {
            			location.href="${ctx}/main.do";
            		}
                },
                fail: function (error) {
                    // Kakao.API.request 요청 실패 시 처리할 코드
                    console.error("Kakao.API.request 요청 실패:", error);
                },
            });
        },
        fail: function (error) {
            // Kakao.Auth.login 요청 실패 시 처리할 코드
            console.error("Kakao.Auth.login 요청 실패:", error);
        },
    });
}
  
//카카오로그아웃  
function kakaoLogout() {
    if (Kakao.Auth.getAccessToken()) {
      Kakao.API.request({
        url: '/v1/user/unlink',
        success: function (response) {
        	console.log(response)
        },
        fail: function (error) {
          console.log(error)
        },
      })
      Kakao.Auth.setAccessToken(undefined)
    }
  }  
</script>
<!-- 	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<script>
		//	00ad72e29796cba962a38d1cdb07c5e5
		window.Kakao.init("00ad72e29796cba962a38d1cdb07c5e5");
		
		function kakaoLogin(){
			window.Kakao.Auth.login({
				scope:'profile_nickname, profile_image',
				success: function(authObj){
					console.log(authObj);
					window.Kakao.API.request({
						url:'/v2/user/me',
						success: res =>{
							const kakao_account = res.kakao_account;
							console.log(kakao_account);
						}
					});
				}
			})
		}
		
		function kakaoLogout() {
		    if (Kakao.Auth.getAccessToken()) {
		      Kakao.API.request({
		        url: '/v1/user/unlink',
		        success: function (response) {
		        	console.log(response)
		        },
		        fail: function (error) {
		          console.log(error)
		        },
		      })
		      Kakao.Auth.setAccessToken(undefined)
		    }
		  }  -->

	</script>
</body>
</html>