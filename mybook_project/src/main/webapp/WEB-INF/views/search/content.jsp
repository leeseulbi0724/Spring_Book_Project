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
<link href="http://localhost:9000/mybook/css/modal.css" rel="stylesheet" >
<link href="http://localhost:9000/mybook/css/commons.css" rel="stylesheet" >
<link href="http://localhost:9000/mybook/css/search/content.css" rel="stylesheet" >
<script src="http://localhost:9000/myjeju/js/jquery-3.6.0.min.js"></script>
<title>상세 정보 | 라온 도서관</title>
</head>
<script>
	$(document).ready(function() {			
		
		
		$(".review_btn").click(function() {
			if ("${session_id}" == "") { //세션에 저장된 아이디가 있는지 확인 (로그인 여부)
				location.replace("login.do"); //없을경우 로그인 페이지로 이동
			} else if (${r_result}) { 
				//페이지 로드 할 때 로그인한 회원의 해당 도서 대여 여부를 가져옴
				//도서대여를 한적이 없다면 (true이면)
				$("#modal").fadeIn(300);
				$(".modal1").fadeIn(300); //후기 작성할 수 있는 모달창 띄우기
			} else {
				alert("대여하신 도서만 후기를 작성하실 수 있습니다");
			}
		});
		
		$(".update_btn").click(function() {
			$("#modal").fadeIn(300);
			$(".modal2").fadeIn(300);
		});
		
		$("#modal, .close").on('click',function(){
			  $("#modal").fadeOut(300);
			  $(".modal-con").fadeOut(300);
		});
		
		$(".heart").click(function() { //좋아요 버튼 클릭 시
			var bid = "${vo.bid}";
			if ("${session_id}" == "") { //로그인 하지 않았을 경우 login 페이지로 이동
				location.replace("login.do");
			} else if (${h_result}) { 
				//페이지 로드 할 때 로그인한 회원의 좋아요 버튼 클릭 여부를 받아옴
				//좋아요가 클릭되어있으면 (true이면)
				$.ajax({
	                type: "post",
	                url: "heart_minus.do", //좋아요 해제
	                data:{bid:bid},
	                dataType: 'json',
	                success: function (result) {
	                    location.reload();
	                },
	            });
			} else {
				//좋아요가 클릭되어있지 않으면 (false이면)
				$.ajax({
	                type: "post",
	                url: "heart_plus.do", //좋아요 추가
	                data:{bid:bid},
	                dataType: 'json',
	                success: function (result) {
	                    location.reload();
	                },
	            });
			}
		});
		
		$(".rental").click(function() {
			 if (${ing} == 1) {
				alert("이미 대여중인 도서입니다");
				$(this).attr("href","");
			}
		});
		
		$(".write").click(function() { //후기등록 버튼클릭 시
			if ($("#content").val() == "") { 
				alert("내용을 입력해주세요");
				$("#content").focus();
			} else {
				var content=$("#content").val(); //내용
				var star = $("#star").val(); //별점
				var bid = "${vo.bid}"; //해당 도서의 시퀀스 값
				$.ajax({
	                type: "post",
	                url: "review_upload.do",
	                data:{content:content, star:star, bid:bid},
	                dataType: 'json',
	                success: function (result) {
	                	if (result) {
		                	alert("작성이 완료되었습니다");
		                    location.reload();	                		
	                	}
	                },
	            });
			}
		});
		
		$(".update").click(function() { //수정버튼 클릭 시
			if ($("#rcontent").val() == "") {
				alert("내용을 입력해주세요");
				$("#rcontent").focus();
			} else {
				var content=$("#rcontent").val(); //수정 내용
				var star = $("#rstar").val(); //수정 별점
				var bid = "${rvo.bid}"; //해당 도서의 시퀀스 값
				$.ajax({
	                type: "post",
	                url: "review_update.do",
	                data:{content:content, star:star, bid:bid},
	                dataType: 'json',
	                success: function (result) {
	                	if (result) {
		                	alert("수정이 완료되었습니다");
		                    location.reload();	                		
	                	}
	                },
	            });
			}
		});
		
		
		$(".delete_btn").click(function() {
			 var con_test = confirm("작성하신 후기를 삭제하시겠습니까?"); 
	        	if(con_test == true){   		
	        		var rid = $(this).attr("id"); //해당 후기의 시퀀스 값
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

 <section>
	 <div class="menu_div">
		 <div>
		 	<a href="index.do"><img src="http://localhost:9000/mybook/images/home_icon.png" width=15 height=15></a>>
		 	<a href="search.do">이용안내</a>><a href="search.do">도서 목록</a>><a href="content.do?bid=${vo.bid }">상세 정보</a>
		 </div>
	 </div>
	 <div class="content">
		 <div class="left">
		 	<ul>
		 		<li><a href="search.do">도서 대여</a></li>
		 		<li><a href="room.do">열람실 예약</a></li>
		 	</ul>
		 </div>
		 <div class="center">
		 	<div class="title">
		 		<h3>상세 정보</h3>
		 		<img src="http://localhost:9000/mybook/images/title_back.gif" height=100% >
		 	</div>
		 	<div class="detail">
		 		<div class="img">
		 			<img src="http://localhost:9000/mybook/upload/${vo.bsfile }" width=100% height=100% >
		 		</div>
		 		<div class="text">
		 			<div class="book_title">
		 				${vo.bname }
		 				<p class="book_heart">
		 					<img src="http://localhost:9000/mybook/images/heart_after.png" width=18 height=18  > 좋아요(${vo.bheart }개)
		 				</p>
		 			</div>		 			
		 			<p class="book_info">${vo.bauthor } 지음 | ${vo.bpublish } | ${vo.bdate } 출간</p>
		 			<p class="book_star">
		 				 <span class='star-rating'>
						<span style ="width:${(sum/count)*20}%"></span>	
						</span>	<p>후기(${count }개)</p>
		 			</p>		 		
		 			<p class="book_text">${vo.bcontent }</p>
					<a href="rental.do?bid=${vo.bid }" class="rental">대여하기</a>
					<button class="heart">
						<c:if test = "${h_result eq 'false' }">
							<img src="http://localhost:9000/mybook/images/heart_before.png" class="heart_img">
						</c:if>
						<c:if test = "${h_result eq 'true' }">
							<img src="http://localhost:9000/mybook/images/heart_after.png" class="heart_img">
						</c:if>
						<br>좋아요
					</button>
		 		</div>
		 	</div>
		 	<div class="review">
		 		<p>후기<button class="review_btn" >후기쓰기</button></p>		 		
		 		<div class="review_box">
		 		<c:forEach var = "vo"  items="${list}">		
		 			<div class="review_text">
		 				<p>
		 					<img src="http://localhost:9000/mybook/images/star${vo.star }.gif" width=100px height=18 > ${vo.rdate }
		 					<c:if test = "${session_id eq vo.id }">
		 						<a class="update_btn">수정</a>
		 						<a class="delete_btn" id="${vo.rid }">삭제</a>
		 					</c:if>
		 				</p>
		 				<p><strong>${vo.id }</strong></p>
		 				<p>${vo.content }</p>
		 			</div>	 	
		 		</c:forEach>		
		 		<c:if test="${empty list }">
		 			<div class="review_text">
		 				<p>작성된 후기가 없습니다</p>
		 			</div>
		 		</c:if>
		 		</div>
		 	</div>		 	
		 </div>
	</div>
</section>
<div id="modal"></div>
  <div class="modal-con modal1">
    <a href="javascript:;" class="close">X</a>
    <p class="title">후기쓰기</p>
    <div class="con">
    	<select class="form-select" id="star" >
    		<option value="5">★★★★★
    		<option value="4">★★★★☆
    		<option value="3">★★★☆☆
    		<option value="2">★★☆☆☆
    		<option value="1">★☆☆☆☆
    	</select>
       <div>
       		<c:if test ="${v_result eq 'true'}">
       			<input type="text" class="form-control" id="content"><a class="write">등록</a>
       		</c:if>
       		<c:if test ="${v_result eq 'false'}">
       			<input type="text" class="form-control" id="content" readonly placeholder="이미 작성된 후기가 있습니다"><button class="write" disabled>등록</button>
       		</c:if>
       	</div>
    </div>
  </div>
  
  <div id="modal"></div>
  <div class="modal-con modal2">
    <a href="javascript:;" class="close">X</a>
    <p class="title">후기수정</p>
    <div class="con">
    	<select class="form-select" id="rstar" >
    		<c:if test = "${rvo.star eq 5 }">
	    		<option value="5" selected>★★★★★
	    		<option value="4">★★★★☆
	    		<option value="3">★★★☆☆
	    		<option value="2">★★☆☆☆
	    		<option value="1">★☆☆☆☆
    		</c:if>
    		<c:if test = "${rvo.star eq 4 }">
	    		<option value="5" >★★★★★
	    		<option value="4" selected>★★★★☆
	    		<option value="3">★★★☆☆
	    		<option value="2">★★☆☆☆
	    		<option value="1">★☆☆☆☆
    		</c:if>
    		<c:if test = "${rvo.star eq 3 }">
	    		<option value="5" >★★★★★
	    		<option value="4" >★★★★☆
	    		<option value="3" selected>★★★☆☆
	    		<option value="2">★★☆☆☆
	    		<option value="1">★☆☆☆☆
    		</c:if>
    		<c:if test = "${rvo.star eq 2 }">
	    		<option value="5" >★★★★★
	    		<option value="4" >★★★★☆
	    		<option value="3" >★★★☆☆
	    		<option value="2" selected>★★☆☆☆
	    		<option value="1">★☆☆☆☆
    		</c:if>
    		<c:if test = "${rvo.star eq 1 }">
	    		<option value="5" >★★★★★
	    		<option value="4" >★★★★☆
	    		<option value="3" >★★★☆☆
	    		<option value="2" >★★☆☆☆
	    		<option value="1" selected>★☆☆☆☆
    		</c:if>
    	</select>
       <div>
       		<input type="text" class="form-control" id="rcontent" value="${rvo.content }"><a class="update">수정</a>      		
       	</div>
    </div>
  </div>
<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>