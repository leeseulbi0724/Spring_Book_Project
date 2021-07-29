<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://localhost:9000/mybook/js/jquery-3.6.0.min.js" ></script>
<style>
	html, body, div, span, object, iframe, h1, h2, h3, h4, h5, h6, p, blockquote, pre, abbr, address, cite, code, del, dfn, em, img, ins, kbd, q, samp, small, strong, sub, sup, var, b, i, dl, dt, dd, ol, ul, li, fieldset, form, label, legend, table, caption, tbody, tfoot, thead, tr, th, td, article, aside, canvas, details, figcaption, figure, footer, header, hgroup, menu, nav, section, summary, time, mark, audio, video {
	    margin: 0;
	    padding: 0;
	    border: 0;
	    font-size:100%;
	    vertical-align: baseline;
	    background: transparent;
	}
	body { font-family:LG PC; padding-top:105px; }
	header { 
		width:100%;
		text-align:center; 
		background-color:white;
		top:0; left:0; right:0;
		position:fixed; 
		z-index:998;
		border-bottom:1px solid rgb(228,230,230);
	}
	header>div { display:inline-block; width:1550px; }
	header div.main_menu { background-color:whtie; width:100%; height:63px; display:inline-block; }
	header div.sub_menu { background-color:rgb(240,242,244); width:100%; height:30px; }
	header p a { 
		color:rgb(1,104,188); 
		font-weight:bold; 
		font-family:나눔스퀘어_ac;
		float:left;
		margin:20px 30px 20px 200px;
		font-size:25px;
		text-decoration:none;
	}
	
	.sub_menu ul, .main_menu ul { list-style:none; margin:0; }
	.sub_menu ul { margin-right:20px; }
	.sub_menu li a {
		display:inline-block;
		float:right;
		margin:2px 5px;
		text-decoration:none;
		color:black;
	}
	.sub_menu li a:hover { text-decoration:underline; }
	.sub_menu>div { display:inline-block; width:1500px; }
	.admin { float:left; }
	
	.home, .book, .com {
		font-size:18px;		
		font-family:나눔스퀘어_ac;
		float:left;
		font-weight:bold;
		margin: 0  10px 0 15px;
		padding:20px 5px;
		text-decoration:none;		
		position:relative;
	}
	.book, .com { cursor:default; }
	.book:hover, .com:hover {
		color:rgb(43,129,199); 
	}	
	.dropmenu { 
		display:none; 
		width:100%; 
		height:150px;
		background-color:rgb(222,225,230); 
		margin:0;
		list-style:none;
		position:absolute;
		left:-2px; top:100px;		
		z-index:999;
	}
	
	.m_book:hover .dropmenu, .m_com:hover .dropmenu { display:inline-block; }
	.drop_book, .drop_com { 	
		display:inline-block; 		
		margin:0; padding:0;
		height:100%;
	}
	.dropmenu a {
		color:black;
		display:block;
		text-decoration:none;
		font-size:18px; 
		margin:10px;
	}
	
	.dropmenu>div { width:1550px; height:150px; display:inline-block; }
	.dropmenu ul { float:left; }
	.dropmenu ul:first-child { margin-left:400px; margin-right:5px; }
	.dropmenu a:hover { text-decoration:underline; }
	
	.modal { background-color : rgba(0,0,0, .7); }
</style>
<script>
	$(document).ready(function() {
		$(".drop_book, .m_book").hover( function() {
			$(".drop_book").css("background-color","rgb(43,129,199)");
			$(".drop_book a").css("color","white");
			$(".drop_com").css("background-color","rgb(222,225,230)");
			$(".drop_com a").css("color","black");
		});
		
		$(".drop_com, .m_com").hover( function() {
			$(".drop_com").css("background-color","rgb(43,129,199)");
			$(".drop_com a").css("color","white");
			$(".drop_book").css("background-color","rgb(222,225,230)");
			$(".drop_book a").css("color","black");
		});
		
		$("#ok").click(function() {
			$(".modal-body").text("로그아웃 되셨습니다");
			$(".modal-footer").children().remove();
		});
	});
</script>
</head>
<body>
<header>
	<div class="sub_menu">
		<div>
			<ul>
				<li class="admin"><a href="admin_login.do" >관리자 로그인</a></li>
				<c:if test= "${empty session_id}">
				<li><a href="join.do">회원가입</a></li>
				<li><a href="login.do">로그인</a></li>
				</c:if>
				<c:if test= "${!empty session_id}">
				<li><a href="mypage.do">마이페이지</a></li>
				<li><a href="#" data-bs-toggle="modal" data-bs-target="#staticBackdrop" id="logout">로그아웃</a></li>
				</c:if>
			</ul>
		</div>
	</div>
	<div>
		<div class="main_menu">
			<p><a href="index.do">라온 도서관</a></p>
			<ul>
				<li><a href="index.do" class="home">홈</a></li>
				<li class="m_book"><a class="book">이용안내</a>
					<div class="dropmenu">
						<div>
						<ul class="drop_book">												
							<li><a href="search.do">도서 검색</a></li>
							<li><a href="room.do">열람실 예약</a></li>
						</ul>
						<ul class="drop_com">
							<li><a href="notice.do">공지사항</a></li>
							<li><a href="board.do">자유 게시판</a></li>
							<li><a href="request.do">도서요청</a></li>
							<li><a href="online.do">온라인 토론</a></li>
						</ul>
						</div>
					</div>
				</li>
				<li class="m_com"><a class="com">커뮤니티</a>
					<div class="dropmenu">
						<div>
						<ul class="drop_book">												
							<li><a href="search.do">도서 검색</a></li>
							<li><a href="room.do">열람실 예약</a></li>
						</ul>
						<ul class="drop_com">
							<li><a href="notice.do">공지사항</a></li>
							<li><a href="board.do">자유 게시판</a></li>
							<li><a href="request.do">도서요청</a></li>
							<li><a href="online.do">온라인 토론</a></li>
						</ul>
						</div>
					</div>
				</li>				
			</ul>
		</div>		
	</div>
</header>
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
        <a href="logout.do" type="button" class="btn btn-primary" id="ok">확인</a>
      </div>
    </div>
  </div>
</div>
 <!-- confirm 모달을 쓸 페이지에 추가 end-->
</body>
</html>