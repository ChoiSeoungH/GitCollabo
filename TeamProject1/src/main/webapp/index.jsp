<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%--               메인 화면                --%>
<html>
<head>
    <link rel="stylesheet" href="css/style.css">
    <title>JSP - Hello World</title>
    <script type="text/javascript" src="js/style.js"></script>
    <script type="text/javascript" src="js/Function.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
</head>
<body>
    <div class="container">
        <header>
            <button style="cursor: pointer" type="button" onclick="ProductListByCategory('0')">경매 상품</button>
            <button style="cursor: pointer" type="button" onclick="ProductListByCategory('1')">디지털</button>
            <button style="cursor: pointer" type="button" onclick="ProductListByCategory('2')">의류</button>
            <button style="cursor: pointer" type="button" onclick="ProductListByCategory('3')">가구</button>
            <button style="cursor: pointer" type="button" onclick="ProductListByCategory('4')">전체</button>
        </header>
        <main>
            <section>
                <div class="logo">
                    <img src="" alt="Logo">
                </div>
                <div class="search">
                    <input type="text" placeholder="검색">
                    <button>검색</button>
                </div>
            </section>
            <section class="ad">
<%--                상품 광고 부분                  --%>
                <div class="product-box">
                    <div class="product-img">
                        <img src="" alt="Product">
                    </div>
                    <div class="content">
                        <span class="title">감자</span>
                        <span class="price">500원</span>
                    </div>
                </div>
                <div class="product-box">
                    <div class="product-img">
                        <img src="" alt="Product">
                    </div>
                    <div class="content">
                        <span class="title">감자</span>
                        <span class="price">500원</span>
                    </div>
                </div>
                <div class="product-box">
                    <div class="product-img">
                        <img src="" alt="Product">
                    </div>
                    <div class="content">
                        <span class="title">감자</span>
                        <span class="price">500원</span>
                    </div>
                </div>
            </section>
            <section id="list">
<%--                상품 리스트 부분                 --%>
                <div class="product-box">
                    <div class="product-img">
                        <img src="" alt="Product">
                    </div>
                    <div class="content">
                        <span class="title">감자</span>
                        <span class="price">500원</span>
                    </div>
                </div>
                <div class="product-box">
                    <div class="product-img">
                        <img src="" alt="Product">
                    </div>
                    <div class="content">
                        <span class="title">감자</span>
                        <span class="price">500원</span>
                    </div>
                </div>
                <div class="product-box">
                    <div class="product-img">
                        <img src="" alt="Product">
                    </div>
                    <div class="content">
                        <span class="title">감자</span>
                        <span class="price">500원</span>
                    </div>
                </div>
                <div class="product-box">
                    <div class="product-img">
                        <img src="" alt="Product">
                    </div>
                    <div class="content">
                        <span class="title">감자</span>
                        <span class="price">500원</span>
                    </div>
                </div>
                <div class="product-box">
                    <div class="product-img">
                        <img src="" alt="Product">
                    </div>
                    <div class="content">
                        <span class="title">감자</span>
                        <span class="price">500원</span>
                    </div>
                </div>
                <div class="product-box">
                    <div class="product-img">
                        <img src="" alt="Product">
                    </div>
                    <div class="content">
                        <span class="title">감자</span>
                        <span class="price">500원</span>
                    </div>
                </div>
                <div class="product-box">
                    <div class="product-img">
                        <img src="" alt="Product">
                    </div>
                    <div class="content">
                        <span class="title">감자</span>
                        <span class="price">500원</span>
                    </div>
                </div>
                <div class="product-box">
                    <div class="product-img">
                        <img src="" alt="Product">
                    </div>
                    <div class="content">
                        <span class="title">감자</span>
                        <span class="price">500원</span>
                    </div>
                </div>
                <div class="product-box">
                    <div class="product-img">
                        <img src="" alt="Product">
                    </div>
                    <div class="content">
                        <span class="title">감자</span>
                        <span class="price">500원</span>
                    </div>
                </div>
                <div class="product-box">
                    <div class="product-img">
                        <img src="" alt="Product">
                    </div>
                    <div class="content">
                        <span class="title">감자</span>
                        <span class="price">500원</span>
                    </div>
                </div>
                <div class="product-box">
                    <div class="product-img">
                        <img src="" alt="Product">
                    </div>
                    <div class="content">
                        <span class="title">감자</span>
                        <span class="price">500원</span>
                    </div>
                </div>
                <div class="product-box">
                    <div class="product-img">
                        <img src="" alt="Product">
                    </div>
                    <div class="content">
                        <span class="title">감자</span>
                        <span class="price">500원</span>
                    </div>
                </div>
                <div class="product-box">
                    <div class="product-img">
                        <img src="" alt="Product">
                    </div>
                    <div class="content">
                        <span class="title">감자</span>
                        <span class="price">500원</span>
                    </div>
                </div>
                <div class="product-box">
                    <div class="product-img">
                        <img src="" alt="Product">
                    </div>
                    <div class="content">
                        <span class="title">감자</span>
                        <span class="price">500원</span>
                    </div>
                </div>
                <div class="product-box">
                    <div class="product-img">
                        <img src="" alt="Product">
                    </div>
                    <div class="content">
                        <span class="title">감자</span>
                        <span class="price">500원</span>
                    </div>
                </div>
                <div class="product-box">
                    <div class="product-img">
                        <img src="" alt="Product">
                    </div>
                    <div class="content">
                        <span class="title">감자</span>
                        <span class="price">500원</span>
                    </div>
                </div>
                <div class="product-box">
                    <div class="product-img">
                        <img src="" alt="Product">
                    </div>
                    <div class="content">
                        <span class="title">감자</span>
                        <span class="price">500원</span>
                    </div>
                </div>
                <div class="product-box">
                    <div class="product-img">
                        <img src="" alt="Product">
                    </div>
                    <div class="content">
                        <span class="title">감자</span>
                        <span class="price">500원</span>
                    </div>
                </div>
                <div class="product-box">
                    <div class="product-img">
                        <img src="" alt="Product">
                    </div>
                    <div class="content">
                        <span class="title">감자</span>
                        <span class="price">500원</span>
                    </div>
                </div>
                <div class="product-box">
                    <div class="product-img">
                        <img src="" alt="Product">
                    </div>
                    <div class="content">
                        <span class="title">감자</span>
                        <span class="price">500원</span>
                    </div>
                </div>
                <div class="product-box">
                    <div class="product-img">
                        <img src="" alt="Product">
                    </div>
                    <div class="content">
                        <span class="title">감자</span>
                        <span class="price">500원</span>
                    </div>
                </div>
            </section>
        </main>

        <footer>
            <div class="user-info">
                <div class="user-box">
                    <div class="user-img">
                        <img src="" alt="User">
                    </div>
                    <div class="user-name">
                        <span id="name">홍길동</span>
                        <span id="money">50000원</span>
                    </div>
                </div>

                <div class="alarm-box">
                    <div class="alarm-card">
                        <img src="" alt="Alarm">
                        <span>알람</span>
                    </div>
                </div>

                <div class="util-box">
                    <button id="chat">채팅</button>
                    <button id="payment">결제</button>
                    <button id="delivery">배송</button>
                    <button id="logout">로그아웃</button>
                </div>
            </div>
        </footer>
    </div>
</body>
</html>