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
<script src="http://rawgit.com/jackmoored/autosize/master/dist/autosize.min.js"></script>
<link href="http://localhost:9000/mybook/css/commons.css" rel="stylesheet" >
<title>자유 게시판 | 라온 도서관</title>
<style>	
	.com { color:rgb(43,129,199); border-bottom:5px solid rgb(43,129,199); }
	.home, .book {	color:rgb(162,162,162); }
	
	.left ul li:nth-child(2) a { color:rgb(43,129,199); font-weight:bold; }

	.sub { text-align:left; }
	.first { border-bottom:1px solid lightgray; text-align:center; }
	.p_title { font-size:23px; padding:10px; }
	.p_id { font-weight:bold; margin-left:10px; text-align:right; }
	.p_date { color:gray; margin-left:10px; margin-bottom:5px; text-align:right; }	
	.sub textarea { background-color:white; width:100%; border:none; margin:5px; }
	
	.comment { border-top:1px solid lightgray; width:100%; padding:10px 0; margin-top:70px; }
	.comment>p { font-weight:bold; font-size:20px; float:left; }
	.comment>textarea { border:1px solid lightgray; margin-top:30px; width:900px; display:inline-block; float:left; }
	.comment>button { 
		display:inline-block; 
		color:white;
		border:none;
		float:left; 
		margin-top:45px; margin-left:10px;
		background-color:rgb(109,171,239);
		padding:5px 10px;
	}
	.comment>div:nth-child(2) { margin-top:50px; }
	.comment>div.comment_div { border-bottom:1px solid lightgray; text-align:left; padding:10px 0; }
	.comment_div img { margin-right:5px; }
	.comment_div>p:nth-child(2), .comment_div>p:nth-child(3) { margin-left:35px; }
	
	.list, .update, .delete {
		background-color:rgb(43,129,199); 
		color:white;
		float:right;
		text-decoration:none;
		margin-left:5px;
	}
	
	p>a { color:lightgray; text-decoration:none; cursor:pointer; }
</style>
</head>
<script>
	$(document).ready(function() {	
		$("#textarea").css("height", $("#textarea").prop('scrollHeight')+5);		
		
		$(".write").click(function() {
			if($("#com_textarea").val() == "") {
				alert("내용을 입력해주세요");
				$("#com_textarea").focus();
			} else {
				var comment = $("#com_textarea").val();
				var bid = "${vo.bid}";
				var id = "${vo.id}";
				 $.ajax({
		                type: "post",
		                url: "board_comment.do",
		                data: {comment:comment, bid:bid, id:id},
		                dataType: 'json',
		                success: function (result) {
		                    location.reload();
		                },

		            });
			}
		});		
		
		$(".delete").click(function() {
			if (confirm("게시물을 삭제하시겠습니까?")) {	
				$.ajax({
	                type: "post",
	                url: "board_delete.do",             
	                data:{bid:"${vo.bid}"},
	                dataType: 'json',
	                success: function (result) {
	                	alert("게시물이 삭제되었습니다");
	                	location.replace("board.do");
	                },
	           }); 
			} 
		});
		
		$(".comment_delete").click(function() {
			var cid = $(this).attr("id");
			$.ajax({
                type: "post",
                url: "board_comment_delete.do",             
                data:{cid:cid},
                dataType: 'json',
                success: function (result) {
                	location.reload();
                },
           }); 			
		});
		
		$(".comment_reply").click(function() {
			var div = "<div class='reply'>"
			div += "<textarea style='resize: none; width:800px' class='form-control'>"
			div += "</textarea>"
			div += "<button class='btn write' style='display:inline-block'>등록</button>"
			div += "</div>"
			$(this).append().html(div);
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
		 		<li><a href="online.do">온라인 토론</a></li>
		 	</ul>
		 </div>
		 <div class="center">
		 	<div class="title">
		 		<h3>자유 게시판</h3>
		 		<img src="http://localhost:9000/mybook/images/title_back.gif" height=100% >
		 	</div>
			<div class="sub">
				<div class="first">
					<p class="p_title">${vo.btitle }</p>
					<p class="p_id">${vo.name }**(${vo.id })</p>
					<p class="p_date">${vo.bdate } 조회 ${vo.bhit }</p>					
				</div>
				<textarea disabled style="resize: none;" id="textarea">${vo.bcontent }</textarea>
				<c:if test = "${not empty vo.bfile }">
					<c:forEach var = "img"  items="${img}" varStatus="status">	
						<a href="http://localhost:9000/mybook/upload/${img }" target='_blank'><img src="http://localhost:9000/mybook/upload/${img }" width=150 height=150></a>
					</c:forEach>
				</c:if>
			</div>
			<a href="board.do" class="btn list">목록</a>
			<c:if test = "${session_id eq vo.id}">
				<a href="board_update.do?bid=${vo.bid }" class="btn update">수정</a>
				<button class="btn delete">삭제</button>
			</c:if>
		 	<div class="comment">			
		 		<p>댓글</p>
		 		<c:forEach var = "vo"  items="${list}">
		 			<div></div>
			 		<div class="comment_div">
			 			<p>
			 			<c:if test = "${empty vo.img }">
			 				<img src="http://localhost:9000/mybook/images/human.png" width=25 height=25>
			 			</c:if>
			 			<c:if test = "${not empty vo.img }">
			 				<img src="http://localhost:9000/mybook/upload/${vo.img }" width=25 height=25>
			 			</c:if>
			 			<strong>${vo.name}**(${vo.id })</strong></p>
			 			<p>${vo.ccontent }</p>
			 			<p style="color:gray">
			 				${vo.cdate }
			 				<a class="comment_reply">답글</a>
			 				<c:if test="${session_id eq vo.id }">
			 					<a class="comment_update">수정</a>
			 					<a class="comment_delete" id="${vo.cid }">삭제</a>			 					
			 				</c:if>
			 			</p>
			 		</div>
		 		</c:forEach>
		 		<c:if test = "${not empty session_id }">
		 			<textarea style="resize: none;" class="form-control" id="com_textarea"></textarea>
		 			<button class="btn write">등록</button>
		 		</c:if>
		 		<c:if test = "${empty session_id }">
		 			<textarea style="resize: none;"class="form-control"  disabled>로그인 후 이용 가능합니다</textarea>
		 			<button class="btn">등록</button>
		 		</c:if>
		 	</div>	 	
		 </div>
	</div>
</section>
<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>