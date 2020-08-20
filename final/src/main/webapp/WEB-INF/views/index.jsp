<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여행의 설렘 TOURSUM !</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>   
<link rel="shortcut icon" type="image⁄x-icon" href="/resources/img/title_logo.png">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/style.css"/>
<style>
.usertaglistimage{
   width:260px;
   height:180px;
   margin-bottom:15px;
}
#latelyhotplace{
      position:relative;
      margin-top:20px;
      height:450px;
}
.latelyhotplace1 img, 
.latelyhotplace2 img,
.latelyhotplace3 img, 
.latelyhotplace4 img {
   width:190px;
   height:190px;
   border-radius:50%;
}
.latelyhotplace1 {
   position:absolute;
   top:50%;
   left:23%;
   transform:translate(0,-50%);
   z-index:2;
}
.latelyhotplace2 {
   position:absolute;
   top:50%;
   right:23%;
   transform:translate(0,-50%);
   z-index:2;
}
.latelyhotplace3 {
   position:absolute;
   top:50%;
   left:8%;
   transform:translate(0,-50%);
}
.latelyhotplace4 {
   position:absolute;
   top:50%;
   right:8%;
   transform:translate(0,-50%);
}
.latelyhotplacecenter{
   position:absolute;
   left:50%;
   top:39%;
   transform:translate(-50%,-50%);
   z-index:3;
}
.latelyhotplacecenter img {
   width:290px;
   height:290px;
   border-radius:50%;
}

