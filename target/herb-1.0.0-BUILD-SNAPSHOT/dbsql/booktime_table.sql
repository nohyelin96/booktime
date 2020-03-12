/*
--임시(주문 테이블과 유저의 아이디 연결 끊)
ALTER TABLE PAYMENT
	DROP
		CONSTRAINT FK_USER_TO_PAYMENT; -- 멤버 -> 주문
--임시(마일리지 테이블과 유저의 아이디 연결 끊)
ALTER TABLE MILEAGE
	DROP
		CONSTRAINT FK_USER_TO_MILEAGE;

--2020-02-05
--임시(마일리지 테이블에 변동이유 컬럼 추가)
alter table mileage
add (reason varchar2(300));

--임시(마일리지 테이블과 주문테이블의 주문번호 연결 끊)
ALTER TABLE MILEAGE
	DROP
		CONSTRAINT FK_PAYMENT_TO_MILEAGE;-- 주문 -> 마일리지

--임시(추천도서 테이블에 북커버 이미지 링크 컬럼 추가)
alter table recommendbook
add (cover varchar2(4000));
*/
	
-- 멤버
drop table "USER" cascade constraints;
CREATE TABLE "USER" (
	userid           varchar2(60)  NOT NULL, -- 아이디
	pwd              varchar2(60)  NOT NULL, -- 비밀번호
	name             varchar2(30)  NOT NULL, -- 이름
	birth            varchar2(30)  NOT NULL, -- 생년월일
	gender           varchar2(10)  NOT NULL, -- 성별
	grade            varchar2(20)  NOT NULL, -- 등급
	email1           varchar2(100) NOT NULL, -- 이메일1
	email2           varchar2(100) NOT NULL, -- 이메일2
	emailAgree       char(3)       default 'N' NULL,     -- 메일수신동의
	zipcode          varchar2(20)  NOT NULL, -- 우편번호
	parselAddress    varchar2(300) NOT NULL, -- 지번주소
	newAddress       varchar2(300) NOT NULL, -- 도로명주소
	addressDetail    varchar2(300) NOT NULL, -- 상세주소
	phone            varchar2(30)  NULL,     -- 전화번호
	mileage          number        default 0 NULL,     -- 마일리지
	withdrawalDate   date          NULL,     -- 탈퇴일
	withdrawalReason varchar2(1000)         NULL      -- 탈퇴사유
);

--테스트용 일반유저
insert into "USER"(userid, pwd, name, birth, gender, grade
    , email1, email2, emailAgree
    , zipcode, parselAddress, newAddress, addressDetail
    , phone)
values('test', '123', '김테스트', '1994-06-13', 'M', 'M1'
    , 'zxczxc613' ,'naver.com', 'Y'
    , '15369', '경기도 안산시 단원구 선부1동', '경기도 안산시 단원구 화정로 9', '100동 100호'
    , '010-9999-0000');
    
--테스트용 관리자
insert into "USER"(userid, pwd, name, birth, gender, grade
    , email1, email2, emailAgree
    , zipcode, parselAddress, newAddress, addressDetail
    , phone)
values('admin', '123', '킹김', '1994-05-05', 'F', 'A'
    , 'admin123' ,'booktime.do', 'N'
    , '15369', '경기도 안산시 단원구 선부1동', '경기도 안산시 단원구 화정로 9', '100동 100호'
    , '010-0000-1111');

select * from "USER";

-- 멤버 기본키
CREATE UNIQUE INDEX PK_USER
	ON "USER" ( -- 멤버
		userid ASC -- 아이디
	);

-- 멤버
ALTER TABLE "USER"
	ADD
		CONSTRAINT PK_USER -- 멤버 기본키
		PRIMARY KEY (
			userid -- 아이디
		);

-- 게시판
drop table board cascade constraints;
CREATE TABLE BOARD (
	boardNo          number        NOT NULL, -- 게시글번호
	userid           varchar2(60)  not NULL,     -- 아이디
	category         varchar2(30)  NOT NULL, -- 카테고리
	title            varchar2(60)  NOT NULL, -- 제목
	content          CLOB          NULL,     -- 내용
	regdate          date          default sysdate,     -- 작성일
	filename         varchar2(600) NULL,     -- 파일이름
	originalFilename varchar2(600) NULL,     -- 원래 파일 이름
	filesize         number        NULL,     -- 파일크기
	deleteDate       date          NULL,     -- 삭제일
	name             varchar2(30)  NULL,     -- 작성자 이름
	qType            varchar2(60)  NULL      -- 문의 유형
);

