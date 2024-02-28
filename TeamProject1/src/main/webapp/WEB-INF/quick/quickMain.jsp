<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="kr.basic.vo.User" %>
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
          height: 100vh;
      }

      #navigation-bar {
          width: 250px;
          height: 100vh;
          position: fixed;
          z-index: 1000;
          background-color: #f8f9fa;
          /* Rest of your styles */
      }

      #main-content {
          margin-left: 250px;
          flex-grow: 1;
          padding: 20px;
          /* Rest of your styles */
      }

      #map-container {
          width: 100%;
          height: 100%;
      }

  </style>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

</head>
<body>
<div id="navigation-bar">
  <!-- User information and status -->
  <div id="user-info">
    <span id="user-name">배달원 이름</span>
    <span id="user-status">상태</span>
  </div>
  <!-- Financial information -->
  <div id="financial-info">
    <span id="cash">현금: </span>
    <span id="weekly-income">이번주 수입: </span>
  </div>
  <!-- Delivery and navigation buttons -->
  <button id="delivery-details">배달 내용</button>
  <button id="arrival">도착</button>
  <button id="main-screen">메인 화면</button>
</div>

<div id="main-content">
  <!-- Map container -->
  <div id="map-container">
    <div id="map" style="width:100%;height:100%;"></div>
  </div>
  <!-- Map control buttons -->
  <button id="center-map" onclick="panTo()">내 중심좌표</button>
  <button id="reset-range" onclick="setBounds()">범위 재설정</button>
  <button id="refresh">새로고침</button>
  <button id="status-toggle">상태전환</button>
</div>

