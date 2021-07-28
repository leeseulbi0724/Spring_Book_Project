<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" type="image⁄x-icon" href="http://localhost:9000/mybook/images/icon.png">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" ></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" >
<script src="http://localhost:9000/mybook/js/jquery-3.6.0.min.js" ></script>
<c:if test="${type eq 'id'}">	
	<title>아이디 찾기 | 라온 도서관</title>
</c:if>
<c:if test="${type eq 'pass'}">	
	<title>비밀번호 찾기 | 라온 도서관</title>
</c:if>
<style>	
	#contents { text-align:center; }
	#contents>p {
		font-weight:bold;
		font-size:20px;	
		margin-top:10px;
	}
	.phone, .email { 
		border:1px solid lightgray; 
		width:230px; 
		height:250px; 
		display:inline-block; 
		margin-top:60px;		
		float:left;
		text-decoration:none; color:gray;
		font-size:14px;
	}
	.phone { margin-left:18px; margin-right:5px; }
	.phone img, .email img { margin:20px 0; }
</style>
</head>
<body>

<div id="contents"> 
	<p>본인인증</p>
	<a href="find_phone.do?type=${type }" class="phone">
		<img src="http://localhost:9000/mybook/images/phone.png" width=150 height=150><br>
		회원님 명의의 휴대폰으로 인증
	</a>
	<a href="find_email.do?type=${type }" class="email">
		<img src="http://localhost:9000/mybook/images/email.png" width=150 height=150><br>
		회원님의 이메일로 인증
	</a>

</div>
  
</body>
</html>