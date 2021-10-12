<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" type="image⁄x-icon" href="http://localhost:9000/mybook/images/icon.png">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" ></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" >
<script src="http://localhost:9000/mybook/js/jquery-3.6.0.min.js" ></script>
<link href="http://localhost:9000/mybook/css/admin/book/admin_book_search.css" rel="stylesheet" >
<title>도서 찾기 | 라온 도서관</title>
</head>
<script>
	$(document).ready(function() {
		$(".search").click(function() {
			if ($("#name").val() == "") {
				alert("도서명을 입력해주세요");
				$("#name").focus();
			} else {
				$(".div").children().remove();
				$.ajax({
					method:"GET",
					url:"https://dapi.kakao.com/v3/search/book?target=title",
					data:{query:$("#name").val() },
					headers:{Authorization:"KakaoAK 18270a8d7ab06d0e6f58f0a0a1a28cc0"},				
					success : function(msg) {
						 for(var i=0; i<10; i++){							
							var date = new Array();
							date = msg.documents[i].datetime.split("T");
							var html = "";
							html += "<div class='box'>";
							html += "<div class='img'>";
							html += "<img src='"+msg.documents[i].thumbnail+"'>";
							html += "</div>";
							html += "<div class='text'>";
							html += "<p><strong>도서명</strong> "+msg.documents[i].title+"</p>";
							html += "<p><strong>저자</strong> "+msg.documents[i].authors+"</p>";
							html += "<p><strong>출판사</strong> "+msg.documents[i].publisher+"</p>";
							html += "<button class='" + msg.documents[i].publisher +"' id='"+msg.documents[i].title +"' name='" +msg.documents[i].authors + "'>선택하기</button>"
							html += "<input type='hidden' value='"+msg.documents[i].contents+"'>";
							html += "<input type='hidden' value='"+date[0] +"'>";
							html += "<input type='hidden' value='"+msg.documents[i].thumbnail+"'>";
							html += "</div>";
							html += "</div>";
							$(".div").append(html);
							
							$(".box button").click(function() {
								$("#bname").val($(this).attr("id"));
								$("#bauthors").val($(this).attr("name"));
								$("#bpublisher").val($(this).attr("class"));
								
								opener.document.getElementById("bname").value = document.getElementById("bname").value;
								opener.document.getElementById("bauthor").value = document.getElementById("bauthors").value;
								opener.document.getElementById("bpublish").value = document.getElementById("bpublisher").value;
								opener.document.getElementById("bcontent").value = $(this).next().val();
								opener.document.getElementById("bdate").value = $(this).next().next().val();
								window.close();
								
							});
						 } 
					}
				})
			}
		});
		
		
	});
</script>
<body>
<div id="contents">
	<input type="hidden" id="bname">
	<input type="hidden" id="bauthors">
	<input type="hidden" id="bpublisher">
	<p>도서 찾기</p>
	<input class="form-control" placeholder="도서명을 입력해주세요" id="name" autocomplete="off">
	<button class="search">검색</button>
	<div class="div"></div>
</div>
  
</body>
</html>