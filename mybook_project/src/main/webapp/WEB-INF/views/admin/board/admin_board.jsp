<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 관리 | Admin</title>
<link rel="shortcut icon" type="image⁄x-icon" href="http://localhost:9000/mybook/images/icon.png">
<script src="http://localhost:9000/mybook/js/jquery-3.6.0.min.js" ></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" ></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" >
<link href="http://localhost:9000/mybook/css/admin/board/admin_board.css" rel="stylesheet" >
</head>
<body>
<jsp:include page="../admin_main.jsp"></jsp:include>

<section class="center">
	<h3>게시판 목록</h3>
	<p><a>게시판</a><span>></span><a>게시판 목록</a></p>
	<div class="list_box">
		<div class="search">
			<form action="admin_board.do" method="post">
			<select class="form-select" id="s_select"  name="category">
				<option value="id">아이디
				<option value="title">제목				
			</select>
			<input type="text" class="form-control" id="search" name="search" autocomplete="off" >
			<button type="submit" class="btn btn-secondary" id="search_btn">검색</button>
			</form>
		</div>
		<div class="container">	
		<table class="table table-hover">
			<thead class="table-light">
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>아이디</th>
					<th>날짜</th>
					<th>조회수</th>
					<th>댓글수</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var = "vo"  items="${list}" varStatus="status">						
			 		<tr>
			 			<td>${ (pageMaker.totalCount - status.index) - ( (pageMaker.cri.page - 1)  *  pageMaker.displayPageNum ) } </td>
			 			<td>${vo.btitle }</td>
			 			<td>${vo.id }</td>
			 			<td>${vo.bdate }</td>
			 			<td>${vo.bhit }</td>
			 			<td>${vo.count }개</td>
			 			<td><a href="admin_board_content.do?bid=${vo.bid }" class="btn btn-secondary"  id="content"  >내용보기</a></td>				
			 		</tr>		 		
		 		</c:forEach>
			</tbody>
		</table>		
		</div>
	</div>
			<c:if test="${count eq 'all' }">
		<div class="button">
			<div>
			<nav aria-label="Page navigation example">
			<ul class="pagination">
		    <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="pageNum">
			   <li class="page-item ${pageMaker.cri.page == pageNum? "active":"" }">
			    	<a class="page-link" href="admin_board.do?page=${pageNum }">${pageNum }</a>
			    </li>
		    </c:forEach>
			</ul>
			</nav>
			</div>
		</div>
	</c:if>
	<c:if test="${count eq 'search' }">
		<div class="button">
			<div>
			<nav aria-label="Page navigation example">
			<ul class="pagination">
		    <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="pageNum">
			   <li class="page-item ${pageMaker.cri.page == pageNum? "active":"" }">
			    	<a class="page-link" href="admin_board.do?page=${pageNum }&search=${search}&category=${category}">${pageNum }</a>
			    </li>
		    </c:forEach>
			</ul>
			</nav>
			</div>
		</div>
	</c:if>
</section>
</body>
</html>