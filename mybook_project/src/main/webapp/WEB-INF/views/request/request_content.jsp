<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" type="image⁄x-icon" href="http://localhost:9000/mybook/images/icon.png">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" ></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" >
<script src="http://localhost:9000/mybook/js/jquery-3.6.0.min.js" ></script>
<link href="http://localhost:9000/mybook/css/commons.css" rel="stylesheet" >
<title>희망도서 신청 | 라온 도서관</title>
<style>	
	.com { color:rgb(43,129,199); border-bottom:5px solid rgb(43,129,199); }
	.home, .book {	color:rgb(162,162,162); }
	
	.left ul li:nth-child(3) a { color:rgb(43,129,199); font-weight:bold; }

	.form-control { display:inline-block; margin-bottom:5px; font-size:14px; width:800px; }
	#bname, #bauthor, #bpublish { background-color:white; }
	
	.back { 
		background-color:rgb(109,171,239); color:white; 
		margin-top:20px; padding:3px10px;
	}
	.back:hover { background-color:lightgray; }
	
	.table { margin-top:20px; font-size:14px; }
	.table tr { border-bottom:1px solid lightgray; }
	.table th { font-weight:normal; text-align:left; padding-left:15px; }
	.table th:first-child { width:100px; background-color:rgb(248,248,248); vertical-align:middle; }
	
	.table th>a{ padding:3px 10px; font-size:13px; margin-left:10px; }
	
</style>
</head>
<script>
	$(document).ready(function() {
		$(".delete").click(function() {
			if (confirm("신청을 삭제하시겠습니까?")) {	
				$.ajax({
	                type: "post",
	                url: "request_delete.do", 
	                data:{rid:"${vo.rid}"},
	                dataType: 'json',
	                success: function (result) {
	                	alert("신청이 삭제되었습니다");
	                	location.replace("request.do");
	                },
	           }); 
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
				<table class="table">				
			 		<tr>
			 			<th>책명</th>
			 			<th><input type="text" class="form-control" name="bname" id="bname" value="${vo.bname }" readonly></th>
			 		</tr>
			 		<tr>
			 			<th>저자</th>
			 			<th><input type="text" class="form-control" name="bauthor" id="bauthor" value="${vo.bauthor }" readonly></th>
			 		</tr>
			 		<tr>
			 			<th>출판사</th>
			 			<th><input type="text" class="form-control" name="bpublish" id="bpublish" value="${vo.bpublish }" readonly></th>
			 		</tr>			 		 		
		 		</table>
		 		<table class="table">	
			 		<tr>
			 			<th>신청결과</th>
			 			<c:if test="${vo.status eq 0}">
			 				<th><span style="color:blue">신청중</span></th>
			 			</c:if>
			 			<c:if test="${vo.status eq 1 }">
			 				<th><span style="color:red">등록완료</span><a href="content.do?bid=${bid }" class="btn btn-outline-secondary">상세보기</a></th>
			 			</c:if>
			 		</tr>			 		 		
		 		</table>
				<a href="request.do" class="btn back">목록</a>
				<c:if test="${vo.status eq 0 }">
					<a href="request_update.do?rid=${vo.rid }" class="btn back update">수정</a>
					<button class="btn back delete">삭제</button>
				</c:if>
		 </div>
	</div>
</section>

<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>