drop sequence board_seq;
create sequence board_seq
increment by 1
start with 1
nocache;

-- 게시판 기본키
CREATE UNIQUE INDEX PK_BOARD
	ON BOARD ( -- 게시판
		boardNo ASC -- 게시글번호
	);

-- 게시판
ALTER TABLE BOARD
	ADD
		CONSTRAINT PK_BOARD -- 게시판 기본키
		PRIMARY KEY (
			boardNo -- 게시글번호
		);

-- 댓글
drop table reply cascade constraints;
CREATE TABLE REPLY (
	replyNo         number       NOT NULL, -- 댓글번호
	boardNo         number       NULL,     -- 게시글번호
	userid          varchar2(60) NULL,     -- 아이디
	replyContent    CLOB         NOT NULL, -- 내용
	replyRegdate    date         default sysdate,     -- 작성시간
	groupNo         number       NOT NULL, -- 그룹번호
	step            char(5)      NOT NULL, -- 단계
	replyDeleteDate date         NULL      -- 삭제일
);

drop sequence reply_seq;
create sequence reply_seq
increment by 1
start with 1
nocache;

-- 댓글 기본키
CREATE UNIQUE INDEX PK_REPLY
	ON REPLY ( -- 댓글
		replyNo ASC -- 댓글번호
	);

-- 댓글
ALTER TABLE REPLY
	ADD
		CONSTRAINT PK_REPLY -- 댓글 기본키
		PRIMARY KEY (
			replyNo -- 댓글번호
		);

-- 즐겨찾기
drop table favorite cascade constraints;
CREATE TABLE FAVORITE (
	favoriteNo number        NOT NULL, -- 찜 번호
	userid     varchar2(60)  NOT NULL, -- 아이디
	"group"      varchar2(30)  NOT NULL, -- 분류
	isbn       varchar2(90)  NOT NULL, -- 책번호
	bookName   varchar2(300) NOT NULL, -- 책이름
	writer     varchar2(300)  NOT NULL, -- 저자
	publisher  varchar2(50)  NOT NULL, -- 출판사
	price      number        NOT NULL,  -- 책가격
	qty         number,  --수량
	regdate     date    default sysdate
);

drop sequence favorite_seq;
create sequence favorite_seq
increment by 1
start with 1
nocache;

-- 즐겨찾기 기본키
CREATE UNIQUE INDEX PK_FAVORITE
	ON FAVORITE ( -- 즐겨찾기
		favoriteNo ASC -- 찜 번호
	);

-- 즐겨찾기
ALTER TABLE FAVORITE
	ADD
		CONSTRAINT PK_FAVORITE -- 즐겨찾기 기본키
		PRIMARY KEY (
			favoriteNo -- 찜 번호
		);

-- 평점
drop table BOOKGRADE cascade constraints;
CREATE TABLE BOOKGRADE (
	bookGradeNo number       NOT NULL, -- 평점번호
	userid      varchar2(60) NULL,     -- 아이디
	isbn        varchar2(90) NOT NULL, -- 책번호
	bookGrade   number       NOT NULL,  -- 평점
	boardNo     number       NULL   --게시글 번호
);

drop sequence bookgrade_seq;
create sequence bookgrade_seq
increment by 1
start with 1
nocache;

-- 평점 기본키
CREATE UNIQUE INDEX PK_BOOKGRADE
	ON BOOKGRADE ( -- 평점
		bookGradeNo ASC -- 평점번호
	);

-- 평점
ALTER TABLE BOOKGRADE
	ADD
		CONSTRAINT PK_BOOKGRADE -- 평점 기본키
		PRIMARY KEY (
			bookGradeNo -- 평점번호
		);

