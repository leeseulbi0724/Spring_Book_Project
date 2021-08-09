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
<link href="http://localhost:9000/mybook/css/index/index.css" rel="stylesheet" >
<script src="http://localhost:9000/mybook/js/jquery-3.6.0.min.js" ></script>
<<!-- script src="http://localhost:9000/mybook/js/index/index.js" ></script>  -->
<title>라온 도서관</title>
</head>
<script>


$(document).ready(function() {
	$(".search_btn").click(function() {
		if ($("#search").val() == "") {
			alert("도서명을 입력해주세요");
			$("#search").focus();
		} else {
			$.ajax({
				method:"GET",
				url:"https://dapi.kakao.com/v3/search/book?target=title", //kakao api
				data:{query:$("#search").val() }, //도서명 전달
				headers:{Authorization:"KakaoAK 18270a8d7ab06d0e6f58f0a0a1a28cc0"},				
				success : function(msg) {
					window.open(msg.documents[0].url); //새로운 창으로 상세페이지 띄우기
				}
			})
		}
	});
	
	
});
</script>
<body>
 <jsp:include page="header.jsp"></jsp:include>

<section>	
	<div class="back_box">
		<div class="center_box">
			<div>
				<div class="best">
					<p class="title">대여 BEST 5</p>
					<ul>
						<c:forEach var = "vo"  items="${blist}"  varStatus="status" >			
							<li><a href="content.do?bid=${vo.bid }">${vo.bname }</a></li>
						</c:forEach>			
						</ul>
				</div>
				<div class="notice">
					<div>
						<p class="title">공지사항<a href="notice.do">더보기+</a></p>						
						<ul>
						<c:forEach var = "vo"  items="${list}" varStatus="status"  begin="0" end="4">			
							<li><a href="notice_content.do?nid=${vo.nid }&rno=${vo.rno }&type=spcl">${vo.ntitle }</a></li>
						</c:forEach>			
						</ul>
					</div>
				</div>
				<div class="search">
					<div>
						<p class="title">도서검색</p>
						<p>검색하고자 하는 도서명을 입력해주세요.</p>
						<input type="text" class="form-control" id="search" autocomplete="off">
						<button class="btn search_btn">검색</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>	

 <jsp:include page="footer.jsp"></jsp:include>
</body>
</html>