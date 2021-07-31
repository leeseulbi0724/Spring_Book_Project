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
<script src="https://localhost:9000/mybook/js/jquery-3.6.0.min.js" ></script>
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

	.sub { text-align:left; }
	.first { border-bottom:1px solid lightgray; text-align:center; }
	.p_title { font-size:23px; padding:10px; }
	.p_id { font-weight:bold; margin-left:10px; text-align:right; }
	.p_date { color:gray; margin-left:10px; margin-bottom:5px; text-align:right; }	
	.sub textarea { background-color:white; width:100%; border:none; }
	
	.comment { border-top:1px solid lightgray; width:100%; padding:10px 0; margin-top:70px; }
	.comment>p { font-weight:bold; font-size:20px; float:left; }
	.comment>textarea { border:1px solid lightgray; margin-top:30px; width:900px; display:inline-block; float:left; }
	.comment>button { 
		display:inline-block; 
		color:white;
		border:none;
		float:left; 
		margin-top:45px; margin-left:10px;
		background-color:rgb(109,171,239);
		padding:5px 10px;
	}
	
	.list, .update, .delete {
		background-color:rgb(43,129,199); 
		color:white;
		float:right;
		text-decoration:none;
		margin-left:5px;
	}
</style>
</head>
<script src="http://rawgit.com/jackmoored/autosize/master/dist/autosize.min.js"></script>
<script>
	$(document).ready(function() {
		$("textarea").css("height", $("textarea").prop('scrollHeight')+5);		
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
			<div class="sub">
				<div class="first">
					<p class="p_title">${vo.btitle }</p>
					<p class="p_id">${vo.name }**(${vo.id })</p>
					<p class="p_date">${vo.bdate } 조회 ${vo.bhit }</p>					
				</div>
				<textarea disabled style="resize: none;" class="textarea">${vo.bcontent }</textarea>
			</div>
			<a href="board.do" class="btn list">목록</a>
			<c:if test = "${session_id eq vo.id}">
				<a href="board_update.do" class="btn update">수정</a>
				<button class="btn delete">삭제</button>
			</c:if>
		 	<div class="comment">			
		 		<p>댓글</p>
		 		<textarea style="resize: none;" class="form-control"></textarea>
		 		<button class="btn">등록</button>
		 	</div>	 	
		 </div>
	</div>
</section>

<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>