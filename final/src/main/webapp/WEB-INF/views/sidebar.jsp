<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 	
<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<meta charset="UTF-8">
<style>
/* 마이페이지 span 설정 */
.menu-trigger, .menu-trigger span {
	display: inline-block;
	transition: all .4s;
	box-sizing: border-box;
}

.menu-trigger {
	position: absolute;
	right:370px;
	top:73px;
	width: 35px;
	height: 28px;
	z-index:9;
}

.menu-trigger span {
	position: absolute;
	left: 0;
	width: 100%;
	height: 2px;
	display:inline-block;
	background-color: black;
	border-radius: 10px;
}

.menu-trigger span:nth-of-type(1) {
	top: 0.5px;
}

.menu-trigger span:nth-of-type(2) {
	top: 50%;
	transform:translate(0,-50%);
}

.menu-trigger span:nth-of-type(3) {
	bottom: 0.6px;
}

/* 마이페이지 애니메이션 */
.menu-trigger.active span:nth-of-type(1) {
	-webkit-transform: translateY(13px) rotate(-45deg);
	transform: translateY(13px) rotate(-45deg);
}

.menu-trigger.active span:nth-of-type(2) {
	opacity: 0;
}

.menu-trigger.active span:nth-of-type(3) {
	-webkit-transform: translateY(-12px) rotate(45deg);
	transform: translateY(-12px) rotate(45deg);
}

/* 마이페이지 */
.sidebar-mypage {
	background-color: #222;
	width: 400px;
	height: 100%;
	position: fixed;
	top: 0;
	right: -400px;
	z-index: 9999;
}

.sidebar-mypage>.sidebar-mypage-content {
	color: #fff;
	width: 100%;
	height: 100%;
}

.sidebar-mypage h1 {
	text-align: left;
	margin-left: 15px;
	margin-top: 10px;
	margin-bottom:60px;
}

.sidebar-mypage .menu-trigger {
	position:absolute;
	left:50%;
}

#mypage_info,
#mypage_booking,
#mypage_like {
	background:#40403f;
	padding-left:45px;
	padding-top:15px;
	padding-bottom:15px;
	cursor:pointer;
}

#mypage_info:hover,
#mypage_booking:hover,
#mypage_like:hover {
	background:gray;
}

.sidebar-mypage a {
	color:white;
	text-decoration:none;
	font-size:17px;
}


/* 카트 디자인 */
.sidebar-btn {
	color: #fff;
	outline: none;
	cursor:pointer;
	position:absolute; 
	top:66px;
	right:426px;
	z-index:9;
	border:none;
	background:none;
}

.sidebar-btn img {
	cursor:pointer;
}

.sidebar {
	background-color: #222;
	width: 400px;
	height: 100%;
	position: fixed;
	top: 0;
	right: -400px;
	z-index: 9999;
}

.sidebar>.sidebar-content {
	color: #fff;
	width: 100%;
	height: 100%;
}

.sidebar h1 {
	text-align: left;
	margin-left: 15px;
	margin-top: 10px;
}
</style>
</head>
<body>
<!-- 	카트 -->
	<button class="sidebar-btn">
		<img src="/resources/img/cart.png" width=45>
	</button>
	<aside class="sidebar">
		<div class="sidebar-content">
			<h1>CART</h1>
		</div>
		
	</aside>
	
<!-- 	마이페이지 -->
	<a class="menu-trigger" href="#">
		<span> </span>
		<span> </span>
		<span> </span>
	</a>
	<aside class="sidebar-mypage">
		<div class="sidebar-mypage-content">
			<h1>MYPAGE</h1>
			<c:if test="${c_id==null}">
				<div id="mypage_info"><a href="/user/mypage/infomation">내 정보</a></div>
				<div id="mypage_booking"><a href="/air/bookinglist">예약내역</a></div>
				<div id="mypage_like"><a href="/hotplace/likelist">찜목록</a></div>
			</c:if>
			<c:if test="${ c_id!=null }">
				<div id="mypage_info"><a href="/user/mypage/infomation">내 정보</a></div>
				<div id="mypage_booking"><a href="/company/roominsert">숙소등록</a></div>
				<div id="mypage_like"><a href="">모름</a></div>
			</c:if>
		</div>
	</aside>
</body>
<script>
	// mypage
	$(function(){
		var duration = 300;
		var $sidebar1 = $('.sidebar-mypage');
		var $sidebar = $('.sidebar');
		var $sidebarButton = $('.menu-trigger').on('click', function() {
			$sidebar1.toggleClass('open');
			if ($sidebar1.hasClass('open')) {
				$(".menu-trigger").addClass("active");
				$sidebar1.stop(true).animate({
					right : '-70px'
				}, duration, 'easeOutBack');
				$sidebar.stop(true).animate({
					right : '-400px'
				}, duration, 'easeInBack');
			} else {
				$sidebar1.stop(true).animate({
					right : '-400px'
				}, duration, 'easeInBack');
				$(".menu-trigger").removeClass("active");
			}
		});
		
		var $sidebarButton = $('.sidebar-btn').on('click', function() {
			$sidebar.toggleClass('open');
			if ($sidebar.hasClass('open')) {
				$sidebar.stop(true).animate({
					right : '-70px'
				}, duration, 'easeOutBack');
				$sidebar1.stop(true).animate({
					right : '-400px'
				}, duration, 'easeInBack');
				$(".menu-trigger").removeClass("active");
			} else {
				$sidebar.stop(true).animate({
					right : '-400px'
				}, duration, 'easeInBack');
			}
		});
	})
</script>
</html>