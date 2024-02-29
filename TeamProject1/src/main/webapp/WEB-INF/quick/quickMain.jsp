<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="vo.User" %>
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
          height: calc(100% - 30px);
          margin-bottom: 10px;
      }


      .infowindow-content {
          width: auto; /* 너비를 자동으로 설정하여 내용물에 맞게 조정 */
          max-width: 400px; /* 최대 너비를 설정하여 너무 크게 확장되는 것을 방지 */
          white-space: nowrap; /* 텍스트를 줄바꿈 없이 한 줄로 표시 */
      }

      .bAddr {
          margin: 0;
          padding: 10px;
          border-radius: 5px;
          background: #fff;
          box-shadow: 0 2px 2px rgba(0, 0, 0, 0.2);
      }

      .title {
          display: block;
          margin-bottom: 5px;
          font-weight: bold;
      }
  </style>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

</head>
<body>
<div id="navigation-bar">
  <!-- User information and status -->
  <div id="user-info">
    <span id="user-name">이름 : ${user.name}</span>
    <span id="user-status">상태 : ${user.status}</span>
  </div>
  <!-- Financial information -->
  <div id="financial-info">
    <span id="cash">현금 : ${user.cash}</span>

    <span id="weekly-income">이번주 수입 : </span>
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
<script
    src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c8936a5cd23e9343aaae775855cc0679&libraries=services,clusterer,drawing"></script>
