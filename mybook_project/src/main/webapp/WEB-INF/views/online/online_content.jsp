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
<title>온라인 토론 | 라온 도서관</title>
<style>	
	#contents { text-align:center; }
	#contents>p {
		font-weight:bold;
		font-size:20px;	
		margin-top:20px;
	}		
	.chat { 
		background-color:rgb(109,171,239); 
		border:1px solid lightgray; 
		width:100%; height:450px; 
		overflow:auto;
		overflow-x:hidden;
	}
	.chat>div { text-align:left; }
	.chat>div>div { 
		background-color:white; 
		text-align:left; 
		border:1px solid lightgray; 
		display:inline-block; 
		border-radius:15px; 
		margin:5px 10px; 
	}
	.chat>div>div>p { padding:5px 5px 0 5px; font-size:13px; }
	p>span { color:gray; font-size:13px; }
	
	.text { width:100%; height:80px; margin-top:10px; }
	.form-control {
		display:inline-block; width:400px; 
		height:50px; font-size:14px;
	}
	.send {
		margin-top:20px; padding:3px10px;
		background-color:rgb(109,171,239); color:white;
		border:1px solid lightgray; border-radius:4px;
	}
</style>
</head>
<body>
<div id="contents">
	<input type="hidden" id="bname">
	<input type="hidden" id="bauthors">
	<input type="hidden" id="bpublisher">
	<p>${name }</p>
	<div class="chat">
		<div>
			<div>
				<p><strong>tmfql4428 : </strong>안녕하세요~<span>오후 5:54</span></p>
			</div>
		</div>
		<div>
			<div>
				<p><strong>tmfql4428 : </strong>안녕하세요~<span>오후 5:54</span></p>
			</div>
		</div>
		<div>
			<div>
				<p><strong>tmfql4428 : </strong>안녕하세요~<span>오후 5:54</span></p>
			</div>
		</div>
	</div>
	<div class="text">
		<input type="text" class="form-control">
		<button class="send">전송</button>
	</div>
</div>
  
</body>
</html>