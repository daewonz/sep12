<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사번 찾기</title>
<script src="./js/jquery-3.7.0.min.js"></script>
<script type="text/javascript">
$(function(){
	$(".logbtn").hide();
	$(".pwbtn").hide();
	
	$(".fbtn").click(function(){
		
		let em = $(".findID").val();
		//$("#msg").text("입력하신 이메일은 "  + em +  " 입니다.");
		
		 if(em != null){
		
		  $.ajax({
		    	url : "./findID",
		      	type : "post",
		    	data : {em : em},
		    	
		    	dataType : "json",
		    	  success : function(data){
		    		  //alert(data);    		
		    		  if(data.mid != null || data.mid !="0"){
		    			
		    			// alert("통신이 되었습니다." + data.mid);
		    			 $("#msg2").text(data.mname + " 님의 아이디는 "+data.mid +" 입니다. ");
		    			 $(".fbtn").hide();
		    			 $(".logbtn").show();
		    			$(".pwbtn").show();
		    			 
		    			 
		    			/* $("#msg2").append('<form action="./login" method="get">');
		    			 $("#msg2").attr("method", "get");
		    			 $("#msg2").attr("action", "./login");
		    			 
		    			 $("#msg2").append('<button type="submit" class="logbtn">로그인 하기</button>');
		    			 $("#msg2").append("</form>");
		    			 $("#msg2").append('<form action="./login" method="get">');
		    			 $("#msg2").append("</form>");
		    			 $("#msg2").append('<form action="./findPW" method="get">');
		    			 $("#msg2").append("<button>비밀번호 찾기</button>");
		    			 $("#msg2").append("</form>"); */
						/* 	
		    			 $(document).on("click", ".logbtn", function(){
		    				 let logbtn = $(".logbtn").
		    				 
		    			 }) */
		    			 
		    			  //$(this).parent().parent().parent().remove();
		    			  //cno_comments.remove(); //변수에 담긴 html 삭제
		    		  }else{
		    			  alert("입력하신 이메일로 회원가입 되어있는 계정이 없습니다. 다시 확인해주세요.");
		    		  }
		    	  },
		    	  error : function(error){
		    		  $("#msg2").text("일치하는 아이디가 없습니다. 다시 시도해주세요.");
		    		  
		    		  //alert("에러가 발생했습니다" + error);
		    	  }
		      });
		}else{
			alert("아이디를 입력하세요.")
		}
		
		 
	});

});


</script>
</head>
<body>
값이오네용

<div>
		<form action="./findID" method="post"></form>
		사내 이메일을 입력해주세요.
		<div class="zzz">
		이름 : <input type="text" class="findID" name="name" placeholder="이름을 입력해주세요"><br>
		이메일 앞 아이디 : <input type="text" class="findID" name="findID" placeholder="이메일 앞 아이디를 입력해주세요">

		<div>
		<button type="submit" class="fbtn">아이디 찾기</button>
			<br>
			<span id="msg"></span>
				<span id="msg2"></span>
			<br>
			<form action="./login" method="get">
				<button type="submit" class="logbtn">로그인 하기</button>
			</form>
			<form action="./findPW" method="get">
				<button type="submit" class="pwbtn">비밀번호 찾기</button>
			</form>
		</div>
		</div>
		</div>


</body>
</html>