<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 | Admin</title>
<link rel="shortcut icon" type="image⁄x-icon" href="http://localhost:9000/mybook/images/icon.png">
<link rel="shortcut icon" type="image⁄x-icon" href="http://localhost:9000/mybook/images/icon.png">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" ></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" >
<link href="http://localhost:9000/mybook/css/admin/admin_login.css" rel="stylesheet" >
<script src="http://localhost:9000/mybook/js/jquery-3.6.0.min.js"></script>
<script>
	$(document).ready(function() {
		$("#login").click(function() {
			if ($("#id").val() == "admin" && $("#pass").val() == "1234") {
				admin_login.submit();
			}			    
		});	
	});
</script>
</head>
<body>
<section>
	<img src="http://localhost:9000/mybook/images/lock.png" width=30 height=30 >
	<p>관리자 로그인</p>
	<div class="background">
	<form autocomplete="off"  name="admin_login" action="admin_main.do" method="get">
		<ul>
			<li>
				<label>관리자 아이디</label>
				<input type="text" class="form-control" id="id">
			</li>
			<li>
				<label>비밀번호</label>
				<input type="password" class="form-control" id="pass">
			</li>
		</ul>
		<ul>
			<li><a type="button" class="btn btn-success" id="login">LOGIN</a></li>
		</ul>
	</form>
	<a href="index.do" class="btn btn-outline-secondary" id="main">메인으로 돌아가기</a>
	</div>	
</section>

</body>
</html>