.hotplace_tag_lightbox {
   border:none;
   outline:none;
   cursor:pointer;
   padding:5px;
   border-radius:8px;
   margin-right:5px;
}   
</style>
</head>
<body>
   <c:if test="${kakaoinfo==0}">
      <jsp:include page="user/mypage/kakaolightbox.jsp"/>
   </c:if>
   <jsp:include page="floatmenu.jsp"/>
   <jsp:include page="sidebar.jsp"/>
   <button type="button" name="button" class="ac-sub-go-top" style="cursor:pointer;">위로</button>
   <div id="page">
      <div id="header" ><jsp:include page="header.jsp"/></div>
      <div id="menu"><jsp:include page="menu.jsp"/></div>
      <div id="container">
         <div id="div_container_area1"> <!-- 퀵검색, 테마 -->
            <div id="div_container_quick">
               <div><p>고객님,<br><strong>어떤 여행을 꿈꾸시나요?</strong></p></div>
               <div class="tapmenu">
                  <ul class="tabs" >
                     <li class="tab-link current" data-tab="tab-1"><b>항공</b></li>
                     <li class="tab-link" data-tab="tab-2"><b>숙소</b></li>
                  </ul>
                  <!-- 항공 퀵 검색 -->
                  <div id="tab-1" class="tab-content current" >
                  	<div style="text-align:center; margin-top:20px;">
						<input type="radio" id="roundtrip" name="air" value="편도" checked>
						<label for="roundtrip">왕복</label>
						<input type="radio" id="oneway" name="air" value="왕복">
						<label for="oneway">편도</label>
					</div>
                     <div id="tab-3" class="tab-content2 current2">
                        <div id="tab-3-1">
                           <input type="text" placeholder="출발지">
                           <img src="/resources/img/container/container_icon.png">
                           <input type="text" placeholder="도착지" ><br>
                        </div>
                        <div id="tab-3-2">
                           <input type="text" class="startdate" placeholder="가는날">
                           <input type="text" class="enddate" placeholder="오는날">
                        </div>
                        <div id="tab-3-3">
                           <input type="text" class="airpersons1" placeholder="인원선택">
                           <div class="aircount1">
                              <h5>인원</h5>
                              <div>
                                 <div>
                                    <span>성인</span>
                                    <button>-</button>
                                    <input type="text" value="1" readonly>
                                    <button>+</button>
                                 </div>
                                 <div>
                                    <span>아동</span>
                                    <button>-</button>
                                    <input type="text" value="1" readonly>
                                    <button>+</button>
                                 </div>
                                 <div>
                                    <button id="btn">선택완료</button>
                                 </div>
                              </div>
                           </div>
                        </div>
                        <div id="tab-3-4">
                           <input type="button" value="항공권 검색">
                        </div>
                     </div>
                  </div>
                  <!-- 숙박 퀵 검색 -->
                  <div id="tab-2" class="tab-content">
                     <div id="tab-2-1">
                        <input type="text" placeholder="지역선택"
                        onfocus="this.placeholder=''" onblur="this.placeholder='지역선택'">
                     </div>
                     <div id="tab-2-2">
                        <input type="text" class="placedate" placeholder="체크인 / 체크아웃"
                        onfocus="this.placeholder=''" onblur="this.placeholder='체크인 / 체크아웃'">
                     </div>
                     <div id="tab-2-3">
                        <input type="text" class="staypersons" placeholder="인원선택"
                        onfocus="this.placeholder=''" onblur="this.placeholder='인원선택'" >
                        <div class="staycount">
                           <h5>인원</h5>
                           <div>
                              <div>
                                 <span>성인</span>
                                 <button>-</button>
                                 <input type="text" value="1" readonly>
                                 <button>+</button>
                              </div>
                              <div>
                                 <span>아동</span>
                                 <button>-</button>
                                 <input type="text" value="1" readonly>
                                 <button>+</button>
                              </div>
                              <div>
                                 <button id="btn">선택완료</button>
                              </div>
                           </div>
                        </div>
                     </div>
                     <div id="tab-2-4">
                        <input type="button" value="숙소 검색">
                     </div>
                  </div>
               </div>
            </div>
            <div id="div_container_tema">
               <div id="wrapper">
                  <div id="slider-wrap">
                     <ul id="slider">
                        <li>
                           <div>
                           </div> <img src="/resources/img/slide/1.jpg">
                        </li>
                        <li>
                           <div>
                           </div> <img src="/resources/img/slide/2.jpg">
                        </li>
                        <li>
                           <div>
                           </div> <img src="/resources/img/slide/3.jpg">
                        </li>
                        <li>
                           <div>
                           </div> <img src="/resources/img/slide/4.jpg">
                        </li>
                        <li>
                           <div>
                           </div> <img src="/resources/img/slide/5.jpg">
                        </li>
                     </ul>
                     <!--controls-->
                     <div class="btns" id="next">
                        <i class="fa fa-arrow-right"></i>
                     </div>
                     <div class="btns" id="previous">
                        <i class="fa fa-arrow-left"></i>
                     </div>
                     <div id="counter"></div>
                     <div id="pagination-wrap">
                        <ul>
                        </ul>
                     </div>
                     <!--controls-->
                  </div>
               </div>
            </div>
         </div>
         <c:if test="${u_id!=null }">    
	         <div id="div_container_area2" style="padding-top:80px;padding-bottom:40px">
	            <div style="margin-left:20px"><h2>고객님만을 위한 추천여행</h2></div>
	            <div id="userrecommendlist" style="margin:auto;margin-top:20px;"></div>
	         </div>
         </c:if>
         
         <!-- 숙소 예약,결제많은순 start ---------------------------------------------------->
         <div id="div_container_area3"> 
         
         	<div id="first_area">
         		<img src="/resources/img/area3_sample.jpg" width=500 height=500/>
         		<div style="font-size:30px; font-weight:bold; padding-left:10px;">Hotel name</div>
         		<div style="padding-left:10px; color:gray;">제주</div>
         		<div style="font-size:25px; font-weight:bold; margin-top:25px; text-align:right; padding-right:10px;">49,900 원~</div>
         	</div>
         	
         	<div id="area3_title"><img src="/resources/img/area3_title.png"/></div>
         	<div id="second_area">
         		<img src="/resources/img/area3_sample2.jpg" width=150 height=150/>
         		<div style="position:absolute; left:160px; top:10px; font-size:23px; font-weight:bold;">Hotel name</div>
         		<div style="position:absolute; left:160px; top:40px; color:gray;">부산</div>
         		<div style="position:absolute; bottom:10px; right:10px; font-weight:bold;">29,900 원~</div>
         	</div>
         	
         	<div id="third_area">
         		<img src="/resources/img/area3_sample2.jpg" width=150 height=150/>
         		<div style="position:absolute; left:160px; top:10px; font-size:23px; font-weight:bold;">Hotel name</div>
         		<div style="position:absolute; left:160px; top:40px; color:gray;">부산</div>
         		<div style="position:absolute; bottom:10px; right:10px; font-weight:bold;">29,900 원~</div>
         	</div>
         	
         </div>
         <!-- 숙소 예약,결제많은순 end ------------------------------------------------------>
         
         <div id="div_container_area4"> <!-- 땡처리 -->
         
         </div>
         
         <div id="div_container_area5">
            <div style="margin-left:20px"><h2>주목! 요즘HOT한 여행지</h2></div>
            <div id="latelyhotplace"></div> 
         </div>
      </div>
      <div id="footer"><jsp:include page="footer.jsp"/></div>
   </div>
