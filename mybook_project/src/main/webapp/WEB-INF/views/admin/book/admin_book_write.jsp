<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서 관리 | Admin</title>
<link rel="shortcut icon" type="image⁄x-icon" href="http://localhost:9000/mybook/images/icon.png">
<script src="http://localhost:9000/mybook/js/jquery-3.6.0.min.js" ></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" ></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" >
<script type="text/javascript" src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<link href="http://localhost:9000/mybook/css/admin/book/admin_book_write.css" rel="stylesheet" >
</head>
<script>
	$(document).ready(function() {		
		$("#write").click(function() {
			if ($("#bname").val() == "") {
				alert("책명을 입력해주세요");
				$("#bname").focus();
			} else if ($("#bauthor").val() == "") {
				alert("저자를 입력해주세요");
				$("#bauthor").focus();
			} else if ($("#bpublish").val() == "") {
				alert("출판사를 입력해주세요");
				$("#bpublish").focus();
			} else if ($("#bdate").val() == "") {
				alert("출간일을 입력해주세요");
				$("#bdate").focus();
			} else if ($("#bcontent").val() == "") {
				alert("설명을 입력해주세요");
				$("#bcontent").focus();
			} else if ($("#bfile").val() == "") {
				alert("이미지를 첨부해주세요");
				$("#bfile").focus();
			} else {
				admin_book.submit();
			}
		});
		
		$("#search").click(function() {
			 var url = "admin_book_search.do";
	         var name = "popup test";
	         var option = "width = 500, height = 600, top = 150, left = 500, location = no"
	         window.open(url, name, option);
		 });
	});
</script>
<body>
<jsp:include page="../admin_main.jsp"></jsp:include>

<section class="center">
	<h3>도서 등록</h3>
	<p><a>도서</a><span>></span><a>도서 목록</a><span>></span><a>도서 등록</a></p>
	<div class="list_box">			
		<div class="box">
		<form name="admin_book" action="admin_book_write_proc.do" method="post" enctype="multipart/form-data">
		<button type="button" class="btn btn-outline-secondary"  id="search">도서검색</button>	
		<table class="table">
		 		<tr>
		 			<th>책명</th>
		 			<th><input type="text" placeholder="책 이름" class="form-control" name="bname" id="bname"></th>
		 		</tr>
		 		<tr>
		 			<th>저자</th>
		 			<th><input type="text" placeholder="저자" class="form-control" name="bauthor" id="bauthor"></th>
		 		</tr>
		 		<tr>
		 			<th>출판사</th>
		 			<th><input type="text" placeholder="출판사" class="form-control" name="bpublish" id="bpublish"></th>
		 		</tr>	
		 		<tr>
		 			<th>출간일</th>
		 			<th><input type="date" class="form-control" name="bdate" id="bdate" ></th>
		 		</tr>	 		
		 			<tr>
		 			<td colspan="2">
		 				<textarea style="resize: none;" placeholder="설명" class="form-control" name="bcontent" id="bcontent"></textarea>		 					
		 			</td>
		 		</tr>
		 		<tr>
		 			<th>이미지 업로드</th>
		 			<th><input type="file" class="form-control" name="file1" id="bfile">
		 		</tr>
		 	</table>
		 	<a class="btn btn-secondary" href="admin_book.do" role="button" id="list">목록</a>
		 	<button type="button" class="btn btn-primary"  id="write">등록</button>
			<button type="reset" class="btn btn-secondary"  id="reset">취소</button>	
		</form>
		</div>
	</div>
</section>
</body>
</html>