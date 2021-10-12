<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서 관리 | Admin</title>
<link rel="shortcut icon" type="image⁄x-icon" href="http://localhost:9000/mybook/images/icon.png">
<script src="http://localhost:9000/mybook/js/jquery-3.6.0.min.js" ></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" ></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" >
<link href="http://localhost:9000/mybook/css/admin/book/admin_book_content.css" rel="stylesheet" >
<script type="text/javascript" src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
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
		 	<div class="review">
		 		<c:forEach var = "vo"  items="${list}">		
		 			<div class="review_text">
		 				<p>
		 					<img src="http://localhost:9000/mybook/images/star${vo.star }.gif" width=100px height=18 > ${vo.rdate }
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
		 	<a href="admin_book_rental.do?bid=${vo.bid }" class="btn btn-primary" id="rental">대여중인 회원</a>
		</div>
	</div>
</section>
</body>
</html>