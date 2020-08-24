<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>여행의 설렘 TOURSUM !</title>
   <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
   <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
   <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
   <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
   <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/style.css"/>
   <link rel="shortcut icon" type="image⁄x-icon" href="/resources/img/title_logo.png">
<style>
#darken-background {
	position: fixed;
	top: 0px;
	left: 0px;
	right: 0px;
	height: 100%;
	display: none;
	background: rgba(0, 0, 0, 0.5);
	z-index: 10000;
	overflow-y: scroll;
}

#lightbox {
	width: 800px;
	height:800px;
	border: 1px solid #333333;
	border-radius: 5px;
	background: white;
	box-shadow: 0px 5px 5px rgba(34, 25, 25, 0.4);
	text-align: center;
	position:absolute; top:50%; left:50%;
	transform:translate(-50%,-50%);
	position:relative;
	padding:20px 10px 10px 10px;
}

#lightbox #btnClose {
	position:absolute;
	top:5px;
	right:-50px;
	background:none;
	border:none;
	outline:none;
	cursor:pointer;
}

.styleseat {
	width:70px;
	height:40px;
	margin:5px;
	cursor:pointer;
	background:black;
	color:white;
	border-radius:3px;
	border:0.5px solid gray;
	outline:none;
}

.seat {
	float: left;
}

.seat .seat1 {
	width:70px;
	height:40px;
	margin:5px;
	cursor:pointer;
}

.div_seat1 {
	margin-right:30px;
	margin-left:35px;
}

.div_seat2 {
	margin-right:30px;
}


#air_booking_area {
	position:relative;
	left:50%;
	transform:translate(-50%,0);
	width:1000px;
	padding-top:40px;
	padding-bottom:60px;
}
#booking_user_info,
#passengers {
	border-collapse:collapse;
	margin-top:10px;
	margin-bottom:60px;
}
#booking_user_info th,
#passengers th {
	width:130px;
}
#booking_user_info input,
#booking_user_info select,
#passengers input[type="text"] {
	border:0.5px solid #e9e9e9;
	outline:none;
	cursor:pointer;
	border-radius:5px;
	height:40px;
	padding:0px 10px 0px 10px;
}
#passengers input[type="text"] {
	width:250px;
}
#booking_info {
	border-collapse:collapse;
	text-align:center;
	margin-top:10px;
	margin-bottom:60px;
}

