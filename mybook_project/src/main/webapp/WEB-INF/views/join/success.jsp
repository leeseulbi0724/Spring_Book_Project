<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" type="image⁄x-icon" href="http://localhost:9000/mybook/images/icon.png">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" ></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" >
<script src="http://localhost:9000/mybook/js/address.js"></script>
<link href="http://localhost:9000/mybook/css/index/header.css" rel="stylesheet" >
<title>회원가입 | 라온 도서관</title>
<style>
	.home, .book, .com { color:rgb(162,162,162); }
	.join_box { text-align:center; height:200px; }
	.join_box>p {
		margin-top:200px;
		font-size:30px;
	}
	.join_box>button {
		background-color:rgb(43,129,199);
		color:white;
		width:100px; height:50px;
		font-size:20px;
		border:1px solid lightgray;
		margin-top:50px;
		margin-left:10px;
		border-radius:4px;
	}
</style>
</head>
<body>
<jsp:include page="../header.jsp"></jsp:include>
<section>
	<div class="join_box">
		<p>회원가입이 완료되었습니다</p>
		<button onclick="location.href='login.do'">로그인</button>
	</div>
</section>
<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>