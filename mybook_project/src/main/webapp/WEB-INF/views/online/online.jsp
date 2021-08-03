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
<title>온라인 토론 | 라온 도서관</title>
<style>	
	.com { color:rgb(43,129,199); border-bottom:5px solid rgb(43,129,199); }
	.home, .book {	color:rgb(162,162,162); }
	.left ul li:last-child a { color:rgb(43,129,199); font-weight:bold; }	
	
	.search { margin:10px 0; text-align:right; }
	.search p { float:left; }
	.search span { color:rgb(170,93,11); }
	.form-select { 
		width:100px; height:30px;
		 display:inline-block; 
		 border-radius:10px; 
		 padding:0 10px; margin:0;
		 font-size:14px;
	}
	.form-control {
		width:200px; height:30px;
		display:inline-block; font-size:14px;
	}
	.btn_search { font-size:14px; padding:2px 5px; }

	.chat { 
		display:inline-block;
		width:220px; height:220px; 
		border:1px solid lightgray; 
		margin:5px; float:left;
	}
	.chat img { margin-top:10px; }
	.chat .name { font-weight:bold; font-size:18px; }
	
	.btn_write { 
		background-color:rgb(109,171,239); color:white; float:left;
		font-size:14px; padding:2px 5px; margin-bottom:14px;
	}
</style>
</head>
<script>
	$(document).ready(function() {
		 $(".btn_write").click(function() {
			 var url = "online_write.do";
	         var name = "popup test";
	         var option = "width = 500, height = 600, top = 100, left = 500, location = no"
	         window.open(url, name, option);
		 });
	});
</script>
<body>
 <jsp:include page="../header.jsp"></jsp:include>
 <section>
	 <div class="menu_div">
		 <div>
		 	<a href="index.do"><img src="http://localhost:9000/mybook/images/home_icon.png" width=15 height=15></a>>
		 	<a href="online.do">커뮤니티</a>><a href="online.do">온라인 토론</a>
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
		 		<h3>온라인 토론</h3>
		 		<img src="http://localhost:9000/mybook/images/title_back.gif" height=100% >
		 	</div>
		 	<div class="search">
		 		<a class="btn btn_write">방 개설</a>	
		 		<select class="form-select">
		 			<option>방이름
		 		</select>		 		
		 		<input type="text" class="form-control">
		 		<button class="btn btn-secondary btn_search">검색</button>
		 	</div>
		 	<div class="chat">
		 		<img src="http://localhost:9000/mybook/images/chat.png" width=100 height=100 >
		 		<p class="name">방이름</p>
		 		<p class="count">참여자 : 2명</p>
		 		<a href="#" class="btn btn-outline-primary">참여하기</a>
		 	</div>	
		 	<div class="chat">
		 		<img src="http://localhost:9000/mybook/images/chat.png" width=100 height=100 >
		 		<p class="name">방이름</p>
		 		<p class="count">참여자 : 5명</p>
		 		<a href="#" class="btn btn-outline-primary">참여하기</a>
		 	</div>		 
		 	<div class="chat">
		 		<img src="http://localhost:9000/mybook/images/chat.png" width=100 height=100 >
		 		<p class="name">방이름</p>
		 		<p class="count">참여자 : 1명</p>
		 		<a href="#" class="btn btn-outline-primary">참여하기</a>
		 	</div>	
		 	<div class="chat">
		 		<img src="http://localhost:9000/mybook/images/chat.png" width=100 height=100 >
		 		<p class="name">방이름</p>
		 		<p class="count">참여자 : 4명</p>
		 		<a href="#" class="btn btn-outline-primary">참여하기</a>
		 	</div>		 	 	
		 </div>
	 </div>
 </section>
  <jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>