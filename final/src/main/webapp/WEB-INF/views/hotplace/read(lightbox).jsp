<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여행의 설렘 TOURSUM !</title>
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
   width: 1250px;
   height: 1500px;
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

#readtitle {
   position: absolute;
   color: white;
   font-size: 30px;
   top: 39%;
   left: 3%;
}

#readimage {
   border-radius: 5px 5px 0px 0px;
   width: 100%;
   height: 700px;
}

#btnClose {
   background: none;
   outline: none;
   cursor: pointer;
   border: none;
   position: absolute;
   top: 10px;
   right: -50px;
}
#btnprev,
#btnnext {
   border:none;
   outline:none;
   background:none;
   cursor:pointer;
}

#btnprev {
   position:absolute;
   left:-55px;
   top:22%;
}

#btnnext {
   position:absolute;
   right:-55px;
   top:22%;
}
.userimages {
   width: 70px;
   height: 70px;
   border-radius: 50%;
   text-align: center;
}
#likeuserlist span {
	padding:10px;
	float:left;
	margin-top:5px;
}
#hotplace_tag_lightbox button{
	border:none;
	outline:none;
	cursor:pointer;
	padding:5px;
	border-radius:8px;
	margin-right:5px;
}

#userpagination>div {
	width:8px;
	height:8px;
	border-radius:50%;
	border:0.5px solid gray;
	display:inline-block;
	margin-right:5px;
}
</style>
</head>
<body>
	<div id="darken-background">
      <div id="lightbox">
         <img id="readimage" src="http://placehold.it/150x150">
         <button id="btnClose"><img src="/resources/img/hotplace/close_icon2.png" width=30></button>
		 <div style="position:absolute; top:37%; left:3%; display:inline-block;" id="hotplace_tag_lightbox">
			<button id="tag1"></button>
			<button id="tag2"></button>
		 </div>
			<div id="readtitle"></div>
         <div id="readdetail" style="display:inline-block; text-align:left; position:absolute; left:3%; top:42%; color:white;"></div>
         <button id="btnprev"><img src="/resources/img/hotplace/prev_icon3.png" width=40/></button>
         <button id="btnnext"><img src="/resources/img/hotplace/next_icon3.png" width=40/></button>
         <div id="readcontent" style="display:inline-block; position:relative; width:100%; height:790px;">
         	<div style="display:inline-block; position:absolute; left:70px; bottom:5px; border-radius:5px 5px 5px 5px;">
				<span id="top_x_div" style="float:left;"></span>
				<span id="donutchart" style="float:left;"></span>
         	</div>
            <div id="map" style="width:800px; height:320px; position:absolute; top:55px; left:10px; border-radius:5px 5px 5px 5px;"></div>
            <div style="position:relative; width:380px; height:320px; left:67.3%; top:55px;">
	            <button id="likeuserprev" style="background:none; outline:none; z-index:10002; border:none; position:absolute; left:-18px; top:140px; cursor:pointer;"><img src="/resources/img/hotplace/prev_icon2.png" width=30 /></button>
	            <div id="likeuserlist" style="position:absolute; height:320px; width:380px; padding-left:10px; padding-top:54px; border-radius:5px 5px 5px 5px; border:0.5px solid #e9e9e9;">
	            	
	            </div>
	            <div id="userpagination" style="position:absolute; top:280px; left:50%; transform:translate(-48%,0); "></div>
	            <button id="likeusernext" style="background:none; outline:none; border:none; position:absolute; right:-18px; top:140px; cursor:pointer;"><img src="/resources/img/hotplace/next_icon2.png" width=30 /></button>
            </div>
            <img src="/resources/img/hotplace/1.png" width=220 style="position:absolute; left:10px; top:8px;"/>
            <img src="/resources/img/hotplace/refresh_icon.png" class="maprefresh" width=20 style="position:absolute; left:215px; top:19px; cursor:pointer;"/>
            <img src="/resources/img/hotplace/2.png" width=222 style="position:absolute; right:188px; top:8px;"/>
            <img src="/resources/img/hotplace/3.png" width=220 style="position:absolute; left:10px; top:51%;"/>
		</div>
      </div>
   </div>
