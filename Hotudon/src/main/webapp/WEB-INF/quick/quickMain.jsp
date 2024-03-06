<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
  <!-- Add Bootstrap for Modal -->
  <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

</head>



<body>
<!-- Navigation Bar -->
<div id="navigation-bar" class="col-md-3 bg-light">
  <!-- User information and status in Card style -->
  <div class="card my-4">
    <div class="card-body">
      <h5 class="card-title">사용자 정보</h5>
      <p class="card-text">이름: ${user.name}</p>
      <p class="card-text">상태: ${user.status}</p>
      <p class="card-text">현금: ${user.cash}원</p>
    </div>
  </div>
  <!-- Control buttons -->
  <div class="btn-group-vertical" role="group">
    <button id="delivery-details-btn" class="btn btn-info mb-2" style="display: none;">배달 내용</button>
    <button id="arrival" class="btn btn-warning mb-2" style="display: none;">도착</button>
    <button id="main-screen" class="btn btn-primary" onclick="location.href='main.do'">메인 화면</button>
  </div>
</div>

<!-- Main Content -->
<div id="main-content" class="col-md-9">
  <!-- Map container adjusted with Bootstrap styling -->
  <div id="map-container" class="container-fluid">
    <div id="map" class="w-100" style="height: 90vh;"></div>
  </div>
  <!-- Adjusted control buttons -->
  <div class="text-center mt-3">
    <button id="center-map" class="btn btn-primary mr-2" onclick="panTo()">내 중심좌표</button>
    <button id="reset-range" class="btn btn-secondary mr-2" onclick="setBounds()">범위 재설정</button>
    <button id="refresh" class="btn btn-success mr-2">새로고침</button>
    <button id="status-toggle" class="btn btn-info">상태전환</button>
  </div>
</div>


<!-- 상태전환 Modal -->
<div class="modal fade" id="statusModal" tabindex="-1" role="dialog" aria-labelledby="statusModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="statusModalLabel">상태 전환</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <button type="button" class="btn btn-secondary status-button" data-status="1">휴식</button>
        <button type="button" class="btn btn-secondary status-button" data-status="2">대기</button>
        <button type="button" class="btn btn-secondary status-button" data-status="0">오프라인</button>
      </div>
    </div>
  </div>
</div>

