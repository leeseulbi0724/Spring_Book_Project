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
	div { text-align:center; }
	div>p.title { font-weight:bold; font-size:20px; margin:30px 0; }
	div>div { text-align:center; margin-bottom:30px; }
	
	.form-control { width:300px; display:inline-block; margin-bottom:5px; }
	
	.text { margin-top:130px; }
	
	form button, .close {
		background-color:rgb(43,129,199); 
		color:white; 
		display:inline-block; 
		border:none;
		border-radius:4px;
		padding:5px 10px;
		margin-top:10px;
	}
</style>
</head>
<script>
$(document).ready(function() {
/* 		$("#update").click(function() {
			if ( $("#pass").val() == "" ) {
				alert("새 비밀번호를 입력해주세요");
				$("#pass").focus();
			} else if ( $("#cpass").val() == "") {
				alert("새 비밀번호 확인을 입력해주세요");
				$("#cpass").focus();
			} else if ( $("#pass").val() != $("#cpass").val() ) {
				alert("비밀번호가 일치하지 않습니다");
				$("#pass").val("").focus();
				$("#cpass").val("");
			} else {
				update.submit();
			}
		}); */
		
		$(".close").click(function() {
			window.close();
		})
	});
</script>
<body>
<c:if test="${type eq 'id'}">	
	<div>
		<p class="title">아이디 찾기</p>
		<div><img src="http://localhost:9000/mybook/images/user.png" width=300 height=300></div>
		<c:if test="${empty id }">
			<span>존재하는 아이디가 없습니다.</span><br>
			<button class="close">닫기</button>
		</c:if>
		<c:if test="${not empty id }">
			<span>회원님의 아이디는 <strong>tmfql4428</strong> 입니다</span><br>
			<button class="close">닫기</button>
		</c:if>
	</div>
</c:if>
<c:if test = "${type eq 'pass' }">
	<div>
		<p class="title">비밀번호 찾기</p>
		<c:if test="${empty id }">
		<div><img src="http://localhost:9000/mybook/images/user.png" width=300 height=300></div>
			<span>일치하는 정보가 없습니다.</span><br>
			<button class="close">닫기</button>
		</c:if>
		<c:if test="${not empty id }">
			<div class="text">
				<p>새로운 비밀번호를 설정하실 수 있습니다</p>
				<form name="udpate" action="pass_update_proc.do" method="post">
					<input type="hidden" value="${id }" name="id">
					<input type="password" placeholder="새 비밀번호" class="form-control" id="pass" name="pass">
					<input type="password" placeholder="새 비밀번호 확인" class="form-control" id="cpass"><br>
					<button type="submit" id="update">변경</button>
				</form>
		</div>
		</c:if>
	</div>
</c:if>
</body>
</html>