<script src="path_to_your_javascript_file.js"></script>
</body>
</html>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c8936a5cd23e9343aaae775855cc0679&libraries=services,clusterer,drawing"></script>
<script>
  var listData = JSON.parse('${json}');
  // listData를 사용하여 작업을 수행합니다.
  console.log(listData);

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
    });
    // 지도 중심좌표를 접속위치로 변경합니다
    map.setCenter(locPosition);
    searchAddrFromCoords(map.getCenter(), displayInfowindow);

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
      // var dong = extractDong(result[0].address.address_name);

      roadAddress = result[0].road_address ? result[0].road_address.address_name : '';
      jibunAddress = result[0].address.address_name;

      var content = '<div class="bAddr">' +
          '<span class="title">내위치</span>' +
          detailAddr

      infowindow.setContent(content);
      infowindow.open(map, marker);
    }
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


  // 지도에 선을 표시한다
  // var dToPline = new kakao.maps.Polyline({ //배달기사 에서 픽업장소
  //   map: map, // 선을 표시할 지도 객체
  //   path: [ // 선을 구성하는 좌표 배열
  //     new kakao.maps.LatLng(latitude, longitude),
  //     new kakao.maps.LatLng(37.56591, 126.97671)
  //   ],
  //   endArrow: true, // 선의 끝을 화살표로 표시되도록 설정한다
  //   strokeWeight: 3, // 선의 두께
  //   strokeColor: '#FF0000', // 선 색
  //   strokeOpacity: 0.9, // 선 투명도
  //   strokeStyle: 'shortdot' // 선 스타일
  //
  //
  // });

  // var pToAline = new kakao.maps.Polyline({ //픽업에서 도착지
  //   map: map, // 선을 표시할 지도 객체
  //   path: [ // 선을 구성하는 좌표 배열
  //     new kakao.maps.LatLng(latitude, longitude),
  //     new kakao.maps.LatLng(37.56591, 126.97671)
  //   ],
  //   endArrow: true, // 선의 끝을 화살표로 표시되도록 설정한다
  //   strokeWeight: 3, // 선의 두께
  //   strokeColor: '#0034ff', // 선 색
  //   strokeOpacity: 0.9, // 선 투명도
  //   strokeStyle: 'shortdot' // 선 스타일
  // });

  function panTo() {//지도좌표 이동
    // 이동할 위도 경도 위치를 생성합니다
    var moveLatLon = new kakao.maps.LatLng(lat, lon);

    // 지도 중심을 부드럽게 이동시킵니다
    // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
    map.panTo(moveLatLon);
  }

  var productGeocoder = new kakao.maps.services.Geocoder();

  // 주소로 좌표를 검색합니다
  productGeocoder.addressSearch('제주특별자치도 제주시 첨단로 242', function (result, status) {

    // 정상적으로 검색이 완료됐으면
    if (status === kakao.maps.services.Status.OK) {

      var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

      // 결과값으로 받은 위치를 마커로 표시합니다
      var marker = new kakao.maps.Marker({
        map: map,
        position: coords
      });

      // 인포윈도우로 장소에 대한 설명을 표시합니다
      var infowindow = new kakao.maps.InfoWindow({
        content: '<div style="width:150px;text-align:center;padding:6px 0;">우리회사</div>'
      });
      infowindow.open(map, marker);

      // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
      map.setCenter(coords);
    }
  });


  //프로덕트 마커 표시
  var MARKER_WIDTH = 33, // 기본, 클릭 마커의 너비
      MARKER_HEIGHT = 36, // 기본, 클릭 마커의 높이
      OFFSET_X = 12, // 기본, 클릭 마커의 기준 X좌표
      OFFSET_Y = MARKER_HEIGHT, // 기본, 클릭 마커의 기준 Y좌표
      OVER_MARKER_WIDTH = 40, // 오버 마커의 너비
      OVER_MARKER_HEIGHT = 42, // 오버 마커의 높이
      OVER_OFFSET_X = 13, // 오버 마커의 기준 X좌표
      OVER_OFFSET_Y = OVER_MARKER_HEIGHT, // 오버 마커의 기준 Y좌표
      SPRITE_MARKER_URL = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markers_sprites2.png', // 스프라이트 마커 이미지 URL
      SPRITE_WIDTH = 126, // 스프라이트 이미지 너비
      SPRITE_HEIGHT = 146, // 스프라이트 이미지 높이
      SPRITE_GAP = 10; // 스프라이트 이미지에서 마커간 간격

  var markerSize = new kakao.maps.Size(MARKER_WIDTH, MARKER_HEIGHT), // 기본, 클릭 마커의 크기
      markerOffset = new kakao.maps.Point(OFFSET_X, OFFSET_Y), // 기본, 클릭 마커의 기준좌표
      overMarkerSize = new kakao.maps.Size(OVER_MARKER_WIDTH, OVER_MARKER_HEIGHT), // 오버 마커의 크기
      overMarkerOffset = new kakao.maps.Point(OVER_OFFSET_X, OVER_OFFSET_Y), // 오버 마커의 기준 좌표
      spriteImageSize = new kakao.maps.Size(SPRITE_WIDTH, SPRITE_HEIGHT); // 스프라이트 이미지의 크기

  var selectedMarker = null; // 클릭한 마커를 담을 변수

  for (let i = 0; i < listData.length; i++) {// 제품의 마커 생성
    const user = listData[i];
    var locationList = user.location.split("/");
    var roadAddress = locationList[0];
    var detailAddress = locationList[2];
    // 주소를 위도와 경도로 변환
    geocoder.addressSearch(roadAddress + ' ' + detailAddress, function (result, status) {
      if (status === kakao.maps.services.Status.OK) {
        // 변환된 주소의 위도와 경도를 가져옴
        var latlng = new kakao.maps.LatLng(result[0].y, result[0].x);

        var gapX = (MARKER_WIDTH + SPRITE_GAP), // 스프라이트 이미지에서 마커로 사용할 이미지 X좌표 간격 값
            originY = (MARKER_HEIGHT + SPRITE_GAP) * i, // 스프라이트 이미지에서 기본, 클릭 마커로 사용할 Y좌표 값
            overOriginY = (OVER_MARKER_HEIGHT + SPRITE_GAP) * i, // 스프라이트 이미지에서 오버 마커로 사용할 Y좌표 값
            normalOrigin = new kakao.maps.Point(0, originY), // 스프라이트 이미지에서 기본 마커로 사용할 영역의 좌상단 좌표
            clickOrigin = new kakao.maps.Point(gapX, originY), // 스프라이트 이미지에서 마우스오버 마커로 사용할 영역의 좌상단 좌표
            overOrigin = new kakao.maps.Point(gapX * 2, overOriginY); // 스프라이트 이미지에서 클릭 마커로 사용할 영역의 좌상단 좌표
        console.log(i);
        // 마커를 생성하고 지도위에 표시합니다
        addMarker(latlng, normalOrigin, overOrigin, clickOrigin);
      }
    });
  }


  // 마커를 생성하고 지도 위에 표시하고, 마커에 mouseover, mouseout, click 이벤트를 등록하는 함수입니다
  function addMarker(position, normalOrigin, overOrigin, clickOrigin) {

    // 기본 마커이미지, 오버 마커이미지, 클릭 마커이미지를 생성합니다
    var normalImage = createMarkerImage(markerSize, markerOffset, normalOrigin),
        overImage = createMarkerImage(overMarkerSize, overMarkerOffset, overOrigin),
        clickImage = createMarkerImage(markerSize, markerOffset, clickOrigin);

    // 마커를 생성하고 이미지는 기본 마커 이미지를 사용합니다
    var marker = new kakao.maps.Marker({
      map: map,
      position: position,
      image: normalImage
    });

    // 마커 객체에 마커아이디와 마커의 기본 이미지를 추가합니다
    marker.normalImage = normalImage;

    // 마커에 mouseover 이벤트를 등록합니다
    kakao.maps.event.addListener(marker, 'mouseover', function () {

      // 클릭된 마커가 없고, mouseover된 마커가 클릭된 마커가 아니면
      // 마커의 이미지를 오버 이미지로 변경합니다
      if (!selectedMarker || selectedMarker !== marker) {
        marker.setImage(overImage);
      }
    });

    // 마커에 mouseout 이벤트를 등록합니다
    kakao.maps.event.addListener(marker, 'mouseout', function () {

      // 클릭된 마커가 없고, mouseout된 마커가 클릭된 마커가 아니면
      // 마커의 이미지를 기본 이미지로 변경합니다
      if (!selectedMarker || selectedMarker !== marker) {
        marker.setImage(normalImage);
      }
    });

    // 마커에 click 이벤트를 등록합니다
    kakao.maps.event.addListener(marker, 'click', function () {

      // 클릭된 마커가 없고, click 마커가 클릭된 마커가 아니면
      // 마커의 이미지를 클릭 이미지로 변경합니다
      if (!selectedMarker || selectedMarker !== marker) {

        // 클릭된 마커 객체가 null이 아니면
        // 클릭된 마커의 이미지를 기본 이미지로 변경하고
        !!selectedMarker && selectedMarker.setImage(selectedMarker.normalImage);

        // 현재 클릭된 마커의 이미지는 클릭 이미지로 변경합니다
        marker.setImage(clickImage);
      }

      // 클릭된 마커를 현재 클릭된 마커 객체로 설정합니다
      selectedMarker = marker;
    });
  }

  // MakrerImage 객체를 생성하여 반환하는 함수입니다
  function createMarkerImage(markerSize, offset, spriteOrigin) {
    var markerImage = new kakao.maps.MarkerImage(
        SPRITE_MARKER_URL, // 스프라이트 마커 이미지 URL
        markerSize, // 마커의 크기
        {
          offset: offset, // 마커 이미지에서의 기준 좌표
          spriteOrigin: spriteOrigin, // 스트라이프 이미지 중 사용할 영역의 좌상단 좌표
          spriteSize: spriteImageSize // 스프라이트 이미지의 크기
        }
    );

    return markerImage;
  }


</script>