<!-- 배달내용 Modal -->
<div class="modal fade" id="deliveryModal" tabindex="-1" role="dialog" aria-labelledby="deliveryModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="deliveryModalLabel">배달 상세 정보</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p id="pName">아이폰 </p>
        <p id="timeDistance">예상 소요시간 및 이동거리: </p>
        <p id="fee">배달료 : </p>

        <p id="pAddress">우리 집</p>
        <p id="pDistance">거리 : </p>
        <p id="pTime">픽업 예상시간 : </p>

        <p id="aAddress">우리 집</p>
        <p id="aDistance">거리 : </p>
        <p id="aTime">도착 예상시간 : </p>`
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>


<script src="path_to_your_javascript_file.js"></script>
</body>
</html>

<%--스트립트시작--%>
<script
    src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c8936a5cd23e9343aaae775855cc0679&libraries=services,clusterer,drawing"></script>
<script>

  // 사용자 상태에 따라 버튼 표시를 토글하는 함수
  function toggleButtonsBasedOnStatus(status) {
    if (status === '배송중') {
      $('#delivery-details-btn').show();
      $('#arrival').show();
    } else {
      // 그 외의 상태일 때 버튼 숨김
      $('#delivery-details-btn').hide();
      $('#arrival').hide();
    }
  }

  document.addEventListener('DOMContentLoaded', toggleButtonsBasedOnStatus(${user.status}));


  //지도부분
  var mapContainer = document.getElementById('map'), // 지도를 표시할 div
      mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
      };

  var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

  var listData = JSON.parse('${json}');
  var deliver = JSON.parse('${deliver}');
  var buyerListData = JSON.parse('${buyerJson}');
  // listData를 사용하여 작업을 수행합니다.
  // console.log(listData);
  // console.log(deliver);

  var geocoder = new kakao.maps.services.Geocoder();
  var infowindow = new kakao.maps.InfoWindow({zIndex: 1}); // 인포윈도우 생성
  var bounds = new kakao.maps.LatLngBounds();
  var marker;
  var lat;
  var lon;
  var locPosition;
  var distance;
  var productNo = 0;
  var price = 0;
  var pDistance;
  var aDistance;
  var productName ;
  var pAddress;
  var aAddress ;
  var deliveryDate;

  var roadAddress = deliver.location.split("/")[0];
  var detailAddress = deliver.location.split("/")[2];
  console.log(roadAddress);
  console.log(detailAddress);

  function getDistance(lat1, lon1, lat2, lon2) {
    const R = 6371; // 지구 반지름 (단위: km)
    const dLat = degToRad(lat2 - lat1);
    const dLon = degToRad(lon2 - lon1);
    const a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
        Math.cos(degToRad(lat1)) * Math.cos(degToRad(lat2)) *
        Math.sin(dLon / 2) * Math.sin(dLon / 2);
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    const distance = R * c * 1000; // 두 지점 간의 거리 (단위: km)
    return distance;
  }

  function degToRad(deg) {
    return deg * (Math.PI / 180);
  }


  function acceptDelivery(position, buyerPosition, productAddress, buyerAddress, deliveryFee) {
    drawRoute(locPosition, position, buyerPosition);
    // 마커 움직임 시작
    var marker = addDeliveryMarker(locPosition, '배달원 위치', position, buyerPosition); // 배달원 위치 주소 정보 필요 시 추가 로직 구현

    addDeliveryMarker(position, '픽업 : ' + productAddress, position, buyerPosition);
    addDeliveryMarker(buyerPosition, '전달 : ' + buyerAddress, position, buyerPosition);
    startMarkerMovement(position, buyerPosition, marker);
  }

  function searchAddrFromCoords(coords, callback) {
    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
  }

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

  function createMarkerForAddress(listDatum, buyerListDatum, i) {
    var product = listDatum;
    var buyer = buyerListDatum;
    var deliveryFee;


    // console.log(product);
    var locationList = product.sellLocation.split("/");
    // console.log(locationList);
    var roadAddress = locationList[0];
    var detailAddress = locationList[2];
    var productAddress = roadAddress + ' ' + detailAddress;


    locationList = buyer.location.split("/");
    // console.log(locationList);
    roadAddress = locationList[0];
    detailAddress = locationList[2];
    var buyerAddress = roadAddress + " " + detailAddress;

    // 주소를 위도와 경도로 변환
    geocoder.addressSearch(productAddress, function (result, status) {
      if (status === kakao.maps.services.Status.OK) {
        // 변환된 주소의 위도와 경도를 가져옴
        var lat1 = result[0].y;
        var lon1 = result[0].x
        var latlng = new kakao.maps.LatLng(result[0].y, result[0].x);
        bounds.extend(latlng);

        var gapX = (MARKER_WIDTH + SPRITE_GAP), // 스프라이트 이미지에서 마커로 사용할 이미지 X좌표 간격 값
            originY = (MARKER_HEIGHT + SPRITE_GAP) * i, // 스프라이트 이미지에서 기본, 클릭 마커로 사용할 Y좌표 값
            overOriginY = (OVER_MARKER_HEIGHT + SPRITE_GAP) * i, // 스프라이트 이미지에서 오버 마커로 사용할 Y좌표 값
            normalOrigin = new kakao.maps.Point(0, originY), // 스프라이트 이미지에서 기본 마커로 사용할 영역의 좌상단 좌표
            clickOrigin = new kakao.maps.Point(gapX, originY), // 스프라이트 이미지에서 마우스오버 마커로 사용할 영역의 좌상단 좌표
            overOrigin = new kakao.maps.Point(gapX * 2, overOriginY); // 스프라이트 이미지에서 클릭 마커로 사용할 영역의 좌상단 좌표
        console.log(i);
        // 마커를 생성하고 지도위에 표시합니다

        geocoder.addressSearch(buyerAddress, function (result2, status) {
          if (status === kakao.maps.services.Status.OK) {
            var lat2 = result2[0].y;
            var lon2 = result2[0].x
            var latlng2 = new kakao.maps.LatLng(result2[0].y, result2[0].x);
            distance = getDistance(lat1, lon1, lat2, lon2);
            // 거리에 따른 배달비 계산
            // 기본배달료는 3,000원으로 고정돼 있다. 내비게이션 기준으로 배달거리 645m를 초과하면 3,500원이 주어지고, 배달거리 1.9km를 초과하면 100m당 80원이 추가된다.
            if (distance > 645) {
              deliveryFee = 3500;
            } else if (distance > 1900) {
              deliveryFee = 3500 + (distance - 1900) * 80;
              // 100원 단위로 정수로 나오게 처리
              deliveryFee = Math.round(deliveryFee / 100) * 100;
            } else {
              deliveryFee = 3000;
            }

            console.log("distance : " + distance);
            console.log("deliveryFee : " + deliveryFee);
            addMarker(product.no ,product.title, latlng,latlng2, normalOrigin, overOrigin, clickOrigin, productAddress, buyerAddress, deliveryFee);
          }
        });

      }
    });
  }

  // 마커를 생성하고 지도 위에 표시하고, 마커에 mouseover, mouseout, click 이벤트를 등록하는 함수입니다
  function addMarker(no, name ,position, buyerPosition, normalOrigin, overOrigin, clickOrigin, productAddress, buyerAddress, deliveryFee) {

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

    var infowindow = new kakao.maps.InfoWindow({
      content: position.content // 인포윈도우에 표시할 내용
    });
    // 클로저를 사용하여 인포윈도우 제어 함수 생성


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
      var content = document.createElement('div');
      content.innerHTML = '<div>배달료 : ' + deliveryFee + '원</div>' +
          '<div>픽업 : ' + productAddress + '</div>' +
          '<div>전달 : ' + buyerAddress + '</div>';
      var closeButton = document.createElement('button');
      closeButton.textContent = '거절';
      closeButton.addEventListener('click', function () {
        infowindow.close();
      });

      content.appendChild(closeButton);


      var acceptDeliveryButton = document.createElement('button');
      acceptDeliveryButton.textContent = '배달수락';
      acceptDeliveryButton.setAttribute('data-product-no', no);
      acceptDeliveryButton.setAttribute('data-product-name', name);
      acceptDeliveryButton.setAttribute('data-product-address', productAddress);
      acceptDeliveryButton.setAttribute('data-buyer-address', buyerAddress);
      acceptDeliveryButton.setAttribute('data-delivery-fee', deliveryFee);
      acceptDeliveryButton.classList.add('accept-delivery-button'); // 클래스 추가

      distance = getDistance(position.getLat(),position.getLng(), buyerPosition.getLat(),buyerPosition.getLng());
      pDistance = getDistance(position.getLat(),position.getLng(), locPosition.getLat(),locPosition.getLng());
      aDistance = getDistance(buyerPosition.getLat(),buyerPosition.getLng(), locPosition.getLat(),locPosition.getLng());

      acceptDeliveryButton.addEventListener('click', function () {
        productNo = $(this).data('product-no');
        price = $(this).data('delivery-fee');
        productName = $(this).data('product-name');
        pAddress = $(this).data('product-address');
        aAddress = $(this).data('buyer-address');
        deliveryDate = new Date();
        acceptDelivery(position, buyerPosition, productAddress, buyerAddress, deliveryFee);
        var newStatus = 3;
        setDelivery(productNo,${user.no},deliveryFee,productAddress);
        updateDeliverStatus(${user.no}, newStatus, 0); // 상태 업데이트 함수 호출
      });

      content.appendChild(acceptDeliveryButton);
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

  geocoder.addressSearch(roadAddress + ' ' + detailAddress, function (result, status) {//배달기사 위치확인
    if (status === kakao.maps.services.Status.OK) {
      // 변환된 주소의 위도와 경도를 가져옴
      // var latlng = new kakao.maps.LatLng(result[0].y, result[0].x);
      lat = result[0].y;
      lon = result[0].x;
      locPosition = new kakao.maps.LatLng(lat, lon)
    }

    map.setCenter(locPosition);
    displayMarker(locPosition);

    // 지도에 마커와 인포윈도우를 표시하는 함수입니다


    var mapTypeControl = new kakao.maps.MapTypeControl();

    // 지도의 상단 우측에 지도 타입 변경 컨트롤을 추가한다
    map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

    // 지도에 확대 축소 컨트롤을 생성한다
    var zoomControl = new kakao.maps.ZoomControl();

    // 지도의 우측에 확대 축소 컨트롤을 추가한다
    map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

    for (let i = 0; i < listData.length; i++) {
      createMarkerForAddress(listData[i], buyerListData[i], i);
      // LatLngBounds 객체 생성

    }

  });

  // 전역 변수로 선을 관리하기 위해 변수 선언
  var dtoSline, stoBline;

  function drawRoute(deliverLocation, sellLocation, buyerLocation) {
    // 기존에 그려진 선이 있다면 지도에서 제거
    if (dtoSline) dtoSline.setMap(null);
    if (stoBline) stoBline.setMap(null);


    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
          center: new kakao.maps.LatLng(lat, lon), // 지도의 중심좌표
          level: 3 // 지도의 확대 레벨
        };
    document.getElementById('map').innerHTML = "";
    map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

    // 새로운 선을 그립니다
    dtoSline = new kakao.maps.Polyline({
      map: map,
      path: [deliverLocation, sellLocation],
      endArrow: true,
      strokeWeight: 3,
      strokeColor: '#FF0000',
      strokeOpacity: 1.0,
      strokeStyle: 'shortdot'
    });

    stoBline = new kakao.maps.Polyline({
      map: map,
      path: [sellLocation, buyerLocation],
      endArrow: true,
      strokeWeight: 3,
      strokeColor: '#0021ff',
      strokeOpacity: 1.0,
      strokeStyle: 'shortdot'
    });
  }

  function addDeliveryMarker(position, address, productPosition, buyerPosition) {
    // var isPickUp = false;
    // var isDeliveryComplete = false;
    // address 변수를 검사하여 조건에 따라 div의 id 속성을 결정합니다.

    var marker = new kakao.maps.Marker({
      map: map,
      position: position,
      draggable: address.includes("배달원"), // "배달원"이 포함된 주소의 마커에 대해 드래그 가능 설정
      zIndex: address.includes("배달원") ? 10 : 5
    });

    if (!address.includes("배달원")) {
      var infowindow = new kakao.maps.InfoWindow({
        content: '<div style="padding:5px;" >' + address + '</div>' // 인포윈도우에 표시할 내용
      });
      infowindow.open(map, marker); // 마커 클릭 시 인포윈도우 표시

    }

    // if (address.includes("배달원")) {
    //   kakao.maps.event.addListener(marker, 'dragend', function () {
    //     // 드래그가 끝난 후 마커의 새 위치를 가져옵니다
    //     var newPos = marker.getPosition();
    //     infowindow.open(map, marker);
    //     // 마커의 새 위치를 배달원 위치 변수에 업데이트
    //     locPosition = newPos;
    //
    //     console.log(getDistance(locPosition.getLat(), locPosition.getLng(), productPosition.getLat(), productPosition.getLng()))
    //     console.log(getDistance(locPosition.getLat(),locPosition.getLng(),buyerPosition.getLat(),buyerPosition.getLng()))
    //
    //     // 판매 위치와의 거리가 0이 아닐 때만 dtoSline 선을 다시 그립니다
    //     if (getDistance(locPosition.getLat(), locPosition.getLng(), productPosition.getLat(), productPosition.getLng()) < 5) {
    //       isPickUp = true;
    //       dtoSline.setMap(null);
    //
    //     }
    //     if (!isPickUp) {
    //       dtoSline.setPath([locPosition, productPosition]);
    //     }
    //
    //
    //     // 구매자 위치와의 거리가 0이 아닐 때만 stoBline 선을 다시 그립니다
    //     if (getDistance(locPosition.getLat(),locPosition.getLng(),buyerPosition.getLat(),buyerPosition.getLng())< 5) {
    //       isDeliveryComplete = true;
    //       stoBline.setMap(null);
    //     }
    //
    //     if (!isDeliveryComplete && isPickUp) {
    //       stoBline.setOptions({
    //         strokeWeight: 3,
    //         strokeColor: '#FF0000',
    //         strokeOpacity: 1.0,
    //         strokeStyle: 'shortdot'
    //       });
    //       stoBline.setPath([locPosition, buyerPosition]);
    //     }
    //
    //   });
    //
    // }
    return marker;
  }

  //마커를 일정시간마다 움직이게하기


  // 전역 변수로 이동할 마커와 인터벌 관리를 위한 변수 선언
  var movingMarker;
  var movementInterval;

  function interpolate(lat1, lng1, lat2, lng2, fraction) {
    return {
      lat: lat1 + (lat2 - lat1) * fraction,
      lng: lng1 + (lng2 - lng1) * fraction
    };
  }

  function generatePathPoints(startPos, endPos, numPoints) {
    let pathPoints = [];
    for (let i = 1; i <= numPoints; i++) {
      let fraction = i / numPoints;
      let interpolated = interpolate(startPos.getLat(), startPos.getLng(), endPos.getLat(), endPos.getLng(), fraction);
      pathPoints.push(new kakao.maps.LatLng(interpolated.lat, interpolated.lng));
    }
    return pathPoints;
  }


  function startMarkerMovement(position, buyerPosition, marker) {
    // var pathToPickup = generatePathPoints(locPosition, position, 5);
    // var pathToDelivery = generatePathPoints(position, buyerPosition, 5);
    var pathToPickup = generatePathPoints(locPosition, position, 2);
    var pathToDelivery = generatePathPoints(position, buyerPosition, 2);
    var completePath = pathToPickup.concat(pathToDelivery); // 두 경로를 합칩니다.

    var currentStep = 0; // 현재 경로 포인트 인덱스

    var isPickUp = false;
    var isDeliveryComplete = false;
    var deliverPosition;

    function moveMarker() {
      if (currentStep < completePath.length) {
       deliverPosition = completePath[currentStep];
        marker.setPosition(deliverPosition); // 마커 위치 업데이트

        // 인포윈도우 내용 업데이트 및 표시
        var content = '<div style="padding:5px;">배달원 위치</div>';
        infowindow.setContent(content);
        infowindow.open(map, marker);

        // 판매 위치와의 거리가 0이 아닐 때만 dtoSline 선을 다시 그립니다
        if (getDistance(deliverPosition.getLat(), deliverPosition.getLng(), position.getLat(), position.getLng()) < 5) {
          isPickUp = true;
          dtoSline.setMap(null);
          updateDeliveryStatus(productNo, 1);
        }

        if (!isPickUp) {
          dtoSline.setPath([deliverPosition, position]);
        }

        // 구매자 위치와의 거리가 0이 아닐 때만 stoBline 선을 다시 그립니다
        if (getDistance(deliverPosition.getLat(),deliverPosition.getLng(), buyerPosition.getLat(), buyerPosition.getLng()) < 5) {
          isDeliveryComplete = true;
          stoBline.setMap(null);
        }

        if (!isDeliveryComplete && isPickUp) {
          stoBline.setOptions({
            strokeWeight: 3,
            strokeColor: '#FF0000',
            strokeOpacity: 1.0,
            strokeStyle: 'shortdot'
          });
          stoBline.setPath([deliverPosition, buyerPosition]);
        }

        currentStep++; // 다음 경로 포인트로 이동
      } else {
        locPosition = deliverPosition;
        clearInterval(movementInterval); // 모든 경로 포인트를 이동했다면 인터벌 종료
      }
    }

    // 500ms마다 moveMarker 함수를 실행하여 마커를 이동
    movementInterval = setInterval(moveMarker, 500);
  }



  function setBounds() {
    console.log(bounds)
    map.setBounds(bounds);
  }


  // 상태 전환 버튼 클릭 이벤트
  $('#status-toggle').on('click', function () {
    $('#statusModal').modal('show'); // 모달 창 표시
  });

  // 모달 내 상태 버튼 클릭 이벤트
  $('.status-button').on('click', function () {
    var newStatus = $(this).data('status'); // data-status 속성 값 가져오기
    updateDeliverStatus(${user.no}, newStatus , 0); // 상태 업데이트 함수 호출
    $('#statusModal').modal('hide'); // 모달 창 숨기기
  });



  //도착버튼
  $('#arrival').on('click', function () {
    var newStatus = 1; // 휴식

    console.log(productNo)
    updateEndDate(productNo);

    // Java의 ProductDAO 클래스 내 updateEndDate 메소드 호출 (서버사이드 코드에서 처리 필요)
    var fee = price;
    updateDeliverStatus(${user.no}, newStatus , fee); // 상태 업데이트 함수 호출
    updateDeliveryStatus(productNo, 2);
    // 클라이언트 사이드에서는 AJAX 호출을 통해 서버에 요청을 보내야 합니다.
    // 예시:
    productNo =0;
  });


  // 배달원 상태 업데이트 함수
  function updateDeliverStatus(no, newStatus, fee) {
    $.ajax({
      url: 'deliverStatus.do', // DeliverStatusController로의 실제 경로
      type: 'POST',
      data: {
        no: no,
        status: newStatus,
        cash : fee
      },
      success: function (response) {
        $('#user-status').text("상태 : " + response.status); // 응답 받은 새로운 상태로 업데이트
        $('#cash').text("현금 : " + response.cash+"원");
        toggleButtonsBasedOnStatus(response.status);
      },
      error: function () {
        alert("상태 업데이트에 실패하였습니다.");
      }
    });
  }

  // 딜리버리 상태 업데이트 함수
  function updateDeliveryStatus(no, newStatus) {
    $.ajax({
      url: 'deliveryStatus.do', // DeliverStatusController로의 실제 경로
      type: 'POST',
      data: {
        no: no,
        status: newStatus
      },
      success: function (response) {
        $('#user-status').text("상태 : " + response); // 응답 받은 새로운 상태로 업데이트
        toggleButtonsBasedOnStatus(response);
      },
      error: function () {
        alert("상태 업데이트에 실패하였습니다.");
      }
    });
  }

  function updateEndDate(productNo) {
    $.ajax({
      url: 'quickEnd.do',
      method: 'POST',
      data: { no: productNo }, // endDate를 제외하고 no만 전송
      success: function(response) {
        console.log("날짜 업데이트 완료");
      },
      error: function(xhr, status, error) {
        console.error("날짜 업데이트 실패");
      }
    });
  }

  function setDelivery(productNo,deliverNo,deliveryFee,productAddress) {
    $.ajax({
      url: 'deliveryUpdate.do',
      method: 'POST',
      data: { productNo: productNo ,
        deliverNo: deliverNo,
        deliveryFee : deliveryFee,
        productAddress : productAddress,
      },
      success: function(response) {
        console.log("딜리버리 셋팅 완료");
      },
      error: function(xhr, status, error) {
        console.error("딜리버리 셋팅 실패");
      }
    });
  }

  document.getElementById('refresh').addEventListener('click', function() {
    $.ajax({
      url: 'quickRefresh.do', // 데이터를 가져올 서버의 엔드포인트
      type: 'GET', // 또는 'POST', 서버의 요구사항에 따라 결정
      dataType: 'json', // 받아올 데이터 타입
      success: function(response) {
        listData = response.productList;
        deliver = response.deliver;
        buyerListData = response.buyerList;

        var mapContainer = document.getElementById('map'), // 지도를 표시할 div
            mapOption = {
              center: new kakao.maps.LatLng(locPosition.getLat(), locPosition.getLng()), // 지도의 중심좌표
              level: 3 // 지도의 확대 레벨
            };
        document.getElementById('map').innerHTML = "";
        map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
        displayMarker(locPosition);

        for (let i = 0; i < listData.length; i++) {
          createMarkerForAddress(listData[i], buyerListData[i], i);
          console.log(listData[i]);
          console.log(buyerListData[i]);
        }
      },
      error: function(xhr, status, error) {
        // 데이터를 받아오는 데 실패한 경우
        console.error("Data fetch failed: ", error);
      }
    });

  });

  // 배달 내용 버튼 클릭 이벤트 핸들러
  $('#delivery-details-btn').click(function() {
    var totalDistance = pDistance + aDistance;
    var delayTime = 2; //건물을 오르는등 기타시간 고려
    var tTime = getTime(totalDistance*2)+ delayTime*2;
    var pTime = getTime(pDistance*2)+ delayTime;
    var aTime = getTime(aDistance*2)+ delayTime;

    var dTime = new Date(deliveryDate.getTime());



    // 계산된 값들을 모달의 적절한 위치에 표시
    $('#pName').text(productName);
    $('#timeDistance').text("예상 소요시간 및 이동거리: " + tTime+"분/" + Math.round(totalDistance)+"m");
    $('#fee').text("배달료: " + price + "원");


    dTime.setMinutes(dTime.getMinutes() + pTime);
    $('#pAddress').text(pAddress);
    $('#pDistance').text("거리 : " + Math.round(pDistance) +"m");
    $('#pTime').text("픽업 예상시간: " + estimateTime(dTime));


    dTime.setMinutes(dTime.getMinutes() + aTime );
    $('#aAddress').text(aAddress);
    $('#aDistance').text("거리 : " + Math.round(aDistance)+"m");
    $('#aTime').text("도착 예상시간: " + estimateTime(dTime));

    // 모달을 표시합니다.
    $('#deliveryModal').modal('show');
  });

  function getTime(distance) {
    // 자전거의 평균 분속 정의 (16km/h => 267m/min)
    var averageSpeedPerMinute = 267;

    // 주어진 거리에 대한 총 이동 시간을 분 단위로 계산
    var totalMinutes = distance / averageSpeedPerMinute;

    // 결과를 반올림하여 반환
    return Math.round(totalMinutes);
  }

  function estimateTime(dTime) {
    // 오전/오후 포맷으로 시간 포맷팅
    var hours = dTime.getHours();
    var minutes = dTime.getMinutes();
    var ampm = hours >= 12 ? '오후' : '오전';
    hours = hours % 12;
    hours = hours ? hours : 12; // 0시는 12시로 표시
    minutes = minutes < 10 ? '0' + minutes : minutes;

    var formattedTime = ampm + ' ' + hours + '시 ' + minutes + '분';

    return formattedTime;
  }



  function panTo() {//지도좌표 이동
    // 이동할 위도 경도 위치를 생성합니다
    var moveLatLon = new kakao.maps.LatLng(locPosition.getLat(), locPosition.getLng());

    // 지도 중심을 부드럽게 이동시킵니다
    // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
    map.panTo(moveLatLon);
  }

</script>