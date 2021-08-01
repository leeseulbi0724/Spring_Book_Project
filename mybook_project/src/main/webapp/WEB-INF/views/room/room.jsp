<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="HH:mm" var="now" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" type="image⁄x-icon" href="http://localhost:9000/mybook/images/icon.png">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" ></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" >
<script src="http://localhost:9000/mybook/js/jquery-3.6.0.min.js" ></script>
<link href="http://localhost:9000/mybook/css/modal.css" rel="stylesheet" >
<link href="http://localhost:9000/mybook/css/commons.css" rel="stylesheet" >
<title>열람실 예약 | 라온 도서관</title>
<style>	
	.book { color:rgb(43,129,199); border-bottom:5px solid rgb(43,129,199); }
	.home, .com  {	color:rgb(162,162,162); }	
	
	.left ul li:last-child a { color:rgb(43,129,199); font-weight:bold; }
	
	.center p { float:left; padding:5px 0; }
	.center p>span { color:rgb(170,93,11); }
	
	.seat { width:100%; display:inline-block; height:500px; margin-top:20px; }
	 .seat_box { width:800px; display:inline-block; margin-top:20px; text-align:center; }
	.seat_box #btn { 
		border:1px solid lightgray;
		width:40px; height:40px;
		font-size:14px;
	 }
	 .seat_box .no { background-color:rgb(245,129,135); color:black; }
	 .seat_box .yes { background-color:white; }
	 .seat_box .choice { 
	 	background-color:lightgray; 
	 	color:white; 
	 	border:none; 
	 	display:inline-block; 
	 	margin-top:50px;
	 	padding:10px 20px;
	 	border-radius:10px;
	}
	.choice:hover { color:rgb(46,88,202); }
	
	.number { font-size:18px; margin-bottom:5px; }
	.start { margin-bottom:5px; }
	.start>span { color:rgb(43,129,199); }
	.end { color:gray; }
	.end>span { color:rgb(188,188,188); }
	
	.app { 
		font-size:14px; 
		background-color:rgb(30,179,136); 
		border:none; 
		color:white; 
		border-radius:4px; 
		float:right;
		margin:10px 0 15px 0;
		text-decoration:none;
	}
</style>
</head>
<script>
	$(document).ready(function() {
		$("[id^=btn]").click(function() {
			if (${result}) {
				$("[id^=btn]").css("border","1px solid lightgray");
				$(this).css("border","2px solid");
				$(".choice").css("background-color","rgb(43,129,199)")
				$(".choice").attr("disabled",false);		
			}  else {
				alert("이미 사용중인 좌석이 있습니다");
			}
			
			var number = $(this).text();
			
			$(".choice").click(function() {				
				if ("${now}" >= "18:00") {
					alert("열람실 이용이 마감되어 예약이 불가능합니다");
				} else {				
					$("#modal").fadeIn(300);
					$(".modal1").fadeIn(300);
					$(".number").html("선택하신 좌석은 <strong style='color:rgb(43,129,199)'>"+number+"</strong> 번입니다");
				}	
				
				$(".app").click(function() {
					if ($("#time").val() >= "18:00" || $("#time").val() < "09:00") {
						alert("열람실 이용시간은 09:00~18:00 입니다");
					} else {
						var con_test = confirm("선택하신 좌석을 예약하시겠습니까?"); 
			        	if(con_test == true){
			        		var time = $("#time").val();
			        		  $.ajax({
					                type: "post",
					                url: "room_proc.do",
					                data:{number:number, time:time},
					                dataType: 'json',
					                success: function (result) {
					                   if (result) {
					                	   alert("예약 신청이 완료되었습니다");
					                	   location.reload();
					                   }
					                },		
					           });
			        	}
					}
				});
			});
		});			
		
		$("#modal, .close").on('click',function(){
			  $("#modal").fadeOut(300);
			  $(".modal-con").fadeOut(300);
		});			
	});

</script>
<body>
 <jsp:include page="../header.jsp"></jsp:include>
 <section>
	 <div class="menu_div">
		 <div>
		 	<a href="index.do"><img src="http://localhost:9000/mybook/images/home_icon.png" width=15 height=15></a>>
		 	<a href="room.do">이용안내</a>><a href="room.do">열람실 예약</a>
		 </div>
	 </div>
	 <div class="content">
		 <div class="left">
		 	<ul>
		 		<li><a href="search.do">도서 검색</a></li>
		 		<li><a href="room.do">열람실 예약</a></li>
		 	</ul>
		 </div>
		 <div class="center">
		 	<div class="title">
		 		<h3>열람실 예약</h3>
		 		<img src="http://localhost:9000/mybook/images/title_back.gif" height=100% >
		 	</div>
		 	<p>총 <span>150</span>석 중 <span>${count }</span>석 사용중</p>
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
				 	<br><button disabled class="choice" >좌석 선택하기</button>
			 	</div>
			 </div>
		 </div>
	 </div>
 </section>
 
 <div id="modal"></div>
  <div class="modal-con modal1">
    <a href="javascript:;" class="close">X</a>
    <p class="title">예약하기</p>
    <div class="con">
    	<p class="number"></p>
    	<p class="start"><span>입실 시간</span>을 선택해주세요</p>
    	<input type="time" class="form-control" id="time" value="${now }">
    	<p class="end">최초 이용 시간은 3시간입니다. 그 이상은 연장해주세요<br><span>단, 15:00 이후부터는 마감시간까지만 이용 가능합니다</span></p>
    	<button class="app">신청</button>
    </div>
  </div>
  <jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>