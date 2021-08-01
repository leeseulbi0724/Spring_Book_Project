<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 | 라온 도서관 </title>
<link rel="shortcut icon" type="image⁄x-icon" href="http://localhost:9000/mybook/images/icon.png">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" ></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" >
<script src="http://localhost:9000/mybook/js/jquery-3.6.0.min.js" ></script>
<style>
	.one { border-bottom:2px solid rgb(43,129,199); }	
	.four, .three, .two { border-bottom:2px solid lightgray; }
	
	.content { 
		background-color:rgb(248,249,251); 
		width:100%;
		margin-bottom:-100px; 
		border-top:1px solid lightgray;
		text-align:center;
	}
	
	.center { display:inline-block; width:1000px; margin:50px 0; }
	.table { background-color:white; width:1000px; }
	.table th { font-weight:normal; border-top:1px solid lightgray; border-bottom:1px solid lightgray; }
	.table tr:first-child td { background-color:rgb(222,225,230); }
	 .table tr:nth-child(2) td {
		 background-color:rgb(247,248,249); 
		 border-bottom:1px solid lightgray;
	}
	.comment_table th:first-child { width:600px; }
	.comment_table th:nth-child(3) { width:150px; }
	.board_table th:first-child { width:700px; }	
	.board_table th:nth-child(2) { width:80px; }
	.board_table th:nth-child(3), .comment_table th:nth-child(2)  { width:280px; }
	.table th:last-child { width:100px; }
	.table th>a { text-decoration:none; color:black; }
	
	#return { background-color:#4fa9de; color:white; margin:5px; padding:2px 10px; border:none; border-radius:4px; }
	#content { background-color:rgb(247,248,249); margin:5px; padding:2px 10px; border:none; border-radius:4px; }
	#return:hover { background-color:rgb(23,86,123); }
	#content:hover { background-color:rgb(222,225,230); }
</style>
</head>
<script>
$(function () {
	$('#profile').click(function (e) {
		e.preventDefault();	
		$('#file').click();	
	});
	
	$(".delete").click(function() {
		var bid = $(this).attr("name");
		if (confirm("게시물을 삭제하시겠습니까?")) {	
			$.ajax({
                type: "post",
                url: "board_delete.do",             
                data:{bid:bid},
                dataType: 'json',
                success: function (result) {
                	alert("게시물이 삭제되었습니다");
                	location.reload();
                },
           }); 
		} 
	});
	
	$(".com_delete").click(function() {
		var cid = $(this).attr("name");
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
 <jsp:include page="../header.jsp"></jsp:include>
 
  <jsp:include page="mypage_commons.jsp"></jsp:include>
  <section class="content">
	  	   	 <div class="center">
 		 	<table class="table board_table">
		 		<tr>
		 			<td colspan="4" style="font-size:18px;">내가 작성한 게시글</td>
		 		</tr>
		 		<tr>
		 			<td>제목</td>
		 			<td>댓글수</td>
		 			<td>작성일</td>
		 			<td></td>
		 		</tr>		 
		 		<c:forEach var = "vo"  items="${blist}" >		
			 		<tr>
			 			<th><a href="board_content.do?bid=${vo.bid }" >${vo.btitle }</a></th>
			 			<th>${vo.count }개</th>
			 			<th>${vo.bdate }</th>
			 			<th><button id="return"  name="${vo.bid }" class="delete">삭제</button></th>
			 		</tr>
			 	</c:forEach>
			 	<c:if test = "${empty blist }">
			 		<tr>
			 			<th colspan="4">작성된 게시글이 없습니다</th>
			 		</tr>
			 	</c:if>
		 	</table>
		 	
		 	<table class="table comment_table">
		 		<tr>
		 			<td colspan="4" style="font-size:18px;">내가 작성한 댓글</td>
		 		</tr>
		 		<tr>
		 			<td>내용</td>
		 			<td>작성일</td>
		 			<td></td>
		 			<td></td>
		 		</tr>		 
		 		<c:forEach var = "vo"  items="${clist}" >		
			 		<tr>
			 			<th>${vo.ccontent }</th>
			 			<th>${vo.cdate }</th>
			 			<th><a href="board_content.do?bid=${vo.bid }"  id="content">게시글 보기</a></th>
			 			<th><button id="return"  name="${vo.cid }" class="com_delete">삭제</button></th>
			 		</tr>
			 	</c:forEach>
			 	<c:if test = "${empty clist }">
			 		<tr>
			 			<th colspan="4">작성된 댓글이 없습니다</th>
			 		</tr>
			 	</c:if>
			 </table>
		 </div>
  </section>
   <jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>