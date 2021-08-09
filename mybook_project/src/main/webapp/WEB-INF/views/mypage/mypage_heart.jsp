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
<link href="http://localhost:9000/mybook/css/mypage/mypage_heart.css" rel="stylesheet" >
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