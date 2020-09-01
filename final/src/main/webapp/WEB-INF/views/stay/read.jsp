<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여행의 설렘 TOURSUM !</title>
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/style.css" />
</head>
<style>
#darken-background {
   position: fixed;
   top: 50%;
   left: 50%;
   transform:translate(-50%,-50%);
   width:100%;
   height: 100%;
   display: none;
   background: rgba(0, 0, 0, 0.5);
   z-index: 10000;
   overflow-y: scroll;
}

#lightbox {
   width: 1000px;
   height: 1000px;
   margin: auto;
   border: 1px solid #333333;
   margin-top:30px;
   border-radius: 5px;
   background: white;
   box-shadow: 0px 5px 5px rgba(34, 25, 25, 0.4);
   text-align: center;
   position: relative;
   padding:20px 10px 10px 10px;
}

#btnClose {
	position:absolute;
	top:10px;
	right:-50px;	
	cursor:pointer;
	background:none;
	outline:none;
	border:none;
}

#tbl2 {
	border-top:1px solid #e9e9e9;
	border-bottom:1px solid #e9e9e9;
	margin-top:20px;
	margin-bottom:15px;
}

#div_star img {
	width:148px;
}

#div_star {
	position:absolute;
	top:478px;
	left:310px;
}

#div_star2 img {
	width:130px;
}

#div_star2 {
	position:absolute;
	top:42px;
	right:495px;
}

#div_option {
	display:inline-block;
	width:237.04px;
	float:left;
}

#roptionB {
	display:inline-block;
	width:740.74px;
	float:left;
	text-align:left;
	padding-left:22px;
}

#roptionB img {
	width:148px;
}