-- 주문
drop table PAYMENT cascade constraints;
CREATE TABLE PAYMENT (
	payNo         number        NOT NULL, -- 결제 번호
	userid        varchar2(60)  NULL, -- 아이디
	email1        varchar2(100) not null,   --이메일
	email2        varchar2(100) not null,
	nonMember     number        null,     --비회원용 식별번호
	price         number        NOT NULL, -- 결제총금액
	usePoint      number        NULL,     -- 결제포인트
	payDate       date          default sysdate,     -- 결제일
	cancleDate    date          NULL,     -- 취소일
	instrument    varchar2(30)  NOT NULL, -- 결제수단
	zipcode       varchar2(20)  NOT NULL, -- 우편번호
	parselAddress varchar2(300) NOT NULL, -- 지번주소
	newAddress    varchar2(300) NOT NULL, -- 도로명주소
	addressDetail varchar2(300) NOT NULL, -- 상세주소
	progress      varchar2(60)  NOT NULL,  -- 진행상태
	customerName    varchar2(30) not NULL,
	message       varchar2(300),
	hp            varchar2(60)
);

drop sequence payment_seq;
create sequence payment_seq
increment by 1
start with 1
nocache;

-- 주문 기본키
CREATE UNIQUE INDEX PK_PAYMENT
	ON PAYMENT ( -- 주문
		payNo ASC -- 결제 번호
	);

-- 주문
ALTER TABLE PAYMENT
	ADD
		CONSTRAINT PK_PAYMENT -- 주문 기본키
		PRIMARY KEY (
			payNo -- 결제 번호
		);

-- 마일리지
drop table MILEAGE cascade constraints;
CREATE TABLE MILEAGE (
	mileageNo   number       NOT NULL, -- 마일리지번호
	userid      varchar2(60) NOT NULL, -- 아이디
	savingDate  date         default sysdate,     -- 적립일
	savingPoint number       NULL,     -- 적립포인트
	payNo       number       NULL,     -- 결제 번호
	usePoint    number       NULL,     -- 결제포인트
	endDate     date         NULL,  -- 만료일
	reason      varchar2(300) null
);

drop sequence mileage_seq;
create sequence mileage_seq
increment by 1
start with 1
nocache;

-- 마일리지 기본키
CREATE UNIQUE INDEX PK_MILEAGE
	ON MILEAGE ( -- 마일리지
		mileageNo ASC -- 마일리지번호
	);

-- 마일리지
ALTER TABLE MILEAGE
	ADD
		CONSTRAINT PK_MILEAGE -- 마일리지 기본키
		PRIMARY KEY (
			mileageNo -- 마일리지번호
		);

-- 추천도서
drop table RECOMMENDBOOK cascade constraints;
CREATE TABLE RECOMMENDBOOK (
	recomBookNo number        NOT NULL, -- 추천도서번호
	isbn        number        NOT NULL, -- 책번호
	cateCode    number        NULL,     -- 카테고리 번호
	bookName    varchar2(300) NOT NULL, -- 책이름
	price       number        NOT NULL, -- 가격
	publisher   varchar2(50)  NOT NULL, -- 출판사
	writer      varchar2(300)  NOT NULL, -- 저자
	managerid   varchar2(30)  NULL,  -- 관리자아이디
	cover       varchar2(4000) null
);

drop sequence recommendbook_seq;
create sequence recommendbook_seq
increment by 1
start with 1
nocache;

-- 추천도서 기본키
CREATE UNIQUE INDEX PK_RECOMMENDBOOK
	ON RECOMMENDBOOK ( -- 추천도서
		recomBookNo ASC -- 추천도서번호
	);

-- 추천도서
ALTER TABLE RECOMMENDBOOK
	ADD
		CONSTRAINT PK_RECOMMENDBOOK -- 추천도서 기본키
		PRIMARY KEY (
			recomBookNo -- 추천도서번호
		);

-- 주문 상세
drop table PAYMENTDETAIL cascade constraints;
CREATE TABLE PAYMENTDETAIL (
	payNo    number        NOT NULL, -- 결제 번호
	isbn     varchar2(90)  NOT NULL, -- 책번호
	bookName varchar2(300) NOT NULL, -- 책이름
	qty      number        NULL,     -- 수량
	price    number        NOT NULL  -- 권당가격
);

drop sequence paymentdetail_seq;
create sequence paymentdetail_seq
increment by 1
start with 1
nocache;

-- 카테고리
drop table BOOKCATEGORY cascade constraints;
CREATE TABLE BOOKCATEGORY (
	cateCode number       NOT NULL, -- 카테고리 번호
	cateName varchar2(100) NOT NULL, -- 카테고리명
	mall varchar2(60)   not null,
	orderNo number  not Null
);

