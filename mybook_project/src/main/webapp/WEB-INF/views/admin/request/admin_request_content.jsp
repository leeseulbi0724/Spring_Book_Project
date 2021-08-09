<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>희망도서 관리 | Admin</title>
<link rel="shortcut icon" type="image⁄x-icon" href="http://localhost:9000/mybook/images/icon.png">
<script src="http://localhost:9000/mybook/js/jquery-3.6.0.min.js" ></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" ></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" >
<script type="text/javascript" src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<style>
	.request { border-bottom:4px solid rgb(76,127,242); }
	.center { width:1319.2px; height:705px; float:left;  background-color:rgb(234,238,241); }
	.center h3 { font-weight:bold; margin:15px 20px; font-size:16px; }
	.center p { float:right; margin-top:-35px; margin-right:20px; }
	.center  p a, .center span { font-size:12px; font-weight:normal; float:left; }
	.list_box { width:1275px; height:600px; background-color:white; margin-left:20px; text-align:center; }
	div.box { display:inline-block; margin-top:30px; text-align:center; display:inline-block; width:1000px; }
	.table { margin-top:20px; font-size:14px; }
	.table tr { border-bottom:1px solid lightgray; }
	.table th { font-weight:normal; text-align:left; padding-left:15px; }
	.table th:first-child { width:100px; background-color:rgb(248,248,248); vertical-align:middle; }
	.table td>textarea { width:100%; background-color:white; border:none; height:100px; }
	input[type=text] { height:30px; display:inline-block; }
	input[type=file] { height:35px; }
	
	#search { float:right; margin:5px 3px; font-size:12px; }
	#write  { float:right; margin:10px 3px; font-size:12px; }
	#list { float:left; margin-top:10px; }
</style>
</head>
<script>
	$(document).ready(function() {		
		$("#write").click(function() {
			if ($("#bname").val() == "") {
				alert("책명을 입력해주세요");
				$("#bname").focus();
			} else if ($("#bauthor").val() == "") {
				alert("저자를 입력해주세요");
				$("#bauthor").focus();
			} else if ($("#bpublish").val() == "") {
				alert("출판사를 입력해주세요");
				$("#bpublish").focus();
			} else if ($("#bdate").val() == "") {
				alert("출간일을 입력해주세요");
				$("#bdate").focus();
			} else if ($("#bcontent").val() == "") {
				alert("설명을 입력해주세요");
				$("#bcontent").focus();
			} else if ($("#bfile").val() == "") {
				alert("이미지를 첨부해주세요");
				$("#bfile").focus();
			} else {
				admin_request.submit();
			}
		});
		
		$("#search").click(function() {
				$.ajax({
					method:"GET",
					url:"https://dapi.kakao.com/v3/search/book?target=title",
					data:{query:$("#bname").val() }, //도서명
					headers:{Authorization:"KakaoAK 18270a8d7ab06d0e6f58f0a0a1a28cc0"},				
					success : function(msg) {
						var date = msg.documents[0].datetime.split("T"); //출판일을 T를 기준으로 잘라서 앞글자만 가져옴
						$("#bdate").val(date[0]); //출판일 저장
						$("#bcontent").val(msg.documents[0].contents); //설명 저장
						//사진 입력을 위한 다운로드로 미리보기 창을 열어 직접 이미지를 다운로드 할 수 있음
						$(".img").append("<a href='"+msg.documents[0].thumbnail+"' target='_blank'>파일 다운로드</a>");						
						$("#bfile").val(msg.documents[0].thumbnail);
					}
				})
			
		});
	});
	
	
</script>
<body>
<jsp:include page="../admin_main.jsp"></jsp:include>

<section class="center">
	<h3>희망도서 목록</h3>
	<p><a>희망도서</a><span>></span><a>희망도서 목록</a><span>></span><a>희망도서 신청</a></p>
	<div class="list_box">			
		<div class="box">
		<form name="admin_request" action="admin_request_write_proc.do" method="post" enctype="multipart/form-data">
			<table class="table">
			<input type="hidden" value="${vo.rid }" name="rid">
		 		<tr>
		 			<th>책명</th>
		 			<th><input type="text" class="form-control" name="bname" id="bname" value="${vo.bname }" readonly></th>
		 		</tr>
		 		<tr>
		 			<th>저자</th>
		 			<th><input type="text" class="form-control" name="bauthor" id="bauthor" value="${vo.bauthor }"  readonly></th>
		 		</tr>
		 		<tr>
		 			<th>출판사</th>
		 			<th><input type="text" class="form-control" name="bpublish" id="bpublish" value="${vo.bpublish }"  readonly></th>
		 		</tr>			 		
		 	</table>
		 	<button type="button" class="btn btn-secondary"  id="search">검색</button>	
		 	<table class="table">
		 		<tr>
		 			<th>출간일</th>
		 			<th><input type="text" class="form-control" name="bdate" id="bdate" ></th>
		 		</tr>	 		
		 			<tr>
		 			<td colspan="2">
		 				<textarea style="resize: none;" placeholder="설명" class="form-control" name="bcontent" id="bcontent"></textarea>		 					
		 			</td>
		 		</tr>
		 		<tr>
		 			<th>이미지 다운로드</th>
		 			<th class="img"></th>		 			
		 		</tr>
		 		<tr>
		 			<th>이미지 업로드</th>
		 			<th><input type="file" class="form-control" name="file1" id="bfile"></th>		 			
		 		</tr>
		 	</table>
		 	<a class="btn btn-secondary" href="admin_request.do" role="button" id="list">목록</a>
		 	<button type="button" class="btn btn-primary"  id="write">도서 등록</button>			
		</form>
		</div>
	</div>
</section>
</body>
</html>