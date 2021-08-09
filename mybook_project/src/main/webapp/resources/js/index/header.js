$(document).ready(function() {
		$(".drop_book, .m_book").hover( function() {
			$(".drop_book").css("background-color","rgb(43,129,199)");
			$(".drop_book a").css("color","white");
			$(".drop_com").css("background-color","rgb(222,225,230)");
			$(".drop_com a").css("color","black");
		});
		
		$(".drop_com, .m_com").hover( function() {
			$(".drop_com").css("background-color","rgb(43,129,199)");
			$(".drop_com a").css("color","white");
			$(".drop_book").css("background-color","rgb(222,225,230)");
			$(".drop_book a").css("color","black");
		});
		
		$("#ok").click(function() {
			$(".modal-body").text("로그아웃 되셨습니다");
			$(".modal-footer").children().remove();
		});
		
		$(".bell").click(function() {			
			 $.ajax({
	                type: "post",
	                url: "bell_update.do",
	                dataType: 'json',
	                success: function (result) {
	                	$(".bell_div").css("display","block");
	        			$(".bell_box").css("display","inline-block");
	                },

	           });
		});
		
		$(".x").click(function() {
			$(".bell_div").css("display","none");
			$(".bell_box").css("display","none");
		});
	});