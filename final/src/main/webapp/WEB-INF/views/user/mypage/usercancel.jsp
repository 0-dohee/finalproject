<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>������ ���� TOURSUM !</title>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/style.css" />
<style>
#user-delete-area {
	padding:40px;
	position:relative;
	margin-bottom:30px;
}
#user,
#company {
	text-align:right;
	height:50px;
}
#user span,
#company span {
	display:inline-block;
	background:#0f4c81;
	width:150px;
	color:white;
	height:40px;
	padding-left:10px;
	padding-top:10px;
	border-radius:5px;
	text-align:left;
	font-size:13px;
}
#user input[type="text"],
#user input[type="password"],
#company input[type="text"],
#company input[type="password"] {
	width:100%;
	height:40px;
	border:0.5px solid gray;
	outline:none;
	border-radius:5px;
	padding-left:10px;
	cursor:pointer;
}
</style>
</head>
<body>
	<div id="page">
		<div id="header"><jsp:include page="../../header.jsp" /></div>
		<div id="menu"><jsp:include page="../../menu.jsp" /></div>
		<div id="container">
			<div id="user-delete-area">
				<img src="/resources/img/user/delete.png"/>
				<c:if test="${u_id!=null}">
					<table id="usertb" style="margin-left:160px;">
						<tr id="user">
							<td width=150><span>���̵�</span></td>
							<td width=400 style="padding-left:10px;"><input type="text" id="u_id" value=${ u_id } readonly></td>
						</tr>
						<tr id="user">
							<td><span>��й�ȣ</span></td>
							<td style="padding-left:10px;">
								<input type="password" id="u_pass" placeholder="��й�ȣ">
							</td>
						</tr>
						<tr style="height:110px;">
							<td colspan=2 style="text-align:center;">
								<input type="button" value="��������" id="cancelUser" 
								style="width:200px; height:50px; border:none; outline:none; border-radius:5px; margin-left:280px; margin-top:50px; cursor:pointer">
							</td>
						</tr>
					</table>
				</c:if>
	
				<c:if test="${c_id!=null}">
					<table id="companytb" style="margin-left:160px;">
						<tr id="company">
							<td width=150><span>���̵�</span></td>
							<td width=400 style="padding-left:10px;"><input type="text" id="c_id" value=${ c_id }></td>
						</tr>
						<tr id="company">
							<td><span>��й�ȣ</span></td>
							<td style="padding-left:10px;">
								<input type="password" id="c_pass" placeholder="��й�ȣ">
							</td>
						</tr>
						<tr style="height:110px;">
							<td colspan=2 style="text-align:center;">
								<input type="button" value="��������" id="cancelCompany" 
								style="width:200px; height:50px; border:none; outline:none; border-radius:5px; margin-left:280px; margin-top:50px; cursor:pointer;">
							</td>
						</tr>
					</table>
				</c:if>
			</div>	
		</div>
		<div id="footer"><jsp:include page="../../footer.jsp"/></div>
	</div>
</body>
<script>
$("#cancelUser").on("click",function(){
	var u_id="${u_id}";
	var u_pass=$("#u_pass").val();
	$.ajax({
		type:"get",
		url:"/user/mypage/UserPass",
		data:{"u_id":u_id,"u_pass":u_pass},
		success:function(data){
			if(data==0){
				alert("��й�ȣ�� �ٽ� Ȯ���Ͻʽÿ�.")
			}else{
				getCancel();
			}
		}
	});
});

$("#cancelCompany").on("click",function(){
	var c_id="${c_id}";
	var c_pass=$("#c_pass").val();
	$.ajax({
		type:"get",
		url:"/user/mypage/CompanyPass",
		data:{"c_id":c_id,"c_pass":c_pass},
		success:function(data){
			if(data==0){
				alert("��й�ȣ�� �ٽ� Ȯ���Ͻʽÿ�.")
			}else{
				getCompanyCancel();
			}
		}
	});
});
	
function getCancel(){
		if(!confirm("ȸ�� Ż���Ͻðڽ��ϱ�?")) return;
		var u_id=$("#u_id").html();
		var u_k_id="${u_k_id}";
		$.ajax({
			type : "post",
			url : "/user/mypage/usercancel",
			data : {
				"u_id" : u_id,
				"u_k_id": u_k_id
			},
			success : function() {
				alert("ȸ�� Ż��Ǿ����ϴ�.");
				location.href = "/user/login";
			}
		});
}
function getCompanyCancel(){
		if(!confirm("ȸ�� Ż���Ͻðڽ��ϱ�?")) return;
		var c_id=$("#c_id").html();

		$.ajax({
			type : "post",
			url : "/user/mypage/companycancel",
			data : {
				"c_id" : c_id
			},
			success : function() {
				alert("ȸ�� Ż��Ǿ����ϴ�.");
				location.href = "/user/login";
			}
		});
}
</script>
</html>