<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정보수정 | 라온 도서관 </title>
<link rel="shortcut icon" type="image⁄x-icon" href="http://localhost:9000/mybook/images/icon.png">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" ></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" >
<script src="http://localhost:9000/mybook/js/jquery-3.6.0.min.js" ></script>
<script src="http//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="http://localhost:9000/mybook/js/address.js"></script>
<style>
	.two { border-bottom:2px solid rgb(43,129,199); }	
	.one, .three, .four { border-bottom:2px solid lightgray; }
	
	.content { 
		background-color:rgb(248,249,251); 
		width:100%;
		margin-bottom:-100px; 
		border-top:1px solid lightgray;
		text-align:center;
	}
	
	#update, #cancle { margin:5px; padding:2px 10px; }
	#update { background-color:#4fa9de; color:white; }
	#update:hover { background-color:rgb(23,86,123); }
	
	.center { display:inline-block; width:800px; margin:50px 0; }
	
	.table { background-color:white; width:800px; }
	.table th { font-weight:normal; text-align:left; border-top:1px solid lightgray; border-bottom:1px solid lightgray; }
	.table th:first-child {
		 font-weight:normal; 
		 width:100px; 
		 margin-bottom:10px; 		 
		 background-color:rgb(247,248,249); 
		 vertical-align:middle;		 
	}
	.table th a, .table th button { padding:1px 10px; font-size:14px; }
	.form-control { width:200px; height:30px; font-size:14px; }
	.table tr:nth-child(5) .form-select, .table tr:nth-child(6) .form-select  { width:100px; height:30px; display:inline-block; padding:0 5px; font-size:14px;  }
	.table tr:nth-child(5) .form-control, .table tr:nth-child(6) .form-control { width:100px;  display:inline-block; }
	.table tr:nth-child(7) button { margin-top:10px; }
</style>
</head>
<script>
	$(document).ready(function() {
		$(".email-select").change(function() {
			$("#email2").val( $(".email-select").val() );
		});
		/* 휴대폰 선택 시 input value값 넣기 */
		$(".hp-select").change(function() {
			$("#hp1").val( $(".hp-select").val() );
		});
		
		 $(function(){
			  $("#update").on("click", update);
		    });
		  
		    function update() {
		            var form1 = $(".form").serialize();

		            console.log(form1);
		            $.ajax({
		                type: "post",
		                url: "info_update.do",
		                data: form1,
		                dataType: 'json',
		                success: function (result) {
		                    if (result) {
		                    	alert("정보 수정이 완료되었습니다");	                    	
		                    } else {
		                    	alert("정보 수정이 실패되었습니다");	                    	
		                    }
		                    location.reload();
		                },

		            });
		    };
		    
		    $(function(){
				  $("#delete").on("click", id_delete);
			    });
			  
			    function id_delete() {
			    	var con_test = confirm("회원탈퇴 신청을 하시겠습니까?");      
		           	if(con_test == true){   
			            $.ajax({
			                type: "post",
			                url: "info_delete.do",
			                dataType: 'json',
			                success: function (result) {
			                    if (result) {
			                    	alert("신청이 완료되었습니다");
			                    } else {
			                    	alert("신청이 실패되었습니다");                  	
			                    }
			                    location.reload();
			                },

			            });
		           	};
			    };
			    
			    $(function(){
					  $("#back").on("click", id_back);
				    });
				  
				    function id_back() {
				    	var con_test = confirm("회원탈퇴 신청을 취소 하시겠습니까?");      
			           	if(con_test == true){   
				            $.ajax({
				                type: "post",
				                url: "info_delete_reset.do",
				                dataType: 'json',
				                success: function (result) {
				                    if (result) {
				                    	alert("신청이 취소되었습니다");
				                    } else {
				                    	alert("신청취소가 실패되었습니다");                  	
				                    }
				                    location.reload();
				                },

				            });
			           	};
				    };
	})
</script>
<body>
 <jsp:include page="../header.jsp"></jsp:include>
 
  <jsp:include page="mypage_commons.jsp"></jsp:include>
  <section class="content">
  <div class="center">
  <form class="form">
  	<table class="table">
		<tr>
			<th>아이디</th>
			<th id="id">${vo.id } 
			<c:if test = "${vo.id_del eq '1' }">
				<button type="button" class="btn btn-secondary" id="back">신청취소</button>
			</c:if>
			<c:if test = "${vo.id_del eq '0' }">
				<button type="button" class="btn btn-secondary" id="delete">탈퇴신청</button>
			</c:if>
			</th>
		</tr>
		<tr>
			<th>비밀번호</th>
			<th><a class="btn btn-outline-dark" href="mypage_pass.do">비밀번호 변경</a></th>
		</tr>
		<tr>
			<th>이름</th>
			<th>${vo.name }</th>
		</tr>
		<tr>
			<th>생년월일</th>
			<th>${vo.birth }</th>
		</tr>
		<tr>
			<th>이메일</th>
			<th>
				<input type="text" class="form-control" value="${vo.email1 }" name="email1"> @ <input type="text" class="form-control" value="${vo.email2 }" id="email2" name="email2" >
				<select class="form-select email-select">
					<option value="">직접선택
					<option value="naver.com">네이버
					<option value="gmail.com">구글
					<option value="daum.net">다음
				</select>
			</th>
		</tr>
		<tr>
			<th>휴대폰번호</th>
			<th>
				<select class="form-select hp-select">
				<c:if test = "${vo.hp1 eq '010'}">
						<option value="선택">선택
						<option value="010" selected>010
						<option value="011">011
						<option value="017">017
					</c:if>
					<c:if test = "${vo.hp1 eq '011'}">
						<option value="선택">선택
						<option value="010" >010
						<option value="011" selected>011
						<option value="017">017
					</c:if>
					<c:if test = "${vo.hp1 eq '017'}">
						<option value="선택">선택
						<option value="010" >010
						<option value="011" >011
						<option value="017" selected>017
					</c:if>
				</select> - 
				<input type="hidden" class="form-control" id="hp1" value="${vo.hp1 }" name="hp1">
				<input type="text" class="form-control" value="${vo.hp2 }" name="hp2"> -
				<input type="text" class="form-control" value="${vo.hp3 }" name="hp3">
			</th>
		</tr>
		<tr>
			<th>주소</th>
			<th>
				<input type="text" class="form-control addr" value="${vo.addr1 }" id="addr1" name="addr1">
				<input type="text" class="form-control addr" value="${vo.addr2 }" id="addr2" name="addr2">
				<button class="btn btn-outline-dark"  onclick="addr()" >주소 검색</button>
			</th>
		</tr>
	</table>
	<a class="btn btn-outline-secondary" href="mypage.do" id="cancle">취소</a>
	<a class="btn" id="update" href="#">수정</a>
	</form>
	</div>
  </section>
   <jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>