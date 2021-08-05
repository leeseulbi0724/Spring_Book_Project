<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<script src="http://rawgit.com/jackmoored/autosize/master/dist/autosize.min.js"></script>
<style>
	.book { border-bottom:4px solid rgb(76,127,242); }
	.center { width:1319.2px; height:705px; float:left;  background-color:rgb(234,238,241); }
	.center h3 { font-weight:bold; margin:15px 20px; font-size:16px; }
	.center p { float:right; margin-top:-35px; margin-right:20px; }
	.center  a, .center span { font-size:12px; font-weight:normal; float:left; }
	.list_box { width:1275px; height:600px; background-color:white; margin-left:20px; text-align:center; }
	div.box { display:inline-block; margin-top:30px; text-align:center; display:inline-block; width:1000px; }
	.table { margin-top:20px; font-size:14px; }
	.table tr { border-bottom:1px solid lightgray; }
	.table th { font-weight:normal; text-align:left; padding-left:15px; }
	.table th:first-child { width:100px; background-color:rgb(248,248,248); vertical-align:middle; }
	.table td>textarea { width:100%; background-color:white; border:none; height:100px; }
	input[type=text] { height:30px; display:inline-block; }
	input[type=file] { height:35px; }
	
	#write, #reset { float:right; margin:10px 3px; font-size:12px; }
	#list { float:left; margin-top:10px; }
	
	.file { background-color:white; position:absolute; margin-top:-27px; margin-left:90px; width:500px; }
</style>
</head>
<script>
	$(document).ready(function() {		
		$("#bcontent").css("height", $("#bcontent").prop('scrollHeight')+5);		
		
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
			} else if ($(".file").text() == "") {
				alert("이미지를 첨부해주세요");
				$("#bfile").focus();
			} else {
				admin_book.submit();
			}
		});
		
		$("#bfile").change(function() {
			if (window.FileReader) {
				var filename = $(this)[0].files[0].name;
				$(".file").text("").text(filename);
			}
		});
	});
</script>
<body>
<jsp:include page="../admin_main.jsp"></jsp:include>

<section class="center">
	<h3>도서 수정</h3>
	<p><a>도서</a><span>></span><a>도서 목록</a><span>></span><a>도서 수정</a></p>
	<div class="list_box">			
		<div class="box">
		<form name="admin_book" action="admin_book_update_proc.do" method="post" enctype="multipart/form-data">
		<table class="table">
		 		<tr>
		 			<th>책명</th>
		 			<th><input type="text" class="form-control" name="bname" id="bname" value="${vo.bname }"></th>
		 		</tr>
		 		<tr>
		 			<th>저자</th>
		 			<th><input type="text" class="form-control" name="bauthor" id="bauthor" value="${vo.bauthor }"></th>
		 		</tr>
		 		<tr>
		 			<th>출판사</th>
		 			<th><input type="text" class="form-control" name="bpublish" id="bpublish" value="${vo.bpublish }"></th>
		 		</tr>	
		 		<tr>
		 			<th>출간일</th>		 			
		 			<th>
		 				<input type="date" class="form-control" name="bdate" id="bdate" value="${vo.yyyy }-${vo.mm}-${vo.dd}" >
		 			</th>
		 		</tr>	 		
		 			<tr>
		 			<td colspan="2">
		 				<textarea style="resize: none;" placeholder="설명" class="form-control" name="bcontent" id="bcontent">${vo.bcontent }</textarea>		 					
		 			</td>
		 		</tr>
		 		<tr>
		 			<th>이미지</th>
		 			<th><input type="file" class="form-control" name="file1" id="bfile">
		 			<div class="file">${vo.bfile }</div>
		 		</tr>
		 	</table>
		 	<input type="hidden" value="${vo.bid }" name="bid">
		 	<a class="btn btn-secondary" href="admin_book.do" role="button" id="list">목록</a>
		 	<button type="button" class="btn btn-primary"  id="write">수정</button>
			<button type="reset" class="btn btn-secondary"  id="reset">취소</button>	
		</form>
		</div>
	</div>
</section>
</body>
</html>