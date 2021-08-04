<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>열람실 관리 | Admin</title>
<script src="http://localhost:9000/mybook/js/jquery-3.6.0.min.js" ></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" ></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" >
<style>
	.room { border-bottom:4px solid rgb(76,127,242); }
	.center { width:1319.2px; height:705px; float:left;  }
	.center h3 { font-weight:bold; margin:15px 20px; font-size:16px; }
	.center p { float:right; margin-top:-35px; margin-right:20px; }
	.center a, .center span { font-size:12px; font-weight:normal; float:left; }
	.list_box { width:1275px; height:600px; background-color:white; margin-left:20px; }
	
	.seat { width:100%; display:inline-block; height:500px; margin-top:20px; text-align:center; }
	 .seat_box { width:800px; display:inline-block; margin-top:20px; text-align:center; margin-top:60px; }
	.seat_box #btn { 
		border:1px solid lightgray;
		width:40px; height:40px;
		font-size:14px;
	 }
	 .seat_box .no { background-color:rgb(245,129,135); color:black; }
	 .seat_box .yes { background-color:white; }
	#write, #write_no, #reset { margin:10px 0 10px 10px; font-size:12px; font-weight:normal; float:left; }
	#reset { float:right; margin-right:10px; }
</style>
</head>
<script>
	$(document).ready(function() {
		$("button[id=btn]").click(function() {
			$(this).css("border","2px solid");
		});
	});
</script>
<body>
<jsp:include page="../admin_main.jsp"></jsp:include>

<section class="center">
	<h3>열람실 목록</h3>
	<p><a>열람실</a><span>></span><a>열람실 목록</a></p>
	<div class="list_box">
	<button class="btn btn-primary" id="write">새로운 좌석 등록</button>
	<button class="btn btn-secondary" id="write_no">사용불가 좌석 등록</button>
	<button class="btn btn-outline-secondary" id="reset">사용 좌석 전체 해제</button>
		<div class="seat">				
		 	<div class="seat_box">
		 		<c:forEach var = "vo"  items="${list}" >
		 			<c:if test="${vo.status eq 0 }">
		 				<button id="btn" class="yes">${vo.seat_number }</button>
		 			</c:if>
		 			<c:if test= "${vo.status eq 1 }">
		 				<button id="btn" disabled class="no">사용</button>
		 			</c:if>
		 		</c:forEach>
		 	</div>
		</div>
	</div>			
</section>
</body>
</html>