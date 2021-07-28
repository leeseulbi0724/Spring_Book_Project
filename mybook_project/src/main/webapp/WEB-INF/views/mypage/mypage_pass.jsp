<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경 | 라온 도서관 </title>
<link rel="shortcut icon" type="image⁄x-icon" href="http://localhost:9000/mybook/images/icon.png">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" ></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" >
<script src="http://localhost:9000/mybook/js/jquery-3.6.0.min.js"></script>
<style>
	.three { border-bottom:2px solid rgb(43,129,199); }	
	.one, .two, .four { border-bottom:2px solid lightgray; }
	
	.content { 
		background-color:rgb(248,249,251); 
		width:100%; height:500px; 
		margin-bottom:-100px; 
		border-top:1px solid lightgray;
	}
	
	#update, #cancle { margin:5px; padding:2px 10px; }
	#update { background-color:#4fa9de; color:white; }
	#update:hover { background-color:rgb(23,86,123); }
	
	.center { display:inline-block; width:800px; margin:100px 0; }
	
	.table { background-color:white; width:800px; }
	.table th { font-weight:normal; text-align:left; border-top:1px solid lightgray; border-bottom:1px solid lightgray; }
	.table th:first-child {
		 font-weight:normal; 
		 width:200px; 
		 margin-bottom:10px; 		 
		 background-color:rgb(247,248,249); 
		 vertical-align:middle;		 
	}
	.table th a, .table th button { padding:1px 10px; font-size:14px; }
	.form-control { width:200px; height:30px; font-size:14px; }
</style>
</head>
<script>
	$(document).ready(function() {
		$("#update").click(function() {
			if ($("#pass").val() == "") {
				alert("비밀번호를 입력해주세요");
				$("#pass").focus();
			} else if ($("#newpass").val() == "") {
				alert("새 비밀번호를 입력해주세요");
				$("#newpass").focus();
			} else if ($("#newcpass").val() == "") {
				alert("새 비밀번호 확인을 입력해주세요");
				$("#newcpass").focus();
			} else if ( $("#newpass").val() != $("#newcpass").val() ) {
				alert("새 비밀번호가 일치하지 않습니다");
				$("#newpass").val("").focus();
				$("#newcpass").val("");
			} else {
				var pass = $("#pass").val();
				 $.ajax({
				        url:"pass_check.do",
				        type:"post",
				        data: {
				     	 	pass: pass,
				        }, 
				        dataType: "json",
				      success:function(result){
				       		if ( result ) {
				       			var newpass = $("#newpass").val();
				       			$.ajax({
							        url:"mypass_update_proc.do",
							        type:"post",
							        data: {
							     	 	pass: newpass,
							        }, 
							        dataType: "json",
							      success:function(result){
							       		if ( result ) {
							       		 	alert("변경이 완료되었습니다. 다시 로그인 해주세요.");
							       		 location.replace("logout.do");
							       		} else {
							       			alert("비밀번호 변경 실패");
							       		 location.reload();
							       		}
							       	},		
							    });
				       		} else {
				       			alert("현재 비밀번호가 일치하지 않습니다");
				       			$("#pass").val("").focus();
				       			$("#newpass").val("");
				       			$("#newcpass").val("");
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
			<th>현재 비밀번호</th>
			<th><input type="password" class="form-control" id="pass"></th>
		</tr>
		<tr>
			<th>새 비밀번호</th>
			<th><input type="password" class="form-control" id="newpass"></th>
		</tr>		
		<tr>
			<th>새 비밀번호 재입력</th>
			<th><input type="password" class="form-control" id="newcpass"> ※비밀번호 확인을 위해 한번 더 입력해 주시기 바랍니다.</th>
		</tr>		
	</table>	
	<a class="btn btn-outline-secondary" href="mypage.do" id="cancle">취소</a>
	<a class="btn" id="update" href="#">수정</a>
	</div>
  </section>
   <jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>