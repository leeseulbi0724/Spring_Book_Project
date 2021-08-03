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

	.form-control { display:inline-block; margin-bottom:5px; font-size:14px; width:800px; }
	
	.up, .back { margin-top:20px; padding:3px10px; }
	.up { background-color:rgb(109,171,239); color:white; }
	.back { background-color:white; border:1px solid lightgray; }
	.back:hover { background-color:lightgray; }
	
	.table { margin-top:20px; font-size:14px; }
	.table tr { border-bottom:1px solid lightgray; }
	.table th { font-weight:normal; text-align:left; padding-left:15px; }
	.table th:first-child { width:100px; background-color:rgb(248,248,248); vertical-align:middle; }
	
	.table th>button { padding:3px 10px; font-size:13px; }
</style>
</head>
<script>
	$(document).ready(function() {
		 $(".search").click(function() {
			 var url = "request_search.do";
	         var name = "popup test";
	         var option = "width = 500, height = 600, top = 150, left = 500, location = no"
	         window.open(url, name, option);
		 });
		
		 $(".up").click(function() {
			 if ($("#bname").val() == "" || $("#bauthor").val() == "" || $("#bpublish").val() == "") {
				 alert("검색버튼을 통해 내용을 입력해주세요");
				 $(".search").focus();
			 } else {
				 request_write.submit();
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
		 	<a href="request.do">커뮤니티</a>><a href="request.do">희망도서 신청</a>
		 </div>
	 </div>
	 <div class="content">
		 <div class="left">
		 	<ul>
		 		<li><a href="notice.do">공지사항</a></li>
		 		<li><a href="board.do">자유 게시판</a></li>
		 		<li><a href="request.do">희망도서 신청</a></li>
		 	</ul>
		 </div>
		 <div class="center">
		 	<div class="title">
		 		<h3>희망도서 신청</h3>
		 		<img src="http://localhost:9000/mybook/images/title_back.gif" height=100% >
		 	</div>
		 	<form name="request_write" action="request_write_proc.do" method="post" enctype="multipart/form-data">
				<table class="table">				
			 		<tr>
			 			<th>책명</th>
			 			<th>
			 				<input type="text" class="form-control" name="bname" id="bname" autocomplete="off" placeholder="검색버튼을 이용해주세요">
			 				<button class="btn btn-secondary search" type="button">검색</button>
			 			</th>
			 		</tr>
			 		<tr>
			 			<th>저자</th>
			 			<th><input type="text" placeholder="검색버튼을 이용해주세요" class="form-control" name="bauthor" id="bauthor" autocomplete="off"></th>
			 		</tr>
			 		<tr>
			 			<th>출판사</th>
			 			<th><input type="text" placeholder="검색버튼을 이용해주세요" class="form-control" name="bpublish" id="bpublish" autocomplete="off"></th>
			 		</tr>			 		 		
		 		</table>
				<button type="button" class="btn up">등록</button>
				<a href="request.do" class="btn back">취소</a>
			</form>
		 </div>
	</div>
</section>

<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>