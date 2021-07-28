$(function() {
	$("#id_check").on("click", check);
})

function check() {
	var id = $("#id").val();
    $.ajax({
        url:"id_check.do",
        type:"post",
        data: {
     	 	 id: id,
        }, 
        dataType:"json",
      success:function(result){
      		if (result) {
      			$(".id_msg").text("사용 가능한 아이디입니다").css("color","blue");
      			$("#id_check").attr("class","on");
      			$("#pass").focus();
      		} else {
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
		/* } else if ($(".hp_check").attr("id") == "off") {
			alert("휴대폰 인증버튼을 클릭해주세요");
			$(".hp_check").focus(); */
		} else if ($("#id_check").attr("class") == "off") {
			 alert("아이디 중복확인 버튼을 클릭해주세요");
			 $("#id_check").focus();
		} else {
			user_join.submit();			
		}
		
	});
	
	/* 비밀번호 - 비밀번호 확인 체크 */
	$("#cpass").blur(function() {
		if ($("#pass").val() != $("#cpass").val() ) {
			$(".pass_msg").text("비밀번호가 동일하지 않습니다.").css("color","red");
			$("#cpass").val("").focus();
		} else {
			$(".pass_msg").text("비밀번호가 동일합니다.").css("color","blue");
		}
	});
	
	/* 생년월일 - 6자리 확인 */
	$("#birth").blur(function() {
		if ( $("#birth").val() != "" && $("#birth").val().length != "6") {
			$(".birth_msg").text("생년월일 형식에 맞지 않습니다.").css("color","red");
			$("#birth").val("").focus();
		} else if ( $("#birth").val() != "" && $("#birth").val().length == "6" ) {
			$(".birth_msg").text("");
		}
	});
	
	/* 인증번호 보내기 */
    $("#off").click(function() {       
        var number = Math.floor(Math.random() * 100000) + 100000;
           if(number>100000){ number = number - 10000; }
           $("#text").val(number);      /* 난수로 생성된 인증번호를 hidden name : text 에 숨긴다 */      
           
        var to = $("#hp1").val() + $("#hp2").val() + $("#hp3").val();
       
     
        if ( $("#hp1").val() == "" ) {
			alert("휴대폰 번호를 선택해주세요");
			$("#hp1").focus();
		} else if ( $("#hp2").val() == "" ) {
			alert("휴대폰 번호를 입력해주세요");
			$("#hp2").focus();
		} else if ( $("#hp3").val() == "" ) {
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
           } else if(con_test == false) {
 	        	  
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