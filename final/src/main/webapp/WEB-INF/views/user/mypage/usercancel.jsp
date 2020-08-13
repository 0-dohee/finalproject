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
</style>
</head>
<body>
	<h1>ȸ�� Ż��</h1>
	
	<c:if test="${u_id!=null}">
		<table border=1 id="usertb">
			<tr>
				<td colspan=2>Ż�� ���Ͻô� ���� ���̵�, ��й�ȣ�� ��ġ�ϸ� �ڵ����� Ż�� �˴ϴ�.</td>
			</tr>
			<tr>
				<td colspan=2>���� ����</td>
			</tr>
			<tr>
				<td colspan=2>Ż�� �ÿ� ���������� ��� �����Ǿ� ���� �Ұ����Ͽ��� ������ �����ּ���.<br>
					�Ʒ��� ������ ��Ȯ�� �Է��Ͻø� �ڵ�Ż�� ó���˴ϴ�.<br>
					Ż�� �Ŀ��� ���������� ��� �����Ǿ� ������ �Ұ����մϴ�.
				</td>
			</tr>
			<tr>
				<td colspan=2>���������� Ȯ���ϼ���.</td>
			</tr>
			<tr id="user">
				<td>���̵�</td>
				<td><span id="u_id">${u_id}</span></td>
			</tr>
			
			<tr>
				<td colspan=2>Ż�� ���� ������ ȸ�� ������ �Է��� �ּ���.</td>
			</tr>
			<tr id="company">
				<td colspan=2><input type="password" id="u_pass" placeholder="��й�ȣ"></td>
			</tr>
			<tr><td colspan=2><input type="button" value="����ϱ�" onClick="location.href='/user/mypage/infomation'">
			<input type="button" value="ȸ��Ż��" id="cancelUser"></td></tr>
		</table>
	</c:if>
	
	<c:if test="${c_id!=null}">
		<table border=1 id="companytb">
			<tr>
				<td colspan=2>Ż�� ���Ͻô� ���� ���̵�, ��й�ȣ�� ��ġ�ϸ� �ڵ����� Ż�� �˴ϴ�.</td>
			</tr>
			<tr>
				<td colspan=2>���� ����</td>
			</tr>
			<tr>
				<td colspan=2>Ż�� �ÿ� ���������� ��� �����Ǿ� ���� �Ұ����Ͽ��� ������ �����ּ���.<br>
					�Ʒ��� ������ ��Ȯ�� �Է��Ͻø� �ڵ�Ż�� ó���˴ϴ�.<br>
					Ż�� �Ŀ��� ���������� ��� �����Ǿ� ������ �Ұ����մϴ�.
				</td>
			</tr>
			<tr>
				<td colspan=2>���������� Ȯ���Ͻʽÿ�.</td>
			</tr>
			<tr id="company">
				<td>���̵�</td>
				<td><span id="c_id">${c_id}</span></td>
			</tr>
			<tr>
				<td colspan=2>Ż�� ���� ������ ȸ�� ������ �Է��� �ּ���.</td>
			</tr>
			<tr id="company">
				<td colspan=2><input type="password" id="c_pass" placeholder="��й�ȣ"></td>
			</tr>
			<tr><td colspan=2><input type="button" value="����ϱ�" onClick="location.href='/user/mypage/infomation'">
			<input type="button" value="ȸ��Ż��" id="cancelCompany"></td></tr>
		</table>
	</c:if>

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