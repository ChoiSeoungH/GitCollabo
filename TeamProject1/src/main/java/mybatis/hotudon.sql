CREATE DATABASE IF NOT EXISTS hotudon;
USE hotudon;

# DROP DATABASE hotudon;
#
# DROP TABLE user;
# Drop TABLE product;
# Drop TABLE product_image;
# Drop TABLE category;
# Drop TABLE auction;
# Drop TABLE chat;
# Drop TABLE alarm;
# Drop TABLE delivery;


CREATE TABLE IF NOT EXISTS user (
                                    no INT AUTO_INCREMENT PRIMARY KEY, # 유저 번호
                                    id VARCHAR(100) NOT NULL UNIQUE KEY, # 아이디
    img_url VARCHAR(100) NOT NULL DEFAULT 'default.jpg', # 프로필 이미지
    pw VARCHAR(100) NOT NULL, # 비밀번호
    name VARCHAR(100) NOT NULL, # 이름
    nickname VARCHAR(100), # 닉네임
    cash INT NOT NULL DEFAULT 0, # 보유 캐시
    phone VARCHAR(100) NOT NULL UNIQUE KEY, # 전화번호
    location VARCHAR(100), # 주소
    reg_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, # 가입일
    penalty INT NOT NULL DEFAULT 0, # 패널티
    deliver BOOLEAN NOT NULL DEFAULT FALSE, # 배달 기사 여부
    status INT NOT NULL DEFAULT 0 # 0 : 오프라인, 1 : 휴식, 2 : 대기, 3 : 배송중, 4 : 비활성화(탈퇴)
    );
DESC user;
SELECT * FROM user;

CREATE TABLE IF NOT EXISTS category (
                                        no INT PRIMARY KEY, # 카테고리 번호 ( 0 : 전체, 1 : 디지털, 2 : 의류, 3 : 가구)
    name VARCHAR(100) NOT NULL # 카테고리 이름
    );
DESC category;
SELECT * FROM category;

CREATE TABLE IF NOT EXISTS product (
                                       no INT AUTO_INCREMENT PRIMARY KEY, # 상품 번호
                                       category INT NOT NULL DEFAULT 0, # 0 : 전체, 1 : 디지털, 2 : 의류, 3 : 가구
                                       seller_no INT NOT NULL, # 판매자 번호
                                       title VARCHAR(100) NOT NULL, # 상품명
    price INT NOT NULL, # 가격
    description TEXT NOT NULL, # 상품 설명
    reg_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, # 등록일
    is_auction BOOLEAN NOT NULL DEFAULT FALSE, # 경매 여부
    sell_location VARCHAR(100), # 희망 거래 위치
    product_method INT NOT NULL DEFAULT 0, # 0 : 직거래, 1 : 택배, 2 : 다른 서비스, 3: 상관없음
    buyer_no INT, # 구매자 번호 (판매 완료가 되어야만 값이 들어감)
    end_date TIMESTAMP, # 판매 종료일
    FOREIGN KEY (seller_no) REFERENCES user(no), # seller_no 외래키
    FOREIGN KEY (buyer_no) REFERENCES user(no), # buyer_no 외래키
    FOREIGN KEY (category) REFERENCES category (no) # category_no외래키
    );
DESC product;
SELECT * FROM product;

CREATE TABLE IF NOT EXISTS product_image (
                                             no INT AUTO_INCREMENT PRIMARY KEY,
                                             product_no INT NOT NULL,
                                             image_url VARCHAR(100) NOT NULL,
    reg_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_no) REFERENCES product(no) # product_no 외래키
    );
DESC product_image;
SELECT * FROM product_image;



CREATE TABLE IF NOT EXISTS auction (
                                       product_no INT, # 상품 번호
                                       last_price INT NOT NULL, # 마지막 입찰가
                                       last_bid_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, # 마지막 입찰일
                                       last_bidder_no INT, # 마지막 입찰자 번호
                                       FOREIGN KEY (product_no) REFERENCES product(no), # product_no 외래키
    FOREIGN KEY (last_bidder_no) REFERENCES user(no) # last_bidder_no 외래키
    );
DESC auction;
SELECT * FROM auction;

CREATE TABLE IF NOT EXISTS chat (
                                    product_no INT NOT NULL, # 상품 번호
                                    sender_no INT NOT NULL, # 보낸 사람 번호
                                    receiver_no INT NOT NULL, # 받는 사람 번호
                                    content TEXT NOT NULL, # 채팅 내용
                                    send_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, # 보낸 날짜
                                    FOREIGN KEY (product_no) REFERENCES product(no), # product_no 외래키
    FOREIGN KEY (sender_no) REFERENCES user(no), # sender_no 외래키
    FOREIGN KEY (receiver_no) REFERENCES user(no) # receiver_no 외래키
    );
DESC chat;
SELECT * FROM chat;

CREATE TABLE IF NOT EXISTS alarm (
                                     no INT AUTO_INCREMENT PRIMARY KEY, # 알람 번호
                                     user_no INT NOT NULL, # 유저 번호
                                     type INT NOT NULL DEFAULT 0, # 0 : 채팅, 1 : 경매, 2 : 배송상태, 3 : 패널티, 4 : 안전재난 문자, 5 : 배송요청
                                     alarm_status BOOLEAN NOT NULL DEFAULT FALSE, # 알람 상태 (읽음, 안읽음)
    reg_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, # 알람 날짜
    content TEXT NOT NULL, # 알람 내용
    FOREIGN KEY (user_no) REFERENCES user(no) # user_no 외래키
    );
