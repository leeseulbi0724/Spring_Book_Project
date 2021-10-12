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
<link href="http://localhost:9000/mybook/css/admin/board/admin_board_content.css" rel="stylesheet" >
</head>
<script>
	$(document).ready(function() {
		$("#delete").click(function() {
			if (confirm("게시물을 삭제하시겠습니까?")) {	
				$.ajax({
	                type: "post",
	                url: "board_delete.do",             
	                data:{bid:"${vo.bid}"},
	                dataType: 'json',
	                success: function (result) {
	                	alert("게시물이 삭제되었습니다");
	                	location.replace("admin_board.do");
	                },
	           }); 
			} 
		});
		
		$(".comment_delete").click(function() {
			var cid = $(this).attr("id");
			if (confirm("댓글을 삭제하시겠습니까?")) {	
				$.ajax({
	                type: "post",
	                url: "board_comment_delete.do",             
	                data:{cid:cid},
	                dataType: 'json',
	                success: function (result) {
	                	alert("댓글이 삭제되었습니다");
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
	<h3>게시판 목록</h3>
	<p><a>게시판</a><span>></span><a>게시판 목록</a><span>></span><a>게시판 상세보기</a></p>
	<div class="list_box">
			<table class="table">
		 		<tr>
		 			<td colspan="2"><strong>${vo.btitle }</strong></td>
		 		</tr>
		 		<tr>
		 			<th>작성일</th>
		 			<th>${vo.bdate }</th>
		 		</tr>
		 		<tr>
		 			<th>작성자</th>
		 			<th>${vo.id }</th>
		 		</tr>	
		 		<tr>
		 			<th>첨부파일</th>
		 			<c:if test = "${not empty vo.bfile }">
		 				<th>
						<c:forEach var = "vo"  items="${img_list}" varStatus="status">	
							<a href="http://localhost:9000/mybook/upload/${vo.bsfile}" target='_blank' id="file">${vo.bfile}</a>
						</c:forEach>
						</th>
					</c:if>
					<c:if test="${empty vo.bfile }">
						<th>첨부된 파일이 없습니다</th>
					</c:if>
		 		</tr>	 		
		 		<tr>
		 			<td colspan="2">
		 				<textarea disabled style="resize: none;">${vo.bcontent }</textarea>		 						
		 			</td>
		 		</tr>
		 	</table>
		 	<div class="comment">		
		 		<c:if test="${empty list }">
		 			<p style="margin-left:10px; ">댓글이 없습니다</p>
		 		</c:if>	
		 		<c:forEach var = "vo"  items="${list}" varStatus="status">
			 		<div class="comment_div">
			 			<p>	<strong>${vo.id }</strong><br>
			 			${vo.ccontent }<br>
			 			<span style="color:gray">${vo.cdate }</span><a class="comment_delete" id="${vo.cid }">삭제</a></p>
			 		</div>
		 		</c:forEach>		 		
		 	</div>	 
		 	<a href="admin_board.do" class="btn btn-secondary" id="list">목록</a>	
		 	<a class="btn btn-primary" id="delete"  >삭제</a>	
	</div>
</section>
</body>
</html>