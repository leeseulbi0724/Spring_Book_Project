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
<link href="http://localhost:9000/mybook/css/mypage/mypage_pass.css" rel="stylesheet" >
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