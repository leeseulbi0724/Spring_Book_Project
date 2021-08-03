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
<title>방 개설 | 라온 도서관</title>
<style>	
	#contents { text-align:center; }
	#contents>p {
		font-weight:bold;
		font-size:20px;	
		margin-top:20px;
	}
	.form-control {
		display:inline-block; width:300px; 
		height:30px; font-size:14px;
	}
	.write {
		margin-top:20px; padding:3px10px;
		background-color:rgb(109,171,239); color:white;
		border:1px solid lightgray; border-radius:4px;
	}
</style>
</head>
<script>
	$(document).ready(function() {
		$(".write").click(function() {
			if($("#name").val() == "") {
				alert("채팅방 이름을 입력해주세요");
				$("#name").focus();
			} else {
				var name = $("#name").val();
				 $.ajax({
		                type: "post",
		                url: "online_write_proc.do",
		                data: {name:name},
		                dataType: 'json',
		                success: function (result) {
		                	alert("온라인 토론방이 개설되었습니다");
		                	 location.replace("online_content.do?name="+name);
		                },

		            });
			}
		});
	});
</script>
<body>
<div id="contents">
	<input type="hidden" id="bname">
	<input type="hidden" id="bauthors">
	<input type="hidden" id="bpublisher">
	<p>온라인 토론방 개설</p>
	<input class="form-control" placeholder="사용하실 채팅방 이름을 입력해주세요" id="name" autocomplete="off">
	<button class="write">개설</button>
</div>
  
</body>
</html>