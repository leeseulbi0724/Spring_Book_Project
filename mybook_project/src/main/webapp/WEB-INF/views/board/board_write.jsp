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
<title>자유 게시판 | 라온 도서관</title>
<style>
	.menu_div {
		background-color:rgb(251,251,251);
		border-bottom:1px solid lightgray;
		text-align:center;
	}
	.menu_div>div { display:inline-block; width:1400px; text-align:right; }
	.menu_div a { margin-right:5px; text-decoration:none; color:black; }
	.menu_div a:last-child { font-weight:bold; margin-right:20px; }
	
	.com { color:rgb(43,129,199); border-bottom:5px solid rgb(43,129,199); }
	.home, .book {	color:rgb(162,162,162); }
	
	section { text-align:center; }
	.content { display:inline-block; width:1300px; margin-top:50px; }
	.left { 
		display:inline-block; 
		width:250px; height:250px;
		float:left;	
	 }	 
	.left ul { list-style:none; padding:0; margin:0; text-align:left; border-top:1px solid; border-bottom:1px solid; }
	.left ul li { font-size:18px; padding:5px; border-bottom:1px solid lightgray; margin-left:10px; }
	.left ul a { text-decoration:none; color:black; }
	.left ul li:hover { text-decoration:underline; cursor:pointer; }
	.left ul li:last-child { border-bottom:none; }
	.left ul li:nth-child(2) a { color:rgb(43,129,199); font-weight:bold; }
	
	.center { display:inline-block; width:1000px; height:500px; }
	.title { height:100px; border-bottom:1px solid lightgray;}
	.title h3 {
		font-size:30px; 
		font-weight:bold; 
		float:left;
		margin:30px 15px;
	}
	.title img { float:right; }	

	.form-control { display:inline-block; margin-bottom:5px; font-size:14px; }
	.textarea { height:500px; resize:none; }
	
	.up, .back { margin-top:20px; padding:3px10px; }
	.up { background-color:rgb(109,171,239); color:white; }
	.back { background-color:white; border:1px solid lightgray; }
	.back:hover { background-color:lightgray; }
</style>
</head>
<script>
	$(document).ready(function() {
		$(".up").click(function() {
			if ($(".btitle").val() == "") {
				alert("제목을 입력해주세요");
				$(".btitle").focus();
			} else if ($(".textarea").val() == "") {
				alert("내용을 입력해주세요");
				$(".textarea").focus();
			} else {
				board_write.submit();
			}
		});
	});
</script>
<body>
<jsp:include page="../header.jsp"></jsp:include>

 <section>
	 <div class="menu_div">
		 <div>
		 	<a href="index.do"><img src="http://localhost:9000/mybook/images/home_icon.png" width=15 height=15></a>>
		 	<a href="board.do">커뮤니티</a>><a href="board.do">자유 게시판</a>
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
		 		<h3>자유 게시판</h3>
		 		<img src="http://localhost:9000/mybook/images/title.gif" height=100% >
		 	</div>
		 	<form name="board_write" action="board_write_proc.do" method="post" enctype= "multipart/form-data">
				<input type="text" class="form-control btitle" placeholder="제목을 입력해주세요" name="btitle">
				<textarea class="form-control textarea" placeholder="내용을 입력해주세요" name="bcontent"></textarea>
				<input type="file" class="form-control"  multiple="multiple" name="file">
				<a class="btn up">등록</a>
				<a href="board.do" class="btn back">취소</a>
			</form>
		 </div>
	</div>
</section>

<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>