<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 관리 | Admin</title>
<link rel="shortcut icon" type="image⁄x-icon" href="http://localhost:9000/mybook/images/icon.png">
<script src="http://localhost:9000/mybook/js/jquery-3.6.0.min.js" ></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" ></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" >
<style>
	.notice { border-bottom:4px solid rgb(76,127,242); }
	.center { width:1319.2px; height:705px; float:left;  }
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
		
	#write { margin:10px 0 10px 10px; }
	
	.button { text-align:center; }
	.table { text-align:center; font-size:14px; border:none; }	
	td>a { color:black; text-decoration:none; }
	
	thead th:nth-child(2) { width:800px; }
	thead th:nth-child(5), thead th:nth-child(6) { width:80px; }
	#delete, #update { margin:0; padding:0; font-size:13px; padding:0 10px; }
	
	.button { text-align:center; margin-top:-80px; }
	.button>div { display:inline-block; }
	
	#search_btn { padding:3px 10px; font-size:13px; }
</style>
</head>
<script>
	$(document).ready(function() {
		$("button[id=delete]").click(function(){
			var nid = $(this).attr("name");
			  var con_test = confirm("게시글을 삭제하시겠습니까?"); 
	        	if(con_test == true){   
					 $.ajax({
			                type: "post",
			                url: "notice_delete_proc.do",
			                data: {nid:nid},
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
		})
	});
</script>
<body>
<jsp:include page="../admin_main.jsp"></jsp:include>

<section class="center">
	<h3>공지사항 목록</h3>
	<p><a>공지사항</a><span>></span><a>공지사항 목록</a></p>
	<div class="list_box">
	<a href="admin_notice_write.do" class="btn btn-primary" id="write">등록</a>
		<div class="search">
		<form action="admin_notice.do" method="post" >
			<select class="form-select" id="s_select"  name="category">
				<option>제목
			</select>
			<input type="text" class="form-control" id="search" name="search" autocomplete="off" >
			<button type="submit" class="btn btn-secondary" id="search_btn">검색</button>
		</form>
		</div>
		<div class="container">	
		<form name="admin_delete" action="process/admin_delete_process.jsp" method="post" enctype= "multipart/form-data">		
		<table class="table table-hover">
			<thead class="table-light">
				<tr>
					<th>NO</th>
					<th>제목</th>
					<th>등록일</th>
					<th>조회수</th>
					<th></th>
					<th></th>
				</tr>
			</thead>
					<tbody>		
					<c:forEach var = "vo"  items="${list}" varStatus="status">				
							<tr>
								<td>${ (pageMaker.totalCount - status.index) - ( (pageMaker.cri.page - 1)  *  pageMaker.displayPageNum ) } </td>
								<td >${vo.ntitle }</td>
								<td>${vo.ndate }</td>
								<td>${vo.ncount }</td>
								<td><a href="admin_notice_update.do?nid=${vo.nid }" type="button" class="btn btn-outline-success"  id="update" >수정</a></td>
								<td><button type="button" class="btn btn-outline-danger"  id="delete" name="${vo.nid }" >삭제</button></td>
							</tr>
					</c:forEach>							
					</tbody>			
		</table>
		</form>		
		</div>
	</div>
				<c:if test="${count eq 'all' }">
		<div class="button">
			<div>
			<nav aria-label="Page navigation example">
			<ul class="pagination">
		    <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="pageNum">
			   <li class="page-item ${pageMaker.cri.page == pageNum? "active":"" }">
			    	<a class="page-link" href="admin_notice.do?page=${pageNum }">${pageNum }</a>
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
			    	<a class="page-link" href="admin_notice.do?page=${pageNum }&search=${search}">${pageNum }</a>
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