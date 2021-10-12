<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>열람실 관리 | Admin</title>
<link rel="shortcut icon" type="image⁄x-icon" href="http://localhost:9000/mybook/images/icon.png">
<script src="http://localhost:9000/mybook/js/jquery-3.6.0.min.js" ></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" ></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" >
<link href="http://localhost:9000/mybook/css/admin/room/admin_room.css" rel="stylesheet" >
</head>
<script>
	$(document).ready(function() {
		$(".seat_box button").click(function() {
			$(".seat_box button").css("border","1px solid lightgray");
			$(this).css("border","2px solid");
			$(this).attr("id","click");
			
			$("button[id=click]").click(function() {
				$(this).css("border","1px solid lightgray");
				$(this).attr("id","");
			});
		});
		
		
		$("#reset").click(function() {
			if (${result}) { //사용중인 좌석이 있는 없는지 페이지 로드 전에 미리 받아옴
				alert("현재 사용중인 좌석이 없습니다");
			} else {
				var con_test = confirm("전체 좌석을 사용 해제하시겠습니까?"); 
		        	if(con_test == true){   
						 $.ajax({
				                type: "get",
				                url: "admin_room_reset.do",
				                dataType: 'json',
				                success: function (result) {
				                	alert("초기화가 완료되었습니다");
				                    location.reload();
				                },
			
				           });	        		
		        	}
			}
		});
		
		$("#write_no").click(function() { //사용불가 좌석 등록하기
			if ($("button[id=click]").length == 0) {
				alert("좌석을 선택해주세요");
			} else {
				var number = $("button[id=click]").text(); //좌석번호
				var con_test = confirm("선택한 좌석을 변경하시겠습니까?"); 
	        	if(con_test == true){   
					 $.ajax({
			                type: "post",
			                url: "admin_room_no.do",
			                data:{number:number},
			                dataType: 'json',
			                success: function (result) {
			                	alert("변경이 완료되었습니다");
			                    location.reload();
			                },
		
			           });	        		
	        	} 
			}
		});
		
		
		
		
		$(".x").click(function() { //사용불가 좌석 해제 하기
			var number = $(this).attr("name"); //좌석번호
			var con_test = confirm("선택한 좌석을 사용좌석으로 변경하시겠습니까?"); 
        	if(con_test == true){   
				 $.ajax({
		                type: "post",
		                url: "admin_room_yes.do",
		                data:{number:number},
		                dataType: 'json',
		                success: function (result) {
		                	alert("변경이 완료되었습니다");
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
	<h3>열람실 목록</h3>
	<p><a>열람실</a><span>></span><a>열람실 목록</a></p>
	<div class="list_box">
	<button class="btn btn-secondary" id="write_no">사용불가 좌석 등록</button>
	<button class="btn btn-outline-secondary" id="reset">사용 좌석 전체 해제(초기화)</button>
		<div class="seat">				
		 	<div class="seat_box">
		 		<c:forEach var = "vo"  items="${list}" >
		 			<c:if test="${vo.status eq 0 }">
		 				<button class="yes">${vo.seat_number }</button>
		 			</c:if>
		 			<c:if test= "${vo.status eq 1 }">
		 				<button disabled class="no">사용</button>
		 			</c:if>
		 			<c:if test= "${vo.status eq 2 }">
		 				<button class="x" name="${vo.seat_number}">금지</button>
		 			</c:if>
		 		</c:forEach>
		 	</div>
		</div>
	</div>			
</section>
</body>
</html>