<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head profile="http://www.w3.org/2005/10/profile">
<meta charset="UTF-8">
<title>여행의 설렘 TOURSUM !</title>
<link rel="icon" type="image/png" href="http://example.com/myicon.png">
<style>
</style>
</head>
<body>
<%-- ${u_id},${u_k_id} --%>
	<div id="div_header_signup">
		<c:if test="${u_id==null && u_k_id==null && c_id==null}">
			<a href="/user/login">로그인</a>
			<a href="/user/signupselect">회원가입</a>
		</c:if>
		<c:if test="${u_id!=null && u_k_id=='0' || c_id!=null}">
				<a href="/user/logout">로그아웃</a>
		</c:if>
		<c:if test="${u_k_id!=null && u_id=='0'}">
			<a href="https://kauth.kakao.com/oauth/logout?client_id=44c4398b724d06191dbaf99c087795b1&logout_redirect_uri=http://localhost:8088/user/login">로그아웃</a>
		</c:if>
	</div>
	<a href="/"><img src="${pageContext.request.contextPath}/resources/img/logo3.png" width=300 id="header_logo"></a>
</body>
<script>
</script>
</html>