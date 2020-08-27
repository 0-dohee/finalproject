<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여행의 설렘 TOURSUM !</title>
<link rel="shortcut icon" type="image⁄x-icon" href="/resources/img/title_logo.png">
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/style.css" />
<style>
#login-area {
	position:relative;
	left:50%;
	transform:translate(-50%,0);
	width:503px;
	padding-top:40px;
	padding-bottom:60px;
}

#login-area .alert-danger {
	margin: auto;
	display: none;
	width: 500px;
}
#login-area ul.login-tab {
	list-style:none;
}
#login-area ul.login-tab li {
	color:black;
	display:inline-block;
	cursor:pointer;
	padding:15px 5px 15px 5px;
	text-align:center;
	margin-bottom:-2px;
}
#login-area ul.login-tab li.current {
	background:white;
	padding:15px 5px 15px 5px;
	border:0.5px solid black;
	border-bottom:0.5px solid white;
	z-index:9;
	margin-bottom:-2px;
	color:#0f4c81;
}
#login-area ul.login-tab li:nth-child(1) {
	position:relative;
	left:50%;
	width:252px;
	transform:translate(-99.6%,0);
}
#login-area ul.login-tab li:nth-child(2) {
	position:relative;
	left:50%;
	width:250px;
	transform:translate(-100.7%,0);
	margin-left:-5px;
}
#login-area .login-content {
	display:none;
	width:502px;
	overflow:hidden;
	border-top:0.5px solid black;
	padding-bottom:10px;
	position:relative;
	left:50%;
	transform:translate(-50%,0);
	padding-top:30px;
}
#login-area .login-content.current {
	display:inherit;
}
#login-area table {
	border-collapse:collapse;
	width:100%;
}
#login-area .login-line {
	height:60px;
}
#login-area .login-company {
	height:60px;
}
#login-area .login-company input {
	height:50px;
	width:30.95%;
	text-align:center;
	border-radius:3px 3px 3px 3px;
	outline:none;
	border:0.5px solid gray;
	cursor:pointer
}
#login-area .login-line input {
	width:100%;
	height:50px;
	padding-left:10px;
	border-radius:3px 3px 3px 3px;
	outline:none;
	border:0.5px solid gray;
	cursor:pointer;
}
#login-area #btnInsert,
#login-area #btnInsertCompany {
	width:100%;
	height:50px;
	padding-left:10px;
	border-radius:3px 3px 3px 3px;
	outline:none;
	border:0.5px solid gray;
	background:#0f4c81;
	color:white;
	cursor:pointer;
}
#div_find_a,
#div_find_b {
	width:100%;
	text-align:center;
	font-size:13px;
	padding-bottom:30px;
	border-bottom:0.5px solid gray;
}
#div_find_a a,
#div_find_b a {
	text-decoration:none;
	color:black;
}
#div_other_login {
	width:100%;
	padding-top:20px;
	padding-bottom:10px;
	position:relative;
}
#div_other_login a {
	display:inline-block;
	width:100%;
	height:50px;
	border-radius:3px 3px 3px 3px;
	text-decoration:none;
	color:black;
}
#div_other_login #kakao {
	background:#fddc3f;
	text-align:center;
	padding-top:13px;
}
#div_other_login #kakaoimg {
	position:absolute;
	top:30px;
	left:5px;
}
input[id="login-chk"] {
	display:none;
}
input[id="login-chk"] + label em {
	display:inline-block;
	width:24px;
	height:24px;
	margin-right:5px;
	background:url(/resources/img/user/check_before_icon.png) 0 0 no-repeat;
	vertical-align:middle;
	margin-bottom:3px;
	cursor:pointer;
}
input[id="login-chk"]:checked + label em {
	background:url(/resources/img/user/check_icon.png) 0 0 no-repeat;
}
input[id="login-chk2"] {
	display:none;
}
input[id="login-chk2"] + label em {
	display:inline-block;
	width:24px;
	height:24px;
	margin-right:5px;
	background:url(/resources/img/user/check_before_icon.png) 0 0 no-repeat;
	vertical-align:middle;
	cursor:pointer;
}
input[id="login-chk2"]:checked + label em {
	background:url(/resources/img/user/check_icon.png) 0 0 no-repeat;
}
#login-area .login-save {
	height:70px;
}
#login-area .login-save span {
	display:inline-block;
	padding-bottom:30px;
}
#login-area h1 {
	margin-bottom:30px;
	color:black;
}