#booking_info tr, #passengers tr, #booking_user_info tr {
	height:90px;
}
#passengers input[type="radio"] {
	cursor:pointer;
	margin-right:10px;
}
.choicefinish {
	width:200px;
	height:40px;
	outline:none;
	border:none;
	background:#0f4c81;
	color:white;
	border-radius:5px;
	margin-top:20px;
	cursor:pointer;
}
</style>
</head>
<body>
	<jsp:include page="../floatmenu.jsp"/>
	<div id="page">
		<div id="header"><jsp:include page="../header.jsp" /></div>
		<div id="menu"><jsp:include page="../menu.jsp" /></div>
		<div id="container">
			<div id="air_booking_area">
				<img src="/resources/img/air/air_booking.png" width=450>
				<table id="booking_info">
					<tr style="border-top:2px solid #0f4c81; border-bottom:2px solid #0f4c81;">
						<th width=200>구분</th>
						<th width=200>항공사</th>
						<th width=200>편명</th>
						<th width=200>출발시간</th>
						<th width=200>도착시간</th>

					</tr>
					<tr style="border-bottom:0.5px solid gray;">
						<td>${go.a_startplace } > ${go.a_endplace }</td>
						<td>${go.a_company }</td>
						<td>${go.a_number }</td>
						<td>${go.a_starttime }</td>
						<td>${go.a_endtime }</td>
					</tr>
					<tr style="border-bottom:2px solid #0f4c81;">

						<c:if test="${a_startdate1 == null }">
							<td>${back.a_endplace } > ${back.a_startplace }</td>
						</c:if>
						<c:if test="${a_startdate1 != '' }">
							<td>${back.a_endplace } > ${back.a_startplace }</td>
							<td>${back.a_company }</td>
							<td>${back.a_number }</td>
							<td>${back.a_starttime }</td>
							<td >${back.a_endtime }</td>
						</c:if>
					</tr>
				</table>
				
				<img src="/resources/img/air/air_booking1.png" width=450>
				<form name="frm" action="kakaoPay">
					<input type="hidden" name="a_number" value="${go.a_number }">
					<input type="hidden" name="a_number1" value="${back.a_number }">
					<input type="hidden" name="sum" value="${sum}">
					<table id="booking_user_info">
						<tr style="border-top:2px solid #0f4c81;">
							<th style="padding-top:20px;">예약자명</th>
							<td width=250 style="padding-top:20px;"><input type="text" name="payName" style="width:100%;"></td>
							<th style="padding-top:20px;">E-mail</th>
							<td width=300 style="padding-top:20px;">
								<input type="text" name="str_email" id="str_email" style="width:45.5%;"> @
								<input type="text" name="str_email1" id="str_email1" style="width:45.5%;">
							</td>
							<td width=190 style="padding-top:20px;">	
								<select name="selectEmail" id="selectEmail" style="margin-left:10px; width:136.19px;">
									<option value="1">직접입력</option>
									<option value="naver.com">naver.com</option>
									<option value="hanmail.net">hanmail.net</option>
									<option value="hotmail.com">hotmail.com</option>
									<option value="nate.com">nate.com</option>
									<option value="yahoo.co.kr">yahoo.co.kr</option>
									<option value="empas.com">empas.com</option>
									<option value="dreamwiz.com">dreamwiz.com</option>
									<option value="freechal.com">freechal.com</option>
									<option value="lycos.co.kr">lycos.co.kr</option>
									<option value="korea.com">korea.com</option>
									<option value="gmail.com">gmail.com</option>
									<option value="hanmir.com">hanmir.com</option>
									<option value="paran.com">paran.com</option>
								</select>
							</td>
						</tr>
						<tr style="border-bottom:2px solid #0f4c81;">
							<th style="padding-bottom:20px;">휴대전화</th>
							<td style="padding-bottom:20px;"><input type="text" name=tel id="tel" onkeyup="keyevent(this);" placeholder="-을 빼고 입력해주세요!" maxlength="13" style="width:100%;"></td>
							<th style="padding-bottom:20px;">생년월일</th>
							<td colspan=2 style="padding-bottom:20px;"><input type="text" name="u_birthday" id="birthday" style="width:300px;" readOnly></td>
						</tr>
					</table>
					<img src="/resources/img/air/air_booking2.png" width=450>
					<table id="passengers" style="border-top:2px solid #0f4c81;">
						<c:forEach var="i" begin="1" end="${sum }" step="1" varStatus="vs">
							<tr >
								<th style="padding-top:20px;">이름</th>
								<td width=250 style="padding-top:20px;"><input type=text name='a_p_name'></td>
								<th style="padding-top:20px;">성별</th>
								<td colspan=2  width=300 style="padding-left:10px;padding-top:20px;">
									남 <input type="radio" name="a_p_gender${vs.count }" value="male">
									여 <input type="radio" name="a_p_gender${vs.count }" value="female">
								</td>
								<td width=190><input type="hidden" width=100></td>
							</tr>
							<tr class=row style="border-bottom:0.5px solid gray;">
								<th style="padding-bottom:20px;">주민번호</th> <!-- <input type=text name='a_p_residentRegistration1'maxlength="6" size="5">-<input type=text name='a_p_residentRegistration2'maxlength="7" size="5"> -->
								<td width=250 colspan=4 style="padding-bottom:20px;">
									<input type=text name='a_p_residentregistration' 
									id="a_p_residentregistration" onkeyup="keyevent(this);"
									placeholder="- 을 빼고 입력해주세요 " maxlength="13">
								</td>
								<td></td>
							</tr>
						</c:forEach>
						<tr class=row style="height:200px; border-bottom:2px solid #0f4c81;">
							<th style="border-right:0.5px solid gray;">좌석선택 </th>
							<td colspan=4 style="text-align:center;">
								<span style="display:inline-block; text-align:center; margin-right:40px;">
									가는항공 
									<input type=text seat="${go.a_number }" class=seatSelection name='a_p_seat' style="width:100px; margin-left:10px;">
								</span>
								<c:if test="${a_startdate1 == null }">
								</c:if>
								<c:if test="${a_startdate1 != '' }">
									<span style="display:inline-block; text-align:center;">
										오는항공
										<input type=text seat="${back.a_number }" class=backseatSelection name='a_p_backseat' style="width:100px; margin-left:10px;">
									</span>
								</c:if>
							</td>
							<td><input type="hidden" name="a_p_gender"/></td>
						</tr>
					</table>
					<div style="text-align:right;">
						<div style="padding:0px 0px 10px 0px; font-size:18px;">총 운임비</div>
						<input type="hidden" name="airsum">
						<div style="font-size:30px; margin-bottom:20px;"><span id="airsum" style="color:red;margin-right:10px;"></span> 원</div>
						<input type="submit" value="카카오페이 결제하기" 
						style="padding:10px; width:200px; cursor:pointer; outline:none; 
						border:none; border-radius:5px; background:#fddc3f;">
					</div>
				</form>
			</div>
			<div id="darken-background">
				<div id="lightbox">
					<div style="padding:30px;">좌석을 선택해주세요.</div>
					<div id="selectseat"></div>
					<button id="btnClose"><img src="/resources/img/air/close.png" width=30 height=30/></button>
				</div>
			</div>
		</div>
		<div id="footer"><jsp:include page="../footer.jsp" /></div>
	</div>
