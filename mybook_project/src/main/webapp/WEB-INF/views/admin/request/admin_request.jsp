<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>희망도서 관리 | Admin</title>
<link rel="shortcut icon" type="image⁄x-icon" href="http://localhost:9000/mybook/images/icon.png">
<script src="http://localhost:9000/mybook/js/jquery-3.6.0.min.js" ></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" ></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" >
<link href="http://localhost:9000/mybook/css/admin/request/admin_request.css" rel="stylesheet">
</head>
<body>
<jsp:include page="../admin_main.jsp"></jsp:include>

<section class="center">
	<h3>희망도서 목록</h3>
	<p><a>희망도서</a><span>></span><a>희망도서 목록</a></p>
	<div class="list_box">
		<div class="search">
		<form action="admin_request.do" method="post">
			<select class="form-select" id="s_select" >
				<option>아이디
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
					<th>도서명</th>
					<th>아이디</th>
					<th>날짜</th>
					<th>신청여부</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var = "vo"  items="${list}" varStatus="status">				
				<tr>
					<td>${ (pageMaker.totalCount - status.index) - ( (pageMaker.cri.page - 1)  *  pageMaker.displayPageNum ) }</td>
					<td>${vo.bname }</td>
					<td>${vo.id }</td>
					<td>${vo.rdate }</td>
					<c:if test="${vo.status eq 0 }">
						<td>N</td>			
						<td><button onclick="location.href='admin_request_content.do?rid=${vo.rid }'" type="button" class="btn btn-secondary"  id="request" >등록하기</button></td>				
					</c:if>
					<c:if test="${vo.status eq 1 }">
						<td>Y</td>
						<td><button type="button" class="btn btn-secondary"  id="request" disabled >등록완료</button></td>				
					</c:if>
					
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
			    	<a class="page-link" href="admin_request.do?page=${pageNum }">${pageNum }</a>
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
			    	<a class="page-link" href="admin_request.do?page=${pageNum }&search=${search}">${pageNum }</a>
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