table {
	border-collapse:collapse;
}
.cart {
	width:80px;
	height:40px;
	border:none;
	border-radius:5px;
	outline:none;
	cursor:pointer;
}
</style>
<body>
	<jsp:include page="../floatmenu.jsp"/>
	<jsp:include page="../sidebar.jsp"/>
	<div id="page">
		<div id="header"><jsp:include page="../header.jsp" /></div>
		<div id="menu"><jsp:include page="../menu.jsp" /></div>
		<div id="container">
			<div id="hotelread_area">
				<table id="tbl" style="border-top:3px solid #0f4c81; border-bottom:3px solid #0f4c81;"></table>
				<script id="temp" type="text/x-handlebars-template">
				{{#each .}}
				<tr class="row">
					<td rowspan=2 height=560><img src="/company/hoteldisplay?fileName={{c_image}}" id="image" width=500></td>
					<td width=700 style="padding-left:30px; height:300px; padding-bottom:70px;">
						<span style="display:inline-block; margin-bottom:20px; color:gray;">평점</span>
						<span style="visibility:hidden;">{{c_grade}}</span><br>
						<span style="font-size:30px; font-weight:bold; font-family:'맑은 고딕'; display:inline-block; margin-bottom:10px;" class="c_name">{{c_name}}</span><br>
						<span style="display:inline-block; margin-bottom:10px; color:gray;">{{c_address}}</span><br>
						<span style="color:gray;">{{c_tel}}</span><br>
					</td>
				</tr>	
				<tr>
					<td style="text-align:right; padding-right:15px; padding-top:45px;">
						<span style="font-size:20px; color:gray;">최저가</span><br>
						<span style="font-size:30px; font-weight:bold; color:#0f4c81;">{{r}}</span> <span style="font-size:25px;">원 ~</span><br>
						<span style="display:inline-block; margin-top:30px;"><button style="background:#0f4c81; width:200px; height:50px; border-radius:5px; outline:none; border:none; color:white; cursor:pointer;">최저가 예약하기</button></span>
					</td>
				</tr>	
				{{/each}}
				</script>
				<div id="div_star2">
						<span id="star21"><img src="/resources/img/star/star0.png"></span> 
						<span id="star22"><img src="/resources/img/star/star05.png"></span> 
						<span id="star23"><img src="/resources/img/star/star10.png"></span> 
						<span id="star24"><img src="/resources/img/star/star15.png"></span> 
						<span id="star25"><img src="/resources/img/star/star20.png"></span> 
						<span id="star26"><img src="/resources/img/star/star25.png"></span> 
						<span id="star27"><img src="/resources/img/star/star30.png"></span> 
						<span id="star28"><img src="/resources/img/star/star35.png"></span> 
						<span id="star29"><img src="/resources/img/star/star40.png"></span> 
						<span id="star210"><img src="/resources/img/star/star45.png"></span> 
						<span id="star211"><img src="/resources/img/star/star50.png"></span>
				</div>
				
				<div style="height:60px; margin-top:40px;"><img src="/resources/img/stay/hotelread_title.png"/></div>
				<table id="tbl1"></table>
				<script id="temp1" type="text/x-handlebars-template">
				<tr style="background:#efefef;">
					<td width=400 style="text-align:center; height:40px;">객실명</td>
					<td width=200 style="text-align:center;">최대 인원</td>
					<td width=400 style="text-align:center;">가격(하루기준)</td>
					<td width=200 style="text-align:center;">장바구니</td>
				</tr>
				{{#each .}}
				<tr class="row" style="border-bottom:0.5px solid #e9e9e9; cursor:pointer;">
					<td style="padding-left:15px; height:80px;"><span style="font-size:20px;" class="r_title">{{r_title}}</span> <span style="font-size:13px; color:gray;">(<span class="roomnum r_roomnum">{{r_roomnum}}</span>호)</span></td>
					<td style="text-align:center;" class="r_persons">{{r_persons}}</td>
					<td style="text-align:right; padding-right:15px;"><span class="r_price">{{r_price}}</span> 원</td>
					<td style="text-align:center;"><input type="button" value="담기" class="cart"></td>
					<td style="visibility:hidden;">
						{{r_grade}}
						<input type="hidden" value="{{r_id}}" class="r_id">
						<input type="hidden" value="{{r_image}}" class="r_image">
					</td>
				</tr>
				{{/each}} 
				</script>
			</div>
			
			<div id="darken-background">
				<div id="lightbox">
					<div>
						<img src="http://placehold.it/500x350" id="repimage" Style="width: 500px; height: 350px;">
					</div>
					<div id="images"></div>
					
					<script id="temp3" type="text/x-handlebars-template">
					{{#each image}}
						<span><img src="/displayRoom?fileName={{r_i_images}}" Style="width:100px;height:70px;"></span>
					{{/each}}	
					</script>
					<table id="tbl2">
						<tr height=40>
							<td width=238 rowspan=3 style="padding-bottom:145px;">객실 정보</td>
							<td style="padding-left:22px; text-align:left; padding-top:10px;">평점</td>
						</tr>
						<tr>	
							<td width=742 style="text-align:left; padding-left:22px;">
								<span id="title1" style="font-size:30px; font-weight:bold;"></span> <span style="color:gray;">(<span id="roomnum1"></span>호)</span><br>
								<span style="color:gray; display:inline-block; margin-top:10px;">최대 인원 수 / <span id="persons1"></span></span><br>
								<span style="display:inline-block; color:gray; margin-top:10px;"><span id="price1"> </span>원</span>
							</td>
						</tr>
						<tr>
							<td height=50 style="text-align:left; padding-left:22px;">상세 설명 : <span id="detail1"></span></td>
						</tr>
					</table>
					<div id="div_star">
						<span id="star1"><img src="/resources/img/star/star0.png"></span> 
						<span id="star2"><img src="/resources/img/star/star05.png"></span> 
						<span id="star3"><img src="/resources/img/star/star10.png"></span> 
						<span id="star4"><img src="/resources/img/star/star15.png"></span> 
						<span id="star5"><img src="/resources/img/star/star20.png"></span> 
						<span id="star6"><img src="/resources/img/star/star25.png"></span> 
						<span id="star7"><img src="/resources/img/star/star30.png"></span> 
						<span id="star8"><img src="/resources/img/star/star35.png"></span> 
						<span id="star9"><img src="/resources/img/star/star40.png"></span> 
						<span id="star10"><img src="/resources/img/star/star45.png"></span> 
						<span id="star11"><img src="/resources/img/star/star50.png"></span>
					</div>
					<div id="div_option">옵션</div>
					<div id="roptionB">
						<span id="roption1">
							<input type="checkbox" id="Rr_option1" name="r_o_option1" value="01"> 
							<label for="Rr_option1" id="tag1">
								<img src="/resources/img/roomoption/Roption_coffemaker_icon2.png">
							</label>
							<label for="Rr_option1" id="tag1-1" style="display: none;">
								<img src="/resources/img/roomoption/Roption_coffemaker_icon_hover.png">
							</label>
						</span> 
						<span id="roption2"> 
							<input type="checkbox" id="Rr_option2" name="r_o_option1" value="02"> 
							<label for="Rr_option2" id="tag1">
								<img src="/resources/img/roomoption/Roption_ketchen_icon2.png">
							</label>
							<label for="Rr_option2" id="tag1-1" style="display: none;">
								<img src="/resources/img/roomoption/Roption_ketchen_icon_hover.png">
							</label>
						</span> <br>
						<span id="roption3"> 
							<input type="checkbox" id="Rr_option3" name="r_o_option1" value="03"> 
							<label for="Rr_option3" id="tag1">
								<img src="/resources/img/roomoption/Roption_shampoo_icon2.png">
							</label>
							<label for="Rr_option3" id="tag1-1" style="display: none;">
								<img src="/resources/img/roomoption/Roption_shampoo_icon_hover.png">
							</label>
						</span> 
						<span id="roption4"> 
							<input type="checkbox" id="Rr_option4" name="r_o_option1" value="04"> 
							<label for="Rr_option4" id="tag1">
								<img src="/resources/img/roomoption/Roption_Bathtub_icon2.png">
							</label>
							<label for="Rr_option4" id="tag1-1" style="display: none;">
								<img src="/resources/img/roomoption/Roption_Bathtub_icon_hover.png">
							</label>
						</span> <br>
						<span id="roption5"> 
							<input type="checkbox" id="Rr_option5" name="r_o_option1" value="05"> 
							<label for="Rr_option5" id="tag1">
								<img src="/resources/img/roomoption/Roption_airconditioner_icon2.png">
							</label>
							<label for="Rr_option5" id="tag1-1" style="display: none;">
								<img src="/resources/img/roomoption/Roption_airconditioner_icon_hover.png">
							</label>
						</span> 
						<span id="roption6"> 
							<input type="checkbox" id="Rr_option6" name="r_o_option1" value="06"> 
							<label for="Rr_option6" id="tag1">
								<img src="/resources/img/roomoption/Roption_safebox_icon2.png"></label>
							<label for="Rr_option6" id="tag1-1" style="display: none;">
								<img src="/resources/img/roomoption/Roption_safebox_icon_hover.png">
							</label>
						</span> <br>
						<span id="roption7"> 
							<input type="checkbox" id="Rr_option7" name="r_o_option1" value="07"> 
							<label for="Rr_option7" id="tag1">
								<img src="/resources/img/roomoption/Roption_minibar_icon2.png">
							</label>
							<label for="Rr_option7" id="tag1-1" style="display: none;">
								<img src="/resources/img/roomoption/Roption_minibar_icon_hover.png">
							</label>
						</span> 
						<span id="roption8"> 
							<input type="checkbox" id="Rr_option8" name="r_o_option1" value="08"> 
							<label for="Rr_option8" id="tag1">
								<img src="/resources/img/roomoption/Roption_wifi_icon2.png"></label> 
							<label for="Rr_option8" id="tag1-1" style="display: none;">
								<img src="/resources/img/roomoption/Roption_wifi_icon_hover.png">
							</label>
						</span> <br>
						<span id="roption9"> 
							<input type="checkbox" id="Rr_option9" name="r_o_option1" value="09"> 
							<label for="Rr_option9" id="tag1">
								<img src="/resources/img/roomoption/Roption_tv_icon2.png"></label> 
							<label for="Rr_option9" id="tag1-1" style="display: none;">
								<img src="/resources/img/roomoption/Roption_tv_icon_hover.png">
							</label>
						</span> 
						<span id="roption10"> 
							<input type="checkbox" id="Rr_option10" name="r_o_option1" value="10"> 
							<label for="Rr_option10" id="tag1">
								<img src="/resources/img/roomoption/Roption_computer_icon2.png">
							</label>
							<label for="Rr_option10" id="tag1-1" style="display: none;">
								<img src="/resources/img/roomoption/Roption_computer_icon_hover.png">
							</label>
						</span> <br>
						<span id="roption11"> 
							<input type="checkbox" id="Rr_option11" name="r_o_option1" value="11"> 
							<label for="Rr_option11" id="tag1">
								<img src="/resources/img/roomoption/Roption_refrigerator_icon2.png">
							</label>
							<label for="Rr_option11" id="tag1-1" style="display: none;">
								<img src="/resources/img/roomoption/Roption_refrigerator_icon_hover.png">
							</label>
						</span> 
						<span id="roption12"> 
							<input type="checkbox" id="Rr_option12" name="r_o_option1" value="12"> 
							<label for="Rr_option12" id="tag1">
								<img src="/resources/img/roomoption/Roption_hairdryer_icon2.png">
							</label>
							<label for="Rr_option12" id="tag1-1" style="display: none;">
								<img src="/resources/img/roomoption/Roption_hairdryer_icon_hover.png">
							</label>
						</span>
					</div>
					<button id="btnClose">
						<img src="/resources/img/hotplace/close_icon2.png" width=30 />
					</button>
				</div>
			</div>
		</div>
		<div id="footer"><jsp:include page="../footer.jsp" /></div>
	</div>		
</body>
<script>
var c_id="${c_id}";
roomlist();
$("#star1").hide();$("#star3").hide();$("#star5").hide();$("#star7").hide();$("#star9").hide();
$("#star2").hide();$("#star4").hide();$("#star6").hide();$("#star8").hide();$("#star10").hide();$("#star11").hide();
$("#star21").hide();$("#star23").hide();$("#star25").hide();$("#star27").hide();$("#star29").hide();
$("#star22").hide();$("#star24").hide();$("#star26").hide();$("#star28").hide();$("#star210").hide();$("#star211").hide();
$(":checkbox").css("display","none");
$("#darken-background").hide();
$("input:checkbox[name='r_o_option1']").prop("checked", false);

	//카트 빼기
	$(".cartcancel").on("click",function(){
		alert("dd");
		var r_roomnum = $(this).attr("r_roomnum");
		var r_id = $(this).attr("r_id");
		
		$.ajax({
			type:"get",
			url:"/cartcancel",
			data:{"r_id":r_id,"r_roomnum":r_roomnum},
			success:function(){
				alert("서어공");
			}
		});
	});


	// 장바구니
	$("#tbl1").on("click", ".row .cart", function(e) {
		e.stopPropagation();
		
		var row = $(this).parent().parent();
		var c_name = $("#tbl .row").find(".c_name").html();
		var r_title = row.find(".r_title").html();
		var r_roomnum = row.find(".r_roomnum").html();
		var r_price = row.find(".r_price").html();
		var r_id = row.find(".r_id").val();
		var r_image = row.find(".r_image").val();
		//alert(c_name);
// 		alert(r_id + c_name + r_title + r_roomnum + r_price + r_image);
		$.ajax({
			type : "get",
			url : "/sidebar",
			dataType:"json",
			data : {
				"r_id" : r_id,
				"c_name" : c_name,
				"r_title" : r_title,
				"r_roomnum" : r_roomnum,
				"r_price" : r_price,
				"r_image" : r_image
			},
			success : function(data) {
				if(data==1){
					if($(".sidebar").hasClass('open')){
						refresh();
					}else{
						refresh();
						$(".sidebar-btn").click();
					}
					alert("이미 장바구니에 있는 품목입니다");
				}else{
					if($(".sidebar").hasClass('open')){
						refresh();
					}else{
						refresh();
						$(".sidebar-btn").click();
					}
				}
			}
		});
	});

	$("input[name=r_o_option1]").on("click", function() {
		var tag1 = $(this).parent().find("#tag1");
		var tag2 = $(this).parent().find("#tag1-1");

		if ($(this).is(":checked") == true) {
			tag1.css("display", "none");
			tag2.css("display", "inline-block");
		} else {
			tag1.css("display", "inline-block");
			tag2.css("display", "none");
		}
	});

	$("#tbl1").on("click", ".row", function() {
		$("#darken-background").css("display", "block"); //팝업 뒷배경 display block
		$("#lightbox").css("display", "block"); //팝업창 display block
		$("body").css("overflow", "hidden");//body 스크롤바 없애기

	});
	$("#btnClose").on("click", function(event) {
		$("#darken-background").css("display", "none"); //팝업창 뒷배경 display none
		$("#lightbox").css("display", "none"); //팝업창 display none
		$("body").css("overflow", "auto");//body 스크롤바 생성
	});

	$.ajax({
		type : "post",
		url : "/stay/read",
		data : {
			"c_id" : c_id
		},
		success : function(data) {
			var c_grade = "${c_grade}";
			var temp = Handlebars.compile($("#temp").html());
			$("#tbl").html(temp(data));

			if (c_grade == 0) {
				$("#star21").show();
			} else if (0 < c_grade && c_grade <= 0.5) {
				$("#star22").show();
			} else if (0.5 < c_grade && c_grade <= 1) {
				$("#star23").show();
			} else if (1 < c_grade && c_grade <= 1.5) {
				$("#star24").show();
			} else if (1.5 < c_grade && c_grade <= 2) {
				$("#star25").show();
			} else if (2 < c_grade && c_grade <= 2.5) {
				$("#star26").show();
			} else if (2.5 < c_grade && c_grade <= 3) {
				$("#star27").show();
			} else if (3 < c_grade && c_grade <= 3.5) {
				$("#star28").show();
			} else if (3.5 < c_grade && c_grade <= 4) {
				$("#star29").show();
			} else if (4 < c_grade && c_grade <= 4.5) {
				$("#star210").show();
			} else if (4.5 < c_grade && c_grade <= 5) {
				$("#star211").show();
			}
		}
	});

	$("#tbl1")
			.on(
					"click",
					".row",
					function() {
						$("input[name=r_o_option1]").prop("checked", false);
						$("input[name=r_o_option1]").parent().find("#tag1")
								.css("display", "inline-block");
						$("input[name=r_o_option1]").parent().find("#tag1-1")
								.css("display", "none");

						$("#star1").hide();
						$("#star3").hide();
						$("#star5").hide();
						$("#star7").hide();
						$("#star9").hide();
						$("#star2").hide();
						$("#star4").hide();
						$("#star6").hide();
						$("#star8").hide();
						$("#star10").hide();
						$("#star11").hide();
						var r_i_roomnum = $(this).find(".roomnum").html();
						var r_i_id = "${c_id}";
						$
								.ajax({
									type : "get",
									url : "/company/getroomread",
									data : {
										"r_i_id" : r_i_id,
										"r_i_roomnum" : r_i_roomnum
									},
									success : function(data) {
										var temp = Handlebars.compile($(
												"#temp3").html());
										$("#images").html(temp(data));
										$("#roomnum1")
												.html(data.read.r_roomnum);
										$("#title1").html(data.read.r_title);
										$("#persons1")
												.html(data.read.r_persons);
										$("#price1").html(data.read.r_price);
										$("#roomnum1")
												.html(data.read.r_roomnum);
										$("#detail1").html(data.read.r_detail);
										$("#repimage").attr(
												"src",
												"/displayRoom?fileName="
														+ data.read.r_image);
										if (data.read.r_grade == 0) {
											$("#star1").show();
										} else if (0 < data.read.r_grade
												&& data.read.r_grade <= 0.5) {
											$("#star2").show();
										} else if (0.5 < data.read.r_grade
												&& data.read.r_grade <= 1) {
											$("#star3").show();
										} else if (1 < data.read.r_grade
												&& data.read.r_grade <= 1.5) {
											$("#star4").show();
										} else if (1.5 < data.read.r_grade
												&& data.read.r_grade <= 2) {
											$("#star5").show();
										} else if (2 < data.read.r_grade
												&& data.read.r_grade <= 2.5) {
											$("#star6").show();
										} else if (2.5 < data.read.r_grade
												&& data.read.r_grade <= 3) {
											$("#star7").show();
										} else if (3 < data.read.r_grade
												&& data.read.r_grade <= 3.5) {
											$("#star8").show();
										} else if (3.5 < data.read.r_grade
												&& data.read.r_grade <= 4) {
											$("#star9").show();
										} else if (4 < data.read.r_grade
												&& data.read.r_grade <= 4.5) {
											$("#star10").show();
										} else if (4.5 < data.read.r_grade
												&& data.read.r_grade <= 5) {
											$("#star11").show();
										}
										//룸 옵션 읽기	
										var option1 = [];
										$.each(data.option, function(index,
												option) {
											option1.push(option.r_o_option);
										});
										$("input[name=r_o_option1]")
												.each(
														function(index, item) {
															for (var i = 0; i < option1.length; i++) {
																if ($(this)
																		.val() == option1[i]) {
																	var tag1 = $(
																			this)
																			.parent()
																			.find(
																					"#tag1");
																	var tag2 = $(
																			this)
																			.parent()
																			.find(
																					"#tag1-1");

																	tag1
																			.css(
																					"display",
																					"none");
																	tag2
																			.css(
																					"display",
																					"inline-block");
																	$(this)
																			.prop(
																					"checked",
																					true);
																}
															}
														});
									}
								});
					});

	function roomlist() {
		$.ajax({
			type : "get",
			url : "/company/roomlist",
			data : {
				"c_id" : c_id
			},
			dataType : "json",
			success : function(data) {
				var template = Handlebars.compile($("#temp1").html());
				$("#tbl1").html(template(data));
			}
		});
	}
</script>
</html>