#div_header_burgermenu{
	display:none;
}
</style>

</head>
<body>
	<jsp:include page="../sidebar.jsp" />
	<div id="page">
		<div id="header"><jsp:include page="../header.jsp" /></div>
		<div id="menu"><jsp:include page="../menu.jsp" /></div>
		<div id="container">
			<div id="login-area">
				<img src="/resources/img/user/login_title2.png" style="display:inline-black; position:relative; left:50%; transform:translate(-50%,0); margin-bottom:20px;"/>
				<ul class="login-tab">
					<li class="tab-link current" data-tab="Regular" id="tab-regular">
						<b>일반</b>
					</li>
					<li class="tab-link" data-tab="company" id="tab-company">
						<b>업체</b>
					</li>
				</ul>
				
				<!-- 유저로그인 -->
				<div id="Regular" class="login-content current">
					<form action="loginCheck" method="post" name="frm" id="user">
						<table id="tbl">
							<tr class="login-line">
								<td><input type="text" id="id" placeholder="ID" name="u_id"></td>
							</tr>
							<tr class="login-line">
								<td><input type="password" id="pass" placeholder="PASSWORD" name="u_pass"></td>
							</tr>
							<tr class="login-save">
								<td>
									<span>
										<input type="checkbox" name="chkLogin" id="login-chk">
										<label for="login-chk"><em></em>로그인 유지</label>
									</span>
								</td>
							</tr>
							<tr>
								<td><input type="submit" id="btnInsert" value="LOGIN"></td>
							</tr>
						</table>
						<div class="alert-danger">
							<span>
								<img src="/resources/img/user/alert_image.jpg" width=100% style="border:none;"/>
							</span>
						</div>
					</form>
				</div>
				
				<!-- 업체로그인 -->
				<div id="company" class="login-content">
					<form action="loginCheckCompany" method="post" name="frm1" id="company">
						<table id="tbl1">
							<tr>
								<td style="color:#757575;">사업자번호</td>
							</tr>
							<tr class="login-company">
								<td>
									<span><input type="text" id="number1" size=8 maxlength=3></span> - 
									<span><input type="text" id="number2" size=5 maxlength=2></span> - 
									<span><input type="text" id="number3" size=8 maxlength=5></span>
								</td>
							</tr>
							<tr class="login-line">
								<td><input type="text" id="id" placeholder="ID" name="c_id"></td>
							</tr>
							<tr class="login-line">
								<td><input type="password" id="pass" placeholder="PASSWORD" name="c_pass"></td>
							</tr>
							<tr class="login-save">
								<td>
									<span>
										<input type="checkbox" name="chkLogin" id="login-chk2">
										<label for="login-chk2"><em></em>로그인 유지</label>
									</span>
								</td>
							</tr>
							<tr>
								<td><input type="submit" id="btnInsertCompany" value="LOGIN"></td>
							</tr>
						</table>
						<div class="alert-danger">
							<span>
								<img src="/resources/img/user/alert_image.jpg" width=100% style="border:none;"/>
							</span>
						</div>
					</form>				
				</div>
				<div id="div_find_a">
					<a href="/user/find(id)">아이디 찾기</a> ﻿· 
					<a href="find(pass)">패스워드 찾기</a> ﻿· 
					<a href="/user/signupselect">회원 가입</a>
				</div>
				<div id="div_find_b">
					<a href="/user/findCompany(id)">아이디 찾기</a> ﻿· 
					<a href="/user/findCompany(pass)">패스워드 찾기</a> ﻿· 
					<a href="/user/signupselect">회원 가입</a>
				</div>
				<div id="div_other_login">
					<!-- <img src="/kakao_login_large_narrow.png" width="50"> -->
					<img src="/resources/img/user/kakao_icon.png" width=30 id="kakaoimg"/>
					<a id="kakao" href="https://kauth.kakao.com/oauth/authorize?client_id=44c4398b724d06191dbaf99c087795b1&redirect_uri=http://localhost:8088/oauth&response_type=code">
					카카오 로그인</a>
				</div>
			</div>
		</div>
		<div id="footer"><jsp:include page="../footer.jsp"/></div>
	</div>
