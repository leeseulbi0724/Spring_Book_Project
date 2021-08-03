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
<link href="http://localhost:9000/mybook/css/commons.css" rel="stylesheet" >
<title>자유 게시판 | 라온 도서관</title>
<style>	
	.com { color:rgb(43,129,199); border-bottom:5px solid rgb(43,129,199); }
	.home, .book {	color:rgb(162,162,162); }

	.left ul li:nth-child(2) a { color:rgb(43,129,199); font-weight:bold; }
	
	.center { display:inline-block; width:1000px; height:500px; }
	.title { height:100px; border-bottom:1px solid lightgray;}
	.title h3 {
		font-size:30px; 
		font-weight:bold; 
		float:left;
		margin:30px 15px;
	}
	.title img { float:right; }	

	.form-control { display:inline-block; margin-bottom:5px; font-size:14px; }
	.textarea { height:500px; resize:none; }
	
	.up, .back { margin-top:20px; padding:3px10px; }
	.up { background-color:rgb(109,171,239); color:white; }
	.back { background-color:white; border:1px solid lightgray; }
	.back:hover { background-color:lightgray; }
	
	form>div { text-align:left; }
	.file_name, .sfile_name, .old_name { display:none; }
	.minus { display:inline-block; margin-left:5px; border:1px solid lightgray; }
	#file { width:970px; display:inline-block; background-color:white; }
</style>
</head>
<script>
	$(document).ready(function() {
		$(".up").click(function() {
			if ($(".btitle").val() == "") {
				alert("제목을 입력해주세요");
				$(".btitle").focus();
			} else if ($(".textarea").val() == "") {
				alert("내용을 입력해주세요");
				$(".textarea").focus();
			} else {
				board_update.submit();
			}
		});
		
		$("#file_name").val($(".file_name").text());
		$("#sfile_name").val($(".sfile_name").text());
		
		$("button[class='minus']").click(function() {
			$(this).closest("div").next().next().remove();
			$(this).closest("div").next().remove();
			$(this).closest("div").remove();
			
			$("#sfile_name").val($(".sfile_name").text());
			$("#file_name").val($(".file_name").text());
			
			$(".old_name").append($(this).prev().attr("name")+",");
			$("#old_name").val($(".old_name").text());
		});
	});
</script>
<body>
<jsp:include page="../header.jsp"></jsp:include>

 <section>
	 <div class="menu_div">
		 <div>
		 	<a href="index.do"><img src="http://localhost:9000/mybook/images/home_icon.png" width=15 height=15></a>>
		 	<a href="board.do">커뮤니티</a>><a href="board.do">자유 게시판</a>
		 </div>
	 </div>
	 <div class="content">
		 <div class="left">
		 	<ul>
		 		<li><a href="notice.do">공지사항</a></li>
		 		<li><a href="board.do">자유 게시판</a></li>
		 		<li><a href="request.do">희망도서 신청</a></li>
		 	</ul>
		 </div>
		 <div class="center">
		 	<div class="title">
		 		<h3>자유 게시판</h3>
		 		<img src="http://localhost:9000/mybook/images/title_back.gif" height=100% >
		 	</div>
		 	<form name="board_update" action="board_update_proc.do" method="post" enctype= "multipart/form-data">
				<input type="text" class="form-control btitle" name="btitle" value="${vo.btitle }">
				<textarea class="form-control textarea" name="bcontent">${vo.bcontent }</textarea>
				<input type="file" class="form-control"  multiple="multiple" name="file">
				<c:forEach var="vo"  items="${list}">
	 				<div>
	 					<input type="text" class="form-control"  id="file" readonly value="${vo.bfile }" name="${vo.bsfile }">
	 					<button type="button" class="minus">-</button>
	 				</div>
 					<span class="file_name">${vo.bfile},</span>		 					
 					<span class="sfile_name">${vo.bsfile},</span>
				 </c:forEach>
				<a class="btn up">수정</a>
				<a href="board_content.do?bid=${vo.bid }" class="btn back">취소</a>
				<input type="hidden" name="bid" value="${vo.bid }">
		 		<input id="file_name" type="hidden" name="bfile">
		 		<input id="sfile_name"  type="hidden" name="bsfile">
		 		<input id="old_name" type="hidden" name="old_name">
		 		<span class="old_name"></span>
			</form>
		 </div>
	</div>
</section>

<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>