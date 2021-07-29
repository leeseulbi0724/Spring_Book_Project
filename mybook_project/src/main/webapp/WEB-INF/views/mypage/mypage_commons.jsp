<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 | 라온 도서관 </title>
<link rel="shortcut icon" type="image⁄x-icon" href="http://localhost:9000/mybook/images/icon.png">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" ></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" >
<script src="http://localhost:9000/mybook/js/jquery-3.6.0.min.js" ></script>
<style>
	.com, .book, .home { color:rgb(162,162,162); }
	
	body { text-align:center; }
	.title { text-align:left; display:inline-block; }
	.title>h5 { font-weight:bold; font-size:30px; margin:80px 0 10px 0; }
	.button>div { width:1000px; display:inline-block; text-align:left; font-size:0; }
	.button>div>button { 
		background-color:white; 
		border-top:1px solid lightgray; 
		border-left:1px solid lightgray; 
		border-right:1px solid lightgray; 
		width:250px; 
		padding:10px 20px; 
		margin:0; 
		font-size:18px; 		
	}	
</style>
</head>
<body>
 <jsp:include page="../header.jsp"></jsp:include>
 
<div class="title"><h5>마이페이지</h5></div>
 <div class="button">
 	<div>
 		<button class="one" onClick="location.href='mypage.do'">My 정보</button>
 		<button class="two" onClick="location.href='mypage_info.do'">정보수정</button>
 		<button class="three" onClick="location.href='mypage_pass.do'">비밀번호 변경</button>
 		<button class="four" onClick="location.href='mypage_book.do'">나의 내역</button>
 	</div>
 </div>
 
</body>
</html>