</body>
<script>
	$("#div_find_b").hide();
	
	$("#tab-company").click(function(){
		$("#div_find_b").show();
		$("#div_find_a").hide();
	});
	
	$("#tab-regular").click(function(){
		$("#div_find_b").hide();
		$("#div_find_a").show();
	})
	
	var chkLogin = 0;

	$('ul.login-tab li').click(function() {
		var tab_id = $(this).attr('data-tab');

		$('ul.login-tab li').removeClass('current');
		$('.login-content').removeClass('current');

		$(this).addClass('current');
		$("#" + tab_id).addClass('current');
	})

	$(frm).submit(function(e) {
		e.preventDefault();
		$(".alert-danger").css("display", "none");
		var u_id = $(frm.id).val();
		var u_pass = $(frm.pass).val();
		var u_k_id="0";
		$.ajax({
			type:"get",
			url:"/user/mypage/read",
			data:{"u_id":u_id,"u_pass":u_pass,"u_k_id":u_k_id},
			success:function(data){
				if(data.readuser.u_status==1){
					alert("관리자에 의해 차단된 아이디입니다.");
				}else{
					if ($(frm.chkLogin).is(":checked"))
						chkLogin = 1;
					$.ajax({
						type : "post",
						url : "/user/loginCheck",
						data : {
							"u_id" : u_id,
							"u_pass" : u_pass,
							"chkLogin" : chkLogin
						},
						success : function(data) {
							if (data == 0) {
								alert("아이디가 존재하지 않습니다.");
							} else if (data == 1) {
								alert("아이디와 패스워드를 확인해주세요.");
							} else if (data == 2 || data == 4) {
									var dest="${dest}";
									if(data == 4){
										location.href = "/admin/index";
									}else{
										if(dest!=""){
											location.href = dest;
										}else{
											location.href="/";
										}
									}
							} else {
								$(".alert-danger").css("display", "block");
							}
						}
					});
				}
			}
		});
	});

	$(frm1).submit(function(e) {
		e.preventDefault();
		$(".alert-danger").css("display", "none");
		var c_id = $(frm1.id).val();
		var c_pass = $(frm1.pass).val();
		var c_num1 = $("#number1").val();
		var c_num2 = $("#number2").val();
		var c_num3 = $("#number3").val();
		var c_number = c_num1 + c_num2 + c_num3;

		if ($(frm1.chkLogin).is(":checked"))
			chkLogin = 1;
		$.ajax({
			type : "post",
			url : "/user/loginCheckCompany",
			data : {
				"c_id" : c_id,
				"c_pass" : c_pass,
				"c_number" : c_number,
				"chkLogin" : chkLogin
			},
			success : function(data) {
				if (data == 0) {
					alert("아이디가 존재하지 않습니다.");
				} else if (data == 1) {
					alert("아이디와 패스워드를 확인해주세요.");
				} else if (data == 2) {
					location.href = "/";
				} else if (data == 3) {
					$(".alert-danger").css("display", "block");
				} else if (data == 4) {
					alert("해당 아이디의 사업자번호가 존재하지 않습니다.");
				}
			}
		});
	});
</script>
</html>