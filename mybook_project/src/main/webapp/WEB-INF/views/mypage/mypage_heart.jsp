<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 | 라온 도서관 </title>
<link rel="shortcut icon" type="image⁄x-icon" href="http://localhost:9000/mybook/images/icon.png">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" ></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" >
<script src="http://localhost:9000/mybook/js/jquery-3.6.0.min.js" ></script>
<style>
	.one { border-bottom:2px solid rgb(43,129,199); }	
	.four, .three, .two { border-bottom:2px solid lightgray; }
	
	.content { 
		background-color:rgb(248,249,251); 
		width:100%;
		margin-bottom:-100px; 
		border-top:1px solid lightgray;
		text-align:center;
	}
	.content>div { display:inline-block; margin-top:50px; }
	.box { 
		display:inline-block; 
		width:900px; 
		padding:20px 0;
		text-align:center;
	}
	.box>div { display:inline-block; }
	.heart {
		background-color:white;
		width:190px; 	height:190px;
		margin-top:-10px;
		border-radius:20px; float:left;
		color:lightgray;
		position :relative;
		border:1px solid lightgray;		
		margin:5px 15px;
	}
	.heart>img { width:15%; height:15%; position:absolute; bottom:0; margin-bottom:5px; margin-left:-15px; }
	.heart>p { color:black; }
</style>
</head>
<script>
$(document).ready(function() {
	$(".heart").click(function() {
		var bid = $(this).attr("name");
		$.ajax({
            type: "post",
            url: "heart_minus.do",
            data:{bid:bid},
            dataType: 'json',
            success: function (result) {
                location.reload();
            },
        });
	});
});
</script>
<body>
 <jsp:include page="../header.jsp"></jsp:include>
 
  <jsp:include page="mypage_commons.jsp"></jsp:include>
  <section class="content">
	  <div>
	  	<div class="box">	  		
		  	<div>
		  	<c:forEach var = "vo"  items="${list}" >
		  		<button class="heart" name="${vo.bid }">
		  			<p>${vo.bname }</p>
					<img src="http://localhost:9000/mybook/images/heart_after.png" class="heart_img">
				</button>
			</c:forEach>
			</div>
	  	</div>
	  </div>
  </section>
   <jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>