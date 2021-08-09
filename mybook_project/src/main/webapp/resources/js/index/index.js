	$(document).ready(function() {
		$(".search_btn").click(function() {
			if ($("#search").val() == "") {
				alert("도서명을 입력해주세요");
				$("#search").focus();
			} else {
				$.ajax({
					method:"GET",
					url:"https://dapi.kakao.com/v3/search/book?target=title",
					data:{query:$("#search").val() },
					headers:{Authorization:"KakaoAK 18270a8d7ab06d0e6f58f0a0a1a28cc0"},				
					success : function(msg) {
						window.open(msg.documents[0].url);
					}
				})
			}
		});
		
		
	});