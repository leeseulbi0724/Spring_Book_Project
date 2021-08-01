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
<link href="http://localhost:9000/mybook/css/modal.css" rel="stylesheet" >
<script src="http://localhost:9000/myjeju/js/jquery-3.6.0.min.js"></script>
<title>상세 정보 | 라온 도서관</title>
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
	.left ul li:first-child a { color:rgb(43,129,199); font-weight:bold; }
	
	.center { display:inline-block; width:1000px; height:600px; }
	.title { height:100px; border-bottom:1px solid lightgray;}
	.title h3 {
		font-size:30px; 
		font-weight:bold; 
		float:left;
		margin:30px 15px;
	}
	.title img { float:right; }	
	
	.detail { 
		width:100%; height:350px; 
		margin-top:20px;
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
	
	.rental { 
		background-color:#4fa9de; color:white; 
		text-decoration:none;
		padding:10px 20px;
		border-radius:4px;
		cursor:pointer;
	}
	.text button { 
		float:right; 
		border:1px solid lightgray;
		background-color:white;
		width:80px; 	height:80px;
		margin-top:-10px;
		border-radius:20px;
		color:lightgray;
	}
	.text button>img { width:25%; height:25%; }
	
	.review { 
		display:inline-block;
		width:900px;
	}
	.review>p { font-weight:bold; font-size:23px; text-align:left; margin-left:10px; }
	.review>p>button { 
		font-size:14px; 
		background-color:rgb(30,179,136); 
		border:none; 
		color:white; 
		float:right; 
		border-radius:4px; 
	}
	.review_box { width:100%; height:200px;  display:inline-block; border-top:1px solid; }
	.review_text { 
		width:100%; 
		display:inline-block; 
		border-bottom:1px solid lightgray; 
		text-align:left;
		padding:10px 20px;
	 }
	.review_text p:first-child { color:gray; }
	.review_text strong { color:black; }	
	.form-select { color:rgb(255,210,3); display:inline-block; width:130px; }
	.form-control { display:inline-block; width:700px; }
	.write, .update { 
		display:inline-block; 
		background-color:#4fa9de; color:white; 
		text-decoration:none;
		padding:5px 10px;
		border-radius:4px;
		cursor:pointer;
		margin-left:5px;
		border:none;
	}
	.con>div { width:750px; }
	
	.book_star>p { float:left; }
	.star-rating { width:100px; float:left; margin-top:5px; margin-right:5px; }
	.star-rating,.star-rating span { display:inline-block; height:18px; overflow:hidden; background:url("http://localhost:9000/mybook/images/re_star.png")no-repeat; }
	.star-rating span{ background-position:left bottom; line-height:0; vertical-align:top; }
	
	.review_text a { text-decoration:none; color:lightgray; cursor:pointer; }
	.review_text a:hover { text-decoration:underline; }
</style>
</head>
<script>
	$(document).ready(function() {		
		$(".review_btn").click(function() {
			if ("${session_id}" == "") {
				location.replace("login.do");
			} else if (${r_result}) {
				$("#modal").fadeIn(300);
				$(".modal1").fadeIn(300);
			} else {
				alert("대여하신 도서만 후기를 작성하실 수 있습니다");
			}
		});
		
		$(".update_btn").click(function() {
			$("#modal").fadeIn(300);
			$(".modal2").fadeIn(300);
		});
		
		$("#modal, .close").on('click',function(){
			  $("#modal").fadeOut(300);
			  $(".modal-con").fadeOut(300);
		});
		
		$(".heart").click(function() {
			var bid = "${vo.bid}";
			if ("${session_id}" == "") {
				location.replace("login.do");
			} else if (${h_result}) {
				$.ajax({
	                type: "post",
	                url: "heart_minus.do",
	                data:{bid:bid},
	                dataType: 'json',
	                success: function (result) {
	                    location.reload();
	                },
	            });
			} else {
				$.ajax({
	                type: "post",
	                url: "heart_plus.do",
	                data:{bid:bid},
	                dataType: 'json',
	                success: function (result) {
	                    location.reload();
	                },
	            });
			}
		});
		
		$(".rental").click(function() {
			 if (${vo.status} == 1) {
				alert("이미 대여중인 도서입니다");
				$(this).attr("href","");
			}
		});
		
		$(".write").click(function() {
			if ($("#content").val() == "") {
				alert("내용을 입력해주세요");
				$("#content").focus();
			} else {
				var content=$("#content").val();
				var star = $("#star").val();
				var bid = "${vo.bid}";
				$.ajax({
	                type: "post",
	                url: "review_upload.do",
	                data:{content:content, star:star, bid:bid},
	                dataType: 'json',
	                success: function (result) {
	                	if (result) {
		                	alert("작성이 완료되었습니다");
		                    location.reload();	                		
	                	}
	                },
	            });
			}
		});
		
		$(".update").click(function() {
			if ($("#rcontent").val() == "") {
				alert("내용을 입력해주세요");
				$("#rcontent").focus();
			} else {
				var content=$("#rcontent").val();
				var star = $("#rstar").val();
				var bid = "${rvo.bid}";
				$.ajax({
	                type: "post",
	                url: "review_update.do",
	                data:{content:content, star:star, bid:bid},
	                dataType: 'json',
	                success: function (result) {
	                	if (result) {
		                	alert("수정이 완료되었습니다");
		                    location.reload();	                		
	                	}
	                },
	            });
			}
		});
		
		$(".delete_btn").click(function() {
			 var con_test = confirm("작성하신 후기를 삭제하시겠습니까?"); 
	        	if(con_test == true){   		
	        		var rid = $(this).attr("id");
					$.ajax({
		                type: "post",
		                url: "review_delete.do",
		                data:{rid:rid},
		                dataType: 'json',
		                success: function (result) {
		                	if (result) {
			                	alert("삭제가 완료되었습니다");
			                	 location.reload();	
		                	}
		                },
		            });
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
		 	<a href="search.do">이용안내</a>><a href="search.do">도서 검색</a>><a href="content.do?bid=${vo.bid }">상세 정보</a>
		 </div>
	 </div>
	 <div class="content">
		 <div class="left">
		 	<ul>
		 		<li><a href="search.do">도서 검색</a></li>
		 		<li><a href="room.do">열람실 예약</a></li>
		 	</ul>
		 </div>
		 <div class="center">
		 	<div class="title">
		 		<h3>상세 정보</h3>
		 		<img src="http://localhost:9000/mybook/images/title_back.gif" height=100% >
		 	</div>
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
					<a href="rental.do?bid=${vo.bid }" class="rental">대여하기</a>
					<button class="heart">
						<c:if test = "${h_result eq 'false' }">
							<img src="http://localhost:9000/mybook/images/heart_before.png" class="heart_img">
						</c:if>
						<c:if test = "${h_result eq 'true' }">
							<img src="http://localhost:9000/mybook/images/heart_after.png" class="heart_img">
						</c:if>
						<br>좋아요
					</button>
		 		</div>
		 	</div>
		 	<div class="review">
		 		<p>후기<button class="review_btn" >후기쓰기</button></p>		 		
		 		<div class="review_box">
		 		<c:forEach var = "vo"  items="${list}">		
		 			<div class="review_text">
		 				<p>
		 					<img src="http://localhost:9000/mybook/images/star${vo.star }.png" width=100px height=18 > ${vo.rdate }
		 					<c:if test = "${session_id eq vo.id }">
		 						<a class="update_btn">수정</a>
		 						<a class="delete_btn" id="${vo.rid }">삭제</a>
		 					</c:if>
		 				</p>
		 				<p><strong>${vo.id }</strong></p>
		 				<p>${vo.content }</p>
		 			</div>	 	
		 		</c:forEach>		
		 		<c:if test="${empty list }">
		 			<div class="review_text">
		 				<p>작성된 후기가 없습니다</p>
		 			</div>
		 		</c:if>
		 		</div>
		 	</div>		 	
		 </div>
	</div>
</section>
<div id="modal"></div>
  <div class="modal-con modal1">
    <a href="javascript:;" class="close">X</a>
    <p class="title">후기쓰기</p>
    <div class="con">
    	<select class="form-select" id="star" >
    		<option value="5">★★★★★
    		<option value="4">★★★★☆
    		<option value="3">★★★☆☆
    		<option value="2">★★☆☆☆
    		<option value="1">★☆☆☆☆
    	</select>
       <div>
       		<c:if test ="${v_result eq 'true'}">
       			<input type="text" class="form-control" id="content"><a class="write">등록</a>
       		</c:if>
       		<c:if test ="${v_result eq 'false'}">
       			<input type="text" class="form-control" id="content" readonly placeholder="이미 작성된 후기가 있습니다"><button class="write" disabled>등록</button>
       		</c:if>
       	</div>
    </div>
  </div>
  
  <div id="modal"></div>
  <div class="modal-con modal2">
    <a href="javascript:;" class="close">X</a>
    <p class="title">후기수정</p>
    <div class="con">
    	<select class="form-select" id="rstar" >
    		<c:if test = "${rvo.star eq 5 }">
	    		<option value="5" selected>★★★★★
	    		<option value="4">★★★★☆
	    		<option value="3">★★★☆☆
	    		<option value="2">★★☆☆☆
	    		<option value="1">★☆☆☆☆
    		</c:if>
    		<c:if test = "${rvo.star eq 4 }">
	    		<option value="5" >★★★★★
	    		<option value="4" selected>★★★★☆
	    		<option value="3">★★★☆☆
	    		<option value="2">★★☆☆☆
	    		<option value="1">★☆☆☆☆
    		</c:if>
    		<c:if test = "${rvo.star eq 3 }">
	    		<option value="5" >★★★★★
	    		<option value="4" >★★★★☆
	    		<option value="3" selected>★★★☆☆
	    		<option value="2">★★☆☆☆
	    		<option value="1">★☆☆☆☆
    		</c:if>
    		<c:if test = "${rvo.star eq 2 }">
	    		<option value="5" >★★★★★
	    		<option value="4" >★★★★☆
	    		<option value="3" >★★★☆☆
	    		<option value="2" selected>★★☆☆☆
	    		<option value="1">★☆☆☆☆
    		</c:if>
    		<c:if test = "${rvo.star eq 1 }">
	    		<option value="5" >★★★★★
	    		<option value="4" >★★★★☆
	    		<option value="3" >★★★☆☆
	    		<option value="2" >★★☆☆☆
	    		<option value="1" selected>★☆☆☆☆
    		</c:if>
    	</select>
       <div>
       		<input type="text" class="form-control" id="rcontent" value="${rvo.content }"><a class="update">수정</a>      		
       	</div>
    </div>
  </div>
<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>