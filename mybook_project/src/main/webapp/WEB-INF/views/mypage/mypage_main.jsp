<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
	.one { border-bottom:2px solid rgb(43,129,199); }	
	.four, .three, .two { border-bottom:2px solid lightgray; }
	
	.content { 
		background-color:rgb(248,249,251); 
		width:100%; height:500px; 
		margin-bottom:-100px; 
		border-top:1px solid lightgray;
		text-align:center;
	}
	.content>div { display:inline-block; margin-top:50px; }
	
	.img { 
		border:1px solid lightgray; 
		display:inline-block; 
		background-color:white; 
		width:300px; height:300px; 
		margin-top:20px; float:left;
	}
	.img>img { margin-top:40px; }
	.img>button {	margin:5px; padding:2px 10px; }
	#file { display:none; }
	
	.box_div { display:inline-block; width:600px; margin-top:20px; float:left; }
	.box {
		border:1px solid lightgray; 
		display:inline-block; 
		background-color:white; 
		width:600px; height:94px; 
		margin-left:10px;
		margin-bottom:9px;
		text-decoration:none;
	}
	.box>p:first-child {
		margin:10px;
		font-size:20px;
	}
	.box>p:last-child { color:gray; }
	
	#change { display:none; }
</style>
</head>
<script>
$(function () {
	$('#profile').click(function (e) {
		e.preventDefault();	
		$('#file').click();	
	});
	
	$("#file").change(function() {
		if (window.FileReader) {
			$("#change").trigger("click");
			$("#change").bind("click", function(){
				profile.submit();
			});
		}
	});
});
</script>
<body>
 <jsp:include page="../header.jsp"></jsp:include>
 
  <jsp:include page="mypage_commons.jsp"></jsp:include>
  <section class="content">
	  <div>
	 		<div class="img">
	 			<c:if test = "${empty vo.msfile  }">
	 				<img src="http://localhost:9000/mybook/images/human.png" width=200px height=200px >
	 			</c:if>
	 			<c:if test = "${not empty vo.msfile }">
	 				<img src="http://localhost:9000/mybook/upload/${vo.msfile }" width=200px height=200px >
	 			</c:if>
		 		<button class="btn btn-outline-secondary" id="profile">프로필 사진 변경하기</button>
		 		<form name="profile"  action="mypage_profile.do" method="post" enctype="multipart/form-data">
		 			<input type="file" id="file" name="file1">
		 			<button type="submit" id="change">변경</button>
		 		</form>
	 		</div>
	 		<div class="box_div">
		 		<a class="box" href="mypage_heart.do">
		 			<p>좋아요</p>
		 			<p>내가 누른 좋아요 목록을 볼 수 있습니다</p>
		 		</a>
		 		<a class="box" href="mypage_review.do">
		 			<p>후기</p>
		 			<p>내가 쓴 도서 후기 목록을 볼 수 있습니다</p>
		 		</a>
		 		<a class="box" href="mypage_board.do">
		 			<p>게시글</p>
		 			<p>내가 쓴 게시글 목록을 볼 수 있습니다</p>
		 		</a>
	 		</div>
	 	</div>
  </section>
   <jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>