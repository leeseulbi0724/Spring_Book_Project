<%@ page language="java" contentType=" text/html; charset=UTF-8"
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
<link href="http://localhost:9000/mybook/css/notice/notice_content.css" rel="stylesheet" >
<title>공지사항 | 라온 도서관</title>
</head>
<script src="http://rawgit.com/jackmoored/autosize/master/dist/autosize.min.js"></script>
<script>
	$(document).ready(function() {
		$("textarea").css("height", $("textarea").prop('scrollHeight')+5);
		
		/* $("#download").click(function() {
			 location.replace("fileDownLoad.do?fileName="+$(this).text());
		}); */
		
	});

</script>
<body>
 <jsp:include page="../header.jsp"></jsp:include>
 <section>
	 <div class="menu_div">
		 <div>
		 	<a href="index.do"><img src="http://localhost:9000/mybook/images/home_icon.png" width=15 height=15></a>>
		 	<a href="notice.do">커뮤니티</a>><a href="notice.do">공지사항</a>
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
		 		<h3>공지사항</h3>
		 		<img src="http://localhost:9000/mybook/images/title_back.gif" height=100% >
		 	</div>
		 	<table class="table">
		 		<tr>
		 			<td colspan="2"><strong>${vo.ntitle }</strong></td>
		 		</tr>
		 		<tr>
		 			<th>작성일</th>
		 			<th>${vo.ndate }</th>
		 		</tr>
		 		<tr>
		 			<th>작성자</th>
		 			<th>관리자</th>
		 		</tr>
		 		<tr>         	
		 			<th>첨부파일</th>
	 				<th>
	 					<c:if test="${not empty vo.nsfile }">
	 						<a href="fileDownLoad.do?fileName=${vo.nsfile }" id="download">${vo.nfile }</a>
	 					</c:if>
	 					<c:if test="${empty vo.nsfile }">
	 						첨부된 파일이 없습니다
	 					</c:if>
	 				</th>
		 		</tr>
		 		<tr>
		 			<td colspan="2">
		 				<textarea disabled style="resize: none;">${vo.ncontent }</textarea>
		 				<c:if test = "${!empty vo.nsfile}">
		 				 	<c:if test = "${ext ne 'hwp' }">
								<img src="http://localhost:9000/mybook/upload/${vo.nsfile }" width=80%>
							</c:if>
						</c:if>		
		 			</td>
		 		</tr>
		 	</table>
		 	<table class="table button">
		 		<tr>
		 			<th>이전글</th>
		 			<th>
		 			<c:if test = "${empty pvo }">
		 				<a>해당 글이 없습니다</a>
		 			</c:if>	
		 			<c:if test = "${not empty pvo }">
		 				<a href="notice_content.do?nid=${pvo.nid}&rno=${rno-1}&type=${type}">${pvo.ntitle }</a>
		 			</c:if>		 			
		 			</th>
		 		</tr>
		 		<tr>
		 			<th>다음글</th>
		 			<th>
		 				<c:if test = "${empty nvo }">
		 					<a>해당 글이 없습니다</a>
			 			</c:if>	
			 			<c:if test = "${not empty nvo }">
			 				<a href="notice_content.do?nid=${nvo.nid}&rno=${rno+1}&type=${type}">${nvo.ntitle }</a>
			 			</c:if>		
			 		</th>
		 		</tr>
		 	</table>
		 </div>
	 </div>
 </section>
  <jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>