<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<c:set var="today" value="<%=new java.util.Date()%>" />	
<c:set var="date"><fmt:formatDate value="${today}" pattern="yyyy-MM-dd" /></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" type="image⁄x-icon" href="http://localhost:9000/mybook/images/icon.png">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" ></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" >
<script src="http://localhost:9000/mybook/js/jquery-3.6.0.min.js" ></script>
<link href="http://localhost:9000/mybook/css/commons.css" rel="stylesheet" >
<link href="http://localhost:9000/mybook/css/request/request.css" rel="stylesheet" >
<title>희망도서 신청 | 라온 도서관</title>
</head>
<script>
	$(document).ready(function() {
		$(".request_content").click(function() {
			if ("${session_id}" == $(this).attr("id")) {
				$(this).attr("href","request_content.do?rid="+$(this).attr("name"));
			} else {
				alert("작성자만 확인가능합니다");
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
		 	<a href="request.do">커뮤니티</a>><a href="request.do">희망도서 신청</a>
		 </div>
	 </div>
	 <div class="content">
		 <div class="left">
		 	<ul>
		 		<li><a href="notice.do">공지사항</a></li>
		 		<li><a href="board.do">자유 게시판</a></li>
		 		<li><a href="request.do">희망도서 신청</a></li>
		 	</ul>
		 </div>
		 <div class="center">
		 	<div class="title">
		 		<h3>희망도서 신청</h3>
		 		<img src="http://localhost:9000/mybook/images/title_back.gif" height=100% >
		 	</div>
		 	<div class="search">
		 		<a href="request_write.do" class="btn write btn_write">신청</a>	
		 	</div>
		 	<table class="table">
		 		<tr>
		 			<th>번호</th>
		 			<th>제목</th>
		 			<th>작성자</th>
		 			<th>날짜</th>
		 		</tr>		 		
		 		<c:forEach var = "vo"  items="${list}" varStatus="status">						
			 		<tr>
			 			<td>${ (pageMaker.totalCount - status.index) - ( (pageMaker.cri.page - 1)  *  pageMaker.displayPageNum ) } </td>
			 			<td>
			 				<a class="request_content" id="${vo.id }" name="${vo.rid }">희망도서 신청합니다!
			 					<img src="http://localhost:9000/mybook/images/lock_yellow.png" width=15 height=15>
				 				<c:if test="${date eq vo.rdate }">
				 					<img src="http://localhost:9000/mybook/images/new.png" width=20 height=20 style="vertical-align:bottom" class="new">
				 				</c:if>
			 				</a>
			 			</td>
			 			<td>${vo.name }**(${vo.id })</td>
			 			<td>${vo.rdate }</td>
			 		</tr>		
		 		</c:forEach>		 		
		 	</table>
		 	<div class="button">
				<div>
				<nav aria-label="Page navigation example">
				<ul class="pagination pagination-sm">
				    <li class="page-item">
				        <a class="page-link" ><</a>
				    </li>
			    <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="pageNum">
				   <li class="page-item ${pageMaker.cri.page == pageNum? "active":"" }">
				    	<a class="page-link" href="request.do?page=${pageNum }">${pageNum }</a>
				    </li>
			    </c:forEach>
				    <li class="page-item">
				        <a class="page-link">></a>
				    </li>
				</ul>
				</nav>
				</div>
			</div>
		 </div>
	</div>
</section>

<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>