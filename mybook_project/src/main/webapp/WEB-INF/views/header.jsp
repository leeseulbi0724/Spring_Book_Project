<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://localhost:9000/mybook/js/jquery-3.6.0.min.js" ></script>
<script src="http://localhost:9000/mybook/js/index/header.js" ></script>
<link href="http://localhost:9000/mybook/css/index/header.css" rel="stylesheet" >
</head>
<body>
<header>
	<div class="sub_menu">
		<div>
			<ul>
				<c:if test= "${empty session_id}">
				<li class="admin"><a href="admin_login.do" >관리자 로그인</a></li>
				<li><a href="join.do">회원가입</a></li>
				<li><a href="login.do">로그인</a></li>
				</c:if>
				<c:if test= "${!empty session_id}">
				<li>
					<a class="bell">
						<c:if test="${b_count > 0 }">
							<img src="http://localhost:9000/mybook/images/notifications_yes.png" width=18 height=18>
						</c:if>
						<c:if test="${b_count eq 0 }">
							<img src="http://localhost:9000/mybook/images/notifications_no.png" width=18 height=18>
						</c:if>
					</a>	
					<div class="bell_div">
						<div class="bell_box">
							<div class="x">X</div>
							<p>알림</p>
							<div class="scroll_box" >
								<c:forEach var = "vo"  items="${bell_list}" >
									<c:if test="${vo.category eq '게시판' }">
										<a href="board_content.do?bid=${vo.kinds }">
									</c:if>
									<c:if test="${vo.category eq '희망도서' }">
										<a href="request_content.do?rid=${vo.kinds }">
									</c:if>
									<c:if test="${vo.category eq '대여' }">
										<a href="mypage_book.do">
									</c:if>
										<div>${vo.content }
											<c:if test="${vo.day eq 0 }">
												<span>오늘</span>
											</c:if>
											<c:if test = "${vo.day > 0 }">
												<span>${vo.day }일전</span>
											</c:if>
										</div>
										</a>
								</c:forEach>
							</div>
						</div>
					</div>
				</li>
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
				<li class="m_book"><a class="book">도서관 이용</a>
					<div class="dropmenu">
						<div>
						<ul class="drop_book">												
							<li><a href="search.do">도서 대여</a></li>
							<li><a href="room.do">열람실 예약</a></li>
						</ul>
						<ul class="drop_com">
							<li><a href="notice.do">공지사항</a></li>
							<li><a href="board.do">자유 게시판</a></li>
							<li><a href="request.do">희망도서 신청</a></li>
						</ul>
						</div>
					</div>
				</li>
				<li class="m_com"><a class="com">커뮤니티</a>
					<div class="dropmenu">
						<div>
						<ul class="drop_book">												
							<li><a href="search.do">도서 대여</a></li>
							<li><a href="room.do">열람실 예약</a></li>
						</ul>
						<ul class="drop_com">
							<li><a href="notice.do">공지사항</a></li>
							<li><a href="board.do">자유 게시판</a></li>
							<li><a href="request.do">희망도서 신청</a></li>
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