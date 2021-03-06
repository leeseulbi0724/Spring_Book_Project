<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
    <c:set var="today" value="<%=new java.util.Date()%>" />	
    <c:set var="date"><fmt:formatDate value="${today}" pattern="yyyy-MM-dd" /></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서대여 | 라온 도서관 </title>
<link rel="shortcut icon" type="image⁄x-icon" href="http://localhost:9000/mybook/images/icon.png">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" ></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" >
<script src="http://localhost:9000/mybook/js/jquery-3.6.0.min.js" ></script>
<link href="http://localhost:9000/mybook/css/modal.css" rel="stylesheet" >
<link href="http://localhost:9000/mybook/css/mypage/mypage_book.css" rel="stylesheet" >
</head>
<script>
$(document).ready(function() {
	
	$("button[id=return]").click(function() {	//반납 버튼 클릭 시
		var bid = $(this).attr("name"); //해당 반납 버튼 name값에 도서 시퀀스 저장
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
	
	$(".book_ing").click(function() {	
		var bid = $(this).attr("name");
		$(".book_ex").attr("id",bid);
		$("#modal").fadeIn(300);
		$(".modal1").fadeIn(300);
	});
	
	$(".book_ex").click(function() {
		var bid = $(this).attr("id");
		if ($("#book_date").val() == "") {
			alert("연장하실 날짜를 선택해주세요");
			$("#book_date").focus();
		} else {
			var day = $("#book_date").val();
			 $.ajax({//
	                type: "post",
	                url: "book_ex_proc.do",
	                data:{bid:bid, day:day}, //연장날짜와 해당 도서 시퀀스 값
	                dataType: 'json',
	                success: function (result) {
	                   if (result) {
	                	   alert("연장이 완료되었습니다");
	                	   location.reload();
	                   }
	                },

	            });
		}
	});
		
	$("#modal, .close").on('click',function(){
		  $("#modal").fadeOut(300);
		  $(".modal-con").fadeOut(300);
	});
	
	$(".room_ing").click(function() {
		var con_test = confirm("연장하시겠습니까? (운영시간내에 최대 3시간입니다)"); 
    	if(con_test == true){   
         $.ajax({
                type: "post",
                url: "room_ing_proc.do",
                data:{end:"${vo.end_time }"},
                dataType: 'json',
                success: function (result) {
                   if (result) {
                	   alert("시간이 연장되었습니다");
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
			 			<th>
			 				<a href="content.do?bid=${vo.bid}" >${vo.bname }</a>
			 				<c:if test = "${date > vo.endday }">
			 					<p style="color:red">반납일이 지났습니다</p>
			 				</c:if>
			 			</th>
			 			<th>${vo.startday }</th>
			 			<th>${vo.endday }</th>
			 			<th><button id="return"  name="${vo.bid }">반납하기</button></th>
			 			<th><button id="ing" class="book_ing" name="${vo.bid }">연장하기</button></th>
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
			 			<th><button id="ing" class="room_ing">연장하기</button></th>
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
  <div id="modal"></div>
  <div class="modal-con modal1">
    <a href="javascript:;" class="close">X</a>
    <div class="con">    	
       <div>
       		<p>반납일을 선택해주세요</p>
       		<input type="date" class="form-control" id="book_date"><a class="book_ex">연장</a>
       	</div>
    </div>
  </div>
   <jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>