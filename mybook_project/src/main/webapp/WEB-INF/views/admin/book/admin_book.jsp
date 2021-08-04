<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서 관리 | Admin</title>
<script src="http://localhost:9000/mybook/js/jquery-3.6.0.min.js" ></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" ></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" >
<style>
	.book { border-bottom:4px solid rgb(76,127,242); }
	.center { width:1319.2px; height:705px; float:left;  background-color:rgb(234,238,241); }
	.center h3 { font-weight:bold; margin:15px 20px; font-size:16px; }
	.center p { float:right; margin-top:-35px; margin-right:20px; }
	.center  a, .center span { font-size:12px; font-weight:normal; float:left; }
	.list_box { width:1275px; height:600px; background-color:white; margin-left:20px; }
	
	.search { float:right; margin:10px; }
	#s_select { width:100px; display:inline-block; font-size:12px; border-radius:15px; }
	#search {
		background-image : url('http://localhost:9000/homeproject/images/search.png'); 
  		background-repeat:no-repeat;
  		background-size: 20px;
  		background-position:right;
  		width:200px; display:inline-block; font-size:12px; border-radius:15px;
	}
	.table { text-align:center; font-size:14px; }	
	table th:first-child { width:600px; }
	table th:nth-child(2) { wdith:300px; }
	table th:nth-child(4) { width:150px; }
	table th:nth-child(5) { width:50px; }
	table th:nth-child(6), table th:nth-child(7) { width:70px; }
 
	#write { margin:10px 0 10px 10px; }
	
	#delete, #update { margin:0; font-size:13px; padding:0 10px; }
	
	.button { text-align:center; margin-top:-80px; }
	.button>div { display:inline-block; }
	
	#search_btn { padding:3px 10px; font-size:13px; }
</style>
</head>
<script>
	$(document).ready(function() {
		$("button[id=delete]").click(function() {
			var bid = $(this).attr("name");
			  var con_test = confirm("도서를 삭제하시겠습니까?"); 
	        	if(con_test == true){   
					 $.ajax({
			                type: "post",
			                url: "book_delete_proc.do",
			                data: {bid:bid},
			                dataType: 'json',
			                success: function (result) {
			                    if (result) {
			                    	alert("삭제가 완료되었습니다");	                    	
			                    } else {
			                    	alert("삭제가 실패되었습니다");	                            	
			                    }
			                    location.reload();
			                },
		
			            });	        		
	        	}
		});
	});
</script>
<body>
<jsp:include page="../admin_main.jsp"></jsp:include>

<section class="center">
	<h3>도서 목록</h3>
	<p><a>도서</a><span>></span><a>도서 목록</a></p>
	<div class="list_box">
	<a href="admin_book_write.do" class="btn btn-primary" id="write">등록</a>
		<div class="search">
		<form action="admin_book.do" method="post" >
			<select class="form-select" id="s_select"  name="category">
				<option value="name">도서명
				<option value="author">저자
			</select>
			<input type="text" class="form-control" id="search" name="search">
			<button type="submit" class="btn btn-secondary" id="search_btn">검색</button>
		</form>
		</div>
		<div class="container">	
		<table class="table table-striped table-hover">
			<thead>
				<tr>
					<th>도서명</th>
					<th>저자</th>
					<th>출판사</th>
					<th>출간일</th>
					<th>좋아요</th>
					<th></th>
					<th></th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var = "vo"  items="${list}" varStatus="status">	
				<tr>
					<td>${vo.bname }</td>
					<td>${vo.bauthor }</td>
					<td>${vo.bpublish }</td>
					<td>${vo.bdate }</td>
					<td>${vo.bheart }</td>
					<td><a href="admin_book_update.do?bid=${vo.bid }" type="button" class="btn btn-outline-success"  id="update" >수정</a></td>
					<td><button type="button" class="btn btn-outline-danger"  id="delete"  name="${vo.bid }">삭제</button></td>				
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
			    	<a class="page-link" href="admin_book.do?page=${pageNum }">${pageNum }</a>
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
			    	<a class="page-link" href="admin_book.do?page=${pageNum }&search=${search}&category=${category}">${pageNum }</a>
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