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
<title>열람실 신청 | 라온 도서관</title>
<style>
	.menu_div {
		background-color:rgb(251,251,251);
		border-bottom:1px solid lightgray;
		text-align:center;
	}
	.menu_div>div { display:inline-block; width:1400px; text-align:right; }
	.menu_div a { margin-right:5px; text-decoration:none; color:black; }
	.menu_div a:last-child { font-weight:bold; margin-right:20px; }
	
	.book { color:rgb(43,129,199); border-bottom:5px solid rgb(43,129,199); }
	.home, .com  {	color:rgb(162,162,162); }
	
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
	.left ul li:last-child a { color:rgb(43,129,199); font-weight:bold; }
	
	.center { display:inline-block; width:1000px; height:600px; }
	.title { height:100px; border-bottom:1px solid lightgray;}
	.title h3 {
		font-size:30px; 
		font-weight:bold; 
		float:left;
		margin:30px 15px;
	}
	.title img { float:right; }	
	
	.center p { float:left; padding:5px 0; }
	.center p>span { color:rgb(170,93,11); }
	
	.seat { width:100%; display:inline-block; height:500px; margin-top:20px; }
	 .seat_box { width:800px; display:inline-block; margin-top:20px; text-align:center; }
	.seat_box #btn { 
		background-color:white; 
		border:1px solid lightgray;
		width:40px; height:40px;
		font-size:14px;
	 }
	 .seat_box .choice { 
	 	background-color:lightgray; 
	 	color:white; 
	 	border:none; 
	 	display:inline-block; 
	 	margin-top:50px;
	 	padding:10px 20px;
	 	border-radius:10px;
	}
</style>
</head>
<script>
	$(document).ready(function() {
		$("[id^=btn]").click(function() {
			$("[id^=btn]").css("border","1px solid lightgray");
			$(this).css("border","2px solid");
			$(".choice").css("background-color","rgb(43,129,199)")
			$(".choice").attr("disabled",false);
			
		});
	});
</script>
<body>
 <jsp:include page="../header.jsp"></jsp:include>
 <section>
	 <div class="menu_div">
		 <div>
		 	<a href="index.do"><img src="http://localhost:9000/mybook/images/home_icon.png" width=15 height=15></a>>
		 	<a href="room.do">이용안내</a>><a href="room.do">열람실 신청</a>
		 </div>
	 </div>
	 <div class="content">
		 <div class="left">
		 	<ul>
		 		<li><a href="search.do">도서 검색</a></li>
		 		<li><a href="room.do">열람실 신청</a></li>
		 	</ul>
		 </div>
		 <div class="center">
		 	<div class="title">
		 		<h3>열람실 신청</h3>
		 		<img src="http://localhost:9000/mybook/images/title.gif" height=100% >
		 	</div>
		 	<p>총 <span>150</span>석 중 <span>48</span>석 사용중</p>
		 	<div class="seat">		 
			 	<div class="seat_box">
			 		<% for(int i=1; i<151; i++) { %>
			 			<button id="btn"><%= i%></button>
			 		<% } %>
				 	<br><button disabled class="choice">좌석 선택하기</button>
			 	</div>
			 </div>
		 </div>
	 </div>
 </section>
  <jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>