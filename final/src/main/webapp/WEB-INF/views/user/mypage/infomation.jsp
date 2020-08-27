<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여행의 설렘 TOURSUM !</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/style.css" />
<style>
#user-information-area {
	padding:40px;
	position:relative;
	margin-bottom:30px;
}
#user-information-area #info,
#user-information-area #companyInfo {
	position:relative;
	left:50%;
	transform:translate(-50%,0);
	margin-top:20px;
}
#user-information-area .line-info {
	height:60px;
}
#user-information-area .line-info td:nth-child(1),
#user-information-area .line-address td:nth-child(1) {
	text-align:left;
	padding-left:7px;
}
#user-information-area .line-info td:nth-child(2),
#user-information-area .line-address td:nth-child(2) {
	padding-left:10px;
	padding-right:10px;
}
#info span,
#companyInfo span {
	background: #0f4c81;
	color:white;
	height:40px;
	width:155.78px;
	display:inline-block;
	padding-top:11px;
	padding-left:10px;
	border-radius:3px 3px 3px 3px;
	font-size:13px;
}
#user-information-area [type="text"],
#user-information-area [type="password"],
#user-information-area [type="submit"] {
	height:40px;
	padding-left:10px;
	border-radius:3px 3px 3px 3px;
	border:0.5px solid #e9e9e9;
	cursor:pointer;
}
#user-information-area .line-info.a input {
	width:100%;
}
#user-information-area select {
	border-radius:3px 3px 3px 3px;
	border:0.5px solid #e9e9e9;
	cursor:pointer;
	padding-left:10px;
}
#tag img{
	width:180px;
	height:190px;
	cursor:pointer;
	margin-bottom:20px;
	border-radius:8px 8px 8px 8px;
	margin-left:10px;
	margin-right:10px;
}
#hoption img {
	width:198px;
	margin-bottom:25px;
	margin-left:5px;
	cursor:pointer;
}
#companyInfo textarea {
	width:100%;
	height:80px;
	padding:10px;
	border-radius:3px 3px 3px 3px;
	border:0.5px solid #e9e9e9;
	cursor:pointer;
}
</style>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
</head>
<body>
	<jsp:include page="../../floatmenu.jsp"/>
	<jsp:include page="../../sidebar.jsp"/>
	<div id="page">
		<div id="header"><jsp:include page="../../header.jsp" /></div>
		<div id="menu"><jsp:include page="../../menu.jsp" /></div>
		<div id="container">
			<div id="user-information-area">
				<div style="text-align:center;"><img src="/resources/img/user/info_title.png" width=350/></div>
				<c:if test="${u_id!=null}">
					<form action="updateUser" name="frm" method="post" enctype="multipart/form-data">
						<table id="info" style="border-collapse:collapse;">
							<tr>
								<td colspan=3 style="text-align:center;">
									<input type="file" name="file" style="visibility: hidden;"><br>
									<img src="http://placehold.it/250x250" id="image" width=200 height=200 style="cursor:pointer; border-radius:50%; margin-bottom:40px;"> 
								</td>
							</tr>
							<tr class="line-info a">
								<td width=170><span>이름</span></td>
								<td width=500><input type="text" id="u_name" value="" readonly></td>
								<td width=170><input type="hidden" id=allAddress name="u_address"></td>
							</tr>
							<tr class="line-info a">
								<td><span>ID</span></td>
								<c:if test="${u_id=='0' }">
									<td>
										<input type="text" id="u_k_id"  value="${u_k_id}" readonly>
									</td>
									<td>
										<input type="hidden" name="u_k_id" value="${u_k_id}">
									</td>
									<td>
										<input type="hidden" name="u_id" value="${u_id}">
									</td>
								</c:if>
								<c:if test="${u_k_id=='0' }">
									<td>
										<input type="text" id="u_id"  value="${u_id}" readonly>
									</td>
									<td>
										<input type="hidden" name="u_id" value="${u_id}">
									</td>
									<td>
										<input type="hidden" name="u_k_id" value="${u_k_id}">
									</td>
								</c:if>
							</tr>
							<tr class="line-info a">
								<td><span>생년월일</span></td>
								<td><input type="text" id="u_birthday" readonly></td>
							</tr>
							<tr class="line-address">
								<td width=150><span style="height:130px; padding-top:56px;">주소</span></td>
								<td style="height:150px;">
									<input type="text" id="sample6_postcode" placeholder="우편번호" style="width:32.5%">
									<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" style="width:32.5%; height:40px; border:none; outline:none; border-radius:3px 3px 3px 3px; cursor:pointer"><br>
									<input type="text" id="sample6_address" placeholder="주소" style="margin-top:5px; width:100%;"><br> 
									<input type="text" id="sample6_detailAddress" style="margin-top:5px; width:100%;"><br>
									<input type="hidden" id="sample6_extraAddress">
								</td>
								<td></td>
							</tr>
							<tr class="line-info">
								<td width=150><span>TEL</span></td>
								<td>
									<select id="selectTel1" style="height:40px; width:30.8%;">
										<option>010</option>
										<option>011</option>
										<option>016</option>
										<option>017</option>
										<option>018</option>
										<option>019</option>
									</select> -
									<input type="text" id="telFirst1" style="height:40px; width:30.8%;"> -
									<input type="text" id="telSecond1" style="height:40px; width:30.8%;">
									<input type="hidden" id="telAll" name="u_tel">
								</td>
								<td></td>
							</tr>
							<tr class="line-info">
								<td><span>이메일</span></td>
								<td>
									<input type="text" id="emailT1" style="width:47%;"> @ 
									<input type="text" id="txtEmailType1" style="width:47%;">
									<input type="hidden" id="emailAll1" name="u_email">
								</td>
								<td style="text-align:center;">
									<select id="email1" style="width:155.78px; height:40px;">
										<option id="direct" value="direct">직접입력</option>
										<option id="gmail" value="gmail.com">@gmail.com</option>
										<option id="naver" value="naver.com">@naver.com</option>
										<option id="daum" value="daum.net">@daum.net</option>
										<option id="nate" value="nate.com">@nate.com</option>
									</select> 
								</td>
							</tr>
							<tr class="line-info a">
								<td><span>현재 비밀번호</span></td>
								<td><input type="password" id="nowPass"></td>
								<td></td>
							</tr>
							<tr class="line-info a">
								<td><span>새 비밀번호</span></td>
								<td><input type="password" id="newPass"></td>
								<td></td>
							</tr>
							<tr class="line-info a">
								<td><span>새 비밀번호 확인</span></td>
								<td><input type="password" id="newPassCheck" name="u_pass"></td>
								<td></td>
							</tr>
						</table>
						<div style="text-align:center; background:#efefef; padding:10px 0px 10px 0px; border-radius:3px 3px 3px 3px; margin:25px 0px 30px 147px; font-size:14.5px; width:830px;">내가 선호하는 여행 스타일</div>
						<div id="tag" style="width:830px; margin-left:147px; text-align:center;">
							<span id="tag11">
								<input type="checkbox" id="t_tag1" name="t_tag" value="01">
									<label for="t_tag1" id="tag1"><img src="/resources/img/usertag/가족과함께.png"></label>
									<label for="t_tag1" id="tag1-1" style="display:none;"><img src="/resources/img/usertag/가족과함께t.png"></label>
							</span>
							<span id="tag1">
								<input type="checkbox" id="t_tag2" name="t_tag" value="02">
									<label for="t_tag2" id="tag1"><img src="/resources/img/usertag/교육.png"></label>
									<label for="t_tag2" id="tag1-1" style="display:none;"><img src="/resources/img/usertag/교육t.png"></label>
							</span>
							<span id="tag1">
								<input type="checkbox" id="t_tag3" name="t_tag" value="03">
									<label for="t_tag3" id="tag1"><img src="/resources/img/usertag/나만아는.png"></label>
									<label for="t_tag3" id="tag1-1" style="display:none;"><img src="/resources/img/usertag/나만아는t.png"></label>
							</span>
							<span id="tag1">
								<input type="checkbox" id="t_tag4" name="t_tag" value="04">
									<label for="t_tag4" id="tag1"><img src="/resources/img/usertag/나혼자여행.png"></label>
									<label for="t_tag4" id="tag1-1" style="display:none;"><img src="/resources/img/usertag/나혼자여행t.png"></label>
							</span>
							<span id="tag1">
								<input type="checkbox" id="t_tag5" name="t_tag" value="05">
									<label for="t_tag5" id="tag1"><img src="/resources/img/usertag/도심속여행.png"></label>
									<label for="t_tag5" id="tag1-1" style="display:none;"><img src="/resources/img/usertag/도심속여행t.png"></label>
							</span>
							<span id="tag1">
								<input type="checkbox" id="t_tag6" name="t_tag" value="06">
									<label for="t_tag6" id="tag1"><img src="/resources/img/usertag/먹방.png"></label>
									<label for="t_tag6" id="tag1-1" style="display:none;"><img src="/resources/img/usertag/먹방t.png"></label>
							</span>
							<span id="tag1">
								<input type="checkbox" id="t_tag7" name="t_tag" value="07">
									<label for="t_tag7" id="tag1"><img src="/resources/img/usertag/야경.png"></label>
									<label for="t_tag7" id="tag1-1" style="display:none;"><img src="/resources/img/usertag/야경t.png"></label>
							</span>
							<span id="tag1">
								<input type="checkbox" id="t_tag8" name="t_tag" value="08">
									<label for="t_tag8" id="tag1"><img src="/resources/img/usertag/연인과함께.png"></label>
									<label for="t_tag8" id="tag1-1" style="display:none;"><img src="/resources/img/usertag/연인과함께t.png"></label>
							</span>
							<span id="tag1">
								<input type="checkbox" id="t_tag9" name="t_tag" value="10">
									<label for="t_tag9" id="tag1"><img src="/resources/img/usertag/익사이팅.png"></label>
									<label for="t_tag9" id="tag1-1" style="display:none;"><img src="/resources/img/usertag/익사이팅t.png"></label>
							</span>
							<span id="tag1">
								<input type="checkbox" id="t_tag10" name="t_tag" value="11">
									<label for="t_tag10" id="tag1"><img src="/resources/img/usertag/친구와함께.png"></label>
									<label for="t_tag10" id="tag1-1" style="display:none;"><img src="/resources/img/usertag/친구와함께t.png"></label>
							</span>
							<span id="tag1">
								<input type="checkbox" id="t_tag11" name="t_tag" value="12">
									<label for="t_tag11" id="tag1"><img src="/resources/img/usertag/헬스케어.png"></label>
									<label for="t_tag11" id="tag1-1" style="display:none;"><img src="/resources/img/usertag/헬스케어t.png"></label>
							</span>
							<span id="tag12">
								<input type="checkbox" id="t_tag12" name="t_tag" value="13">
									<label for="t_tag12" id="tag1"><img src="/resources/img/usertag/힐링.png"></label>
									<label for="t_tag12" id="tag1-1" style="display:none;"><img src="/resources/img/usertag/힐링t.png"></label>
							</span>
						</div>
					<input type="submit" value="수정하기" style="width:200px; height:40px; margin-top:30px; position:relative; left:50%; transform:translate(-50%,0); background:#0f4c81; color:white;">
					</form>

				</c:if>
				<c:if test="${c_id!=null}">
					<form action="updateCompany" name="frm" method="post"
						enctype="multipart/form-data">
						<table id="companyInfo" style="border-collapse:collapse;">
							<tr>
								<td colspan=3 style="text-align:center;">
									<input type="file" name="file1" style="visibility: hidden;"><br>
									<img src="http://placehold.it/250x250" id="image1" width=200 height=200 style="cursor:pointer; border-radius:50%; margin-bottom:40px;">
								</td>
							</tr>
							<tr class="line-info a">
								<td width=170><span>이름</span></td>
								<td width=500><input type="text" id="c_name" readonly></td>
								<td width=170></td>
							</tr>
							<tr class="line-info a">
								<td><span>ID</span></td>
								<td><input type="text" id="c_id" value="${c_id}" readonly></td>
								<td><input type="hidden" name="c_id" value="${c_id}"></td>
							</tr>
							<tr class="line-address">
								<td width=150><span style="height:85px; padding-top:38px;">주소</span></td>
								<td style="height:95px;">
									<span id="address" style="width:100%; background:none; color:black; border:0.5px solid #e9e9e9; margin-top:5px;"></span><br> 
									<span id="addressDetail" style="width:100%; background:none; color:black; border:0.5px solid #e9e9e9; margin-top:5px;">상세 주소</span>
								</td>
								
							</tr>
							<tr class="line-info">
								<td width=150><span>TEL</span></td>
								<td>
									<select id="selectTel2" style="height:40px; width:30.8%;">
										<option>02</option>
										<option>031</option>
										<option>032</option>
										<option>033</option>
										<option>041</option>
										<option>042</option>
										<option>043</option>
										<option>044</option>
										<option>051</option>
										<option>052</option>
										<option>053</option>
										<option>054</option>
										<option>055</option>
										<option>061</option>
										<option>062</option>
										<option>063</option>
										<option>064</option>
									</select> -
									<input type="text" id="telFirst2" style="height:40px; width:30.8%;"> -
									<input type="text" id="telSecond2" style="height:40px; width:30.8%;">
									<input type="hidden" id="telAll2" name="c_tel">
								</td>
								<td></td>
							</tr>
							<tr class="line-info">
								<td><span>이메일</span></td>
								<td>
									<input type="text" id="emailT2" style="width:47%;"> @ 
									<input type="text" id="txtEmailType2" style="width:47%;"> 
									<input type="hidden" id="emailAll2" name="c_email">
								</td>
								<td style="text-align:center;">
									<select id="email2" style="width:155.78px; height:40px;">
										<option id="direct" value="direct">직접입력</option>
										<option id="gmail" value="gmail.com">@gmail.com</option>
										<option id="naver" value="naver.com">@naver.com</option>
										<option id="daum" value="daum.net">@daum.net</option>
										<option id="nate" value="nate.com">@nate.com</option>
									</select> 
								</td>
							</tr>
							<tr class="line-info">
								<td width=170><span>대표 성명</span></td>
								<td width=500><input type="text" id="c_ceo" name="c_ceo"></td>
								<td width=170></td>
							</tr>
							<tr class="line-info">
								<td width=150><span>대표 전화번호</span></td>
								<td>
									<select id="selectTel3" style="height:40px; width:30.8%;">
										<option>010</option>
										<option>011</option>
										<option>016</option>
										<option>017</option>
										<option>018</option>
										<option>019</option>
									</select> -
									<input type="text" id="telFirst3" style="height:40px; width:30.8%;"> -
									<input type="text" id="telSecond3" style="height:40px; width:30.8%;">
									<input type="hidden" id="c_telAll" name="c_ceo_tel">
								</td>
								<td></td>
							</tr>
							<tr class="line-info">
								<td style="height:100px;"><span style="height:80px; padding-top:30px;">세부정보</span></td>
								<td><textarea id="detail" name="c_detail"></textarea></td>
								<td><input type="hidden" name="c_status" value=0></td>
							</tr>
							<tr class="line-info">
								<td><span>지역</span></td>
								<td>
									<select id="area" name="c_area" style="height:40px; width:30.8%;">
										<option>인천</option>
										<option>속초</option>
										<option>충주</option>
										<option>전주</option>
										<option>부산</option>
										<option>여수</option>
										<option>제주</option>
									</select>
								</td>
								<td></td>
							</tr>
							<tr class="line-info a">
								<td><span>현재 비밀번호</span></td>
								<td><input type="password" size=30 id="nowpass"></td>
								<td></td>
							</tr>
							<tr class="line-info a">
								<td><span>새 비밀번호</span></td>
								<td><input type="password" id="newpass"></td>
								<td></td>
							</tr>
							<tr class="line-info a">
								<td><span>새 비밀번호 확인</span></td>
								<td><input type="password" id="newpassCheck" name="c_pass"></td>
							</tr>
						</table>
						<div style="text-align:center; background:#efefef; padding:10px 0px 10px 0px; border-radius:3px 3px 3px 3px; margin:25px 0px 30px 147px; font-size:14.5px; width:830px;">호텔 옵션</div>
							<div id="hoption" style="width:830px; margin-left:147px; text-align:center;">
								<span id="hoption1">
									<input type="checkbox" id="h_option1" name="hoption" value="01">
										<label for="h_option1" id="option1"><img src="/resources/img/hoteloption/Hoption_parking_icon2.png"></label>
										<label for="h_option1" id="option1-1" style="display:none;"><img src="/resources/img/hoteloption/Hoption_parking_icon_hover.png"></label>
								</span>
								<span id="hoption2">
									<input type="checkbox" id="h_option2" name="hoption" value="02">
										<label for="h_option2" id="option1"><img src="/resources/img/hoteloption/Hoption_food_icon2.png"></label>
										<label for="h_option2" id="option1-1" style="display:none;"><img src="/resources/img/hoteloption/Hoption_food_icon_hover.png"></label>
								</span>
								<span id="hoption3">
									<input type="checkbox" id="h_option3" name="hoption" value="03">
										<label for="h_option3" id="option1"><img src="/resources/img/hoteloption/Hoption_valet_icon2.png"></label>
										<label for="h_option3" id="option1-1" style="display:none;"><img src="/resources/img/hoteloption/Hoption_valet_icon_hover.png"></label>
								</span>
								<span id="hoption4">
									<input type="checkbox" id="h_option4" name="hoption" value="04">
										<label for="h_option4" id="option1"><img src="/resources/img/hoteloption/Hoption_wifi_icon2.png"></label>
										<label for="h_option4" id="option1-1" style="display:none;"><img src="/resources/img/hoteloption/Hoption_wifi_icon_hover.png"></label>
								</span>
								<span id="hoption5">
									<input type="checkbox" id="h_option5" name="hoption" value="05">
										<label for="h_option5" id="option1"><img src="/resources/img/hoteloption/Hoption_luggage_icon2.png"></label>
										<label for="h_option5" id="option1-1" style="display:none;"><img src="/resources/img/hoteloption/Hoption_luggage_icon_hover.png"></label>
								</span>
								<span id="hoption6">
									<input type="checkbox" id="h_option6" name="hoption" value="06">
										<label for="h_option6" id="option1"><img src="/resources/img/hoteloption/Hoption_smoking_option2.png"></label>
										<label for="h_option6" id="option1-1" style="display:none;"><img src="/resources/img/hoteloption/Hoption_smoking_option_hover.png"></label>
								</span>
								<span id="hoption7">
									<input type="checkbox" id="h_option7" name="hoption" value="07">
										<label for="h_option7" id="option1"><img src="/resources/img/hoteloption/hoption_Fitness_icon3.png"></label>
										<label for="h_option7" id="option1-1" style="display:none;"><img src="/resources/img/hoteloption/hoption_Fitness_icon_hover.png"></label>
								</span>
								<span id="hoption8">
									<input type="checkbox" id="h_option8" name="hoption" value="08">
										<label for="h_option8" id="option1"><img src="/resources/img/hoteloption/Hoption_front_icon2.png"></label>
										<label for="h_option8" id="option1-1" style="display:none;"><img src="/resources/img/hoteloption/Hoption_front_icon_hover.png"></label>
								</span>
								<span id="hoption9">
									<input type="checkbox" id="h_option9" name="hoption" value="09">
										<label for="h_option9" id="option1"><img src="/resources/img/hoteloption/Hoption_handicapped_icon2.png"></label>
										<label for="h_option9" id="option1-1" style="display:none;"><img src="/resources/img/hoteloption/Hoption_handicapped_icon_hover.png"></label>
								</span>
								<span id="hoption10">
									<input type="checkbox" id="h_option10" name="hoption" value="10">
										<label for="h_option10" id="option1"><img src="/resources/img/hoteloption/Hoption_swimming_icon.png"></label>
										<label for="h_option10" id="option1-1" style="display:none;"><img src="/resources/img/hoteloption/Hoption_swimming_icon_hover.png"></label>
								</span>
								<span id="hoption11">
									<input type="checkbox" id="h_option11" name="hoption" value="11">
										<label for="h_option11" id="option1"><img src="/resources/img/hoteloption/Hoption_restaurant_icon2.png"></label>
										<label for="h_option11" id="option1-1" style="display:none;"><img src="/resources/img/hoteloption/Hoption_restaurant_icon_hover.png"></label>
								</span>
								<span id="hoption12">
									<input type="checkbox" id="h_option12" name="hoption" value="12">
										<label for="h_option12" id="option1"><img src="/resources/img/hoteloption/Hoption_Washing_icon2.png"></label>
										<label for="h_option12" id="option1-1" style="display:none;"><img src="/resources/img/hoteloption/Hoption_Washing_icon_hover.png"></label>
								</span>
							</div>
						<input type="submit" value="수정" style="width:200px; height:40px; margin-top:30px; position:relative; left:50%; transform:translate(-50%,0); background:#0f4c81; color:white;">
					</form>
				</c:if>
				<a href="/user/mypage/usercancel" style="font-size:5px; text-decoration:none; color:black; position:absolute; bottom:-29px; right:0px;">회원 탈퇴</a>
			</div>
		</div>
		<div id="footer"><jsp:include page="../../footer.jsp" /></div>
	</div>