DESC alarm;
SELECT * FROM alarm;

CREATE TABLE IF NOT EXISTS delivery (
                                        no INT AUTO_INCREMENT PRIMARY KEY, # 배송 번호
                                        product_no INT NOT NULL, # 상품 번호
                                        deliver_no INT NOT NULL, # 배송 기사 번호
                                        price INT NOT NULL DEFAULT 0, # 배송비
                                        status INT NOT NULL DEFAULT 0, # 0 : 배송 준비중, 1 : 배송 중, 2 : 배송 완료
                                        reg_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, # 배송 신청일
                                        location VARCHAR(100) NOT NULL, # 도착 장소
    FOREIGN KEY (product_no) REFERENCES product(no), # product_no 외래키
    FOREIGN KEY (deliver_no) REFERENCES user(no) # deliver_no 외래키
    );
DESC delivery;
SELECT * FROM delivery;

# EX : -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO user (id, pw, name, phone, deliver) VALUES ('admin', 'admin', '관리자', '010-1234-5678', TRUE);
INSERT INTO user (id, pw, name, phone) VALUES ('qwer', '1234', '김세희', '010-3231-1232');
INSERT INTO user (id, pw, name, phone, deliver) VALUES ('abcd', '1234', '김민수', '010-1234-5643', TRUE);

INSERT INTO category (no, name) VALUES (0, '전체');
INSERT INTO category (no, name) VALUES (1, '디지털');
INSERT INTO category (no, name) VALUES (2, '의류');
INSERT INTO category (no, name) VALUES (3, '가구');

INSERT INTO product (category, seller_no, title, price, description, sell_location, product_method) VALUES (1, 2, '아이폰 12', 1000000, '아이폰 12 256GB 실버 색상입니다.', '서울시 강남구', 0);
INSERT INTO product_image (product_no, image_url) VALUES (1, 'iphone12.jpg');
INSERT INTO product (category, seller_no, title, price, description, sell_location, product_method) VALUES (2, 2, '나이키 후드티', 50000, '나이키 후드티 검정색입니다.', '서울시 강남구', 0);
INSERT INTO product_image (product_no, image_url) VALUES (2, 'nike.jpg');
INSERT INTO product (category, seller_no, title, price, description, is_auction, sell_location, product_method) VALUES (3, 2, '책상', 30000, '책상입니다.', TRUE, '서울시 강남구', 1);
INSERT INTO product_image (product_no, image_url) VALUES (3, 'desk.jpg');
INSERT INTO product_image (product_no, image_url) VALUES (3, 'desk2.jpg');

INSERT INTO auction (product_no, last_price, last_bidder_no) VALUES (3, 30000, 2);
UPDATE auction SET last_price = 35000 WHERE product_no = 3;
UPDATE auction SET last_bidder_no = 1 WHERE product_no = 3;

INSERT INTO chat (product_no, sender_no, receiver_no, content) VALUES (3, 1, 2, '안녕하세요');
INSERT INTO alarm (user_no, type, content) VALUES (2, 0, '새로운 채팅이 도착했습니다.');
UPDATE alarm SET alarm_status = TRUE WHERE no = 1;
INSERT INTO chat (product_no, sender_no, receiver_no, content) VALUES (3, 2, 1, '안녕하세요');
INSERT INTO alarm (user_no, type, content) VALUES (1, 0, '새로운 채팅이 도착했습니다.');
UPDATE alarm SET alarm_status = TRUE WHERE no = 2;
INSERT INTO chat (product_no, sender_no, receiver_no, content) VALUES (3, 1, 2, '책상 퀵으로 배송해 주세요. ');
INSERT INTO alarm (user_no, type, content) VALUES (2, 0, '새로운 채팅이 도착했습니다.');
UPDATE alarm SET alarm_status = TRUE WHERE no = 3;
INSERT INTO chat (product_no, sender_no, receiver_no, content) VALUES (3, 2, 1, '네 알겠습니다.');
INSERT INTO alarm (user_no, type, content) VALUES (1, 0, '새로운 채팅이 도착했습니다.');
UPDATE alarm SET alarm_status = TRUE WHERE no = 4;

INSERT INTO delivery (product_no, deliver_no, location, price) VALUES (3, 3, '서울시 강남구', 4000);
INSERT INTO alarm (user_no, type, content) VALUES (3, 5, '배송 요청이 도착했습니다.');
UPDATE alarm SET alarm_status = TRUE WHERE no = 5;
INSERT INTO alarm (user_no, type, content) VALUES (1, 2, '배송이 시작되었습니다.');
INSERT INTO alarm (user_no, type, content) VALUES (2, 2, '배송이 시작되었습니다.');
INSERT INTO alarm (user_no, type, content) VALUES (1, 2, '상품이 곧 도착합니다');
INSERT INTO alarm (user_no, type, content) VALUES (2, 2, '상품이 곧 도착합니다');
INSERT INTO alarm (user_no, type, content) VALUES (1, 2, '상품이 도착완료되었습니다.');
INSERT INTO alarm (user_no, type, content) VALUES (2, 2, '상품이 도착완료되었습니다.');
UPDATE delivery SET status = 2 WHERE no = 1;

UPDATE product SET buyer_no = 1 WHERE no = 3;
UPDATE product SET end_date = NOW() WHERE no = 3;

# -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT * FROM user;
SELECT * FROM category;
SELECT * FROM product;
SELECT * FROM product_image;
SELECT * FROM auction;
SELECT * FROM chat;
SELECT * FROM alarm;
SELECT * FROM delivery;