</body>
<script>
	var userlikelist = [];
	var userpage = 1;
	var usermaxpage = 0;
	var userperpage = 8;
	var userstartpage=1;
	var userendpage = userperpage;
	var address;
	var detail;
	var imagepage = 0;
	var images = [];
	
	
	//맵새로고침
	$(".maprefresh").on("click",function(){
		getmap();
	});
	
	//좋아요유저 넘기기(next)
	$("#likeusernext").on("click",function(){
		if(userlikelist.length > userperpage){
			userpage++;
			getnowpage();
			var html="";
			userstartpage = userstartpage + userperpage;
			userendpage = userendpage + userperpage;
			if(userlikelist.length>=userendpage){
				$("#likeuserlist").html("");
				for(var p=userstartpage-1; p<userendpage;p++){
					if(userlikelist[p].u_image==null || userlikelist[p].u_image==""){
						if(userlikelist[p].u_gender=='male'){
							html += "<span><img class='userimages' src='/resources/img/user/profileM.png'/></span>";
						}else{
							html += "<span><img class='userimages' src='/resources/img/user/profileF.png'/></span>";
						}
					}else{
						html += "<span><img class='userimages' src='/hotplace/userdisplay?fileName="+userlikelist[p].u_image+"'/></span>";	
					}
				}
				$("#likeuserlist").html(html);
			}else{
				if(userlikelist.length<userstartpage){
					 userstartpage = 1;
					 userendpage = userperpage;
					 userpage = 1;
					 getnowpage();
					 for(var p=userstartpage-1; p<userendpage;p++){
							if(userlikelist[p].u_image==null || userlikelist[p].u_image==""){
								if(userlikelist[p].u_gender=='male'){
									html += "<span><img class='userimages' src='/resources/img/user/profileM.png'/></span>";
								}else{
									html += "<span><img class='userimages' src='/resources/img/user/profileF.png'/></span>";
								}
							}else{
								html += "<span><img class='userimages' src='/hotplace/userdisplay?fileName="+userlikelist[p].u_image+"'/></span>";	
							}
						}
					 $("#likeuserlist").html(html);
				}else{
					$("#likeuserlist").html("");
					for(var p=userstartpage-1; p<userlikelist.length;p++){
						if(userlikelist[p].u_image==null || userlikelist[p].u_image==""){
							if(userlikelist[p].u_gender=='male'){
								html += "<span><img class='userimages' src='/resources/img/user/profileM.png'/></span>";
							}else{
								html += "<span><img class='userimages' src='/resources/img/user/profileF.png'/></span>";
							}
						}else{
							html += "<span><img class='userimages' src='/hotplace/userdisplay?fileName="+userlikelist[p].u_image+"'/></span>";	
						}
					}
					$("#likeuserlist").html(html);
				}
				
			}
			
		}
	});
	//좋아요유저 넘기기(prev)
	$("#likeuserprev").on("click",function(){
		if(userlikelist.length > userperpage){
			$("#likeuserlist").html("");
			var html="";
			userstartpage = userstartpage - userperpage;
			userendpage = userendpage - userperpage;
			if(userstartpage <= 0){
				userpage = usermaxpage;
				getnowpage();
				var userlikelistlength=userlikelist.length-1;
				userstartpage = (parseInt(userlikelistlength/userperpage)*userperpage)+1;
				userendpage = userstartpage+7;
				for(var p=userstartpage-1; p<userlikelist.length; p++){
					if(userlikelist[p].u_image==null || userlikelist[p].u_image==""){
						if(userlikelist[p].u_gender=='male'){
							html += "<span><img class='userimages' src='/resources/img/user/profileM.png'/></span>";
						}else{
							html += "<span><img class='userimages' src='/resources/img/user/profileF.png'/></span>";
						}
					}else{
						html += "<span><img class='userimages' src='/hotplace/userdisplay?fileName="+userlikelist[p].u_image+"'/></span>";	
					}
					$("#likeuserlist").html(html);
				}
			}else{
				userpage--;
				getnowpage();
				for(var p=userstartpage-1; p<userendpage;p++){
					if(userlikelist[p].u_image==null || userlikelist[p].u_image==""){
						if(userlikelist[p].u_gender=='male'){
							html += "<span><img class='userimages' src='/resources/img/user/profileM.png'/></span>";
						}else{
							html += "<span><img class='userimages' src='/resources/img/user/profileF.png'/></span>";
						}
					}else{
						html += "<span><img class='userimages' src='/hotplace/userdisplay?fileName="+userlikelist[p].u_image+"'/></span>";	
					}
				}
				$("#likeuserlist").html(html);
			}
		}
	});
	//read사진넘기기
	$("#btnnext").on(
			"click",
			function() {
				var imagelength = images.length;
				imagepage++;
				if (imagepage >= imagelength) {
					imagepage = 0;
					$("#readimage").attr("src",
							"/hotplace/display?fileName=" + images[imagepage]);
				} else {
					$("#readimage").attr("src",
							"/hotplace/display?fileName=" + images[imagepage]);
				}
			});
	$("#btnprev").on(
			"click",
			function() {
				var imagelength = images.length;
				imagepage = imagepage - 1;
				if (imagepage < 0) {
					imagepage = imagelength - 1;
					$("#readimage").attr("src",
							"/hotplace/display?fileName=" + images[imagepage]);
				} else {
					$("#readimage").attr("src",
							"/hotplace/display?fileName=" + images[imagepage]);
				}
			});

	
	//////read(라이트박스)//////
	$("#divlist, #likelist-area")
			.on(
					"click",".div_hotplace_list",
					function(event) {
						usermaxpage = 0;
						var src = $(this).find(".mainimage").attr("src");
						var title = $(this).find(".mainimage").attr("title");
						x = $(this).find(".mainimage").attr("x");
						y = $(this).find(".mainimage").attr("y");
						address = $(this).find(".mainimage").attr("address");
						detail = $(this).find(".mainimage").attr("detail");
						  tag1 = $(this).find(".mainimage").attr("tag1");
		                  tag2 = $(this).find(".mainimage").attr("tag2");
		                  $("#readimage").attr("src", src);
		                  $("#readtitle").html(title);
		                  $("#readdetail").html(detail);
		                  
		                  if(tag1=="01") {
		                	  $("#tag1").text("#힐링");
		                  }else if(tag1=="02") {
		                	  $("#tag1").text("#헬스케어");
		                  }else if(tag1=="03") {
		                	  $("#tag1").text("#익사이팅");
		                  }else if(tag1=="04") {
		                	  $("#tag1").text("#나홀로여행");
		                  }else if(tag1=="05") {
		                	  $("#tag1").text("#가족과함께");
		                  }else if(tag1=="06") {
		                	  $("#tag1").text("#연인과함께");
		                  }else if(tag1=="07") {
		                	  $("#tag1").text("#친구와함께");
		                  }else if(tag1=="08") {
		                	  $("#tag1").text("#먹방");
		                  }else if(tag1=="10") {
		                	  $("#tag1").text("#도심속여행");
		                  }else if(tag1=="11") {
		                	  $("#tag1").text("#나만아는");
		                  }else if(tag1=="12") {
		                	  $("#tag1").text("#야경");
		                  }else if(tag1=="13") {
		                	  $("#tag1").text("#교육");
		                  }
		                  
		                  if(tag2=="01") {
		                	  $("#tag2").text("#힐링");
		                  }else if(tag2=="02") {
		                	  $("#tag2").text("#헬스케어");
		                  }else if(tag2=="03") {
		                	  $("#tag2").text("#익사이팅");
		                  }else if(tag2=="04") {
		                	  $("#tag2").text("#나홀로여행");
		                  }else if(tag2=="05") {
		                	  $("#tag2").text("#가족과함께");
		                  }else if(tag2=="06") {
		                	  $("#tag2").text("#연인과함께");
		                  }else if(tag2=="07") {
		                	  $("#tag2").text("#친구와함께");
		                  }else if(tag2=="08") {
		                	  $("#tag2").text("#먹방");
		                  }else if(tag2=="10") {
		                	  $("#tag2").text("#도심속여행");
		                  }else if(tag2=="11") {
		                	  $("#tag2").text("#나만아는");
		                  }else if(tag2=="12") {
		                	  $("#tag2").text("#야경");
		                  }else if(tag2=="13") {
		                	  $("#tag2").text("#교육");
		                  }
						//서브사진들 가져오기
						$.ajax({
							type : "get",
							url : "readimages",
							dataType : "json",
							data : {
								"h_x" : x,
								"h_y" : y
							},
							success : function(data) {
								for (var i = 0; i < data.length; i++) {
									images.push(data[i]);
								}
							}
						});

						$("#darken-background")
								.css(
										{
											"top" : (($(window).height() - $(
													"#darken-background")
													.outerHeight()) / 2 + $(
													window).scrollTop())
													+ "px",
											"left" : (($(window).width() - $(
													"#darken-background")
													.outerWidth()) / 2 + $(
													window).scrollLeft())
													+ "px"
										//팝업창을 가운데로 띄우기 위해 현재 화면의 가운데 값과 스크롤 값을 계산하여 팝업창 CSS 설정
										});
						$("#darken-background").css("display", "block"); //팝업 뒷배경 display block
						$("#lightbox").css("display", "block"); //팝업창 display block

						$("body").css("overflow", "hidden");//body 스크롤바 없애기

						getlikeuserlist();
						getmap();
						getagechart();
						getsexchart();
						
					});
	$("#btnClose").on("click", function(event) {
		userlikelist = [];
		$("#likeuserlist").html("");
		images = [];
		imagepage = 0;
		userstartpage = 1;
		userendpage = userperpage;
		usermaxpage = 0;
		userpage = 1;
		
		$("#darken-background").css("display", "none"); //팝업창 뒷배경 display none
		$("#lightbox").css("display", "none"); //팝업창 display none
		$("body").css("overflow", "auto");//body 스크롤바 생성
	});

	//특정추천명소 좋아요누른 유저 출력
	function getlikeuserlist() {
		$.ajax({
			type : "get",
			url : "likeuserlist",
			dataType : "json",
			data : {
				"h_x" : x,
				"h_y" : y
			},
			success : function(data) {
				if(parseInt(data.length%userperpage)==0){
					usermaxpage = parseInt(data.length/userperpage);
				}else{
					usermaxpage = (parseInt(data.length/userperpage))+1;
				}
				var html = "";
				for (var i = 0; i < data.length; i++) {
					userlikelist.push(data[i]);
				}
				if(userlikelist.length==0){
					html = "<div style='margin-top:80px; font-size:14.5px;'>좋아요 누른 유저가 한명도 없습니다.<br>처음으로 좋아요를 눌러보세요!</div>";
				}else{
					if(userlikelist.length<8){
						for(var n = 0; n < userlikelist.length; n++){
							if(userlikelist[n].u_image==null || userlikelist[n].u_image==""){
								if(userlikelist[n].u_gender=='male'){
									html += "<span><img class='userimages' src='/resources/img/user/profileM.png'/></span>";
								}else{
									html += "<span><img class='userimages' src='/resources/img/user/profileF.png'/></span>";
								}
								
							}else{
								html += "<span><img class='userimages' src='/hotplace/userdisplay?fileName="+userlikelist[n].u_image+"'/></span>";	
							}
						}	
					}else{
						for(var n = 0; n < 8; n++){
							if(userlikelist[n].u_image==null || userlikelist[n].u_image==""){
								if(userlikelist[n].u_gender=='male'){
									html += "<span><img class='userimages' src='/resources/img/user/profileM.png'/></span>";
								}else{
									html += "<span><img class='userimages' src='/resources/img/user/profileF.png'/></span>";
								}
								
							}else{
								html += "<span><img class='userimages' src='/hotplace/userdisplay?fileName="+userlikelist[n].u_image+"'/></span>";	
							}
						}	
					}
					
				}
				$("#likeuserlist").html(html);
				getnowpage();
			}
		});
	}
	
	//좋아요유저현제페이지출력
	function getnowpage(){
		var html = "";
		for(var i=1; i<=usermaxpage; i++){
			if(userpage==i){
				html += "<div style='background:red; width:13px:height:13px' page="+i+"></div>";
			}else{
				html += "<div page="+i+"></div>";
			}
		}
		$("#userpagination").html(html);
	}
	
	
