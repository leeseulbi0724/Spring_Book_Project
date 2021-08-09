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
<link rel="stylesheet" href="http://localhost:9000/mybook/css/join/join.css">
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="http://localhost:9000/mybook/js/address.js"></script>
<!-- <script src="http://localhost:9000/mybook/js/join/join.js"></script>-->
<title>회원가입 | 라온 도서관</title>
</head>
<script>
$(function() {
	$("#id_check").on("click", check);
})

function check() {
	var id = $("#id").val(); //아이디
    $.ajax({
        url:"id_check.do",
        type:"post",
        data: {
     	 	 id: id,
        }, 
        dataType:"json",
      success:function(result){
      		if (result) { //true이면 사용 가능 아이디
      			$(".id_msg").text("사용 가능한 아이디입니다").css("color","blue");
      			$("#id_check").attr("class","on"); //중복확인 완료이므로 class이름을 on으로 변경
      			$("#pass").focus();
      		} else { //false이면 이미 존재하는 아이디
      			$(".id_msg").text("이미 존재하는 아이디입니다").css("color","red");
      			$("#id").val("").focus();
      		}
        },
        
     });  
}

$(document).ready(function() {
	/* 이메일 선택 시 input value값 넣기 */
	$(".email-select").change(function() {
		$("#email2").val( $(".email-select").val() );
	});
	/* 휴대폰 선택 시 input value값 넣기 */
	$(".hp-select").change(function() {
		$("#hp1").val( $(".hp-select").val() );
	});
	
	/* 유효성체크 */
	
	
	$(".join").click(function() {
		if ($("#id").val() == "") {
			alert("아이디를 입력해주세요");
			$("#id").focus();
		} else if ($("#pass").val() == "") {
			alert("비밀번호를 입력해주세요");
			$("#pass").focus();
		} else if ($("#cpass").val() == "") {
			alert("비밀번호 확인을 입력해주세요");
			$("#cpass").focus();
		} else if ($("#name").val() == "") {
			alert("이름을 입력해주세요");
			$("#name").focus();
		} else if ($("#birth").val() == "") {
			alert("생년월일을 입력해주세요");
			$("#birth").focus();
		} else if ($("#email1").val() == "") {
			alert("이메일을 입력해주세요");
			$("#email1").focus();
		} else if ($("#email2").val() == "") {
			alert("이메일 주소를 입력해주세요");
			$("#email2").focus();
		} else if ( $("#hp1").val() == "" ) {
			alert("휴대폰 번호를 선택해주세요");
			$("#hp1").focus();
		} else if ( $("#hp2").val() == "" ) {
			alert("휴대폰 번호를 입력해주세요");
			$("#hp2").focus();
		} else if ( $("#hp3").val() == "" ) {
			alert("휴대폰 번호를 입력해주세요");
			$("#hp3").focus();
		} else if ($("#addr1").val() == "" ) {
			alert("주소를 입력해주세요");
			$("#addr1").focus();
		} else if ($("#addr2").val() == "" ) {
			alert("상세 주소를 입력해주세요");
			$("#addr2").focus();
		} 
		/*else if ($(".hp_check").attr("id") == "off") {
			alert("휴대폰 인증버튼을 클릭해주세요");
			$(".hp_check").focus();
		}*/
		else if ($("#id_check").attr("class") == "off") {
			 alert("아이디 중복확인 버튼을 클릭해주세요");
			 $("#id_check").focus();
		} else {
			user_join.submit();			
		}		
	});
	
	/* 비밀번호 - 비밀번호 확인 체크 */
	$("#cpass").blur(function() {
		if ($("#pass").val() != $("#cpass").val() ) { //비밀번호와 비밀번호 확인이 같지 않으면~
			$(".pass_msg").text("비밀번호가 동일하지 않습니다.").css("color","red");
			$("#cpass").val("").focus();
		} else { //비밀번호와 비밀번호 확인이 같으면~
			$(".pass_msg").text("비밀번호가 동일합니다.").css("color","blue");
		}
	});
	
	/* 생년월일 - 6자리 확인 */
	$("#birth").blur(function() {
		if ( $("#birth").val() != "" && $("#birth").val().length != "6") { //생년월일이 비어있지 않은데 6자리가 아니면~
			$(".birth_msg").text("생년월일 형식에 맞지 않습니다.").css("color","red");
			$("#birth").val("").focus();
		} else if ( $("#birth").val() != "" && $("#birth").val().length == "6" ) { //생년월일이 비어있지 않은데 6자리면~
			$(".birth_msg").text("");
		}
	});
	
	/* 인증번호 보내기 */
    $("#off").click(function() {       
        var number = Math.floor(Math.random() * 100000) + 100000;
           if(number>100000){ number = number - 10000; }
           $("#text").val(number);      /* 난수로 생성된 인증번호를 hidden name : text 에 숨긴다 */                 
        var to = $("#hp1").val() + $("#hp2").val() + $("#hp3").val();       
     
        if ( $("#hp1").val() == "" ) { //휴대폰번호 미입력시 
			alert("휴대폰 번호를 선택해주세요");
			$("#hp1").focus();
		} else if ( $("#hp2").val() == "" ) {  //휴대폰번호 미입력시 
			alert("휴대폰 번호를 입력해주세요");
			$("#hp2").focus();
		} else if ( $("#hp3").val() == "" ) {  //휴대폰번호 미입력시 
			alert("휴대폰 번호를 입력해주세요");
			$("#hp3").focus();
       } else {
       		var con_test = confirm("해당번호로 인증문자를 발송하시겠습니까?");   /* 문자를 보낼껀지 물어본다 */          
           	if(con_test == true){   
                $.ajax({
                    url:"sendSms.do",
                    type:"post",
                    data: {
                 	 	 to: to,
                         text: $("#text").val()
                    }, 
                  success:function(){
                    alert("해당 휴대폰으로 인증번호를 발송했습니다");      
                    $(".hp_msg").text("");
                    $("#userNum").focus();
                    },
                    
                 });  
           } 
         }   
     })
     
     
     
     $("#enterBtn").click(function() {   /* 내가 작성한 번호와 인증번호를 비교한다 */
        var userNum = $("#num").val();       
        var sysNum = $("#text").val();         
        
        if(userNum == null || userNum == ""){ 
     	  	$(".num_msg").text("휴대폰으로 발송된 인증번호를 입력해주세요").css("color","red");
     	   $("#num").focus();
     	} else{     
           if(userNum.trim() == sysNum.trim()){
              $(".num_msg").text("인증번호가 일치합니다.").css("color","blue");
              $(".hp_check").attr("id","on");
              $("#addr1").focus();
            }
            else {
            	$(".num_msg").text("인증번호가 일치하지 않습니다");
            	$("#num").focus();
            }          
        }
     });
    
})
</script>
<body>
<jsp:include page="../header.jsp"></jsp:include>

