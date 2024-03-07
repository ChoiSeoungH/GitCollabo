<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%--강남구 역삼동 831-3--%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>뜨끈한 우동</title>
  <!-- 부트스트랩 CSS -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <style>
      @font-face {
          font-family: 'GmarketSansMedium';
          src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
          font-weight: normal;
          font-style: normal;
      }

      body {
          font-family: 'GmarketSansMedium', sans-serif;
          text-underline-position: under;
      }

      .overlaybox {
          position: relative;
          display: inline-block;
          background: #284a6e no-repeat;
          padding: 10px;
          border-radius: 10px;
          color: #fff;
      }


      #map-container {
          position: relative; /* For absolute positioning of the buttons */
      }
      #map {
          width: 100%;
          height: 600px;
      }

      /* 인포윈도우 디자인 커스텀 */
      .custom-infowindow .card-body {
          padding: 0.5rem;
      }
      .custom-infowindow .card-title {
          margin-bottom: 0.5rem;
      }
      .custom-infowindow .card-text:last-child {
          margin-bottom: 0;
      }

      .no-wrap {
          white-space: nowrap;
      }
  </style>
</head>
<body>
<div class="container mt-4">
  <div id="search-form" class="input-group mb-3">
    <input type="text" id="search" class="form-control" placeholder="검색할 주소를 입력하세요">
    <div class="input-group-append">
      <button onclick="searchAndMoveTo()" class="btn btn-outline-secondary">검색</button>
    </div>
  </div>

  <div id="main-content">
    <!-- Map container -->
    <div id="map-container" class="mb-3">
      <div id="map"></div>
    </div>
  </div>

  <!-- Address form -->
  <div id="address-form">
    <input type="text" id="basic-address" class="form-control mb-2" placeholder="기본 주소" readonly>
    <input type="text" id="detail-address" class="form-control mb-2" placeholder="상세 주소">
    <!-- '내 중심좌표'와 '주소 저장' 버튼을 왼쪽에 나란히 배치 -->
    <div id="buttons-container" class="d-flex justify-content-start mb-2">
      <button id="center-map" onclick="panTo()" class="btn btn-info mr-2">내 중심좌표</button>
      <button onclick="saveAddress()" class="btn btn-primary">주소 저장</button>
    </div>
  </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- 부트스트랩 JS -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>

<!-- Daum 지도 API -->
<script
    src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c8936a5cd23e9343aaae775855cc0679&libraries=services,clusterer,drawing"></script>
<script>
  var geocoder = new kakao.maps.services.Geocoder();
  var infowindow = new kakao.maps.InfoWindow({zIndex: 1}); // 인포윈도우 생성
  var marker;
  var lat;
  var lon;
  var ctx = "${ctx}";

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
      lat = position.getLat();
      lon = position.getLng();
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
      var detailAddr = !!result[0].road_address ? '도로명주소 : ' + result[0].road_address.address_name : '';
      detailAddr += '<br>지번 주소 : ' + result[0].address.address_name;

      // 도로명 주소 또는 지번 주소에서 '동'을 추출합니다.
      var dong = extractDong(result[0].address.address_name);

      roadAddress = result[0].road_address ? result[0].road_address.address_name : '';
      jibunAddress = result[0].address.address_name;

      var content =
          '<div class="card custom-infowindow" style="min-width: 22rem; max-width: 25rem;">' +
          '<div class="card-header bg-primary text-white">주소 정보</div>' +
          '<div class="card-body">' +
          '<h6 class="card-subtitle mb-2 text-muted">현재 위치</h6>' +
          '<p class="card-text no-wrap">' + detailAddr + '</p>' +
          '<p class="card-text no-wrap"><small class="text-muted">이 위치는 ' + dong + ' 내에 있습니다.</small></p>' +
          '</div>' +
          '</div>';


      // 기본 주소 입력 필드 업데이트
      document.getElementById('basic-address').value = roadAddress ? roadAddress : jibunAddress;

      infowindow.setContent(content);
      infowindow.open(map, marker);
    }
  }

  // '동'을 추출하는 함수
  function extractDong(address) {
    // 주소에서 '동'에 해당하는 부분을 정규식을 사용하여 추출합니다.
    var dongRegex = /[^ ]+동/;
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
        location.href = ctx+"/myPage.do"
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

  // 엔터 키로 주소 검색 활성화
  document.getElementById('search').addEventListener('keyup', function(event) {
    if (event.key === "Enter") {
      searchAndMoveTo();
    }
  });

  // JSON 파일 URL
  const jsonFileUrl = './json/TL_SCCO_CTPRVN.json';
  // jQuery를 사용하여 JSON 파일 로드
  $.getJSON(jsonFileUrl, function(data) {
    // 로드된 데이터를 바탕으로 폴리곤 생성
    data.features.forEach(function(feature) {
      var coordinates = feature.geometry.coordinates[0];
      var path = coordinates.map(function(coord) {
        return new kakao.maps.LatLng(coord[1], coord[0]);
      });

      var polygon = new kakao.maps.Polygon({
        map: map,
        path: path,
        strokeWeight: 2,
        strokeColor: '#004c80',
        strokeOpacity: 0.8,
        fillColor: '#fff',
        fillOpacity: 0.7
      });

    });
  });




</script>