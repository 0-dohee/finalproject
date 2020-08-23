<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<title>여행의 설렘 TOURSUM !</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/style.css" />
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
   height: 800px;
   margin: auto;
   margin-top: 25px;
   margin-bottom: 25px;
   border: 1px solid #333333;
   border-radius: 5px;
   background: white;
   box-shadow: 0px 5px 5px rgba(34, 25, 25, 0.4);
   text-align: center;
   position: relative;
}
#roominsert_area {
	position:relative;
	left:50%;
	transform:translate(-50%,0);
	width:1000px;
	border-radius:5px 5px 5px 5px;	
	background:yellow;
}
</style>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
</head>
<body>
	<jsp:include page="../floatmenu.jsp"/>
	<jsp:include page="../sidebar.jsp"/>
	<div id="page">
		<div id="header"><jsp:include page="../header.jsp" /></div>
		<div id="menu"><jsp:include page="../menu.jsp" /></div>
		<div id="container">
			<div id="roominsert_area">
			<h1>룸 등록</h1>
			<form name="frm" action="insertroom" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
				<table border=1>
					<tr>
						<td><span>숙소명</span></td>
						<td>
							<input type="text" name="r_title" id="title">
							<input type="hidden" name="r_id" value="${c_id}" readonly>
						</td>
						<td><span>호 수</span></td>
						<td><input type="text" name="r_roomnum" id="roomnum"></td>
					</tr>
					<tr>
						<td><span>최대 인원 수</span></td>
						<td><input type="text" name="r_persons" id="persons"></td>
						<td><span>가격</span></td>
						<td><input type="text" name="r_price" id="price"></td>
					</tr>
					<tr>
						<td colspan=4><span>숙소 옵션을 선택해주세요.</span></td>
					</tr>
					<tr>
						<td colspan=4>
						<div id="roption" style="text-align:center;">
							<span id="roption1">
								<input type="checkbox" id="r_option1" name="r_o_option" value="01">
									<label for="r_option1" id="tag1"><img src="/resources/img/roomoption/Roption_coffemaker_icon2.png"></label>
									<label for="r_option1" id="tag1-1" style="display:none;"><img src="/resources/img/roomoption/Roption_coffemaker_icon_hover.png"></label>
							</span>
							<span id="roption2">
								<input type="checkbox" id="r_option2" name="r_o_option" value="02">
									<label for="r_option2" id="tag1"><img src="/resources/img/roomoption/Roption_ketchen_icon2.png"></label>
									<label for="r_option2" id="tag1-1" style="display:none;"><img src="/resources/img/roomoption/Roption_ketchen_icon_hover.png"></label>
							</span>
							<span id="roption3">
								<input type="checkbox" id="r_option3" name="r_o_option" value="03">
									<label for="r_option3" id="tag1"><img src="/resources/img/roomoption/Roption_shampoo_icon2.png"></label>
									<label for="r_option3" id="tag1-1" style="display:none;"><img src="/resources/img/roomoption/Roption_shampoo_icon_hover.png"></label>
							</span>
							<span id="roption4">
								<input type="checkbox" id="r_option4" name="r_o_option" value="04">
									<label for="r_option4" id="tag1"><img src="/resources/img/roomoption/Roption_Bathtub_icon2.png"></label>
									<label for="r_option4" id="tag1-1" style="display:none;"><img src="/resources/img/roomoption/Roption_Bathtub_icon_hover.png"></label>
							</span>
							<span id="roption5">
								<input type="checkbox" id="r_option5" name="r_o_option" value="05">
									<label for="r_option5" id="tag1"><img src="/resources/img/roomoption/Roption_airconditioner_icon2.png"></label>
									<label for="r_option5" id="tag1-1" style="display:none;"><img src="/resources/img/roomoption/Roption_airconditioner_icon_hover.png"></label>
							</span>
							<span id="roption6">
								<input type="checkbox" id="r_option6" name="r_o_option" value="06">
									<label for="r_option6" id="tag1"><img src="/resources/img/roomoption/Roption_safebox_icon2.png"></label>
									<label for="r_option6" id="tag1-1" style="display:none;"><img src="/resources/img/roomoption/Roption_safebox_icon_hover.png"></label>
							</span>
							<span id="roption7">
								<input type="checkbox" id="r_option7" name="r_o_option" value="07">
									<label for="r_option7" id="tag1"><img src="/resources/img/roomoption/Roption_minibar_icon2.png"></label>
									<label for="r_option7" id="tag1-1" style="display:none;"><img src="/resources/img/roomoption/Roption_minibar_icon_hover.png"></label>
							</span>
							<span id="roption8">
								<input type="checkbox" id="r_option8" name="r_o_option" value="08">
									<label for="r_option8" id="tag1"><img src="/resources/img/roomoption/Roption_wifi_icon2.png"></label>
									<label for="r_option8" id="tag1-1" style="display:none;"><img src="/resources/img/roomoption/Roption_wifi_icon_hover.png"></label>
							</span>
							<span id="roption9">
								<input type="checkbox" id="r_option9" name="r_o_option" value="09">
									<label for="r_option9" id="tag1"><img src="/resources/img/roomoption/Roption_tv_icon2.png"></label>
									<label for="r_option9" id="tag1-1" style="display:none;"><img src="/resources/img/roomoption/Roption_tv_icon_hover.png"></label>
							</span>
							<span id="roption10">
								<input type="checkbox" id="r_option10" name="r_o_option" value="10">
									<label for="r_option10" id="tag1"><img src="/resources/img/roomoption/Roption_computer_icon2.png"></label>
									<label for="r_option10" id="tag1-1" style="display:none;"><img src="/resources/img/roomoption/Roption_computer_icon_hover.png"></label>
							</span>
							<span id="roption11">
								<input type="checkbox" id="r_option11" name="r_o_option" value="11">
									<label for="r_option11" id="tag1"><img src="/resources/img/roomoption/Roption_refrigerator_icon2.png"></label>
									<label for="r_option11" id="tag1-1" style="display:none;"><img src="/resources/img/roomoption/Roption_refrigerator_icon_hover.png"></label>
							</span>
							<span id="roption12">
								<input type="checkbox" id="r_option12" name="r_o_option" value="12">
									<label for="r_option12" id="tag1"><img src="/resources/img/roomoption/Roption_hairdryer_icon2.png"></label>
									<label for="r_option12" id="tag1-1" style="display:none;"><img src="/resources/img/roomoption/Roption_hairdryer_icon_hover.png"></label>
							</span>
						</div>
						</td>
					</tr>
					<tr>
						<td>세부설명</td>
						<td colspan=3><textarea name="r_detail" id="detail"></textarea></td>
					</tr>
					<tr>
						<td> 대표 이미지 </td>
						<td>
							<input type="file" name="file" style="visibility: hidden;"><br>
							<img src="http://placehold.it/150x150" id="image" width=200 height=200><br>
						</td>
					</tr>
					<tr>
						<td width=100>추가이미지</td>
						<td width=150 height=150>
							<input type="file" name="files" accept="image/*" multiple>
							<div id="listFile"></div>
						</td>
					</tr>
				</table>
				<input type="submit" value="룸 등록">
				</form>	
				<h1>룸 목록</h1>
				<span id="total">( ${pm.totalCount} 건 )</span>
				<table id="tbl">
					<tr>
						<td>대표 이미지</td>
						<td>호 수</td>
						<td>방이름</td>
						<td>수용인원 수</td>
						<td>가격</td>
						<td>평점</td>
						<td>영업상태</td>
					</tr>
				<c:forEach items="${list}" var="vo">
					<tr class="row">
					<c:if test="${vo.r_image!=null}">
						<td><img src="/displayRoom?fileName=${vo.r_image}" id="image" width=150></td>
					</c:if>
					<c:if test="${vo.r_image==null}">
						<td><img src="http://placehold.it/150x120" id="image" width=150></td>
					</c:if>
						<td class="roomnum">${vo.r_roomnum}</td>
						<td>${vo.r_title}</td>
						<td>${vo.r_persons}</td>
						<td>${vo.r_price}</td>
						<td>${vo.r_grade}</td>
					<c:if test="${vo.r_status==1}">
						<td>영업중</td>
					</c:if>
					<c:if test="${vo.r_status==0}">
						<td>영업 대기</td>
					</c:if>
					</tr>
				</c:forEach>
				</table>
				<div id="pagination" style="padding:10px 0px 10px 0px; text-align:center;">
						<c:if test="${pm.prev}">
							<a href="${pm.startPage-1}">◀</a>
						</c:if>
						<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
							<c:if test="${cri.page==i}">
								<span class="active"><a href="${i}">${i}</a></span>
							</c:if>
							<c:if test="${cri.page!=i}">
								<span><a href="${i}">${i}</a></span>
							</c:if>
						</c:forEach>
						<c:if test="${pm.next}">
							<a href="${pm.endPage+1}">▶</a>
						</c:if>
					</div>
					
					<div id="darken-background">
						<div id="lightbox">
							  <div><img src="http://placehold.it/250x250" id="repimage" Style="width:450px;height:300px;"></div>
							  <div id="images"></div>
							  <div id="roptionB" style="text-align:center;">
									<span id="roption1">
										<input type="checkbox" id="Rr_option1" name="r_o_option1" value="01">
											<label for="Rr_option1" id="tag1"><img src="/resources/img/roomoption/Roption_coffemaker_icon2.png"></label>
											<label for="Rr_option1" id="tag1-1" style="display:none;"><img src="/resources/img/roomoption/Roption_coffemaker_icon_hover.png"></label>
									</span>
									<span id="roption2">
										<input type="checkbox" id="Rr_option2" name="r_o_option1" value="02">
											<label for="Rr_option2" id="tag1"><img src="/resources/img/roomoption/Roption_ketchen_icon2.png"></label>
											<label for="Rr_option2" id="tag1-1" style="display:none;"><img src="/resources/img/roomoption/Roption_ketchen_icon_hover.png"></label>
									</span>
									<span id="roption3">
										<input type="checkbox" id="Rr_option3" name="r_o_option1" value="03">
											<label for="Rr_option3" id="tag1"><img src="/resources/img/roomoption/Roption_shampoo_icon2.png"></label>
											<label for="Rr_option3" id="tag1-1" style="display:none;"><img src="/resources/img/roomoption/Roption_shampoo_icon_hover.png"></label>
									</span>
									<span id="roption4">
										<input type="checkbox" id="Rr_option4" name="r_o_option1" value="04">
											<label for="Rr_option4" id="tag1"><img src="/resources/img/roomoption/Roption_Bathtub_icon2.png"></label>
											<label for="Rr_option4" id="tag1-1" style="display:none;"><img src="/resources/img/roomoption/Roption_Bathtub_icon_hover.png"></label>
									</span>
									<span id="roption5">
										<input type="checkbox" id="Rr_option5" name="r_o_option1" value="05">
											<label for="Rr_option5" id="tag1"><img src="/resources/img/roomoption/Roption_airconditioner_icon2.png"></label>
											<label for="Rr_option5" id="tag1-1" style="display:none;"><img src="/resources/img/roomoption/Roption_airconditioner_icon_hover.png"></label>
									</span>
									<span id="roption6">
										<input type="checkbox" id="Rr_option6" name="r_o_option1" value="06">
											<label for="Rr_option6" id="tag1"><img src="/resources/img/roomoption/Roption_safebox_icon2.png"></label>
											<label for="Rr_option6" id="tag1-1" style="display:none;"><img src="/resources/img/roomoption/Roption_safebox_icon_hover.png"></label>
									</span>
									<span id="roption7">
										<input type="checkbox" id="Rr_option7" name="r_o_option1" value="07">
											<label for="Rr_option7" id="tag1"><img src="/resources/img/roomoption/Roption_minibar_icon2.png"></label>
											<label for="Rr_option7" id="tag1-1" style="display:none;"><img src="/resources/img/roomoption/Roption_minibar_icon_hover.png"></label>
									</span>
									<span id="roption8">
										<input type="checkbox" id="Rr_option8" name="r_o_option1" value="08">
											<label for="Rr_option8" id="tag1"><img src="/resources/img/roomoption/Roption_wifi_icon2.png"></label>
											<label for="Rr_option8" id="tag1-1" style="display:none;"><img src="/resources/img/roomoption/Roption_wifi_icon_hover.png"></label>
									</span>
									<span id="roption9">
										<input type="checkbox" id="Rr_option9" name="r_o_option1" value="09">
											<label for="Rr_option9" id="tag1"><img src="/resources/img/roomoption/Roption_tv_icon2.png"></label>
											<label for="Rr_option9" id="tag1-1" style="display:none;"><img src="/resources/img/roomoption/Roption_tv_icon_hover.png"></label>
									</span>
									<span id="roption10">
										<input type="checkbox" id="Rr_option10" name="r_o_option1" value="10">
											<label for="Rr_option10" id="tag1"><img src="/resources/img/roomoption/Roption_computer_icon2.png"></label>
											<label for="Rr_option10" id="tag1-1" style="display:none;"><img src="/resources/img/roomoption/Roption_computer_icon_hover.png"></label>
									</span>
									<span id="roption11">
										<input type="checkbox" id="Rr_option11" name="r_o_option1" value="11">
											<label for="Rr_option11" id="tag1"><img src="/resources/img/roomoption/Roption_refrigerator_icon2.png"></label>
											<label for="Rr_option11" id="tag1-1" style="display:none;"><img src="/resources/img/roomoption/Roption_refrigerator_icon_hover.png"></label>
									</span>
									<span id="roption12">
										<input type="checkbox" id="Rr_option12" name="r_o_option1" value="12">
											<label for="Rr_option12" id="tag1"><img src="/resources/img/roomoption/Roption_hairdryer_icon2.png"></label>
											<label for="Rr_option12" id="tag1-1" style="display:none;"><img src="/resources/img/roomoption/Roption_hairdryer_icon_hover.png"></label>
									</span>
									
									</div>
						      <table id="tbl2">
						      	<tr>
						      		<td>✔  호 수 : <span id="roomnum1"></span></td>
						      		<td>✔  방 이름 : <span id="title1"></span></td>
						      		<td>✔  최대 인원 수 : <span id="persons1"></span>명</td>
						      		<td>✔ 가 격 : <span id="price1"></span>원</td>
						      		
						      	</tr>
						      	<tr>
						      		<td>상세 설명 : <span id="detail1"></span></td>
						      	</tr>
						      	
						      </table>
						      <div>별점  :	<span id="star1"><img src="/resources/img/star/star0.png"></span>
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
						      
						      <script id="temp" type="text/x-handlebars-template">
								{{#each image}}
									<span><img src="/displayRoom?fileName={{r_i_images}}" Style="width:100px;height:100px;"></span>
								{{/each}}
							  </script>
												      
						      
						      <input type="button" id="btnClose" value="close">
					    </div>
					</div>
			</div>
		</div>
		
		<div id="footer"><jsp:include page="../footer.jsp" /></div>
	</div>
</body>
<script>
$("#star1").hide();$("#star3").hide();$("#star5").hide();$("#star7").hide();$("#star9").hide();
$("#star2").hide();$("#star4").hide();$("#star6").hide();$("#star8").hide();$("#star10").hide();$("#star11").hide();
$(":checkbox").css("display","none");
$("#darken-background").hide();
$("input:checkbox[name='r_o_option1']").prop("checked", false);

$("input[name=r_o_option]").on("click",function(){
	var tag1=$(this).parent().find("#tag1");
	var tag2=$(this).parent().find("#tag1-1");
	
	if($(this).is(":checked")==true){
		tag1.css("display","none");
		tag2.css("display","inline-block");
	}else{
		tag1.css("display","inline-block");
		tag2.css("display","none");
	}
});


$("#tbl").on("click",".row",function(){
  	$("#darken-background").show();
  });



$(frm).submit(function(e){
	e.preventDefault();
		var r_id="${c_id}";
		var r_roomnum=$("#roomnum").val();
		var r_title=$("#title").val();
		var r_detail=$("#detail").val();
		var r_persons=$("#persons").val();
		var r_price=$("#price").val();
		if(!confirm("룸을 새로 등록하시겠습니까?")) return;
			if(r_roomnum=="" || r_title=="" || r_detail=="" || r_persons=="" ||r_price==""){
				alert("빈 공란을 입력해주세요.");
			}else{
				if($("input:checkbox[name='r_o_option']").is(":checked")==false){
					alert("방 옵션을 1개이상 선택해주세요.");
				}else{
					$.ajax({
						type:"get",
						url:"/company/readroom",
						data:{"r_id":r_id,"r_roomnum":r_roomnum},
						success:function(data){
							if(data==1){
								alert("이미 존재하는 룸입니다.");
							}else{
								frm.submit();
							}
						}
					});
				}
			}	
	});

$("#tbl").on("click", ".row", function() {
	$("input[name=r_o_option1]").prop("checked",false);
	$("input[name=r_o_option1]").parent().find("#tag1").css("display","inline-block");
	$("input[name=r_o_option1]").parent().find("#tag1-1").css("display","none");

	$("#star1").hide();$("#star3").hide();$("#star5").hide();$("#star7").hide();$("#star9").hide();
	$("#star2").hide();$("#star4").hide();$("#star6").hide();$("#star8").hide();$("#star10").hide();$("#star11").hide();
	var r_i_roomnum=$(this).find(".roomnum").html();
	var r_i_id="${c_id}";
	$.ajax({
		type:"get",
		url:"/company/getroomread",
		data:{"r_i_id":r_i_id,"r_i_roomnum":r_i_roomnum},
		success:function(data){
			var temp=Handlebars.compile($("#temp").html());
			 $("#images").html(temp(data));
			 $("#roomnum1").html(data.read.r_roomnum);
			 $("#title1").html(data.read.r_title);
			 $("#persons1").html(data.read.r_persons);
			 $("#price1").html(data.read.r_price);
			 $("#roomnum1").html(data.read.r_roomnum);
			 $("#detail1").html(data.read.r_detail);
			 $("#repimage").attr("src", "/displayRoom?fileName="+data.read.r_image);
			 if(data.read.r_grade==0){
				 $("#star1").show();
			 }else if(0<data.read.r_grade && data.read.r_grade<=0.5){
				 $("#star2").show();
			 }else if(0.5<data.read.r_grade && data.read.r_grade<=1){
				 $("#star3").show();
			 }else if(1<data.read.r_grade && data.read.r_grade<=1.5){
				 $("#star4").show();
			 }else if(1.5<data.read.r_grade && data.read.r_grade<=2){
				 $("#star5").show();
			 }else if(2<data.read.r_grade && data.read.r_grade<=2.5){
				 $("#star6").show();
			 }else if(2.5<data.read.r_grade && data.read.r_grade<=3){
				 $("#star7").show();
			 }else if(3<data.read.r_grade && data.read.r_grade<=3.5){
				 $("#star8").show();
			 }else if(3.5<data.read.r_grade && data.read.r_grade<=4){
				 $("#star9").show();
			 }else if(4<data.read.r_grade && data.read.r_grade<=4.5){
				 $("#star10").show();
			 }else if(4.5<data.read.r_grade && data.read.r_grade<=5){
				 $("#star11").show();
			 }
			//룸 옵션 읽기	
				var option1=[];
				    $.each(data.option, function(index, option){
					  	option1.push(option.r_o_option);
				   });
				    $("input[name=r_o_option1]").each(function(index, item){
				    	for(var i=0; i<option1.length; i++){
					    	if($(this).val()==option1[i]){
					    		var tag1=$(this).parent().find("#tag1");
								var tag2=$(this).parent().find("#tag1-1");
								
								tag1.css("display","none");
								tag2.css("display","inline-block");
					    		$(this).prop("checked",true);
					    	}
				    	}
				    });
		}
	});
});


$("#btnImage").on("click", function() {
	$(frm.files).click();
});

$(frm.files).change(function() {
	var files = $(frm.files)[0].files;
	var html = "";
	$.each(files, function(index, file) {
		html += "<img src='" + URL.createObjectURL(file) + "'>";
	});
	$("#listFile").html(html);
});

$("#image").click(function() {
	$(frm.file).click();
});

$(frm.file).on("change", function() {
	var file = $(frm.file)[0].files[0];
	$("#image").attr("src", URL.createObjectURL(file));
});

$("#pagination").on("click","a",function(e){
	e.preventDefault();
	var page=$(this).attr("href");
	var c_id="${c_id}";
	location.href="roominsert?c_id="+c_id+"&&page="+page;
});

$("#tbl").on("click", ".row", function() {
	$("#darken-background").css("display", "block"); //팝업 뒷배경 display block
	$("#lightbox").css("display", "block"); //팝업창 display block
	$("body").css("overflow", "hidden");//body 스크롤바 없애기

});
$("#btnClose").on("click", function(event) {
	$("#darken-background").css("display", "none"); //팝업창 뒷배경 display none
	$("#lightbox").css("display", "none"); //팝업창 display none
	$("body").css("overflow", "auto");//body 스크롤바 생성
});
$("input[name=r_o_option1]").on("click",function(){
	var tag1=$(this).parent().find("#tag1");
	var tag2=$(this).parent().find("#tag1-1");
	
	if($(this).is(":checked")==true){
		tag1.css("display","none");
		tag2.css("display","inline-block");
	}else{
		tag1.css("display","inline-block");
		tag2.css("display","none");
	}
});
</script>
</html>