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
			 login();
		 }
	 })
	 
	// 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
    var key = getCookie("key");
    $("#id").val(key); 
     
    if($("#id").val() != ""){ // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
        $("#idSaveCheck").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
    }
     
    $("#idSaveCheck").change(function(){ // 체크박스에 변화가 있다면,
        if($("#idSaveCheck").is(":checked")){ // ID 저장하기 체크했을 때,
            setCookie("key", $("#id").val(), 7); // 7일 동안 쿠키 보관
        }else{ // ID 저장하기 체크 해제 시,
            deleteCookie("key");
        }
    });
     
    // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
    $("#id").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
        if($("#idSaveCheck").is(":checked")){ // ID 저장하기를 체크한 상태라면,
            setCookie("key", $("#id").val(), 7); // 7일 동안 쿠키 보관
        }
    });
	 
 });
 
	 function enterkey() {
	     if (window.event.keyCode == 13) {
	          // 엔터키가 눌렸을 때 실행할 내용
	    	 login();
	     }
	}
	 
	 function login() {
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
 
	function setCookie(cookieName, value, exdays){
	    var exdate = new Date();
	    exdate.setDate(exdate.getDate() + exdays);
	    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
	    document.cookie = cookieName + "=" + cookieValue;
	}
	 
	function deleteCookie(cookieName){
	    var expireDate = new Date();
	    expireDate.setDate(expireDate.getDate() - 1);
	    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
	}
	 
	function getCookie(cookieName) {
	    cookieName = cookieName + '=';
	    var cookieData = document.cookie;
	    var start = cookieData.indexOf(cookieName);
	    var cookieValue = '';
	    if(start != -1){
	        start += cookieName.length;
	        var end = cookieData.indexOf(';', start);
	        if(end == -1)end = cookieData.length;
	        cookieValue = cookieData.substring(start, end);
	    }
	    return unescape(cookieValue);
	}
</script>
<body>
<jsp:include page="../header.jsp"></jsp:include>

<section>
	<div class="login_box">
		<div>
			<form autocomplete="off" name="user_login"  id="form">
			<div class="input">
				<input type="text" class="form-control" placeholder="아이디 입력" name="id" id="id">
				<input type="password" class="form-control" placeholder="비밀번호 입력" name="pass" id="pass" onkeyup="enterkey();">
			</div>
			<div class="btn_login">
				<button type="button" id="login">로그인</button>
			</div>
			<div class="btn_find">				
				<input type="checkbox" id="idSaveCheck"> 아이디 저장
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