<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin</title>
<script src="http://localhost:9000/mybook/js/jquery-3.6.0.min.js" ></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" ></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" >
<style>	
	body { font-family:LG PC; }
	.left {
		background-color:rgb(65,66,70);
		width:200px; height:750px;
		text-align:center; font-size:13px; 
		display:inline-block; float:left;
	}
	.left>ul { list-style:none; padding:0; margin:0; color:white; }
	.logo { padding:10px 0; font-size:14px; font-weight:bold; }
	.main { background-color:rgb(84,85,89);  padding:5px 0; }
	.main a { text-decoration:none; color:white; }
	.main a:hover { text-decoration:underline; color:white; }
	
	.top { width:1319.2px; height:45px; float:left; background-color:white; }
	.top>ul { list-style:none; padding:0; margin:0; }
	.top>ul>li { display:inline-block; padding:10px; font-size:14px; }
	.top>ul>li.user:hover, .notice:hover, .board:hover, .request:hover, .book:hover { border-bottom:4px solid rgb(76,127,242); }	
	.top a { text-decoration:none; color:black; }
	.logout { float:right; }
	.logout a { font-size:12px; height:30px; color: #0d6efd; }
		
	.center { width:1319.2px; height:705px; background-color:rgb(234,238,241); float:left; }	
	
	.modal { background-color : rgba(0,0,0, .7); }
</style>
<script>
	$(document).ready(function() {	
		$("#ok").click(function() {
			$(".modal-body").text("로그아웃 되셨습니다");
			$(".modal-footer").children().remove();
				setTimeout(function() {
				location.replace("http://localhost:9000/mybook/admin_login.do");
			}, 1000);
		});

		
	});

</script>
</head>
<body>
<section class="left">
<ul>
	<li class="logo"><p>관리자 페이지</p></li>
	<li  class="main" ><a href="index.do" target='_blank'>사이트 바로가기</a></li>
</ul>
</section>
<section class="top">
	<ul>
		<li class="user"><a href="admin_user.do">회원 관리</a></li>
		<li class="book"><a href="admin_book.do">도서 관리</a></li>
		<li class="request"><a href="admin_request.do">희망도서 관리</a></li>
		<li class="board"><a href="admin_board.do">게시판 관리</a></li>
		<li class="notice"><a href="admin_notice.do">공지사항 관리</a></li>
		<li class="room"><a href="admin_room.do">열람실 관리</a></li>
		<li class="logout"><a class="btn btn-outline-primary"  data-bs-toggle="modal" data-bs-target="#staticBackdrop">로그아웃</a>
	</ul>
</section>
<!-- <section class="center"></section> -->
<!-- confirm 모달을 쓸 페이지에 추가 start-->
 <div class="modal fade" id="staticBackdrop" data-bs-backdrop="false" data-bs-dismiss="modal" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">로그아웃</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        로그아웃 하시겠습니까?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <a href="#" type="button" class="btn btn-primary" id="ok">확인</a>
      </div>
    </div>
  </div>
</div>
 <!-- confirm 모달을 쓸 페이지에 추가 end-->
</body>
</html>