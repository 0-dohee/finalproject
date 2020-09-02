<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여행의 설렘 TOURSUM !</title>
<!-- <script src="http://code.jquery.com/jquery-1.9.1.js"></script> -->
<link rel="shortcut icon" type="image⁄x-icon" href="/resources/img/title_logo.png">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/style.css"/>
<!-- <script src="http://code.jquery.com/jquery-3.1.1.min.js"></script> -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<style>
ul,li{list-style:none;}
.slide{height:400px;}
.slide ul{position:relative;height:100%;}
.slide li{position:absolute;left:0;right:0;top:0;bottom:0;opacity:0;animation:fade 16s infinite;}
.slide li:nth-child(1){background-image:url("/resources/img/stay/1.jpg");animation-delay:0s}
.slide li:nth-child(2){background-image:url("/resources/img/stay/2.jpg");animation-delay:4s}
.slide li:nth-child(3){background-image:url("/resources/img/stay/3.jpg");animation-delay:8s}
.slide li:nth-child(4){background-image:url("/resources/img/stay/4.jpg");animation-delay:12s}
 /* 100 / 8 = 12.5 */
@keyframes fade {
	0% {opacity:0;}
	5% {opacity:1;}
	25% {opacity:1;}
	30% {opacity:0;}
	100% {opacity:0;}
}
#stay_search {
	background:white;
	background-color: rgba( 255, 255, 255, 0.7 );
	height:100px;
	width:950px;
	position:absolute;
	top:250px;
	left:50%;
	transform:translate(-50%,0);
	margin-bottom:-300px;
}
#stay_search input[type="text"] {
	height:50px; 
	border-radius:5px; 
	border:0.5px solid #e9e9e9;
	padding-left:10px;
	cursor:pointer;
	line-height:50px;
	margin-top:25px;
}
/*인원선택*/
#reserver .aircount1 {
	position:absolute;
	top:85px;
	background:white;
	width:300px;
	height:350px;
	z-index:30;
	border-radius:3px 3px 3px 3px;
	transtion:all 1s;
	padding:10px;
	box-shadow:3px 3px 15px gray;
}
#reserver .aircount1 h5 {
	text-align:left;
	margin-top:5px;
	margin-bottom:10px;
	font-size:20px;
	color:gray;
}
#reserver .aircount1>.aircount_row {
	background:white;
	border-top:2px solid gray;
	border-bottom:2px solid black;
	padding-top:5px;
	padding-bottom:5px;
	height:280px;
	text-align:center;
}
#reserver .aircount1>.aircount_row>.row {
	margin:5px 0px 5px 0px;
	height:50px;
}
#reserver .aircount1>.aircount_row>.row:nth-child(1) {
	margin-bottom:5px;
	margin-top:10px;
}
#reserver .aircount1 .age {
	display:inline-block;
	width:120px;
}
#reserver .aircount1 .aircount_row input[type="button"] {
	width:40px;
	height:40px;
	border-radius:50%;
	border:1px solid #0f4c81;
	cursor:pointer;
	font-size:15px;
}
#reserver .aircount1 .aircount_row #btn {
	width:100%;
	border-radius:3px 3px 3px 3px;
	background:#0f4c81;
	color:white;
	float:right;
	margin-top:100px;
}
#reserver .aircount1 .aircount_row input[type="text"] {
	width:40px;
	height:40px;
	text-align:center;
	padding-left:0;
	background:none;
	outline:none;
	border:none;
}

#companylist {
	border-top:3px solid #0f4c81;
	border-bottom:3px solid #0f4c81;
	cursor:pointer;
}

table {
	border-collapse:collapse;
}

#companylist button {
	width:200px;
	height:40px;
	border:none;
	outline:none;
	border-radius:5px;
	cursor:pointer;
	margin-top:10px;
}

#pagination {
	margin-top:60px;
	margin-bottom:60px;	
	text-align:center;
}

#pagination a {
	display:inline-block;
	text-decoration:none;
	color:black;
	width:20px;
	margin-right:7px;
}

