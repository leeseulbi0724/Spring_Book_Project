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
<script src="http://localhost:9000/mybook/js/jquery-3.6.0.min.js" ></script>
<title>휴대폰 인증 | 라온 도서관</title>
<style>
	div { text-align:center; }
	div>p { font-weight:bold; font-size:20px; margin:50px 0; }
	form { border:1px solid lightgray; padding:30px 0; margin-top:15px; display:inline-block; }
	form ul { list-style:none; padding:0; margin:0; }
	form label { display:inline-block; width:100px; text-align:left; }
	form li { display:inline-block; margin:5px 0; }
	.form-control { display:inline-block; height:30px; font-size:14px; }
	.name, .id { width:300px; }
	.hp, .num { width:250px; }
	.first { width:150px; }
	.last { width:40px; }
	form button { 
		background-color:rgb(43,129,199); 
		color:white; 
		display:inline-block; 
		border:none;
		border-radius:4px;
	}
</style>
</head>
<script>   
 $(document).ready(function() {
    $("#send").click(function() {       
       var number = Math.floor(Math.random() * 100000) + 100000;
          if(number>100000){ number = number - 10000; }
          $("#text").val(number);      /* 난수로 생성된 인증번호를 hidden name : text 에 숨긴다 */      
               
          
       var to = $("#to").val();
       var name = $("#name").val();
       var first = $("#first").val();
       var last = $("#last").val();
       var id = $("#id").val();   
      
    
      if ( name == "" || name == null ) {
    	  alert("이름을 입력해주세요");
    	  $("#name").focus();
      } else if ( first == "" || first == null ) {
    	  alert("주민등록번호를 입력해주세요");
    	  $("#first").focus();
      } else if ( last == "" || last == null ) {
    	  alert("주민등록번호를 입력해주세요");
    	  $("#last").focus();    	  
      } else if ( id == "" || id == null ) {
 	      alert("아이디를 입력해주세요");
 	      $("#id").focus();
	  } else if ( to == "" || to == null ) {
    	  alert("휴대폰 번호를 입력해주세요");
    	  $("#to").focus();    	 
      } else {
      		var con_test = confirm("해당번호로 인증문자를 발송하시겠습니까?");   /* 문자를 보낼껀지 물어본다 */          
          	if(con_test == true){   
               $.ajax({
                   url:"sendSms.do",
                   type:"post",
                   data: {
                	 	to: $("#to").val(),
                        text: $("#text").val()
                   }, 
                 success:function(){
                   alert("해당 휴대폰으로 인증번호를 발송했습니다");
                   $("#userNum").focus();
                   },
                   error(){
                      
                   }
                   
                });  
          } else if(con_test == false) {
	        	  $("#to").val("");
	              $("#name").val("");
	              $("#first").val("");
	              $("#last").val("");
	              $(".id").val("");
             }
         }   
    })
    $("#enterBtn").click(function() {   /* 내가 작성한 번호와 인증번호를 비교한다 */
       var userNum = $("#userNum").val();       
       var sysNum = $("#text").val();         
       
       if(userNum == null || userNum == ""){ 
		   alert("휴대폰으로 발송된 인증번호를 입력해주세요");
    	   $("#userNum").focus(); 
    	} else{     
          if(userNum.trim() == sysNum.trim()){        	  
        	  alert("인증번호가 일치합니다");
        	  $("#go").attr("disabled",false);
           }
           else {
              alert("인증번호가 일치하지 않습니다");
           }          
       }
    });
  }); 
 
</script>
<body>
	<!-- 아이디 찾기 -->
	<c:if test="${type eq 'id'}">	
		<div>
			<p>휴대폰 인증</p>
			<form autocomplete="off" name="find_proc" action="phone_id_proc.do" method="post">
				<ul>
					<li>
						<label>이름</label>
						<input type="text" placeholder="이름" class="form-control name" id="name" name="name">
					</li>
					<li>
						<label>주민등록번호</label>
						<input type="text" placeholder="●●●●●●" class="form-control first" id="first" name="birth"> - <input type="password" placeholder="●" class="form-control last" id="last">●●●●●●
					</li>
					<li>
						<label>휴대폰번호</label>
						<input type="text" placeholder="'-'를 포함하여 작성해주세요" id="to" name="hp" class="form-control hp" >
						<button type="button" id="send">전송</button>
					</li>
					<li>
						<label>인증번호</label>
						<input type="text" placeholder="인증번호 6자리를 입력해주세요" id="userNum" class="form-control num">
						<button type="button" id="enterBtn">확인</button>
						<input type="hidden" name="text" id="text">
						<input type="hidden" name="text" id="id" value="empty">
					</li>
				</ul>
			<button type="submit" disabled id="go">찾기</button>
			</form>
		</div>		
	</c:if>
	
	<!-- 비밀번호 찾기 -->
	<c:if test="${type eq 'pass'}">
				<div>
			<p>휴대폰 인증</p>
			<form autocomplete="off" name="find_proc" action="phone_pass_proc.do" method="post">
				<ul>
					<li>
						<label>이름</label>
						<input type="text" placeholder="이름" class="form-control name" id="name" name="name">
					</li>
					<li>
						<label>주민등록번호</label>
						<input type="text" placeholder="●●●●●●" class="form-control first" id="first" name="birth"> - <input type="password" placeholder="●" class="form-control last" id="last">●●●●●●
					</li>
					<li>
						<label>아이디</label>
						<input type="text" placeholder="아이디" class="form-control id" id="id" name="id">
					</li>
					<li>
						<label>휴대폰번호</label>
						<input type="text" placeholder="''-'를 포함하여 작성해주세요" id="to" name="hp" class="form-control hp">
						<button type="button" id="send">전송</button>
					</li>
					<li>
						<label>인증번호</label>
						<input type="text" placeholder="인증번호 6자리를 입력해주세요" id="userNum" class="form-control num">
						<button type="button" id="enterBtn">확인</button>
						<input type="hidden" name="text" id="text">
					</li>
				</ul>
			<button type="submit" id="go" disabled>찾기</button>
			</form>
		</div>	
	</c:if>
</body>
</html>