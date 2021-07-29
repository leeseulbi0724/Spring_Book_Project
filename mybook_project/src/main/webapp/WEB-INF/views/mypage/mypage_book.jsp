<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서대여 | 라온 도서관 </title>
<link rel="shortcut icon" type="image⁄x-icon" href="http://localhost:9000/mybook/images/icon.png">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" ></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" >
<script src="http://localhost:9000/mybook/js/jquery-3.6.0.min.js" ></script>
<style>
	.four { border-bottom:2px solid rgb(43,129,199); }	
	.one, .three, .two { border-bottom:2px solid lightgray; }
	
	.content { 
		background-color:rgb(248,249,251); 
		width:100%; 
		margin-bottom:-100px; 
		border-top:1px solid lightgray;
	}
	.center { display:inline-block; width:1000px; margin:50px 0; }
	
	.table { background-color:white; width:1000px; }
	.table th { font-weight:normal; border-top:1px solid lightgray; border-bottom:1px solid lightgray; }
	.table tr:first-child td { background-color:rgb(222,225,230); }
	 .table tr:nth-child(2) td {
		 background-color:rgb(247,248,249); 
		 border-bottom:1px solid lightgray;
	}
	.table th:first-child { width:600px; }
	.table th:last-child, .table th:nth-child(4) { width:100px; }
	.book_table th>a { text-decoration:none; color:black; }
	#ing { background-color:#4fa9de; color:white; margin:5px; padding:2px 10px; border:none; border-radius:4px; }
	#cancle, #return { background-color:rgb(247,248,249); margin:5px; padding:2px 10px; border:none; border-radius:4px; }
	#ing:hover { background-color:rgb(23,86,123); }
	#return:hover, #cancle:hover { background-color:rgb(222,225,230); }
</style>
</head>
<script>
$(document).ready(function() {	
	$("button[id=return]").click(function() {	
		var bid = $(this).attr("name");
    	var con_test = confirm("해당 도서를 반납하시겠습니까?"); 
    	if(con_test == true){   
         $.ajax({
                type: "post",
                url: "book_return_proc.do",
                data:{bid:bid},
                dataType: 'json',
                success: function (result) {
                   if (result) {
                	   alert("도서 반납 완료되었습니다");
                	   location.reload();
                   }
                },

            });
    	}	
	});
	
	$("button[id=cancle]").click(function() {	
		var number = $(this).attr("name");
    	var con_test = confirm("열람실 예약을 취소하시겠습니까?"); 
    	if(con_test == true){   
         $.ajax({
                type: "post",
                url: "room_cancle_proc.do",
                data:{number:number},
                dataType: 'json',
                success: function (result) {
                   if (result) {
                	   alert("예약이 취소되었습니다");
                	   location.reload();
                   }
                },

            });
    	}	
	});
})
</script>
<body>
 <jsp:include page="../header.jsp"></jsp:include>
 
  <jsp:include page="mypage_commons.jsp"></jsp:include>
  <section class="content">
 	 <div class="center">
 		 	<table class="table book_table">
		 		<tr>
		 			<td colspan="5" style="font-size:18px;">현재 대여중인 도서</td>
		 		</tr>
		 		<tr>
		 			<td>책명</td>
		 			<td>대여일</td>
		 			<td>반납일</td>
		 			<td></td>
		 			<td></td>
		 		</tr>
		 		<c:forEach var = "vo"  items="${list}" varStatus="status">				
			 		<tr>
			 			<th><a href="content.do?bid=${vo.bid}" >${vo.bname }</a></th>
			 			<th>${vo.startday }</th>
			 			<th>${vo.endday }</th>
			 			<th><button id="return"  name="${vo.bid }">반납하기</button></th>
			 			<th><button id="ing">연장하기</button></th>
			 		</tr>
		 		</c:forEach>
		 		<c:if test = "${empty list }">
		 			<tr>
		 				<th colspan="4">대여 중인 도서가 없습니다</th>
		 			</tr>
		 		</c:if>
		 	</table>
		 	
		 	<table class="table room_table">
		 		<tr>
		 			<td colspan="5" style="font-size:18px;">현재 예약중인 열람실 좌석</td>
		 		</tr>
		 		<tr>
		 			<td>좌석번호</td>
		 			<td>입실시간</td>
		 			<td>퇴실시간</td>
		 			<td></td>
		 			<td></td>
		 		</tr>		 		
		 		<c:if test = "${result eq false }">
			 		<tr>
			 			<th>${vo.seat_number }</th>
			 			<th>${vo.start_time }</th>
			 			<th>${vo.end_time }</th>
			 			<th><button id="cancle" name="${vo.seat_number }">취소하기</button></th>
			 			<th><button id="ing">연장하기</button></th>
			 		</tr>
			 	</c:if>
		 		<c:if test = "${result eq true }">
		 			<tr>
		 				<th colspan="5">예약 중인 좌석이 없습니다</th>
		 			</tr>
		 		</c:if>
		 	</table>
		 </div>
  </section>
   <jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>