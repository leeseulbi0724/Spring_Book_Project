<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" type="image⁄x-icon" href="http://localhost:9000/mybook/images/icon.png">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" ></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" >
<script src="http://localhost:9000/mybook/js/jquery-3.6.0.min.js"></script>
<link href="http://localhost:9000/mybook/css/commons.css" rel="stylesheet" >
<link href="http://localhost:9000/mybook/css/search/search.css" rel="stylesheet" >
<title>도서 대여 | 라온 도서관</title>
</head>
<script>
$(document).ready(function() {
	$(".book_div").hover(function() {
		$(this).children().css("display","block");
	}, function() {
		$(this).children().css("display","none");
	});
	
	$(".rental").click(function() {
		if ($(this).attr("id") == 1) {
			alert("이미 대여중인 도서입니다");
			$(this).attr("href","");
		}
	});
	
	$("#more_btn").click(function() {
		$(".more_div").css("display", "inline-block");
	});
	
	$("#all").click(function() {
		location.reload();
	});
	
	$("#search").click(function() {
		search_ajax();
	});	

});	

function enterkey() {
    if (window.event.keyCode == 13) {
         // 엔터키가 눌렸을 때 실행할 내용
   	 search_ajax();
    }
}

function search_ajax() {
	var addListHtml="";
    var search = $("#search_input").val(); //도서명
    $.ajax({
		type:"GET",
		url:"search_proc.do",
		data:{
			search:search
		},
		success:function(result){
			var jdata = JSON.parse(result);
			
			if(jdata.jlist == null){
				$("#more_btn").remove();
			}
			for(var i in jdata.jlist){
				addListHtml += "<div class='book_div' id='book_div' style='background-image:url(http://localhost:9000/mybook/upload/" +jdata.jlist[i].bsfile+")'"+">";
				addListHtml += "	<div>";
				addListHtml += "<p ><strong class='bname'>" + jdata.jlist[i].bname + "</strong></p>";
				addListHtml += "<p>" + jdata.jlist[i].bauthor +" 지음<br>"+ jdata.jlist[i].bpublish +"<br>" + jdata.jlist[i].yyyy + "</p>";
				addListHtml += "<div>";
				addListHtml += "<a href='rental.do?bid="+jdata.jlist[i].bid+"'" +" class='rental' id='" +  jdata.jlist[i].status + "' style='margin-right:5px'>대여하기</a>";
				addListHtml += "<a href='content.do?bid="+jdata.jlist[i].bid+"'"+" class='detail' >상세정보</a>";
				addListHtml += "</div>";
				addListHtml += "</div>";
				addListHtml += "</div>";
			}
			$(".booklist").children().remove();
			$(".booklist").append(addListHtml);
			$(".book_div").hover(function() {
				$(this).children().css("display","block");
			}, function() {
				$(this).children().css("display","none");
			});
		}
	}); 
}



</script>
<body>
 <jsp:include page="../header.jsp"></jsp:include>
 <section>
	 <div class="menu_div">
		 <div>
		 	<a href="index.do"><img src="http://localhost:9000/mybook/images/home_icon.png" width=15 height=15></a>>
		 	<a href="search.do">이용안내</a>><a href="search.do">도서 목록</a>
		 </div>
	 </div>
	 <div class="content">
		 <div class="left">
		 	<ul>
		 		<li><a href="search.do">도서 대여</a></li>
		 		<li><a href="room.do">열람실 예약</a></li>
		 	</ul>
		 </div>
		 <div class="center">
		 	<div class="title">
		 		<h3>도서 목록</h3>
		 		<img src="http://localhost:9000/mybook/images/title_back.gif" height=100% >
		 	</div>		 	
	 		<div class="search">
	 			<img src="http://localhost:9000/mybook/images/search.png" width=30px height=30px >
	 			<input type="text" class="form-control" placeholder="검색하실 도서명을 입력해주세요" id="search_input" autocomplete="off" onkeyup="enterkey();">
	 			<button id="search">검색</button>
	 			<button id="all">전체</button>
	 			<div class="booklist">
	 			
	 			
	 			<!-- 0~11 도서만 먼저 보여주기 -->
	 			<c:forEach var = "vo"  items="${list}" varStatus="status" begin="0" end="11">
	 				<div class="book_div" style="background-image:url('http://localhost:9000/mybook/upload/${vo.bsfile}')">
	 					<div>
	 						<p><strong>${vo.bname }</strong></p>
	 						<p>${vo.bauthor } 지음<br>${vo.bpublish }<br>${vo.yyyy }</p>
	 						<div>
		 						<a href="rental.do?bid=${vo.bid }" class="rental" id="${vo.status }">대여하기</a>	 						
		 						<a href="content.do?bid=${vo.bid }" class="detail">상세정보</a>	 	
		 					</div>					
	 					</div>
	 				</div>	
	 			</c:forEach> 	
	 			
	 			<!-- 12~마지막 more버튼 클릭 시 보여주기 -->	
	 			<c:forEach var = "vo"  items="${list}" varStatus="status" begin="12" end="${fn:length(list)-1}" >
	 				<div class="book_div more_div" style="background-image:url('http://localhost:9000/mybook/upload/${vo.bsfile}')">
	 					<div>
	 						<p ><strong class="bname">${vo.bname }</strong></p>
	 						<p>${vo.bauthor } 지음<br>${vo.bpublish }<br>${vo.yyyy }</p>
	 						<div>
		 						<a href="rental.do?bid=${vo.bid }" class="rental" id="${vo.status }">대여하기</a>	 						
		 						<a href="content.do?bid=${vo.bid }" class="detail">상세정보</a>	 	
		 					</div>					
	 					</div>
	 				</div>	
	 			</c:forEach> 	
	 			
	 			
	 			
	 			
	 			<div class="button">
		 			<button type="button" id="more_btn">more
						<img src="http://localhost:9000/mybook/images/bill_list_btn2.png">
						<img src="http://localhost:9000/mybook/images/bill_list_btn.png">
					</button>		
				</div>
	 			</div>
	 		</div>
		 </div>
	 </div>
 </section> 
  <jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>