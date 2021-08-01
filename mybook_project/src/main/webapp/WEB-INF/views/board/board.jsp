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
	
	.search { margin:10px 0; text-align:right; }
	.search p { float:left; }
	.search span { color:rgb(170,93,11); }
	.form-select { 
		width:100px; height:30px;
		 display:inline-block; 
		 border-radius:10px; 
		 padding:0 10px; margin:0;
		 font-size:14px;
	}
	.form-control {
		width:200px; height:30px;
		display:inline-block; font-size:14px;
	}
	.btn_search, .btn_write { font-size:14px; padding:2px 5px; }
	.write { background-color:rgb(109,171,239); color:white; float:left; }
	
	.table tr:first-child th { background-color:rgb(248,248,248); border-top:1px solid lightgray; border-bottom:1px solid lightgray; }
	.table tr:first-child th:nth-child(2) { width:600px; }
	.table td:nth-child(2) { text-align:left; }
	.table tr { border-top:1px solid rgb(238,238,238); }
	.table td>a { text-decoration:none; color:black; }
	
	.button>div { display:inline-block; }
	.page-item { background-color:white; }
	.pagination > .active > a.page-link, .pagination > .active > a:hover {  background-color:rgb(109,171,239); border:1px solid rgb(109,171,239); }
</style>
</head>
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
		 	<div class="search">
		 		<a href="board_write.do" class="btn write btn_write">등록</a>
		 		<select class="form-select">
		 			<option>제목
		 			<option>아이디
		 		</select>
		 		<input type="text" class="form-control">
		 		<button class="btn btn-secondary btn_search">검색</button>
		 	</div>
		 	<table class="table">
		 		<tr>
		 			<th>번호</th>
		 			<th>제목</th>
		 			<th>작성자</th>
		 			<th>날짜</th>
		 			<th>조회수</th>
		 		</tr>		 
		 		<c:forEach var = "vo"  items="${list}" varStatus="status">						
			 		<tr>
			 			<td>${ (pageMaker.totalCount - status.index) - ( (pageMaker.cri.page - 1)  *  pageMaker.displayPageNum ) } </td>
			 			<td><a href="board_content.do?bid=${vo.bid}">${vo.btitle }</a></td>
			 			<td>${vo.name }**(${vo.id })</td>
			 			<td>${vo.bdate }</td>
			 			<td>${vo.bhit }</td>
			 		</tr>		 		
		 		</c:forEach>
		 	</table>
		 			 	<div class="button">
				<div>
				<nav aria-label="Page navigation example">
				<ul class="pagination pagination-sm">
		    	
				    <li class="page-item">
				        <a class="page-link" ><</a>
				    </li>
			
			    <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="pageNum">
				   <li class="page-item ${pageMaker.cri.page == pageNum? "active":"" }">
				    	<a class="page-link" href="board.do?page=${pageNum }">${pageNum }</a>
				    </li>
			    </c:forEach>
			    
				    <li class="page-item">
				        <a class="page-link">></a>
				    </li>
				    
				</ul>
				</nav>
				</div>
			</div>
		 </div>
	</div>
</section>

<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>