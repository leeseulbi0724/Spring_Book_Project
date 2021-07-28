<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 관리 | Admin</title>
<script src="http://localhost:9000/mybook/js/jquery-3.6.0.min.js" ></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" ></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" >
<style>
	.board { border-bottom:4px solid rgb(76,127,242); }
	.center { width:1319.2px; height:705px; float:left;  background-color:rgb(234,238,241); }
	.center h3 { font-weight:bold; margin:15px 20px; font-size:16px; }
	.center p { float:right; margin-top:-35px; margin-right:20px; }
	.center  a, .center span { font-size:12px; font-weight:normal; float:left; }
	.list_box { width:1275px; height:500px; background-color:white; margin-left:20px; }
	
	.search { float:right; margin:10px; }
	#s_select { width:100px; display:inline-block; font-size:12px; border-radius:15px; }
	#search {
		background-image : url('http://localhost:9000/homeproject/images/search.png'); 
  		background-repeat:no-repeat;
  		background-size: 20px;
  		background-position:right;
  		width:200px; display:inline-block; font-size:12px; border-radius:15px;
	}
	
	.table { text-align:center; font-size:14px; }	
	#request { margin:0; padding:0; font-size:13px; padding:0 10px; }
	.button { text-align:center; }
	nav { display:inline-block; }
</style>
</head>
<body>
<jsp:include page="../admin_main.jsp"></jsp:include>

<section class="center">
	<h3>게시판 목록</h3>
	<p><a>게시판</a><span>></span><a>게시판 목록</a></p>
	<div class="list_box">
		<div class="search">
			<select class="form-select" id="s_select" >
				<option>아이디
				<option>이름
			</select>
			<input type="text" class="form-control" id="search">
		</div>
		<div class="container">	
		<table class="table table-striped">
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>아이디</th>
					<th>날짜</th>
					<th>공감수</th>
					<th>신고수</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>1</td>
					<td>요청합니다</td>
					<td>tmfql4428</td>
					<td>2021-07-10</td>
					<td>10</td>			
					<td>0</td>			
					<td><button type="button" class="btn btn-secondary"  id="request" >내용보기</button></td>				
				</tr>
			</tbody>
		</table>
		<div class="button">
		<nav aria-label="Page navigation example">
		  <ul class="pagination">
		    <li class="page-item">
		      <a class="page-link" href="#" aria-label="Previous">
		        <span aria-hidden="true">&laquo;</span>
		      </a>
		    </li>
		    <li class="page-item"><a class="page-link" href="#">1</a></li>
		    <li class="page-item"><a class="page-link" href="#">2</a></li>
		    <li class="page-item"><a class="page-link" href="#">3</a></li>
		    <li class="page-item">
		      <a class="page-link" href="#" aria-label="Next">
		        <span aria-hidden="true">&raquo;</span>
		      </a>
		    </li>
		  </ul>
		</nav>
		</div>
		</div>
	</div>
</section>
</body>
</html>