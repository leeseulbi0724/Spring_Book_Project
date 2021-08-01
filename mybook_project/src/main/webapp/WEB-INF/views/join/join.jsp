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
<link rel="stylesheet" href="http://localhost:9000/mybook/css/join.css">
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="http://localhost:9000/mybook/js/address.js"></script>
<script src="http://localhost:9000/mybook/js/join/join.js"></script>
<title>회원가입 | 라온 도서관</title>
</head>
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