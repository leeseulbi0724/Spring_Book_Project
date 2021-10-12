<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 관리 | Admin</title>
<link rel="shortcut icon" type="image⁄x-icon" href="http://localhost:9000/mybook/images/icon.png">
<script src="http://localhost:9000/mybook/js/jquery-3.6.0.min.js" ></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" ></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" >
<link href="http://localhost:9000/mybook/css/admin/user/admin_user.css" rel="stylesheet" >
</head>
<script>
 $(document).ready(function() {
	 
	 
	 
	 
	 $("button[id=request]").click(function() {
	    	var id = $(this).attr("name");   
	    	var con_test = confirm("회원탈퇴 처리를 하시겠습니까?"); 
	       	if(con_test == true){   
	         $.ajax({
	                type: "post",
	                url: "member_drop.do",
	                data:{id:id},
	                dataType: 'json',
	                success: function (result) {
	                    location.reload();
	                },

	        });
	 	}
 	});	 
	 
	 
		
 })
</script>
<body>
<jsp:include page="../admin_main.jsp"></jsp:include>

<section class="center">
	<h3>회원 목록</h3>
	<p><a>회원</a><span>></span><a>회원 목록</a></p>
	<div class="list_box">
		<div class="search">
			<form action="admin_user.do" method="post" >
				<select class="form-select" id="s_select"  name="category">
					<option value="id">아이디
					<option value="name">이름
				</select>
				<input type="text" class="form-control" id="search_input" name="search" autocomplete="off" >
				<button type="submit" class="btn btn-secondary" id="search_btn">검색</button>
			</form>
		</div>
		<div class="container">	
		<table class="table table-striped table-hover">
			<thead>
				<tr>
					<th>ID</th>
					<th>이름</th>
					<th>주민등록번호</th>
					<th>휴대폰번호</th>
					<th>가입일자</th>
					<th>탈퇴신청</th>
				</tr>
			</thead>
			<tbody class="tbody">
			<c:forEach var = "vo"  items="${list}" varStatus="status">
				<tr>
					<td>${vo.id }</td>
					<td >${vo.name }</td>
					<td>${vo.birth }</td>
					<td>${vo.hp }</td>
					<td>${vo.mdate }</td>			
					<c:if test = "${vo.id_del eq '0'}">
						<td><button type="button" class="btn btn-secondary"  disabled id="request">탈퇴</button></td>	
					</c:if>
					<c:if test = "${vo.id_del eq '1'}">
						<input type="hidden" name=currentid${status.index} value="${vo.id }">
						<td><button type="button" class="btn btn-danger"  id="request" name="${vo.id }" >탈퇴</button></td>	
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
			    	<a class="page-link" href="admin_user.do?page=${pageNum }">${pageNum }</a>
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
			    	<a class="page-link" href="admin_user.do?page=${pageNum }&search=${search}&category=${category}">${pageNum }</a>
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