</body>
<script>
   var u_id="${u_id}";
   var u_k_id="${u_k_id}";
   var userrecommendlist=[];
   $(".staycount").hide();
   $(".aircount1").hide();
   $(".aircount2").hide();
   
   $("#oneway").click(function(){
	   $(".enddate").hide();
	   $(".startdate").css("width", "331");
   });
   
   $("#roundtrip").click(function(){
	   $(".startdate").css("width", "150");
	   $(".enddate").show();
   });
    
   usertaglist();
   latelyhotplace();
    $.ajax({
    	type:"get",
    	url:"/user/mypage/read",
    	data:{"u_id":u_id,"u_k_id":u_k_id},
    	success:function(data){
    		if(data.read.u_status==1){
    			alert("관리자에 의해 차단 된 아이디입니다.");
    			location.href="/user/login"
    		}
    	}
    });

   //요즘핫한지역
   function latelyhotplace(){
      $.ajax({
         type:"get",
         url:"/hotplace/latelyhotplace",
         dataType:"json",
         success:function(data){
            
                  var html = "";
                  for (var i = 0; i < data.length; i++) {
                     if(i==0){
                        html += "<div class='latelyhotplacecenter'>";
                        html += "<img src='/resources/img/hotplace/first-class.png' style='width:100px;height:100px;position:absolute;'/>";
                        html += "<a href='/hotplace/list#"+data[i].h_x+"|"+data[i].h_y+"'><img src='/hotplace/display?fileName="
                              + data[i].h_image
                              + "'  x='"
                              + data[i].h_x
                              + "' y='" + data[i].h_y + "'/></a>";
                        html += "<div style='text-align:center;'>"+data[i].h_title+"</div>";
                        html += "</div>";
                     }else{
                        html += "<div class='latelyhotplace"+i+"'>";
                        html += "<a href='/hotplace/list#"+data[i].h_x+"|"+data[i].h_y+"'><img src='/hotplace/display?fileName="
                              + data[i].h_image
                              + "'  x='"
                              + data[i].h_x
                              + "' y='" + data[i].h_y + "'/></a>";
                        html += "<div style='text-align:center'>"+data[i].h_title+"</div>";   
                        html += "</div>";
                     }
                     
                  }
                  $("#latelyhotplace").html(html);
               }
            });
   }

   //특정유저추천 여행지
   function usertaglist() {
      $
            .ajax({
               type : "get",
               url : "/hotplace/usertaglist",
               dataType : "json",
               data : {
                  "u_id" : u_id,
                  "u_k_id" : u_k_id
               },
               success : function(data) {
                  var html = "";
                  var tag1 = 0;
                  var tag2 = 0;
                  for (var i = 0; i < data.length; i++) {
                     userrecommendlist.push(data[i]);
                  }

                  for (var i = 0; i < 4; i++) {
                     tag1 = userrecommendlist[i].h_tag1;
                     tag2 = userrecommendlist[i].h_tag2;
                     html += "<div style='float:left; margin:20px;' class=''>";
                     html += "<a href='/hotplace/list#"+userrecommendlist[i].h_x+"|"+userrecommendlist[i].h_y+"'><img class='usertaglistimage' src='/hotplace/display?fileName="
                           + userrecommendlist[i].h_image
                           + "'  x='"
                           + userrecommendlist[i].h_x
                           + "' y='"
                           + userrecommendlist[i].h_y
                           + "' title='"
                           + userrecommendlist[i].h_title
                           + "' address='"
                           + userrecommendlist[i].h_address
                           + "' detail='"
                           + userrecommendlist[i].h_detail
                           + "' tag1='"
                           + userrecommendlist[i].h_tag1
                           + "' tag2='"
                           + userrecommendlist[i].h_tag2
                           + "'/></a>";
                     html += "<div style='margin-bottom:3px;'>"
                           + userrecommendlist[i].h_area + "</div>";
                     html += "<div style='font-size:18px;font-weight:bold;margin-bottom:5px;'>"
                           + userrecommendlist[i].h_title + "</div>";
                     if (tag1 == "01") {
                        html += "<button class='hotplace_tag_lightbox' style='float:left'>#힐링</button>"
                     } else if (tag1 == "02") {
                        html += "<button class='hotplace_tag_lightbox' style='float:left'>#헬스케어</button>"
                     } else if (tag1 == "03") {
                        html += "<button class='hotplace_tag_lightbox' style='float:left'>#익사이팅</button>"
                     } else if (tag1 == "04") {
                        html += "<button class='hotplace_tag_lightbox' style='float:left'>#나홀로여행</button>"
                     } else if (tag1 == "05") {
                        html += "<button class='hotplace_tag_lightbox' style='float:left'>#가족과함께</button>"
                     } else if (tag1 == "06") {
                        html += "<button class='hotplace_tag_lightbox' style='float:left'>#연인과함께</button>"
                     } else if (tag1 == "07") {
                        html += "<button class='hotplace_tag_lightbox' style='float:left'>#친구와함께</button>"
                     } else if (tag1 == "08") {
                        html += "<button class='hotplace_tag_lightbox' style='float:left'>#먹방</button>"
                     } else if (tag1 == "10") {
                        html += "<button class='hotplace_tag_lightbox' style='float:left'>#도심속여행</button>"
                     } else if (tag1 == "11") {
                        html += "<button class='hotplace_tag_lightbox' style='float:left'>#나만아는</button>"
                     } else if (tag1 == "12") {
                        html += "<button class='hotplace_tag_lightbox' style='float:left'>#야경</button>"
                     } else if (tag1 == "13") {
                        html += "<button class='hotplace_tag_lightbox' style='float:left'>#교육</button>"
                     }

                     if (tag2 == "01") {
                        html += "<button class='hotplace_tag_lightbox' style='float:left'>#힐링</button>"
                     } else if (tag2 == "02") {
                        html += "<button class='hotplace_tag_lightbox' style='float:left'>#헬스케어</button>"
                     } else if (tag2 == "03") {
                        html += "<button class='hotplace_tag_lightbox' style='float:left'>#익사이팅</button>"
                     } else if (tag2 == "04") {
                        html += "<button class='hotplace_tag_lightbox' style='float:left'>#나홀로여행</button>"
                     } else if (tag2 == "05") {
                        html += "<button class='hotplace_tag_lightbox' style='float:left'>#가족과함께</button>"
                     } else if (tag2 == "06") {
                        html += "<button class='hotplace_tag_lightbox' style='float:left'>#연인과함께</button>"
                     } else if (tag2 == "07") {
                        html += "<button class='hotplace_tag_lightbox' style='float:left'>#친구와함께</button>"
                     } else if (tag2 == "08") {
                        html += "<button class='hotplace_tag_lightbox' style='float:left'>#먹방</button>"
                     } else if (tag2 == "10") {
                        html += "<button class='hotplace_tag_lightbox' style='float:left'>#도심속여행</button>"
                     } else if (tag2 == "11") {
                        html += "<button class='hotplace_tag_lightbox' style='float:left'>#나만아는</button>"
                     } else if (tag2 == "12") {
                        html += "<button class='hotplace_tag_lightbox' style='float:left'>#야경</button>"
                     } else if (tag2 == "13") {
                        html += "<button class='hotplace_tag_lightbox' style='float:left'>#교육</button>"
                     }

                     html += "</div>";
                  }
                  $("#userrecommendlist").html(html);
               }
            });
   }

   // 항공, 숙소 퀵 검색
   $('ul.tabs li').click(function() {
      var tab_id = $(this).attr('data-tab');

      $('ul.tabs li').removeClass('current');
      $('.tab-content').removeClass('current');

      $(this).addClass('current');
      $("#" + tab_id).addClass('current');
   })

   // 달력
   $(".startdate").datepicker({});
   $(".enddate").datepicker({});

   // 인원선택
   $(".staypersons").toggle(function() {
      $(".staycount").show();
      $("html").animate({
         scrollTop : 300
      }, 500);
   }, function() {
      $(".staycount").hide();
   });

   $(".airpersons1").toggle(function() {
      $(".aircount1").show();
      $("html").animate({
         scrollTop : 300
      }, 500);
   }, function() {
      $(".aircount1").hide();
   });

   $(".airpersons2").toggle(function() {
      $(".aircount2").show();
      $("html").animate({
         scrollTop : 300
      }, 500);
   }, function() {
      $(".aircount2").hide();
   });

   // top 스크롤
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

   /*슬라이드 배너*/
   //current position
   var pos = 0;
   //number of slides
   var totalSlides = $('#slider-wrap ul li').length;
   //get the slide width
   var sliderWidth = $('#slider-wrap').width();

   $(document).ready(function() {

      /*****************
       BUILD THE SLIDER
       *****************/
      //set width to be 'x' times the number of slides
      $('#slider-wrap ul#slider').width(sliderWidth * totalSlides);

      //next slide    
      $('#next').click(function() {
         slideRight();
      });

      //previous slide
      $('#previous').click(function() {
         slideLeft();
      });

      /*************************
       //*> OPTIONAL SETTINGS
       ************************/
      //automatic slider
      var autoSlider = setInterval(slideRight, 3000);

      //for each slide 
      $.each($('#slider-wrap ul li'), function() {

         //create a pagination
         var li = document.createElement('li');
         $('#pagination-wrap ul').append(li);
      });

      //counter
      countSlides();

      //pagination
      pagination();

      //hide/show controls/btns when hover
      //pause automatic slide when hover
      $('#slider-wrap').hover(function() {
         $(this).addClass('active');
         clearInterval(autoSlider);
      }, function() {
         $(this).removeClass('active');
         autoSlider = setInterval(slideRight, 5000);
      });

   });//DOCUMENT READY

   /***********
    SLIDE LEFT
    ************/
   function slideLeft() {
      pos--;
      if (pos == -1) {
         pos = totalSlides - 1;
      }
      $('#slider-wrap ul#slider').css('left', -(sliderWidth * pos));

      //*> optional
      countSlides();
      pagination();
   }

   /************
    SLIDE RIGHT
    *************/
   function slideRight() {
      pos++;
      if (pos == totalSlides) {
         pos = 0;
      }
      $('#slider-wrap ul#slider').css('left', -(sliderWidth * pos));

      //*> optional 
      countSlides();
      pagination();
   }

   /************************
    //*> OPTIONAL SETTINGS
    ************************/
   function countSlides() {
      $('#counter').html(pos + 1 + ' / ' + totalSlides);
   }

   function pagination() {
      $('#pagination-wrap ul li').removeClass('active');
      $('#pagination-wrap ul li:eq(' + pos + ')').addClass('active');
   }
</script>
</html>