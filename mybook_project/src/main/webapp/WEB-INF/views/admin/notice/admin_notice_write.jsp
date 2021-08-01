<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 | Admin</title>
<script src="http://localhost:9000/mybook/js/jquery-3.6.0.min.js"></script>
<style>
	.notice { border-bottom:4px solid rgb(76,127,242); }
	.center { width:1319.2px; height:705px; float:left; background-color:rgb(234,238,241);  }
	.center h3 { font-weight:bold; margin:15px 20px; font-size:16px; }
	.center p { float:right; margin-top:-35px; margin-right:20px; }
	.center  a, .center span { font-size:12px; font-weight:normal; float:left; }
	.write_box { width:1275px; height:600px; background-color:white; margin-left:20px; text-align:center; }
	#list { float:left; margin-top:10px; }
	#write, #reset { float:right; margin:10px 3px; font-size:12px; }
	
	.form-control { width:1000px; display:inline-block; }
	#title, #nfile { font-size:14px; }
	#select { width:100px; display:inline-block; float:left; font-size:14px; }
	#content { height:300px; font-size:14px;  }
	
	div.box { display:inline-block; margin-top:30px; text-align:center; display:inline-block; width:1000px; }
</style>
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
			 admin_write.submit();
		}
	});
	
	$("#select").change(function() {
		$("#category").val($(this).val());
	});
});
</script>
</head>
<body>
<jsp:include page="../admin_main.jsp"></jsp:include>

<section class="center">
	<h3>공지사항 등록</h3>
	<p><a>공지사항</a><span>></span><a>공지사항 목록</a><span>></span><a>등록하기</a></p>
	<div class="write_box">
	<div class="box">
			<select class="form-select" id="select" >
				<option value="null">선택
				<option value="spcl">공지
				<option value="normal">일반
			</select>
		<form autocomplete="off" name="admin_write" action="admin_notice_write_process.do" method="post" enctype= "multipart/form-data">
			<input type="hidden" class="form-control" id="category" name="ncategory">
			<input type="text" class="form-control" id="title" name="ntitle" placeholder="제목을 입력해주세요">
			<textarea name="ncontent" class="form-control" style="resize: none;" id="content" placeholder="내용을 입력해주세요"></textarea>
			<input type="file" class="form-control" id="nfile" name="file1">
		<a class="btn btn-secondary" href="admin_notice.do" role="button" id="list">목록</a>
		<button type="button" class="btn btn-primary"  id="write">등록</button>
		<button type="reset" class="btn btn-secondary"  id="reset">취소</button>	
		</form>
	</div>
	</div>
</section>
<script>
</script>
</body>
</html>