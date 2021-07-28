<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정보수정 | 라온 도서관 </title>
<link rel="shortcut icon" type="image⁄x-icon" href="http://localhost:9000/mybook/images/icon.png">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" ></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" >
<script src="http://localhost:9000/mybook/js/jquery-3.6.0.min.js" ></script>
<style>
	.two { border-bottom:2px solid rgb(43,129,199); }	
	.one, .three, .four { border-bottom:2px solid lightgray; }
	
	.content { 
		background-color:rgb(248,249,251); 
		width:100%; height:500px; 
		margin-bottom:-100px; 
		border-top:1px solid lightgray;
	}
	
	.content>p { margin:100px 0 30px 0; font-size:18px; }
	.content>.form-control { display:inline-block; width:400px; margin-bottom:30px; }
	
	#go, #cancle { margin:5px; padding:2px 10px; }
	#go { background-color:#4fa9de; color:white; }
	#go:hover { background-color:rgb(23,86,123); }
</style>
</head>
<script type= "text/javascript">
$(document).ready(function() {
	$("#go").click(function() {
		if ($("#pass").val() == "") {
			alert("비밀번호를 입력해주세요");
			$("#pass").focus();
		} 
		else {
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
			       		 location.replace("mypage_info_content.do");
			       		} else {
			       			alert("비밀번호가 일치하지 않습니다");
			       			$("#pass").val("").focus();
			       		}
			       	},		
			    });
		}
	})
});
</script>
<body>
 <jsp:include page="../header.jsp"></jsp:include>
 
  <jsp:include page="mypage_commons.jsp"></jsp:include>
  <section class="content">
	 	<p>회원님의 개인정보 보호를 위해 <strong>비밀번호</strong>를 입력하셔야 합니다.<br>
		<span>로그인 시 사용하시는 비밀번호를 입력해주세요.</span></p>
		<input type="password" class="form-control" id="pass">
		<div>
			<a class="btn btn-outline-secondary" href="mypage.do" id="cancle">취소</a>
			<a href="#" class="btn" id="go" >확인</a>
		</div>
  </section>
   <jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>