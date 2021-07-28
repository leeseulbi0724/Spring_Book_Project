<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" type="image⁄x-icon" href="http://localhost:9000/mybook/images/icon.png">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" ></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" >
<script src="http://localhost:9000/mybook/js/jquery-3.6.0.min.js" ></script>
<link rel="stylesheet" href="http://localhost:9000/mybook/css/login.css">
<title>로그인 | 라온 도서관</title>
</head>
 <script>
 $(document).ready(function() {
	 $(".id, .pass").click(function() {
		 var type = $(this).attr("class");
		 var url = "find.do?type="+type;
         var name = "popup test";
         var option = "width = 500, height = 500, top = 150, left = 500, location = no"
         window.open(url, name, option);
	 });
	 
	 $("#login").click(function() {
		 if ($("#id").val() == "") {
			 alert("아이디를 입력해주세요");
			 $("#id").focus();
		 } else if ( $("#pass").val() == "") {
			 alert("비밀번호를 입력해주세요");
			 $("#pass").focus();
		 } else {
			 var form1 = $("#form").serialize();
			 $.ajax({
	                type: "post",
	                url: "login_proc.do",
	                data: form1,
	                dataType: 'json',
	                success: function (result) {
	                    if (result) {
	                    	 location.replace("index.do");
	                    } else {
	                    	alert("아이디 또는 비밀번호가 틀립니다.");
	                    }
	                },

	            });
		 }
	 })
 });
</script>
<body>
<jsp:include page="../header.jsp"></jsp:include>

<section>
	<div class="login_box">
		<div>
			<form autocomplete="off" name="user_login"  id="form">
			<div class="input">
				<input type="text" class="form-control" placeholder="아이디 입력" name="id" id="id">
				<input type="password" class="form-control" placeholder="비밀번호 입력" name="pass" id="pass">
			</div>
			<div class="btn_login">
				<button type="button" id="login">로그인</button>
			</div>
			<div class="btn_find">				
				<input type="checkbox"> 아이디 저장
				<input type="checkbox"> 자동 로그인
				<button type="button" id="find" class="pass">비밀번호찾기</button>
				<button type="button" id="find" class="id">아이디찾기</button>
			</div>
			</form>
		</div>
	</div>
	<p>아직 계정이 없으신가요?</p>
	<a href="join.do" class="join">회원가입</a>
</section>

<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>