////////////////////////////////////////////////////////////////////////////////////	
	
	
	
	//지도촐력
	function getmap() {
		
		$.ajax({
			type:"get",
			url:"hotplacehotel",
			dataType:"json",
			data:{"c_x":x,"c_y":y},
			success:function(data){
				
				var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
				mapOption = {
					center : new kakao.maps.LatLng(y, x), // 지도의 중심좌표
					level : 3
				// 지도의 확대 레벨
				};

				var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
				
				var positions = [];
				for(var i=0; i<data.length; i++){
					var test = {};
					test.content = "<div>"+data[i].c_name+"</div>";
					test.latlng = new kakao.maps.LatLng(data[i].c_y, data[i].c_x);
					test.c_id = data[i].c_id;
					positions.push(test);
				}
				var no = 0;
				for (var i = 0; i < positions.length; i++) {
					no = i;
					// 마커를 생성합니다
						var marker = new kakao.maps.Marker({
						map : map, // 마커를 표시할 지도
						position : positions[i].latlng
					// 마커의 위치
					});

					// 마커에 표시할 인포윈도우를 생성합니다 
					var infowindow = new kakao.maps.InfoWindow({
						content : positions[i].content
					// 인포윈도우에 표시할 내용
					});

					// 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
					// 이벤트 리스너로는 클로저를 만들어 등록합니다 
					// for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
					kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(
							map, marker, infowindow));
					kakao.maps.event.addListener(marker, 'mouseout',
							makeOutListener(infowindow));
					
					// 마커에 클릭이벤트를 등록합니다
					kakao.maps.event.addListener(marker, 'click', function() {
					      // 마커 위에 인포윈도우를 표시합니다
						location.href = "/stay/read?c_id=" + positions[no].c_id;
					});
				}
				
				

				// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
				function makeOverListener(map, marker, infowindow) {
					return function() {
						infowindow.open(map, marker);
					};
				}

				// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
				function makeOutListener(infowindow) {
					return function() {
						infowindow.close();
					};
				}
			}
		});
		
	}
	



	function getagechart() {
		//연령벌 차트
		google.charts.load('current', {
			'packages' : [ 'bar' ]
		});
		google.charts.setOnLoadCallback(drawStuff);

		function drawStuff() {
			$
					.ajax({
						type : "get",
						url : "agechart",
						dataType : "json",
						data : {
							"h_x" : x,
							"h_y" : y
						},
						success : function(result) {
							var data = new google.visualization.arrayToDataTable(
									result);
							var options = {
								width : 270,
								height : 270,
								legend : {
									position : 'none'
								},
								chart : {
									title : '',
									subtitle : ''
								},
								bar : {
									groupWidth : "70%"
								}
							};

							var chart = new google.charts.Bar(document
									.getElementById('top_x_div'));
							// Convert the Classic options to Material options.
							chart.draw(data, google.charts.Bar
									.convertOptions(options));
						}
					});

		}
	}

	//성별차트
	function getsexchart() {
		google.charts.load("current", {
			packages : [ "corechart" ]
		});
		google.charts.setOnLoadCallback(drawChart);

		function drawChart() {
			$.ajax({
				type : "get",
				url : "sexchart",
				dataType : "json",
				data : {
					"h_x" : x,
					"h_y" : y
				},
				success : function(result) {
					var data = google.visualization.arrayToDataTable(result);

					var options = {
						width : 600,
						height : 300,
						pieHole : 0.4
					};

					var chart = new google.visualization.PieChart(document
							.getElementById('donutchart'));
					chart.draw(data, options);
				}
			});

		}
	}

	$(".hover").mouseleave(function() {
		$(this).removeClass("hover");
	});

</script>
</html>