</body>
<script>
	var sum = "${sum}";
	var present;
	var email = "";
	var a_startdate1 = "${a_startdate1}";
	var goPrice = "${go.a_price}";
	var backPrice = "${back.a_price}";
	var thisseat;
	var seatSelection;
	var seatchoice = "";
	var seatcount = 0;
	var price="${price}";
	//이메일 입력방식 선택 
	$('#selectEmail').change(function() {
		$("#selectEmail option:selected").each(function() {
			if ($(this).val() == '1') { //직접입력일 경우 
				$("#str_email").val(''); //값 초기화 
				$("#str_email1").attr("disabled", false); //활성화 
			} else { //직접입력이 아닐경우 
				$("#str_email1").val($(this).text()); //선택값 입력 
				$("#str_email1").attr("disabled", true); //비활성화 
			}
		});
	});

	//핸드폰 하이픈 생성   
	$(document)
			.on(
					"keyup",
					"#tel",
					function() {
						$(this)
								.val(
										$(this)
												.val()
												.replace(/[^0-9]/g, "")
												.replace(
														/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,
														"$1-$2-$3").replace(
														"--", "-"));
					});
	//주민번호 하이픈 생성   
	$(document)
			.on(
					"keyup",
					"#a_p_residentregistration",
					function() {
						$(this)
								.val(
										$(this)
												.val()
												.replace(/[^0-9]/g, "")
												.replace(
														).replace(
														"--", "-"));
					});
	//총 운임비 계산하기 
	
	   if(price!=""){
	      $(frm.airsum).val(price * sum);
	      $("#airsum").html(price * sum);
	   }else{
	      if (a_startdate1 == "") {
	         $(frm.airsum).val(goPrice * sum);
	         $("#airsum").html(goPrice * sum);
	      } else {
	         $(frm.airsum).val(
	               (parseInt(goPrice) + parseInt(backPrice)) * parseInt(sum));
	         $("#airsum").html(
	               (parseInt(goPrice) + parseInt(backPrice)) * parseInt(sum));
	      };
	   }

	//결제하기 
	$(frm).submit(function(e) {
		
		e.preventDefault();
		var payname = $(frm.payName).val();
		email += $(frm.str_email).val();
		email += "@";
		email += $(frm.str_email1).val();
		var tel = $(frm.tel).val();
		var birthday = $(frm.u_birthday).val();
		var a_p_name = $(frm.a_p_name).val();
		var a_p_gender = $(frm.a_p_gender).val();
		var a_p_residentRegistration = $(frm.a_p_residentRegistration)
				.val();
		var a_p_seat = $(frm.a_p_seat).val();
		var radio = [];
		for (var i = 1; i <= sum; i++) {
			radio.push($("input[name='a_p_gender" + i + "']:checked")
					.val());
			// 			$(frm.a_p_gender+i).removeAttr("name").attr({name:"a_p_gender"});
			// 			$(":radio[name='a_p_gender'][value="+radio[i-1]+"']").attr('checked', true);
		}
		$("input[name='a_p_gender']").val(radio);

		if (!confirm("여행을 떠날 준비가 되셨나요?"))
			return;
		frm.submit();
		// 			window.open("kakaoPay","","100px, 100px");
		if (payName != "" || email != "" || tel != "" || birthday != ""
				|| a_p_name != "" || a_p_gender != ""
				|| a_p_residentRegistration != "" || a_p_seat != "") {

		} else {
			alert("모든 text 창을 입력해주세요 ");
		}
	});

	//좌석선택(라이트박스)
	$("#passengers")
			.on(
					"click",
					".row .seatSelection, .backseatSelection",
					function() {
						var a_number = $(this).attr("seat");
						seatSelection = $(this);
						$
								.ajax({
									type : "get",
									url : "/air/seatlist",
									dataType : "json",
									data : {
										"a_number" : a_number
									},
									success : function(data) {
										var html = "";
										var datalength = data.length;
										var dataseat = [];
										present = $(this);
										for (var i = 1; i <= 12; i++) {
											html += "<div class='seat div_seat1'><button class='seat1'>A"
													+ i
													+ "</button><button class='seat1'>B"
													+ i + "</button></div>";
											html += "<div class='seat div_seat2'><button class='seat1'>C"
													+ i
													+ "</button><button class='seat1'>D"
													+ i
													+ "</button><button class='seat1'>E"
													+ i
													+ "</button><button class='seat1'>F"
													+ i + "</button></div>";
											html += "<div class='seat div_seat3'><button class='seat1'>G"
													+ i
													+ "</button><button class='seat1'>H"
													+ i
													+ "</button></div><br><br>";
										}
										html += "<button class='choicefinish'>선택완료</button>";
										$("#selectseat").html(html);
										$("#darken-background").show();

										$(".seat1")
												.each(
														function() {
															thisseat = $(this);

															for (var n = 0; n < datalength; n++) {
																dataseat
																		.push(data[n]);
																if (dataseat[n] == thisseat
																		.html()) {
																	thisseat
																			.attr(
																					'disabled',
																					true);
																	// 																	thisseat.contents().unwrap().wrap( "<img src='/resources/img/hotplace/close_icon.png' style='width:40px;height:30px'/>" );
																	// 																	thisseat.html("<img src='/resources/img/hotplace/close_icon.png' style='width:40px;height:30px'/>");
																}
															}
														});

									}
								});

					});
	//라이트박스 닫기
	$("#btnClose").on("click", function() {
		$("#darken-background").hide();
		seatcount = 0;
	});
	//좌석선택완료
	$("#selectseat").on("click", ".choicefinish", function() {
		$("#darken-background").hide();
		$("#selectseat .seat button").each(function() {
			if ($(this).attr("class") == "styleseat") {
				seatchoice += "," + $(this).html();
			}
		});
		seatchoice = seatchoice.substring(1);
		seatSelection.val(seatchoice);
		seatchoice = "";
		seatcount = 0;
	});

	//라이트박스안에 버튼선택 
	$("#selectseat").on("click", ".seat button", function() {
		if ($(this).attr("class") == "styleseat") {
			$(this).attr("class", "seat1");
			seatcount--;
		} else {
			if (seatcount >= sum) {
				alert("선택가능 인원수는" + sum + "명 입니다");
			} else {
				$(this).attr("class", "styleseat");
				seatcount++;
			}
		}
	});

	//생일 받기
	$(document).ready(
			function() {
				$("#birthday")
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
									dateFormat : "yy년mm월dd일",
									yearRange : 'c-100:c+0',
									maxDate : 0
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
</script>
</html>