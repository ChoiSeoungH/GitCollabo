package controller.Product;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.databind.ObjectMapper;

import dao.AuctionDAO;
import dao.ProductDAO;
import dao.ProductImgDAO;
import dao.UserDAO;
import frontcontorller.Controller;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vo.Auction;
import vo.Product;
import vo.ProductImg;
import vo.User;

public class ProductContentController implements Controller {

	@Override
	public String requestHandler(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int ProductNo = Integer.parseInt(request.getParameter("productNo"));
		String isAuction = request.getParameter("auction");

		String clientId = "13_wgGKv5DSSkXmuqLvJ"; //애플리케이션 클라이언트 아이디
		String clientSecret = "7NDxx6guwd"; //애플리케이션 클라이언트 시크릿
		String ctx = request.getContextPath();

		String text = request.getParameter("query").trim();
		if (text != null && !text.isEmpty()) {
			text = URLEncoder.encode(text, "UTF-8");
		} else {
			response.getWriter().write("접속 에러.");
			return "main";
		}


		String apiURL = "https://openapi.naver.com/v1/search/shop?query=" + text+"&start=995"+"&filter=naverpay"+"&display=5" + "&sort=asc"; // JSON 결과

		Map<String, String> requestHeaders = new HashMap<>();
		requestHeaders.put("X-Naver-Client-Id", clientId);
		requestHeaders.put("X-Naver-Client-Secret", clientSecret);
		String responseBody = get(apiURL, requestHeaders); // ApiExamSearchBlog.get 메소드 활용

		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().write(responseBody); // API 응답 결과 출력
		ObjectMapper objectMapper = new ObjectMapper();
		Map<String, Object> responseMap=null;
		try {
			// JSON을 Map으로 변환
			responseMap = objectMapper.readValue(responseBody, Map.class);
			System.out.println( "오브젝트변환"+responseMap);
		} catch (IOException e) {
			throw new RuntimeException("Failed to parse JSON response", e);
		}


		//옥션 리스트 가져오기
		Auction au = AuctionDAO.getInstance().getOneAuction(ProductNo);
		//이미지 파일 가져오기
		List<ProductImg> image = ProductImgDAO.getInstance().getOneProductImg(ProductNo);
		if(isAuction.equals("true")) {
			Product vo = ProductDAO.getInstance().getProductNoContent(ProductNo);
			// 밑에느 경매 연관카테고리 5개 가져오기
			List<Product> list = ProductDAO.getInstance().getAboutCategory(ProductNo);
			System.out.println(list.toString());
			List<Auction> auList =AuctionDAO.getInstance().getAllAuction();
			List<ProductImg> imageList = ProductImgDAO.getInstance().getAllProductImg();
			if(AuctionDAO.getInstance().getOneAuctioBidNo(ProductNo) == null) {
				request.setAttribute("au", au);
				request.setAttribute("img", image);
				request.setAttribute("list", list);
				request.setAttribute("auList", auList);
				request.setAttribute("imageList", imageList);
				request.setAttribute("auction", isAuction);
				request.setAttribute("vo", vo);
				return "product/productContent";
			}
			int getNo =Integer.parseInt(AuctionDAO.getInstance().getOneAuctioBidNo(ProductNo));
			User bo = UserDAO.getInstance().getOneUser(getNo);
			System.out.println(getNo);
			request.setAttribute("nick", bo);
			request.setAttribute("au", au);
			request.setAttribute("img", image);
			request.setAttribute("list", list);
			request.setAttribute("auList", auList);
			request.setAttribute("imageList", imageList);
			request.setAttribute("auction", isAuction);
			request.setAttribute("vo", vo);
			return "product/productContent";

		}
		Product vo = ProductDAO.getInstance().getProductNoContent(ProductNo);
		int getNo = vo.getSellerNo();
		User bo = UserDAO.getInstance().getOneUser(getNo);
		request.setAttribute("bo", bo);
		request.setAttribute("au", au);
		request.setAttribute("img", image);
		request.setAttribute("auction", isAuction); // 옥션 값던지기
		request.setAttribute("vo", vo);
		request.setAttribute("naver", responseMap); //네이버 최저가
		return "product/productContent";

	}










	private static String get(String apiUrl, Map<String, String> requestHeaders){
		HttpURLConnection con = connect(apiUrl);
		try {
			con.setRequestMethod("GET");
			for(Map.Entry<String, String> header :requestHeaders.entrySet()) {
				con.setRequestProperty(header.getKey(), header.getValue());
			}


			int responseCode = con.getResponseCode();
			if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
				return readBody(con.getInputStream());
			} else { // 오류 발생
				return readBody(con.getErrorStream());
			}
		} catch (IOException e) {
			throw new RuntimeException("API 요청과 응답 실패", e);
		} finally {
			con.disconnect();
		}
	}
	private static HttpURLConnection connect(String apiUrl){
		try {
			URL url = new URL(apiUrl);
			return (HttpURLConnection)url.openConnection();
		} catch (MalformedURLException e) {
			throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
		} catch (IOException e) {
			throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
		}
	}


	private static String readBody(InputStream body){
		InputStreamReader streamReader = new InputStreamReader(body);


		try (BufferedReader lineReader = new BufferedReader(streamReader)) {
			StringBuilder responseBody = new StringBuilder();


			String line;
			while ((line = lineReader.readLine()) != null) {
				responseBody.append(line);
			}


			return responseBody.toString();
		} catch (IOException e) {
			throw new RuntimeException("API 응답을 읽는 데 실패했습니다.", e);
		}
	}
}



