<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<c:set var="today" value="<%=new java.util.Date()%>" />	
<c:set var="date"><fmt:formatDate value="${today}" pattern="yyyy-MM-dd" /></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서 관리 | Admin</title>
<script src="http://localhost:9000/mybook/js/jquery-3.6.0.min.js" ></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" ></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" >
<script type="text/javascript" src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<style>
	.book { border-bottom:4px solid rgb(76,127,242); }
	.center { width:1319.2px; height:705px; float:left;  background-color:rgb(234,238,241); }
	.center h3 { font-weight:bold; margin:15px 20px; font-size:16px; }
	.center>p { float:right; margin-top:-35px; margin-right:20px; }
	.center>p>a, .center>p>span { font-size:12px; font-weight:normal; float:left; }
	.list_box { width:1275px; height:600px; background-color:white; margin-left:20px; text-align:center; }

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
	table th:first-child { width:200px; }
	table th:nth-child(2) { wdith:400px; }
	table th:nth-child(3) { width:400px; }
	table th:nth-child(4) { width:200px; }
	table th:nth-child(5) { width:100px; }
	table td { vertical-align:middle; }
	table td>button.bell { margin:0; padding:0; font-size:13px; padding:0 10px; }
	
	#search_btn { padding:3px 10px; font-size:13px; }
	
	.button { text-align:center; margin-top:-80px; }
	.button>div { display:inline-block; }
	
	
</style>
</head>
<script>
	$(document).ready(function() {
		
		
		$(".bell").click(function() {
			var id = $(this).attr("name"); //회원 아이디
			var bid = $(this).attr("id"); //해당 도서 시퀀스
			var con_test = confirm("반납 알림메세지를 보내겠습니까?"); 
        	if(con_test == true){   
				 $.ajax({
		                type: "post",
		                url: "admin_rental_bell.do",
		                data: {bid:bid, id:id},
		                dataType: 'json',
		                success: function (result) {
		                	if (result) {
		                		alert("회원에게 알림 메세지를 전송하였습니다")
			                    location.reload();
		                	}		                   	
		                },
	
		            });	        		
        	}
		});
		
		
		
	});
</script>
<body>
<jsp:include page="../admin_main.jsp"></jsp:include>

<section class="center">
	<h3>대여중인 회원</h3>
	<p><a>도서</a><span>></span><a>도서 목록</a><span>></span><a>도서 상세보기</a><span>></span><a>대여중인 회원</a></p>
	<div class="list_box">		
		<div class="search">
		<form action="admin_book_rental.do?bid=${bid }" method="post" >
			<select class="form-select" id="s_select"  name="category">
				<option value="id">아이디
			</select>
			<input type="text" class="form-control" id="search" name="search" autocomplete="off" >
			<button type="submit" class="btn btn-secondary" id="search_btn">검색</button>
		</form>
		</div>
		<div class="container">	
		<table class="table table-striped table-hover">
			<thead>
				<tr>
					<th>아이디</th>
					<th>대여일</th>
					<th>반납일</th>
					<th>남은 대여일 수</th>
					<th></th>
				</tr>
			</thead>
			<c:if test ="${empty list }">
				<tr>
					<td colspan="5">대여중인 회원이 없습니다</td>
				</tr>
			</c:if>
			<c:if test ="${not empty list }">
				<c:forEach var = "vo"  items="${list}" varStatus="status">	
				<tr>
					<fmt:parseDate value="${vo.startday }" var="start" pattern="yyyy-MM-dd"/>
					<fmt:parseNumber value="${start.time / (1000*60*60*24)}" integerOnly="true" var="startday"></fmt:parseNumber>
					<fmt:parseDate value="${vo.endday }" var="end" pattern="yyyy-MM-dd"/>
					<fmt:parseNumber value="${end.time / (1000*60*60*24)}" integerOnly="true" var="endday"></fmt:parseNumber>
					<fmt:parseDate value="${date }" var="n" pattern="yyyy-MM-dd"/>
					<fmt:parseNumber value="${n.time / (1000*60*60*24)}" integerOnly="true" var="now"></fmt:parseNumber>
						<td>${vo.id }</td>
						<td>${vo.startday }</td>
						<td>${vo.endday }</td>
						<c:if test = "${date > vo.endday }">
							<td>D+${endday-now } <br><span style="color:red">대여일이 지났습니다</span></td>		
							<td><button class="btn btn-danger bell"  type="button" name="${vo.id }" id="${vo.bid }">알림전송</button></td>			
						</c:if>	
						<c:if test = "${date < vo.endday }">
							<td>D-${endday-now }</td>					
							<td><button type="button" class="btn btn-secondary bell"  disabled>알림전송</button></td>
						</c:if>					
				</tr>
				</c:forEach>
			</c:if>
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
			    	<a class="page-link" href="admin_book_rental.do?page=${pageNum }">${pageNum }</a>
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
			    	<a class="page-link" href="admin_book_rental.do?page=${pageNum }&search=${search}">${pageNum }</a>
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