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
	.table th:first-child { width:400px; }	
	.table th:nth-child(2) { width:100px; }
	.table th:nth-child(3) { width:650px; }
	.table th:nth-child(4) { width:300px; }
	.table th:last-child { width:150px; }
	.table th>a { text-decoration:none; color:black; }
	
	#return { background-color:#4fa9de; color:white; margin:5px; padding:2px 10px; border:none; border-radius:4px; }
	#return:hover { background-color:rgb(23,86,123); }
</style>
</head>
<script>
$(function () {
	$('#profile').click(function (e) {
		e.preventDefault();	
		$('#file').click();	
	});
	
	$("#return").click(function() {
		 var con_test = confirm("작성하신 후기를 삭제하시겠습니까?"); 
       	if(con_test == true){   		
       		var rid = $(this).attr("name");
				$.ajax({
	                type: "post",
	                url: "review_delete.do",
	                data:{rid:rid},
	                dataType: 'json',
	                success: function (result) {
	                	if (result) {
		                	alert("삭제가 완료되었습니다");
		                	 location.reload();	
	                	}
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
 		 	<table class="table">
		 		<tr>
		 			<td colspan="5" style="font-size:18px;">내가 작성한 후기</td>
		 		</tr>
		 		<tr>
		 			<td>책명</td>
		 			<td>별점</td>
		 			<td>내용</td>
		 			<td>작성일</td>
		 			<td></td>
		 		</tr>		 
		 		<c:forEach var = "vo"  items="${list}" >		
			 		<tr>
			 			<th><a href="content.do?bid=${vo.bid }" >${vo.bname }</a></th>
			 			<th><img src="http://localhost:9000/mybook/images/star${vo.star }.gif" width=100 height=18></th>
			 			<th>${vo.content }</th>
			 			<th>${vo.rdate }</th>
			 			<th><button id="return"  name="${vo.rid }">삭제</button></th>
			 		</tr>
			 	</c:forEach>
		 	</table>
		 </div>
  </section>
   <jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>