#pagination .active a {
	font-size:30px;
}
</style>
</head>
<body>
	<jsp:include page="../sidebar.jsp"/>
	<jsp:include page="../floatmenu.jsp"/>
	<button type="button" name="button" class="ac-sub-go-top"
      style="cursor: pointer;">위로</button>
	<div id="page">
		<div id="header"><jsp:include page="../header.jsp" /></div>
		<div id="menu"><jsp:include page="../menu.jsp" /></div>
		<div id="container">

			<!-- 1start ------------------------------------------------------------------------------->
			<div style="position: relative; margin-bottom: 10px;">
				<div class="slide">
					<ul>
						<li></li>
						<li></li>
						<li></li>
						<li></li>
					</ul>
				</div>
				<div id="stay_search">
					<div style="height: 177.33px; text-align: center;">
						<input type="text" placeholder=지역선택
							style="width: 100px;" id="areasearch">
						<input type="text" name="a_startdate" id="sdate" placeholder="체크인" style="width:150px">
						<input type="text" name="a_startdate1" id="edate" placeholder="체크아웃" style="width:150px">
						<!-- 인원선택 -->
						<div id="reserver" style="position: relative; display:inline-block;">
							<input type="text" class="a_emptyseat" placeholder="성인 1  청소년 0" style="width:300px;">
							<div class="aircount1">
								<h5>인원</h5>
								<div class="aircount_row">
									<div class="row" style="">
										<span class="age">성인</span> <input type="button" value="-"
											class="peopleSubtract"> <input type="text" value="1"
											size="1" class="people"> <input type="button"
											value="+" class="peoplePlus">
									</div>
									<div class="row">
										<span class="age">청소년/어린이</span> <input type="button"
											value="-" class="childSubtract"> <input type="text"
											value="0" readonly size="1" class="child"> <input
											type="button" value="+" class="childPlus">
									</div>
									<div>
										<input type="button" id="btn" value="선택완료">
									</div>
								</div>
							</div>
						</div>
						<input type="button" value="검색" id="btnsearch"
							style="width: 200px; height: 50px; border: 0.5px solid #e9e9e9; outline: none; border-radius: 5px; background: #0f4c81; color: white; cursor: pointer;">
					</div>
				</div>
			</div>
			<!-- 1end -------------------------------------------------------------------------------->
			<div style="text-align:right;"><span id="total">( ${pm.totalCount} 건 )</span></div>
			<table id="companylist">
				<c:forEach items="${list}" var="vo">
					<tr class="row" >
						<td class="c_id" style="display:none;">${vo.c_id}</td>
						<td rowspan=2 width=300 height=230 style="border-bottom:0.5px solid #e9e9e9;"><img src="/company/hoteldisplay?fileName=${vo.c_image}" id="image" width=280 height=203 style="margin-left:10px;"></td>
						<td style="padding-left:10px;width:900px; height:90px;">
							<span style="font-size:25px; font-weight:bold; font-family:'맑은 고딕'; color:#373737;">${vo.c_name }</span><br>
							<span style="font-size:13px; color:gray; ">${vo.c_address }</span>
						</td>
					</tr>
					<tr>
						<td style="text-align:right; padding-right:10px; padding-top:20px; border-bottom:0.5px solid #e9e9e9;">
							최저가 <span style="font-size:25px; font-weight:bold; color:#0f4c81;"><fmt:formatNumber value="${vo.r}" pattern="#,###"/> ~</span><br>
							<button class="btnSee">보러가기</button>
						</td>
					</tr>
				</c:forEach>
			</table>
			<div id="pagination">
				<c:if test="${pm.prev}">
					<a href="${pm.startPage-1}">◀</a>
				</c:if>
				<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
					<c:if test="${pm.cri.page == i}">
						<span class='active'><a href="${i}" >${i}</a></span>
					</c:if>
					<c:if test="${pm.cri.page != i}">
						<span><a href="${i}">${i}</a></span>
					</c:if>
				</c:forEach>
				<c:if test="${pm.next}">
					<a href="${pm.endPage+1}">▶</a>
				</c:if>
			</div>
		</div>
		<div id="footer"><jsp:include page="../footer.jsp" /></div>
	</div>
