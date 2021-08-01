<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" type="image⁄x-icon" href="http://localhost:9000/mybook/images/icon.png">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" ></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" >
<script src="http://localhost:9000/mybook/js/jquery-3.6.0.min.js" ></script>
<link href="http://localhost:9000/mybook/css/commons.css" rel="stylesheet" >
<title>희망도서 신청 | 라온 도서관</title>
<style>	
	.com { color:rgb(43,129,199); border-bottom:5px solid rgb(43,129,199); }
	.home, .book {	color:rgb(162,162,162); }
	
	.left ul li:nth-child(3) a { color:rgb(43,129,199); font-weight:bold; }

	.form-control { display:inline-block; margin-bottom:5px; font-size:14px; }
	.textarea { height:500px; resize:none; }
	
	.up, .back { margin-top:20px; padding:3px10px; }
	.up { background-color:rgb(109,171,239); color:white; }
	.back { background-color:white; border:1px solid lightgray; }
	.back:hover { background-color:lightgray; }
</style>
</head>
<body>
<jsp:include page="../header.jsp"></jsp:include>

 <section>
	 <div class="menu_div">
		 <div>
		 	<a href="index.do"><img src="http://localhost:9000/mybook/images/home_icon.png" width=15 height=15></a>>
		 	<a href="request.do">커뮤니티</a>><a href="request.do">희망도서 신청</a>
		 </div>
	 </div>
	 <div class="content">
		 <div class="left">
		 	<ul>
		 		<li><a href="notice.do">공지사항</a></li>
		 		<li><a href="board.do">자유 게시판</a></li>
		 		<li><a href="request.do">희망도서 신청</a></li>
		 		<li><a href="online.do">온라인 토론</a></li>
		 	</ul>
		 </div>
		 <div class="center">
		 	<div class="title">
		 		<h3>희망도서 신청</h3>
		 		<img src="http://localhost:9000/mybook/images/title_back.gif" height=100% >
		 	</div>
			<input type="text" class="form-control">
			<textarea class="form-control textarea"></textarea>
			<input type="file" class="form-control">
			<a href="#" class="btn up">등록</a>
			<a href="request.do" class="btn back">취소</a>
		 </div>
	</div>
</section>

<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>