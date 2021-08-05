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
<script src="http://localhost:9000/mybook/js/jquery-3.6.0.min.js"></script>
<link href="http://localhost:9000/mybook/css/commons.css" rel="stylesheet" >
<title>도서 대여 | 라온 도서관</title>
<style>	
	.book { color:rgb(43,129,199); border-bottom:5px solid rgb(43,129,199); }
	.home, .com  {	color:rgb(162,162,162); }
	.left ul li:first-child a { color:rgb(43,129,199); font-weight:bold; }
	
	.detail { 
		width:100%; height:350px; 
		margin-top:20px;
	}
	.img { 
		border:1px solid lightgray; 
		display:inline-block;
		width:130px; height:180px;
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
	.book_text { color:gray; margin-bottom:20px; }
	
	.table { margin-top:30px; font-size:16px; }
	.table tr { border-bottom:1px solid lightgray; }
	.table th { font-weight:normal; padding-left:15px; }
	.table td { background-color:rgb(248,248,248); }
	
	 .rental { 
	 	background-color:#4fa9de; color:white; 
		text-decoration:none;
		padding:5px 10px;
		border-radius:4px;
		cursor:pointer;
	 	float:right;
	 }
</style>
</head>
<script>
$(document).ready(function() {
	$(".heart").click(function() {
		if ($(".heart img").attr("id") == "before") {
			$(".heart img").attr("src", "http://localhost:9000/mybook/images/heart_after.png");
			$(".heart img").attr("id", "after");				
		} else {
			$(".heart img").attr("src", "http://localhost:9000/mybook/images/heart_before.png")
			$(".heart img").attr("id", "before");	
		}
	});
	
	$(".rental").click(function() {
		if ($("#date").val() == "") {
			alert("반납일을 선택해주세요");
			$("#date").focus();
		} else {
			var bid = "${vo.bid}";
			var date = $("#date").val();
	    	var con_test = confirm("해당 도서를 대여하시겠습니까?"); 
        	if(con_test == true){   
	         $.ajax({
	                type: "post",
	                url: "book_rental_proc.do",
	                data:{bid:bid, date:date},
	                dataType: 'json',
	                success: function (result) {
	                   if (result) {
	                	   alert("도서 대여가 완료되었습니다");
	                	   location.replace("mypage_book.do");
	                   }
	                },

	            });
        	}			
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
		 	<a href="search.do">이용안내</a>><a href="search.do">도서 목록</a>><a href="rental.do?bid=${vo.bid }">도서 대여</a>
		 </div>
	 </div>
	 <div class="content">
		 <div class="left">
		 	<ul>
		 		<li><a href="search.do">도서 대여</a></li>
		 		<li><a href="room.do">열람실 예약</a></li>
		 	</ul>
		 </div>
		 <div class="center">
		 	<div class="title">
		 		<h3>도서 대여</h3>
		 		<img src="http://localhost:9000/mybook/images/title_back.gif" height=100% >
		 	</div>
		 	<table class="table">
		 		<tr>
		 			<td colspan="2" style="font-size:18px;">현재 대여중인 도서</td>
		 		</tr>		 		
		 		<tr>
		 			<td>책명</td>
		 			<td>반납일</td>
		 		</tr>
		 		<c:if test = "${empty list }">
		 			<tr>
		 				<th colspan="4">대여 중인 도서가 없습니다</th>
		 			</tr>
		 		</c:if>
		 		<c:forEach var = "vo"  items="${list}" varStatus="status">				
			 		<tr>
			 			<th>${vo.bname }</th>
			 			<th>${vo.endday }</th>
			 		</tr>
				</c:forEach>
		 	</table>
		 	<div class="detail">
		 		<div class="img">
		 			<img src="http://localhost:9000/mybook/upload/${vo.bsfile }" width=100% height=100% >
		 		</div>
		 		<div class="text">
		 			<div class="book_title">${vo.bname }</div>
		 			<p class="book_info">${vo.bauthor } 지음 | ${vo.bpublish } | ${vo.bdate } 출간</p>
		 			<table class="table">
		 				<tr>
		 					<th>반납일 선택하기</th>
		 					<th><input type="date" class="form-control" id="date"></th>
		 				</tr>
		 			</table>
		 			<a class="rental">대여하기</a>
		 		</div>
		 	</div>	 	
		 </div>
	</div>
</section>

<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>