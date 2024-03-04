package org.apache.jsp.WEB_002dINF.map;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.jsp.*;

public final class map_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports,
                 org.apache.jasper.runtime.JspSourceDirectives {

  private static final jakarta.servlet.jsp.JspFactory _jspxFactory =
          jakarta.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.LinkedHashSet<>(3);
    _jspx_imports_packages.add("jakarta.servlet");
    _jspx_imports_packages.add("jakarta.servlet.http");
    _jspx_imports_packages.add("jakarta.servlet.jsp");
    _jspx_imports_classes = null;
  }

  private volatile jakarta.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public boolean getErrorOnELNotFound() {
    return false;
  }

  public jakarta.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
  }

  public void _jspDestroy() {
  }

  public void _jspService(final jakarta.servlet.http.HttpServletRequest request, final jakarta.servlet.http.HttpServletResponse response)
      throws java.io.IOException, jakarta.servlet.ServletException {

    if (!jakarta.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
      final java.lang.String _jspx_method = request.getMethod();
      if ("OPTIONS".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        return;
      }
      if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSP들은 오직 GET, POST 또는 HEAD 메소드만을 허용합니다. Jasper는 OPTIONS 메소드 또한 허용합니다.");
        return;
      }
    }

    final jakarta.servlet.jsp.PageContext pageContext;
    jakarta.servlet.http.HttpSession session = null;
    final jakarta.servlet.ServletContext application;
    final jakarta.servlet.ServletConfig config;
    jakarta.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    jakarta.servlet.jsp.JspWriter _jspx_out = null;
    jakarta.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write('\r');
      out.write('\n');
      out.write("\r\n");
      out.write("<!DOCTYPE html>\r\n");
      out.write("<html lang=\"ko\">\r\n");
      out.write("<head>\r\n");
      out.write("  <meta charset=\"UTF-8\">\r\n");
      out.write("  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n");
      out.write("  <title>뜨끈한 우동</title>\r\n");
      out.write("  <!-- Add your CSS file link here -->\r\n");
      out.write("  <style>\r\n");
      out.write("      body {\r\n");
      out.write("          margin: 0;\r\n");
      out.write("          padding: 0;\r\n");
      out.write("          display: flex;\r\n");
      out.write("          flex-direction: column; /* Children to stack vertically */\r\n");
      out.write("      }\r\n");
      out.write("      #search-form {\r\n");
      out.write("          margin-top: 20px; /* Spacing from the map */\r\n");
      out.write("          text-align: center;\r\n");
      out.write("      }\r\n");
      out.write("\r\n");
      out.write("      #map-container {\r\n");
      out.write("          width: 1200px;\r\n");
      out.write("          height: 600px;\r\n");
      out.write("          position: relative; /* For absolute positioning of the buttons */\r\n");
      out.write("      }\r\n");
      out.write("\r\n");
      out.write("      #address-form {\r\n");
      out.write("          margin-top: 20px; /* Spacing from the map */\r\n");
      out.write("          text-align: center;\r\n");
      out.write("      }\r\n");
      out.write("\r\n");
      out.write("      .address-input {\r\n");
      out.write("          margin: 10px 0; /* Spacing between inputs */\r\n");
      out.write("          width: 50%;\r\n");
      out.write("      }\r\n");
      out.write("  </style>\r\n");
      out.write("  <script src=\"https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js\"></script>\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("<div id=\"search-form\">\r\n");
      out.write("  <input type=\"text\" id=\"search\" class=\"address-input\" placeholder=\"검색할 주소를 입력하세요\">\r\n");
      out.write("  <button onclick=\"searchAndMoveTo()\">검색</button>\r\n");
      out.write("</div>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<div id=\"main-content\">\r\n");
      out.write("  <!-- Map container -->\r\n");
      out.write("  <div id=\"map-container\">\r\n");
      out.write("    <div id=\"map\" style=\"width:1200px;height:600px;\"></div>\r\n");
      out.write("  </div>\r\n");
      out.write("  <!-- Map control buttons -->\r\n");
      out.write("  <button id=\"center-map\" onclick=\"panTo()\">내 중심좌표</button>\r\n");
      out.write("</div>\r\n");
      out.write("\r\n");
      out.write("<!-- Address form -->\r\n");
      out.write("<div id=\"address-form\">\r\n");
      out.write("  <input type=\"text\" id=\"basic-address\" class=\"address-input\" placeholder=\"기본 주소\" readonly>\r\n");
      out.write("  <input type=\"text\" id=\"detail-address\" class=\"address-input\" placeholder=\"상세 주소\">\r\n");
      out.write("  <div id=\"user-dong\" class=\"address-input\"> </div> <!-- 여기에 '동'을 표시할 div를 추가합니다 -->\r\n");
      out.write("  <button onclick=\"saveAddress()\">주소 저장</button>\r\n");
      out.write("</div>\r\n");
      out.write("</div>\r\n");
      out.write("</body>\r\n");
      out.write("</html>\r\n");
      out.write("<script\r\n");
      out.write("    src=\"//dapi.kakao.com/v2/maps/sdk.js?appkey=c8936a5cd23e9343aaae775855cc0679&libraries=services,clusterer,drawing\"></script>\r\n");
      out.write("<script>\r\n");
      out.write("  var geocoder = new kakao.maps.services.Geocoder();\r\n");
      out.write("  var infowindow = new kakao.maps.InfoWindow({zIndex: 1}); // 인포윈도우 생성\r\n");
      out.write("  var marker;\r\n");
      out.write("  var lat;\r\n");
      out.write("  var lon;\r\n");
      out.write("  var mapContainer = document.getElementById('map'), // 지도를 표시할 div\r\n");
      out.write("      mapOption = {\r\n");
      out.write("        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표\r\n");
      out.write("        level: 3 // 지도의 확대 레벨\r\n");
      out.write("      };\r\n");
      out.write("\r\n");
      out.write("  var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다\r\n");
      out.write("\r\n");
      out.write("  // HTML5의 geolocation으로 사용할 수 있는지 확인합니다\r\n");
      out.write("  if (navigator.geolocation) {\r\n");
      out.write("\r\n");
      out.write("    // GeoLocation을 이용해서 접속 위치를 얻어옵니다\r\n");
      out.write("    navigator.geolocation.getCurrentPosition(function (position) {\r\n");
      out.write("\r\n");
      out.write("      lat = position.coords.latitude, // 위도\r\n");
      out.write("          lon = position.coords.longitude; // 경도\r\n");
      out.write("\r\n");
      out.write("      var locPosition = new kakao.maps.LatLng(lat, lon) // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("      // 마커와 인포윈도우를 표시합니다\r\n");
      out.write("      displayMarker(locPosition);\r\n");
      out.write("\r\n");
      out.write("    });\r\n");
      out.write("\r\n");
      out.write("  } else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다\r\n");
      out.write("\r\n");
      out.write("    var locPosition = new kakao.maps.LatLng(33.450701, 126.570667);\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("    displayMarker(locPosition);\r\n");
      out.write("  }\r\n");
      out.write("\r\n");
      out.write("  // 지도에 마커와 인포윈도우를 표시하는 함수입니다\r\n");
      out.write("  function displayMarker(locPosition) {\r\n");
      out.write("\r\n");
      out.write("    // 마커를 생성합니다\r\n");
      out.write("    marker = new kakao.maps.Marker({\r\n");
      out.write("      map: map,\r\n");
      out.write("      position: locPosition,\r\n");
      out.write("      draggable: true // 마커를 드래그 가능하도록 설정합니다\r\n");
      out.write("    });\r\n");
      out.write("\r\n");
      out.write("    // 지도 중심좌표를 접속위치로 변경합니다\r\n");
      out.write("    map.setCenter(locPosition);\r\n");
      out.write("\r\n");
      out.write("    searchAddrFromCoords(map.getCenter(), displayInfowindow);\r\n");
      out.write("\r\n");
      out.write("    // 마커에 드래그 종료 이벤트를 등록합니다\r\n");
      out.write("    kakao.maps.event.addListener(marker, 'dragend', function () {\r\n");
      out.write("      // 드래그가 끝난 위치의 좌표를 얻어옵니다\r\n");
      out.write("      var position = marker.getPosition();\r\n");
      out.write("      // 드래그 끝난 위치에 대한 주소 정보를 조회합니다\r\n");
      out.write("      searchAddrFromCoords(position, displayInfowindow);\r\n");
      out.write("    });\r\n");
      out.write("\r\n");
      out.write("    // 마커에 클릭 이벤트를 등록한다 (우클릭 : rightclick)\r\n");
      out.write("    kakao.maps.event.addListener(marker, 'click', function () {\r\n");
      out.write("      alert('마커를 클릭했습니다!');\r\n");
      out.write("    });\r\n");
      out.write("  }\r\n");
      out.write("\r\n");
      out.write("  var mapTypeControl = new kakao.maps.MapTypeControl();\r\n");
      out.write("\r\n");
      out.write("  // 지도의 상단 우측에 지도 타입 변경 컨트롤을 추가한다\r\n");
      out.write("  map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);\r\n");
      out.write("\r\n");
      out.write("  // 지도에 확대 축소 컨트롤을 생성한다\r\n");
      out.write("  var zoomControl = new kakao.maps.ZoomControl();\r\n");
      out.write("\r\n");
      out.write("  // 지도의 우측에 확대 축소 컨트롤을 추가한다\r\n");
      out.write("  map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("  function searchAddrFromCoords(coords, callback) {\r\n");
      out.write("    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);\r\n");
      out.write("  }\r\n");
      out.write("  var jibunAddress;\r\n");
      out.write("  var roadAddress;\r\n");
      out.write("\r\n");
      out.write("  function displayInfowindow(result, status) {\r\n");
      out.write("    if (status === kakao.maps.services.Status.OK && result[0]) {\r\n");
      out.write("      var detailAddr = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';\r\n");
      out.write("      detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';\r\n");
      out.write("\r\n");
      out.write("      // 도로명 주소 또는 지번 주소에서 '동'을 추출합니다.\r\n");
      out.write("      var dong = extractDong(result[0].address.address_name);\r\n");
      out.write("\r\n");
      out.write("      roadAddress = result[0].road_address ? result[0].road_address.address_name : '';\r\n");
      out.write("      jibunAddress = result[0].address.address_name;\r\n");
      out.write("\r\n");
      out.write("      var content = '<div class=\"bAddr\">' +\r\n");
      out.write("          '<span class=\"title\">법정동 주소정보</span>' +\r\n");
      out.write("          detailAddr\r\n");
      out.write("      // Update the basic address input field with the road address\r\n");
      out.write("      if (roadAddress=='') {//도로명주소가 없을시 지번주소를 기본주소로\r\n");
      out.write("        document.getElementById('basic-address').value = jibunAddress;\r\n");
      out.write("      }else{\r\n");
      out.write("        document.getElementById('basic-address').value = roadAddress;\r\n");
      out.write("      }\r\n");
      out.write("      document.getElementById('user-dong').innerText = '현재 위치는 '+dong+' 내에 있어요.';\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("      infowindow.setContent(content);\r\n");
      out.write("      infowindow.open(map, marker);\r\n");
      out.write("    }\r\n");
      out.write("  }\r\n");
      out.write("\r\n");
      out.write("  // '동'을 추출하는 함수\r\n");
      out.write("  function extractDong(address) {\r\n");
      out.write("    // 주소에서 '동'에 해당하는 부분을 정규식을 사용하여 추출합니다.\r\n");
      out.write("    var dongRegex = /.*동/;\r\n");
      out.write("    var match = address.match(dongRegex);\r\n");
      out.write("    return match ? match[0] : '동을 찾을 수 없음';\r\n");
      out.write("  }\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("  function panTo() {//지도좌표 이동\r\n");
      out.write("    // 이동할 위도 경도 위치를 생성합니다\r\n");
      out.write("    var moveLatLon = new kakao.maps.LatLng(lat, lon);\r\n");
      out.write("\r\n");
      out.write("    // 지도 중심을 부드럽게 이동시킵니다\r\n");
      out.write("    // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다\r\n");
      out.write("    map.panTo(moveLatLon);\r\n");
      out.write("    marker.setPosition(moveLatLon);\r\n");
      out.write("    var position = marker.getPosition();\r\n");
      out.write("    searchAddrFromCoords(position, displayInfowindow);\r\n");
      out.write("  }\r\n");
      out.write("\r\n");
      out.write("  function saveAddress() {\r\n");
      out.write("    // var basicAddress = $('#basic-address').val();\r\n");
      out.write("    var detailAddress = $('#detail-address').val();\r\n");
      out.write("\r\n");
      out.write("    var address = {\r\n");
      out.write("      roadAddress: roadAddress,\r\n");
      out.write("      jibunAddress: jibunAddress,\r\n");
      out.write("      detailAddress: detailAddress\r\n");
      out.write("    };\r\n");
      out.write("    console.log(JSON.stringify(address));\r\n");
      out.write("    $.ajax({\r\n");
      out.write("      url: \"insertAddress.do\",\r\n");
      out.write("      type: \"POST\",\r\n");
      out.write("      contentType: \"application/json\",\r\n");
      out.write("      data: JSON.stringify(address),\r\n");
      out.write("      success: function(response) {\r\n");
      out.write("        // 성공적으로 응답을 받았을 때의 처리\r\n");
      out.write("        console.log(\"응답:\", response);\r\n");
      out.write("        alert('주소가 성공적으로 저장되었습니다.');\r\n");
      out.write("      },\r\n");
      out.write("      error: function(xhr, status, error) {\r\n");
      out.write("        // 에러가 발생했을 때의 처리\r\n");
      out.write("        console.error(\"에러 발생:\", xhr, status, error);\r\n");
      out.write("        alert('주소 저장에 실패했습니다.');\r\n");
      out.write("      }\r\n");
      out.write("    });\r\n");
      out.write("  }\r\n");
      out.write("\r\n");
      out.write("  // 주소를 검색하고 해당 위치로 지도를 이동시키는 함수\r\n");
      out.write("  function searchAndMoveTo() {\r\n");
      out.write("    var address = document.getElementById('controller.search').value; // 사용자 입력 주소 가져오기\r\n");
      out.write("\r\n");
      out.write("    // 주소로 좌표를 검색합니다.\r\n");
      out.write("    geocoder.addressSearch(address, function(result, status) {\r\n");
      out.write("      // 정상적으로 검색이 완료됐으면\r\n");
      out.write("      if (status === kakao.maps.services.Status.OK) {\r\n");
      out.write("        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);\r\n");
      out.write("\r\n");
      out.write("        // 검색된 좌표로 지도 이동\r\n");
      out.write("        map.setCenter(coords);\r\n");
      out.write("\r\n");
      out.write("        // 마커 위치를 변경합니다\r\n");
      out.write("        marker.setPosition(coords);\r\n");
      out.write("\r\n");
      out.write("        // 인포윈도우 내용을 업데이트하고 열기\r\n");
      out.write("        displayInfowindow(result, status);\r\n");
      out.write("      } else {\r\n");
      out.write("        alert('검색 결과가 없습니다. 주소를 다시 확인해주세요.');\r\n");
      out.write("      }\r\n");
      out.write("    });\r\n");
      out.write("  }\r\n");
      out.write("\r\n");
      out.write("</script>");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof jakarta.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
