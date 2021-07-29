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
<script src="http://localhost:9000/myjeju/js/jquery-3.6.0.min.js"></script>
<title>도서 검색 | 라온 도서관</title>
<style>
	.menu_div {
		background-color:rgb(251,251,251);
		border-bottom:1px solid lightgray;
		text-align:center;
	}
	.menu_div>div { display:inline-block; width:1400px; text-align:right; }
	.menu_div a { margin-right:5px; text-decoration:none; color:black; }
	.menu_div a:last-child { font-weight:bold; margin-right:20px; }
	
	.book { color:rgb(43,129,199); border-bottom:5px solid rgb(43,129,199); }
	.home, .com  {	color:rgb(162,162,162); }
	
	section { text-align:center; }
	.content { display:inline-block; width:1300px; margin-top:50px; }
	.left { 
		display:inline-block; 
		width:250px; height:250px;
		float:left;	
	 }	 
	.left ul { list-style:none; padding:0; margin:0; text-align:left; border-top:1px solid; border-bottom:1px solid; }
	.left ul li { font-size:18px; padding:5px; border-bottom:1px solid lightgray; margin-left:10px; }
	.left ul a { text-decoration:none; color:black; }
	.left ul li:hover { text-decoration:underline; cursor:pointer; }
	.left ul li:last-child { border-bottom:none; }
	.left ul li:first-child a { color:rgb(43,129,199); font-weight:bold; }
	
	.center { display:inline-block; width:1000px; height:600px; }
	.title { height:100px; border-bottom:1px solid lightgray;}
	.title h3 {
		font-size:30px; 
		font-weight:bold; 
		float:left;
		margin:30px 15px;
	}
	.title img { float:right; }	
	
	.search {  text-align:left; margin-top:20px; }
	.search input { display:inline-block; width:500px; height:30px; font-size:14px; }
	.search button { background-color:rgb(43,129,199); color:white; border:none; }
	
	.booklist { margin-top:20px; width:100%; height:400px; }
	.book_div { border:1px solid lightgray; width:150px; height:210px; margin:5px; display:inline-block; background-size:95%; }
	
	 .book_div>div { 
	 	width:150px; height:210px;
	 	position:absolute; display:none; 
	 	background-color: rgba( 0,0,0, 0.5 );
	 	text-align:center;
	 }
	 .book_div>div>p {	color:white; }
	 .book_div>div>p:first-child { margin-top:20px; }
	 .book_div>div>p:nth-child(2) { margin-bottom:20px; }
	  .book_div>div>div { position:absolute; bottom:0px; margin-bottom:20px; }
	 .book_div>div>div>a {
	 	text-decoration:none;	 	
	 	padding:2px 5px;
	 	border-radius:4px;	 
	 }
	  .book_div>div>div>a:first-child { margin-left:15px; }
	 .rental { background-color:#4fa9de; color:white; cursor:pointer; }
	 .detail { background-color:rgb(245,245,245); color:black; }
	 
	 .button { text-align:center; }
	 #more_btn {
		width:65px;
		background-color:white;
		border:2px solid lightgray;
		border-radius:50px;
		padding:10px;
		color:lightgray;
		font-size:15px;
		text-align:center;
		margin-top:50px;
		cursor:pointer;
		display:inline-block;
	}
	 #more_btn:hover {
		border:2px solid #4fa9de;
		color:#4fa9de;
	}
	button#more_btn>img { width:18px; }
	button#more_btn>img:last-child { display:none; }
	button#more_btn:hover img:first-child {	display:none; }
	button#more_btn:hover img:last-child { display:inline-block; }
	
	.more_div { display:none; }
</style>
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
			var addListHtml="";
	        var search = $("#search_input").val();		
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
		});
});	
	
</script>
<body>
 <jsp:include page="../header.jsp"></jsp:include>
 <section>
	 <div class="menu_div">
		 <div>
		 	<a href="index.do"><img src="http://localhost:9000/mybook/images/home_icon.png" width=15 height=15></a>>
		 	<a href="search.do">이용안내</a>><a href="search.do">도서 검색</a>
		 </div>
	 </div>
	 <div class="content">
		 <div class="left">
		 	<ul>
		 		<li><a href="search.do">도서 검색</a></li>
		 		<li><a href="room.do">열람실 예약</a></li>
		 	</ul>
		 </div>
		 <div class="center">
		 	<div class="title">
		 		<h3>도서 검색</h3>
		 		<img src="http://localhost:9000/mybook/images/title_bg.gif" height=100% >
		 	</div>		 	
	 		<div class="search">
	 			<img src="http://localhost:9000/mybook/images/search.png" width=30px height=30px >
	 			<input type="text" class="form-control" placeholder="검색하실 도서명을 입력해주세요" id="search_input">
	 			<button id="search">검색</button>
	 			<button id="all">전체</button>
	 			<div class="booklist">
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
						<img src="http://localhost:9000/myjeju/images/travel/bill_list_btn2.png">
						<img src="http://localhost:9000/myjeju/images/travel/bill_list_btn.png">
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