<script>


  var listData = JSON.parse('${json}');
  var deliver = JSON.parse('${deliver}');
  var buyerListData = JSON.parse('${buyerJson}');
  // listData를 사용하여 작업을 수행합니다.
  // console.log(listData);
  // console.log(deliver);

  var geocoder = new kakao.maps.services.Geocoder();
  var infowindow = new kakao.maps.InfoWindow({zIndex: 1}); // 인포윈도우 생성
  var marker;
  var lat;
  var lon;
  var locPosition;

  var roadAddress = deliver.location.split("/")[0];
  var detailAddress = deliver.location.split("/")[2];
  console.log(roadAddress);
  console.log(detailAddress);

  geocoder.addressSearch(roadAddress + ' ' + detailAddress, function (result, status) {//배달기사 위치확인
    if (status === kakao.maps.services.Status.OK) {
      // 변환된 주소의 위도와 경도를 가져옴
      // var latlng = new kakao.maps.LatLng(result[0].y, result[0].x);
      lat = result[0].y;
      lon = result[0].x;
      locPosition = new kakao.maps.LatLng(lat, lon)
    }


    console.log('lat :' + lat);
    console.log('lon :' + lon);


    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
          center: new kakao.maps.LatLng(lat, lon), // 지도의 중심좌표
          level: 3 // 지도의 확대 레벨
        };

    var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
    displayMarker(locPosition);

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

      // 마커에 마우스오버 이벤트를 등록합니다
      kakao.maps.event.addListener(marker, 'mouseover', function () {
        // 마커에 마우스오버 이벤트가 발생하면 인포윈도우를 마커위에 표시합니다
        infowindow.open(map, marker);
      });

      // 마커에 마우스아웃 이벤트를 등록합니다
      kakao.maps.event.addListener(marker, 'mouseout', function () {
        // 마커에 마우스아웃 이벤트가 발생하면 인포윈도우를 제거합니다
        infowindow.close();
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


    function displayInfowindow(result, status) {
      if (status === kakao.maps.services.Status.OK && result[0]) {
        var detailAddr = !!result[0].road_address ? '<div style="width: 100%;">도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
        detailAddr += '<div style="width: 100%;">지번 주소 : ' + result[0].address.address_name + '</div>';

        var content = '<div class="infowindow-content">' + // 이 클래스에 스타일 적용
            '<div class="bAddr">' +
            '<span class="title">내위치</span>' +
            detailAddr +
            '</div></div>';

        infowindow.setContent(content);
      }
    }


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
      var product = listData[i];
      var buyer = buyerListData[i];
      console.log(product);
      console.log(buyer);
      var locationList = product.sellLocation.split("/");
      var buyerLocationList = buyer.location.split("/");
      console.log(locationList);
      var roadAddress = locationList[0];
      var detailAddress = locationList[2];
      var adress = roadAddress + " " + detailAddress;

      var buyerRoadAddress = locationList[0];
      var buyerDetailAddress = locationList[2];
      var buyerAdress = buyerRoadAddress + " " + buyerDetailAddress;
      // 주소를 위도와 경도로 변환
      geocoder.addressSearch(roadAddress + ' ' + detailAddress, function (result, status) {
        if (status === kakao.maps.services.Status.OK) {
          // 변환된 주소의 위도와 경도를 가져옴
          var latlng = new kakao.maps.LatLng(result[0].y, result[0].x);
          geocoder.addressSearch(buyerRoadAddress + ' ' + buyerDetailAddress, function (result, status) {
            if (status === kakao.maps.services.Status.OK) {
              var buyerLatlng = new kakao.maps.LatLng(result[0].y, result[0].x);
              var gapX = (MARKER_WIDTH + SPRITE_GAP), // 스프라이트 이미지에서 마커로 사용할 이미지 X좌표 간격 값
                  originY = (MARKER_HEIGHT + SPRITE_GAP) * i, // 스프라이트 이미지에서 기본, 클릭 마커로 사용할 Y좌표 값
                  overOriginY = (OVER_MARKER_HEIGHT + SPRITE_GAP) * i, // 스프라이트 이미지에서 오버 마커로 사용할 Y좌표 값
                  normalOrigin = new kakao.maps.Point(0, originY), // 스프라이트 이미지에서 기본 마커로 사용할 영역의 좌상단 좌표
                  clickOrigin = new kakao.maps.Point(gapX, originY), // 스프라이트 이미지에서 마우스오버 마커로 사용할 영역의 좌상단 좌표
                  overOrigin = new kakao.maps.Point(gapX * 2, overOriginY); // 스프라이트 이미지에서 클릭 마커로 사용할 영역의 좌상단 좌표
              console.log(i);
              // 마커를 생성하고 지도위에 표시합니다
              addMarker(latlng, buyerLatlng,adress,buyerAdress, normalOrigin, overOrigin, clickOrigin);
            }
          });
        }
      });
    }


    // 마커를 생성하고 지도 위에 표시하고, 마커에 mouseover, mouseout, click 이벤트를 등록하는 함수입니다
    function addMarker(position,buyerPosition,adress,buyerAdress, normalOrigin, overOrigin, clickOrigin) {

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

        // 인포윈도우에 표시할 내용
        // var content = '<div>배달료 : ' + data.estimatedCost + '</div>' +

        var content = '<div>배달료 : 3900원</div>' +
            '<div>픽업 : ' + adress + '</div>' +
            '<div>전달 : ' + buyerAdress + '</div>' +
            '<button onclick="infowindow.close();">거절</button>'
            // '<button onclick="acceptDelivery();">배차 수락</button>';
        infowindow.setContent(content);
        infowindow.open(map, marker);
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
  });

  // 배차 수락 시, 경로를 그리는 함수
  function drawRoute(map, sellLocation, buyerLocation) {
    // 판매 위치와 구매자 위치로부터 위도와 경도를 구함
    var sellPosition = new kakao.maps.LatLng(sellLocation.lat, sellLocation.lng);
    var buyerPosition = new kakao.maps.LatLng(buyerLocation.lat, buyerLocation.lng);

    // 판매 위치에서 구매자 위치까지 선을 그림
    // var linePath = [
    //   sellPosition,
    //   buyerPosition
    // ];

    var dtoSline = new kakao.maps.Polyline({
      path: sellPosition, // 선을 구성하는 좌표 배열
      endArrow: true,
      strokeWeight: 3, // 선의 두께
      strokeColor: '#FF0000', // 선의 색깔
      strokeOpacity: 1.0, // 선의 불투명도
      strokeStyle: 'shortdot' // 선의 스타일
    });

    var stoBline = new kakao.maps.Polyline({
      path: buyerPosition, // 선을 구성하는 좌표 배열
      endArrow: true,
      strokeWeight: 3, // 선의 두께
      strokeColor: '#0021ff', // 선의 색깔
      strokeOpacity: 1.0, // 선의 불투명도
      strokeStyle: 'shortdot' // 선의 스타일
    });

    dtoSline.setMap(map);
    stoBline.setMap(map);
  }

  function panTo() {//지도좌표 이동
    // 이동할 위도 경도 위치를 생성합니다
    var moveLatLon = new kakao.maps.LatLng(lat, lon);

    // 지도 중심을 부드럽게 이동시킵니다
    // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
    map.panTo(moveLatLon);
  }

</script>