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
<title>라온 도서관</title>
<style>
	html, body, div, span, object, iframe, h1, h2, h3, h4, h5, h6, p, blockquote, pre, abbr, address, cite, code, del, dfn, em, img, ins, kbd, q, samp, small, strong, sub, sup, var, b, i, dl, dt, dd, ol, ul, li, fieldset, form, label, legend, table, caption, tbody, tfoot, thead, tr, th, td, article, aside, canvas, details, figcaption, figure, footer, header, hgroup, menu, nav, section, summary, time, mark, audio, video {
	    margin: 0;
	    padding: 0;
	    border: 0;
	    font-size:100%;
	    vertical-align: baseline;
	    background: transparent;
	}
	.home { 	color:rgb(43,129,199);	border-bottom:5px solid rgb(43,129,199); }
	.com, .book { color:rgb(162,162,162); }
	
	body { background-color:rgb(240,242,244); }	
	section { text-align:center; 	}
	.back_box {
		display:inline-block; 
		text-align:center;
		width:100%; height:500px;
		background-image:url("http://localhost:9000/mybook/images/bg3.jpg");
		background-repeat: no-repeat;
		background-position:center;
		background-size: cover;
		opacity: 0.7;		
	}
	.center_box { 
		background-color:white; 
		width:1300px; 
		height:400px; 
		border:1px solid lightgray;
		display:inline-block; 
		margin-top:300px;
	 }
	 
	 .calendar { border:1px solid lightgray; display:inline-block; width:300px; height:200px; margin:20px 10px 20px 20px; float:left; }
	 .notice { border:1px solid lightgray; display:inline-block; width:620px; height:200px; margin:20px 10px; float:left; }
	 .search { border:1px solid lightgray; display:inline-block; width:300px; height:200px; margin:20px 10px; text-align:center; float:left; }
	 
	.title {
	 	font-weight:bold; 
	 	font-size:25px;
	 	margin:10px;
	 }
	 
	 .notice, .calendar { text-align:left; }
	 .notice p>a { 
	 	text-decoration:none; 
	 	color:black; 
	 	float:right;
	 	font-size:14px;
	 	font-weight:normal;
	 	margin-top:10px;
	 }
	 .notice li { margin-left:35px; }
	 .notice li>a { text-decoration:none; color:black; }
	 .notice li>a:hover { text-decoration:underline; }
	 
	 .search>div { display:inline-block; margin-top:35px; }
	 .search p:nth-child(2) { font-size:15px;	margin:0 10px; }
	 .search .form-control { width:200px; height:25px; display:inline-block; margin-top:10px; }
	 .search a { border:1px solid lightgray; height:25px; margin:0; padding:0 5px; background-color:rgb(61,76,105); color:white; }
</style>
</head>
<body>
 <jsp:include page="header.jsp"></jsp:include>

<section>	
	<div class="back_box">
		<div class="center_box">
			<div>
				<div class="calendar">
					<p class="title">달력</p>
				</div>
				<div class="notice">
					<div>
						<p class="title">공지사항<a href="notice.do">더보기+</a></p>						
						<ul>
						<c:forEach var = "vo"  items="${list}" varStatus="status"  begin="0" end="4">			
							<li><a href="notice_content.do?nid=${vo.nid }">${vo.ntitle }</a></li>
						</c:forEach>			
						</ul>
					</div>
				</div>
				<div class="search">
					<div>
						<p class="title">도서검색</p>
						<p>검색하고자 하는 도서명을 입력해주세요.</p>
						<input type="text" class="form-control">
						<a href="#" class="btn">검색</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>	

 <jsp:include page="footer.jsp"></jsp:include>
</body>
</html>