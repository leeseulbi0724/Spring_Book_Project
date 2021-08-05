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
<title>공지사항 | 라온 도서관</title>
<style>	
	.com { color:rgb(43,129,199); border-bottom:5px solid rgb(43,129,199); }
	.home, .book {	color:rgb(162,162,162); }
	
	.left ul li:first-child a { color:rgb(43,129,199); font-weight:bold; }
	
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
	.btn_search { font-size:14px; padding:2px 5px; }
	
	.table tr:first-child th { background-color:rgb(248,248,248); border-top:1px solid lightgray; border-bottom:1px solid lightgray; }
	.table tr:first-child th:nth-child(2) { width:700px; }
	.table td:nth-child(2) { text-align:left; }
	.table tbody>tr { border-top:1px solid rgb(238,238,238); }
	.table td>a { color:black; text-decoration:none; }
	.table td>a:hover { color:rgb(10,88,202); }
	
	.table button {
		background-color:rgb(109,171,239);
		border:none;
		font-size:13px;
		border-radius:5px;
		color:white;
		cursor:default;
	}
	
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
		 	<div class="search">
		 		<p>총 <span>${total }</span>건</p>
		 		<form action="notice.do" method="get">
			 		<select class="form-select">
			 			<option>제목
			 		</select>
			 		<input type="text" class="form-control" id="search_input"  name="search">
			 		<button class="btn btn-secondary btn_search" type="submit">검색</button>
		 		</form>
		 	</div>
		 	<table class="table">
		 		<tr class="title_tr">
		 			<th>번호</th>
		 			<th>제목</th>
		 			<th>날짜</th>
		 			<th>조회수</th>
		 		</tr>
		 		<c:if test="${count eq 'all' }">
		 		<tbody>
		 		<c:forEach var = "vo"  items="${spcl_list}" varStatus="status">				
					<tr>
			 			<td><button>공지</button></td>
			 			<td><a href="notice_content.do?nid=${vo.nid}&rno=${vo.rno}&type=spcl">${vo.ntitle }</a></td>
			 			<td>${vo.ndate }</td>
			 			<td>${vo.ncount }</td>
			 		</tr>	
				</c:forEach>					 	
		 		</tbody>	
		 		<tbody>
			 		<c:forEach var = "vo"  items="${normal_list}" varStatus="status">				
						<tr>
				 			<td>${ (pageMaker.totalCount - status.index) - ( (pageMaker.cri.page - 1)  *  pageMaker.displayPageNum ) } </td>
				 			<td><a href="notice_content.do?nid=${vo.nid}&rno=${ (pageMaker.totalCount - status.index) - ( (pageMaker.cri.page - 1)  *  pageMaker.displayPageNum ) }&type=normal">${vo.ntitle }</a></td>
				 			<td>${vo.ndate }</td>
				 			<td>${vo.ncount }</td>
				 		</tr>	
					</c:forEach>		
		 		</tbody>
		 	</c:if>
		 	<c:if test="${count eq 'search' }">
		 		<c:forEach var = "vo"  items="${list}" varStatus="status">				
						<tr>
							<c:if test="${vo.ncategory eq 'spcl' }">
								<td><button>공지</button></td>
							</c:if>
							<c:if test="${vo.ncategory eq 'normal' }">
				 				<td>${vo.rno }</td>
				 			</c:if>
				 			<td><a href="notice_content.do?nid=${vo.nid}&rno=${vo.rno}&type=${vo.ncategory}">${vo.ntitle }</a></td>
				 			<td>${vo.ndate }</td>
				 			<td>${vo.ncount }</td>
				 		</tr>	
				</c:forEach>
		 	</c:if>	
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
				    	<a class="page-link" href="notice.do?page=${pageNum }">${pageNum }</a>
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