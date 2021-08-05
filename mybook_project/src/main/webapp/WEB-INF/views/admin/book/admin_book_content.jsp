<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서 관리 | Admin</title>
<link rel="shortcut icon" type="image⁄x-icon" href="http://localhost:9000/mybook/images/icon.png">
<script src="http://localhost:9000/mybook/js/jquery-3.6.0.min.js" ></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" ></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" >
<script type="text/javascript" src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<style>
	.book { border-bottom:4px solid rgb(76,127,242); }
	.center { width:1319.2px; height:705px; float:left;  background-color:rgb(234,238,241); }
	.center h3 { font-weight:bold; margin:15px 20px; font-size:16px; }
	.center>p { float:right; margin-top:-35px; margin-right:20px; }
	.center>p>a, .center>p>span { font-size:12px; font-weight:normal; float:left; }
	.list_box { width:1275px; height:600px; background-color:white; margin-left:20px; text-align:center; }
	div.box { display:inline-block; margin-top:30px; text-align:center; width:1000px; }

	.detail { 
		width:100%; height:350px; 
		margin-top:70px;
	}
	.img { 
		border:1px solid lightgray; 
		display:inline-block;
		width:200px; height:300px;
		float:left;
		margin-left:85px;
	}
	.text {
		display:inline-block;
		width:600px;
		margin-left:30px;
		float:left;
		text-align:left;
		margin-bottom:20px;
	 }
	 .book_title { border-bottom:1px solid; font-size:23px; text-align:left; margin-top:20px; }
	 .book_heart { display:inline-block; float:right; }
	.book_star { margin-bottom:5px; }
	.book_text { color:gray; margin-bottom:20px; }
	
	.book_star>p { float:left; }
	.star-rating { width:100px; float:left; margin-top:5px; margin-right:5px; }
	.star-rating,.star-rating span { display:inline-block; height:18px; overflow:hidden; background:url("http://localhost:9000/mybook/images/re_star.png")no-repeat; }
	.star-rating span{ background-position:left bottom; line-height:0; vertical-align:top; }
	
	#rental { margin:10px 0 10px 10px; font-size:12px; font-weight:normal; }
</style>
</head>
<body>
<jsp:include page="../admin_main.jsp"></jsp:include>

<section class="center">
	<h3>도서 상세보기</h3>
	<p><a>도서</a><span>></span><a>도서 목록</a><span>></span><a>도서 상세보기</a></p>
	<div class="list_box">			
		<div class="box">
			<div class="detail">
		 		<div class="img">
		 			<img src="http://localhost:9000/mybook/upload/${vo.bsfile }" width=100% height=100% >
		 		</div>
		 		<div class="text">
		 			<div class="book_title">
		 				${vo.bname }
		 				<p class="book_heart">
		 					<img src="http://localhost:9000/mybook/images/heart_after.png" width=18 height=18  > 좋아요(${vo.bheart }개)
		 				</p>
		 			</div>		 			
		 			<p class="book_info">${vo.bauthor } 지음 | ${vo.bpublish } | ${vo.bdate } 출간</p>
		 			<p class="book_star">
		 				 <span class='star-rating'>
						<span style ="width:${(sum/count)*20}%"></span>	
						</span>	<p>후기(${count }개)</p>
		 			</p>		 		
		 			<p class="book_text">${vo.bcontent }</p>
		 		</div>
		 	</div>
		 	<a href="admin_book_rental.do?bid=${vo.bid }" class="btn btn-primary" id="rental">대여중인 회원</a>
		</div>
	</div>
</section>
</body>
</html>