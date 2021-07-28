<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" type="image⁄x-icon" href="http://localhost:9000/mybook/images/icon.png">
<title>비밀번호 찾기 | 라온 도서관</title>
<script src="http://localhost:9000/mybook/js/jquery-3.6.0.min.js" ></script>
<style>
	body { text-align:center; }
	p { margin-top:200px; font-size:20px; }
	button {
		background-color:rgb(43,129,199); 
		color:white; 
		display:inline-block; 
		border:none;
		border-radius:4px;
		padding:5px 10px;
		margin-top:10px;
		cursor:pointer;
	 }	 
</style>
</head>
<script>
	$(document).ready(function() {
		$("button").click(function() {
			window.close();
		})
	});
</script>
<body>
	<p><strong>비밀번호</strong>가 변경되었습니다</p>
	<button>닫기</button>
</body>
</html>