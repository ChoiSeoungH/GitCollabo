<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%--강남구 역삼동 831-3--%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>뜨끈한 우동</title>
  <!-- Add your CSS file link here -->
  <style>
      body {
          margin: 0;
          padding: 0;
          display: flex;
          flex-direction: column; /* Children to stack vertically */
      }
      #search-form {
          margin-top: 20px; /* Spacing from the map */
          text-align: center;
      }

      #map-container {
          width: 1200px;
          height: 600px;
          position: relative; /* For absolute positioning of the buttons */
      }

      #address-form {
          margin-top: 20px; /* Spacing from the map */
          text-align: center;
      }

      .address-input {
          margin: 10px 0; /* Spacing between inputs */
          width: 50%;
      }
  </style>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<div id="search-form">
  <input type="text" id="search" class="address-input" placeholder="검색할 주소를 입력하세요">
  <button onclick="searchAndMoveTo()">검색</button>
</div>


<div id="main-content">
  <!-- Map container -->
  <div id="map-container">
    <div id="map" style="width:1200px;height:600px;"></div>
  </div>
  <!-- Map control buttons -->
  <button id="center-map" onclick="panTo()">내 중심좌표</button>
</div>

<!-- Address form -->
<div id="address-form">
  <input type="text" id="basic-address" class="address-input" placeholder="기본 주소" readonly>
  <input type="text" id="detail-address" class="address-input" placeholder="상세 주소">
  <div id="user-dong" class="address-input"> </div> <!-- 여기에 '동'을 표시할 div를 추가합니다 -->
  <button onclick="saveAddress()">주소 저장</button>
</div>
</div>
</body>
</html>
<script
    src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c8936a5cd23e9343aaae775855cc0679&libraries=services,clusterer,drawing"></script>
<script>
  var geocoder = new kakao.maps.services.Geocoder();
  var infowindow = new kakao.maps.InfoWindow({zIndex: 1}); // 인포윈도우 생성
  var marker;
  var lat;
  var lon;
  var mapContainer = document.getElementById('map'), // 지도를 표시할 div
      mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
      };

  var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

  // HTML5의 geolocation으로 사용할 수 있는지 확인합니다
  if (navigator.geolocation) {

    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
    navigator.geolocation.getCurrentPosition(function (position) {

      lat = position.coords.latitude, // 위도
          lon = position.coords.longitude; // 경도

      var locPosition = new kakao.maps.LatLng(lat, lon) // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다


      // 마커와 인포윈도우를 표시합니다
      displayMarker(locPosition);

    });

  } else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다

    var locPosition = new kakao.maps.LatLng(33.450701, 126.570667);


    displayMarker(locPosition);
  }

  // 지도에 마커와 인포윈도우를 표시하는 함수입니다
  function displayMarker(locPosition) {

    // 마커를 생성합니다
    marker = new kakao.maps.Marker({
      map: map,
      position: locPosition,
      draggable: true // 마커를 드래그 가능하도록 설정합니다
    });

    // 지도 중심좌표를 접속위치로 변경합니다
    map.setCenter(locPosition);

    searchAddrFromCoords(map.getCenter(), displayInfowindow);

    // 마커에 드래그 종료 이벤트를 등록합니다
    kakao.maps.event.addListener(marker, 'dragend', function () {
      // 드래그가 끝난 위치의 좌표를 얻어옵니다
      var position = marker.getPosition();
      // 드래그 끝난 위치에 대한 주소 정보를 조회합니다
      searchAddrFromCoords(position, displayInfowindow);
    });

    // 마커에 클릭 이벤트를 등록한다 (우클릭 : rightclick)
    kakao.maps.event.addListener(marker, 'click', function () {
      alert('마커를 클릭했습니다!');
    });
  }

  var mapTypeControl = new kakao.maps.MapTypeControl();

  // 지도의 상단 우측에 지도 타입 변경 컨트롤을 추가한다
  map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

  // 지도에 확대 축소 컨트롤을 생성한다
  var zoomControl = new kakao.maps.ZoomControl();

  // 지도의 우측에 확대 축소 컨트롤을 추가한다
  map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);



  function searchAddrFromCoords(coords, callback) {
    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
  }
  var jibunAddress;
  var roadAddress;

  function displayInfowindow(result, status) {
    if (status === kakao.maps.services.Status.OK && result[0]) {
      var detailAddr = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
      detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';

      // 도로명 주소 또는 지번 주소에서 '동'을 추출합니다.
      var dong = extractDong(result[0].address.address_name);

      roadAddress = result[0].road_address ? result[0].road_address.address_name : '';
      jibunAddress = result[0].address.address_name;

      var content = '<div class="bAddr">' +
          '<span class="title">법정동 주소정보</span>' +
          detailAddr
      // Update the basic address input field with the road address
      if (roadAddress=='') {//도로명주소가 없을시 지번주소를 기본주소로
        document.getElementById('basic-address').value = jibunAddress;
      }else{
        document.getElementById('basic-address').value = roadAddress;
      }
      document.getElementById('user-dong').innerText = '현재 위치는 '+dong+' 내에 있어요.';


      infowindow.setContent(content);
      infowindow.open(map, marker);
    }
  }

  // '동'을 추출하는 함수
  function extractDong(address) {
    // 주소에서 '동'에 해당하는 부분을 정규식을 사용하여 추출합니다.
    var dongRegex = /.*동/;
    var match = address.match(dongRegex);
    return match ? match[0] : '동을 찾을 수 없음';
  }



  function panTo() {//지도좌표 이동
    // 이동할 위도 경도 위치를 생성합니다
    var moveLatLon = new kakao.maps.LatLng(lat, lon);

    // 지도 중심을 부드럽게 이동시킵니다
    // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
    map.panTo(moveLatLon);
    marker.setPosition(moveLatLon);
    var position = marker.getPosition();
    searchAddrFromCoords(position, displayInfowindow);
  }

  function saveAddress() {
    // var basicAddress = $('#basic-address').val();
    var detailAddress = $('#detail-address').val();

    var address = {
      roadAddress: roadAddress,
      jibunAddress: jibunAddress,
      detailAddress: detailAddress
    };
    console.log(JSON.stringify(address));
    $.ajax({
      url: "insertAddress.do",
      type: "POST",
      contentType: "application/json",
      data: JSON.stringify(address),
      success: function(response) {
        // 성공적으로 응답을 받았을 때의 처리
        console.log("응답:", response);
        alert('주소가 성공적으로 저장되었습니다.');
        location.href = "/selfLogin.do"
      },
      error: function(xhr, status, error) {
        // 에러가 발생했을 때의 처리
        console.error("에러 발생:", xhr, status, error);
        alert('주소 저장에 실패했습니다.');
      }
    });
  }

  // 주소를 검색하고 해당 위치로 지도를 이동시키는 함수
  function searchAndMoveTo() {
    var address = document.getElementById('search').value; // 사용자 입력 주소 가져오기

    // 주소로 좌표를 검색합니다.
    geocoder.addressSearch(address, function(result, status) {
      // 정상적으로 검색이 완료됐으면
      if (status === kakao.maps.services.Status.OK) {
        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

        // 검색된 좌표로 지도 이동
        map.setCenter(coords);

        // 마커 위치를 변경합니다
        marker.setPosition(coords);

        // 인포윈도우 내용을 업데이트하고 열기
        displayInfowindow(result, status);
      } else {
        alert('검색 결과가 없습니다. 주소를 다시 확인해주세요.');
      }
    });
  }

</script>