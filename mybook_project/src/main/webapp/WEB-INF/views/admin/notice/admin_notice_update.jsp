<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 | Admin</title>
<link rel="shortcut icon" type="image⁄x-icon" href="http://localhost:9000/mybook/images/icon.png">
<script src="http://localhost:9000/mybook/js/jquery-3.6.0.min.js"></script>
<link href="http://localhost:9000/mybook/css/admin/notice/admin_notice_update.css" rel="stylesheet" >
<script>
$(document).ready(function() {
	$("#write").click(function() {
		if ($("#select").val() == "null") {
			alert("카테고리를 선택해주세요");
			$("#select").focus();
		} else if ($("#title").val() == "") {
			alert("제목을 입력해주세요");
			$("#title").focus();		
		} else if ($("#content").val() == "") {
			alert("내용을 입력해주세요");
			$("#content").focus();		
		} else {
			 admin_update.submit();
		}
	});
	
	$("#select").change(function() {
		$("#category").val($(this).val());
	});
	
	$("#nfile").change(function() {
		if (window.FileReader) {
			var filename = $(this)[0].files[0].name;
			$(".file").text("").text(filename);
		}
	});
});
</script>
</head>
<body>
<jsp:include page="../admin_main.jsp"></jsp:include>

<section class="center">
	<h3>공지사항 수정</h3>
	<p><a>공지사항</a><span>></span><a>공지사항 목록</a><span>></span><a>수정하기</a></p>
	<div class="write_box">
	<div class="box">
			<select class="form-select" id="select" >
			<c:if test = "${vo.ncategory eq 'spcl' }">
				<option value="null">선택</option>
				<option value="spcl" selected>공지</option>
				<option value="normal">일반</option>
			</c:if>
			<c:if test = "${vo.ncategory eq 'normal' }">
				<option value="null">선택</option>
				<option value="spcl">공지</option>
				<option value="normal"  selected>일반</option>
			</c:if>
			</select>
		<form autocomplete="off" name="admin_update" action="admin_notice_update_proc.do" method="post" enctype= "multipart/form-data">
			<input type="hidden" class="form-control" id="category" name="ncategory" value="${vo.ncategory }">
			<input type="hidden" class="form-control" name="nid" value="${vo.nid }">
			<input type="text" class="form-control" id="title" name="ntitle" placeholder="제목을 입력해주세요" value="${vo.ntitle }">
			<textarea name="ncontent" class="form-control" style="resize: none;" id="content" placeholder="내용을 입력해주세요">${vo.ncontent }</textarea>
			<input type="file" class="form-control" id="nfile" name="file1">
			<div class="file">${vo.nfile }</div>
		<a class="btn btn-primary" href="admin_notice.jsp" role="button" id="list">목록</a>
		<button type="button" class="btn btn-primary"  id="write">등록</button>
		<button type="reset" class="btn btn-primary"  id="reset">취소</button>	
		</form>
	</div>
	</div>
</section>
<script>
</script>
</body>
</html>