</body>
<script>
	var id = "${u_id}";
	var people = 1;
	var child = 0;
	
	$(window).scroll(function() {
		var quickHeight = $(document).scrollTop(); //스크롤 높이가 500 이상이면 나타나기
		if (500 <= quickHeight) {
			$('.ac-sub-go-top').css('display', 'block');
		} else {
			$('.ac-sub-go-top').css('display', 'none');
		}
	});

	$('.ac-sub-go-top').click(function() {//위로가기 버튼을 클릭했을때
		$('html, body').animate({
			scrollTop : '0'
		}, 800);
	});
	
	// 보러가기 버튼
	$("#companylist").on("click", ".btnSee", function(){
		var c_id = $(this).parent().parent().prev().find(".c_id").html();
		location.href = "/stay/read?c_id=" + c_id;
	});
	
	$(".aircount1").hide();
	//인원선택
	$(".a_emptyseat").on("click", function() {
		$(".aircount1").show();
		$("#btn").on("click", function() {
			$(".aircount1").hide();
			$(".a_emptyseat").val("성인 " + people + "  청소년 " + child);
		});
	});
	//성인-
	$("#reserver").on("click", ".peopleSubtract", function() {
		if (people == 0) {

		} else if (people > 1) {
			people = people - 1;
			$(".people").val(people);
		}

	});
	//성인+
	$("#reserver").on("click", ".row .peoplePlus", function() {
		people = people + 1;
		$(".people").val(people);
	});

	//청소년-
	$("#reserver").on("click", ".childSubtract", function() {
		if (child == 0) {

		} else if (child > 0) {
			child = child - 1;
			$(".child").val(child);
		}

	});
	//청소년+
	$("#reserver").on("click", ".row .childPlus", function() {
		child++;
		$(".child").val(child);
	});

	//숙소검색
	$("#stay_search").on("click", "#btnsearch", function() {
		var area = $("#areasearch").val();
		var edate = $("#edate").val();
		var sdate = $("#sdate").val();
		var sum = parseInt($(".people").val()) + parseInt($(".child").val());
		alert(area + edate + sdate + sum);
	});

	//날짜 받기
	$(document).ready(
			function() {
				$("#sdate,#edate")
						.datepicker(
								{
									changeMonth : true, //년을 바꿀수 있는 셀렉박스 
									changeYear : true, //년을 바꿀수 있는 셀렉박스 
									showMonthAfterYear : true,
									nextText : '다음 달',
									//dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
									dayNamesMin : [ '일', '월', '화', '수', '목',
											'금', '토' ],
									monthNamesShort : [ '1월', '2월', '3월', '4월',
											'5월', '6월', '7월', '8월', '9월',
											'10월', '11월', '12월' ],
									monthNames : [ '1월', '2월', '3월', '4월',
											'5월', '6월', '7월', '8월', '9월',
											'10월', '11월', '12월' ],
									dateFormat : "yy/mm/dd",
									minDate : 0
								});

				$('#sdate').datepicker("option", "maxDate", $("#edate").val());
				$('#sdate').datepicker(
						"option",
						"onClose",
						function(selectedDate) {
							$("#edate").datepicker("option", "minDate",
									selectedDate);
						});

				$('#edate').datepicker();
				$('#edate').datepicker("option", "minDate", $("#sdate").val());
				$('#edate').datepicker(
						"option",
						"onClose",
						function(selectedDate) {
							$("#sdate").datepicker("option", "maxDate",
									selectedDate);
						});
			});

	//페이징
	$("#pagination").on("click", "a", function(e) {
		e.preventDefault();
		page = $(this).attr("href");
		location.href = "/stay/search?page=" + page;
	});
	//호텔읽기 
	$("#companylist").on("click", ".row #image", function() {
		var c_id = $(this).parent().parent().find(".c_id").html();
		location.href = "/stay/read?c_id=" + c_id;
	});
</script>
</html>