</body>
<script>
	$(":checkbox").css("display","none");
	var u_id = "${u_id}";
	var u_k_id = "${u_k_id}";
	var c_id = "${c_id}";
	var u_name = "${u_name}";
	//유저태그
	$("input[name=t_tag]").on("click",function(){
		
		$(this).length	
		var count=$("input:checked[type='checkbox']").length;	
		if(count<3){
			var tag1=$(this).parent().find("#tag1");
			var tag2=$(this).parent().find("#tag1-1");
			
			if($(this).is(":checked")==true){
				tag1.css("display","none");
				tag2.css("display","inline-block");
			}else{
				tag1.css("display","inline-block");
				tag2.css("display","none");
			}
		}else{
			$(this).prop("checked",false);
			alert("2개까지만 선택할 수 있습니다.");
		}
	});
	//호텔옵션
	$("input[name=hoption]").on("click",function(){
		var option1=$(this).parent().find("#option1");
		var option2=$(this).parent().find("#option1-1");
		
		if($(this).is(":checked")==true){
			option1.css("display","none");
			option2.css("display","inline-block");
		}else{
			option1.css("display","inline-block");
			option2.css("display","none");
		}
	});
	
	$("#email").change(function() {
		var email = $("#email option:selected").val();
		if (email != "direct") {
			$("#txtEmailType1").attr("readonly", true);

		}
	});
	$("#email2").change(function() {
		var email = $("#email2 option:selected").val();
		if (email != "direct") {
			$("#txtEmailType2").attr("readonly", true);

		}
	});
	//업체 회원 정보 수정
	$(frm).submit(function(e) {
		e.preventDefault();
		//전화번호 합치기
		var tel1=$("#selectTel2 option:selected").val();
		var tel2=$("#telFirst2").val();
		var tel3=$("#telSecond2").val();
		$("#telAll2").val(tel1+"-"+tel2+"-"+tel3);
		//패스워드 합치기
		var now_pass=$("#nowpass").val();
		var new_pass=$("#newpass").val();
		var new_passCheck=$("#newpassCheck").val();
		//대표 번호 합치기
		var ctel1=$("#selectTel3 option:selected").val();
		var ctel2=$("#telFirst3").val();
		var ctel3=$("#telSecond3").val();
		$("#c_telAll").val(ctel1+"-"+ctel2+"-"+ctel3);
		//이메일 합치기
		var txtEmail = $("#emailT2").val();
		var txtEmailType = $("#txtEmailType2").val();
		var emailAll = txtEmail + "@" + txtEmailType;
		$("#emailAll2").val(emailAll);
		
		 $.ajax({
			type:"get",
			url:"/user/mypage/readCompany",
			data:{"c_id":c_id},
			success:function(data){
					if($("#telFirst").val()=="" || $("#telSecond").val()==""){
						alert("대표 전화번호를 입력하세요");
					}else{
					if(data.read.c_pass!=now_pass){
						alert("현재비밀번호를 확인하세요.");
					}else{
						var new_pass=$("#newpass").val();
						var new_passCheck=$("#newpassCheck").val();
						if(new_pass!=new_passCheck){
							alert("비밀번호와 비밀번호 확인 값이 다릅니다.")
						}else{
							if(!confirm("수정하시겠습니까?")) return;
							//이메일 합치기
							var txtEmail=$("#emailT2").val();
							var txtEmailType=$("#txtEmailType2").val();
							var emailAll=txtEmail+"@"+txtEmailType;
							$("#emailAll2").val(emailAll);
							frm.submit();
						}
					}
				}
			}

		});
	});

	//업체 정보 읽어오기
	$.ajax({
		type:"get",
		url:"/user/mypage/readCompany",
		data:{"c_id":c_id},
		success:function(data){
			$("#c_name").val(data.read.c_name);
			$("#c_ceo").val(data.read.c_ceo);
			$("#detail").val(data.read.c_detail);
			$("#area").val(data.read.c_area);
			//주소 split
			var beforeAdd = data.read.c_address;
			var afterAdd = beforeAdd.split(',');
			$("#address").html(afterAdd[0]);
			$("#addressDetail").html(afterAdd[1]);
			//이메일 split
			var beforeEmail = data.read.c_email;
			var afterEmail = beforeEmail.split('@');
			$("#emailT2").val(afterEmail[0]);
			$("#txtEmailType2").val(afterEmail[1]);
			//전화번호
			var beforeTel=data.read.c_tel;
			var afterTel = beforeTel.split('-');
			$("#selectTel2").val(afterTel[0]);
			$("#telFirst2").val(afterTel[1]);
			$("#telSecond2").val(afterTel[2]);
			//전화번호
			var beforeTel1=data.read.c_ceo_tel;
			var afterTel1 =beforeTel1.split('-');
			$("#selectTel3").val(afterTel1[0]);
			$("#telFirst3").val(afterTel1[1]);
			$("#telSecond3").val(afterTel1[2]);
			//이미지 read
			if(data.read.c_image!=null){
				$("#image1").attr("src","/displayCompany?fileName="+data.read.c_image);
			}else{
				$("#image1").attr("src","/resources/img/user/profileC.png");
			}
			
			//호텔 태그 읽기	
			var option=[];
			    $.each(data.readOption, function(index,readOption){
				  	option.push(readOption.c_o_option);
			   });
			    
			    $("input[name=hoption]").each(function(index, item){
			    	 for(var i=0; i<option.length; i++){
			    		if($(this).val()==Number(option[i])){
			    			var option1=$(this).parent().find("#option1");
			    			var option2=$(this).parent().find("#option1-1");
			    			
			    			option1.css("display","none");
			    			option2.css("display","inline-block");
				    		$(this).attr("checked",true);
			    		}
			    	 }
			    });
			}
		});

	//회원 정보 수정
	$(frm).submit(function(e) {
		e.preventDefault();
		var now_pass = $("#nowPass").val();
		//전화번호 합치기
		var tel1=$("#selectTel1 option:selected").val();
		var tel2=$("#telFirst1").val();
		var tel3=$("#telSecond1").val();
		$("#telAll").val(tel1+"-"+tel2+"-"+tel3);
		//현재 비밀번호 확인
		$.ajax({
			type : "get",
			url : "/user/mypage/read",
			data : {
				"u_id" : u_id,
				"u_k_id": u_k_id
			},
			success : function(data) {
				if (data.read.u_pass != now_pass) {
					alert("현재비밀번호를 확인하세요.");
				} else {
					var new_pass = $("#newPass").val();
					var new_passCheck = $("#newPassCheck").val();
					if (new_pass != new_passCheck) {
						alert("비밀번호와 비밀번호 확인 값이 다릅니다.")
					} else {
						if (!confirm("수정하시겠습니까?"))
							return;
						//주소 합치기
						var address = $("#sample6_address").val();
						var addressDetail = $("#sample6_detailAddress").val();
						var allAddress = address + "," + addressDetail;
						//이메일 합치기
						var txtEmail = $("#emailT1").val();
						var txtEmailType = $("#txtEmailType1").val();
						var emailAll = txtEmail + "@" + txtEmailType;
						$("#emailAll1").val(emailAll);
						$("#allAddress").val(allAddress);
						frm.submit();
					}
				}
			}
		});
	});
	 
	//회원 정보 읽어오기
	$.ajax({
		type : "get",
		url : "/user/mypage/read",
		data : {
			"u_id" : u_id,
			"u_k_id" : u_k_id
		},
		success : function(data) {
			$("#u_name").val(data.read.u_name);
			$("#u_birthday").val(data.read.u_birthday);
			//주소 split
			var beforeAdd = data.read.u_address;
			var afterAdd = beforeAdd.split(',');
			$("#sample6_address").val(afterAdd[0]);
			$("#sample6_detailAddress").val(afterAdd[1]);
			//이메일 split
			var beforeEmail = data.read.u_email;
			var afterEmail = beforeEmail.split('@');
			$("#emailT1").val(afterEmail[0]);
			$("#txtEmailType1").val(afterEmail[1]);

			//전화번호
			var beforeTel=data.read.u_tel;
			var afterTel = beforeTel.split('-');
			$("#selectTel1").val(afterTel[0]);
			$("#telFirst1").val(afterTel[1]);
			$("#telSecond1").val(afterTel[2]);
			//이미지 read
			if (data.read.u_image != null) {
				$("#image").attr("src",
						"/display?fileName=" + data.read.u_image);
				$("#imagename").val(data.read.u_image);
			}else{
				if(data.read.u_gender=='male'){
					$("#image").attr("src","/resources/img/user/profileM.png");
					$("#imagename").val(data.read.u_image);
				}else{
					$("#image").attr("src","/resources/img/user/profileF.png");
					$("#imagename").val(data.read.u_image);
				}
			}
			//유저 태그 읽기	
			var tag=[];
			    $.each(data.readtag, function(index, readtag){
				  	tag.push(readtag.t_tag);
			   });
			    $("input[name=t_tag]").each(function(index, item){
			    	for(var i=0; i<tag.length; i++){
				    	if($(this).val()==tag[i]){
				    		var tag1=$(this).parent().find("#tag1");
							var tag2=$(this).parent().find("#tag1-1");
							
							tag1.css("display","none");
							tag2.css("display","inline-block");
				    		$(this).attr("checked",true);
				    	}
			    	}
			    });
			 }
		});

	//email 타입
	$("#email1").change(function() {
		var email = $("#email1 option:selected").val();
		if (email == $("#direct").val()) {
			$("#txtEmailType1").attr("readonly", false);
			$("#txtEmailType1").val("");
			$("#txtEmailType1").focus();
		} else {
			$("#txtEmailType1").val(email);
		}
	});
	
	//업체email 타입
	$("#email2").change(function() {
		var email = $("#email2 option:selected").val();
		if (email == $("#direct").val()) {
			$("#txtEmailType2").attr("readonly", false);
			$("#txtEmailType2").val("");
			$("#txtEmailType2").focus();
		} else {
			$("#txtEmailType2").val(email);
		}
	});
	//주소 검색 API
	function sample6_execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분
						var addr = '';//주소 변수
						var extraAddr = '';//참고 항목 변수

						//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
						if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
							addr = data.roadAddress;
						} else { // 사용자가 지번 주소를 선택했을 경우(J)
							addr = data.jibunAddress;
						}
						// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
						if (data.userSelectedType === 'R') {
							// 법정동명이 있을 경우 추가한다. (법정리는 제외)
							// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
							if (data.bname !== ''
									&& /[동|로|가]$/g.test(data.bname)) {
								extraAddr += data.bname;
							}
							// 건물명이 있고, 공동주택일 경우 추가한다.
							if (data.buildingName !== ''
									&& data.apartment === 'Y') {
								extraAddr += (extraAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
							if (extraAddr !== '') {
								extraAddr = ' (' + extraAddr + ')';
							}
							// 조합된 참고항목을 해당 필드에 넣는다.
							document.getElementById("sample6_extraAddress").value = extraAddr;
						} else {
							document.getElementById("sample6_extraAddress").value = '';
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('sample6_postcode').value = data.zonecode;
						document.getElementById("sample6_address").value = addr;
						// 커서를 상세주소 필드로 이동한다.
						document.getElementById("sample6_detailAddress")
								.focus();

					}
				}).open();
	}

	//업체이미지 클릭시
	$("#image1").click(function() {
		$(frm.file1).click();

	});

	//업체대표 이미지 화면 출력
	$(frm.file1).on("change", function() {
		var file = $(frm.file1)[0].files[0];
		$("#image1").attr("src", URL.createObjectURL(file));
	});

	//이미지 클릭시
	$("#image").click(function() {
		$(frm.file).click();

	});

	//대표 이미지 화면 출력
	$(frm.file).on("change", function() {
		var file = $(frm.file)[0].files[0];
		$("#image").attr("src", URL.createObjectURL(file));
	});

	//주소 검색 api
	new daum.Postcode({
		oncomplete : function(data) {
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
			// 예제를 참고하여 다양한 활용법을 확인해 보세요.
		}
	}).open();
</script>
<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js?autoload=false"></script>
</html>