<form autocomplete="off" name="user_join" action="join_proc.do" method="post" >
<section>
<div class="join_box">
<p>회원가입</p>
	<section>
	<div class="center">	
	<table class="table">
		<tr>
			<th>아이디</th>
			<th><input type="text" class="form-control" placeholder="아이디를 입력해주세요" name="id" id="id"><button type="button" id="id_check"  class="off">중복확인</button>
			<div class="id_msg"></div></th>
		</tr>
		<tr>
			<th>비밀번호</th>
			<th><input type="password" class="form-control" placeholder="비밀번호를 입력해주세요" name="pass" id="pass"></th>
		</tr>
		<tr>
			<th>비밀번호 확인</th>
			<th><input type="password" class="form-control" placeholder="비밀번호 확인을 입력해주세요" name="cpass" id="cpass">
			<div class="pass_msg"></div></th>
		</tr>
		<tr>
			<th>이름</th>
			<th><input type="text" class="form-control" placeholder="이름을 입력해주세요" name="name" id="name">
			<div class="name_msg"></div></th>
		</tr>
		<tr>
			<th>생년월일</th>
			<th><input type="text" class="form-control" placeholder="주민등록번호 앞자리(6자리)" name="birth" id="birth">
			<div class="birth_msg"></div></th>
		</tr>		
		<tr>
			<th>이메일</th>
			<th>
				<input type="text" class="form-control "  placeholder="이메일 입력" name="email1" id="email1"> @ <input type="text" class="form-control" placeholder="주소 입력" name="email2" id="email2">
				<select class="form-select email-select">
					<option value="">직접 입력
					<option value="naver.com">네이버
					<option value="gmail.com">구글
					<option value="daum.net">다음
				</select>
				<div class="email_msg"></div>
			</th>
		</tr>
		<tr>
			<th>휴대폰번호</th>
			<th>
				<select class="form-select hp-select">
					<option value="">선택
					<option value="010">010
					<option value="011">011
					<option value="017">017
				</select> - 
				<input type="hidden" name="hp1" id="hp1" >
				<input type="text" class="form-control" placeholder="번호 입력" name="hp2" id="hp2"> - 
				<input type="text" class="form-control" placeholder="번호 입력" name="hp3" id="hp3">
				<button class="check hp_check"  type="button" id="off">인증</button>
				<input type="hidden" name="text" id="text">
				<div class="hp_msg"></div>
			</th>
		</tr>
		<tr>
			<th></th>
			<th>
				<input type="text" class="form-control" placeholder="인증번호 6자리를 입력해주세요" id="num">
				<button class="check" type="button" id="enterBtn" >확인</button>
				<div class="num_msg"></div>
			</th>
		</tr>
		<tr>
			<th>주소</th>
			<th>
				<input type="text" class="form-control addr" placeholder="주소를 입력해주세요" id="addr1" name="addr1">
				<input type="text" class="form-control addr" placeholder="상세 주소를 입력해주세요" id="addr2" name="addr2">
				<button type="button" class="btn btn-outline-dark"  onclick="addr()" >주소 검색</button>
				<div class="addr_msg"></div>
			</th>
		</tr>
	</table>
	<a href="index.do" class="cancle">가입취소</a>
	<button type="button" class="join">회원가입</button>
	</div>
</section>
</div>
</section>
</form>

<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>