drop sequence bookcategory_seq;
create sequence bookcategory_seq
increment by 1
start with 1
nocache;

-- 카테고리 기본키
CREATE UNIQUE INDEX PK_BOOKCATEGORY
	ON BOOKCATEGORY ( -- 카테고리
		cateCode ASC -- 카테고리 번호
	);

-- 카테고리
ALTER TABLE BOOKCATEGORY
	ADD
		CONSTRAINT PK_BOOKCATEGORY -- 카테고리 기본키
		PRIMARY KEY (
			cateCode -- 카테고리 번호
		);

-- 게시판
ALTER TABLE BOARD
	ADD
		CONSTRAINT FK_USER_TO_BOARD -- 멤버 -> 게시판
		FOREIGN KEY (
			userid -- 아이디
		)
		REFERENCES "USER" ( -- 멤버
			userid -- 아이디
		);

-- 댓글
ALTER TABLE REPLY
	ADD
		CONSTRAINT FK_BOARD_TO_REPLY -- 게시판 -> 댓글
		FOREIGN KEY (
			boardNo -- 게시글번호
		)
		REFERENCES BOARD ( -- 게시판
			boardNo -- 게시글번호
		);

-- 댓글
ALTER TABLE REPLY
	ADD
		CONSTRAINT FK_USER_TO_REPLY -- 멤버 -> 댓글
		FOREIGN KEY (
			userid -- 아이디
		)
		REFERENCES "USER" ( -- 멤버
			userid -- 아이디
		);

/*
-- 즐겨찾기
ALTER TABLE FAVORITE
	ADD
		CONSTRAINT FK_USER_TO_FAVORITE -- 멤버 -> 즐겨찾기
		FOREIGN KEY (
			userid -- 아이디
		)
		REFERENCES "USER" ( -- 멤버
			userid -- 아이디
		);
*/

-- 평점
ALTER TABLE BOOKGRADE
	ADD
		CONSTRAINT FK_USER_TO_BOOKGRADE -- 멤버 -> 평점
		FOREIGN KEY (
			userid -- 아이디
		)
		REFERENCES "USER" ( -- 멤버
			userid -- 아이디
		);

-- 평점
ALTER TABLE bookgrade
	ADD
		CONSTRAINT FK_BOARD_TO_BOOKGRADE -- 게시판 -> 평점 
		FOREIGN KEY (
			boardNo -- 게시글번호
		)
		REFERENCES BOARD ( -- 게시판
			boardNo -- 게시글번호
		);

/*
-- 주문
ALTER TABLE PAYMENT
	ADD
		CONSTRAINT FK_USER_TO_PAYMENT -- 멤버 -> 주문
		FOREIGN KEY (
			userid -- 아이디
		)
		REFERENCES "USER" ( -- 멤버
			userid -- 아이디
		);
*/

/*
-- 마일리지
ALTER TABLE MILEAGE
	ADD
		CONSTRAINT FK_USER_TO_MILEAGE -- 멤버 -> 마일리지
		FOREIGN KEY (
			userid -- 아이디
		)
		REFERENCES "USER" ( -- 멤버
			userid -- 아이디
		);
*/

/*
-- 마일리지
ALTER TABLE MILEAGE
	ADD
		CONSTRAINT FK_PAYMENT_TO_MILEAGE -- 주문 -> 마일리지
		FOREIGN KEY (
			payNo -- 결제 번호
		)
		REFERENCES PAYMENT ( -- 주문
			payNo -- 결제 번호
		);
*/

-- 추천도서
ALTER TABLE RECOMMENDBOOK
	ADD
		CONSTRAINT FK_BOOKCATE_TO_RECOMMENDBOOK -- 카테고리 -> 추천도서
		FOREIGN KEY (
			cateCode -- 카테고리 번호
		)
		REFERENCES BOOKCATEGORY ( -- 카테고리
			cateCode -- 카테고리 번호
		);

-- 주문 상세
ALTER TABLE PAYMENTDETAIL
	ADD
		CONSTRAINT FK_PAYMENT_TO_PAYMENTDETAIL -- 주문 -> 주문 상세
		FOREIGN KEY (
			payNo -- 결제 번호
		)
		REFERENCES PAYMENT ( -- 주문
			payNo -- 결제 번호
		);

