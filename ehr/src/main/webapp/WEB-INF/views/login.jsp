<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" href="../css/admin.css">
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
$(function(){
	$(".loginBtn").click(function(){
		let id = $(".id").val();
		let pw = $(".pw").val();

		
		$(".pwInfo").text("");
		$(".idInfo").text("");
		if($(".id")==null||$(".id").val().length != 5){
			alert("사번은 5자리여야 합니다.");
			$(".idInfo").css("color","red");
			$(".idInfo").text("올바른 사번을 입력해주세요");			
			$(".id").focus();
			return false;
		}
		if( $(".pw").length == null ||$(".pw").val().length < 5){
			alert("비밀번호은 5자리 이상입니다.");
			$(".pwInfo").css("color","red");
			$(".pwInfo").text("올바른 비밀번호를 입력해주세요");			
			$(".pw").focus();
			return false;
		}
				
			//ajax
		$.ajax({
		    url: "./loginCheck",
		    type: "post",
		    data: {"id": id, "pw": pw},
		    dataType: "json",
		    success: function(data){
		    	let ecount = data.ecount +1;
		    	
		    	if(data.result == 1 && data.ecount > 5){
		            $(".idInfo").css("color","red");
		            $(".idInfo").text("비밀번호를 5회 초과하여 잘못 입력했습니다. 관리자에게 문의하세요.");
		            $(".id").focus();
		            $(".loginBtn").hide();
		            return false;
		        }
		    	
		    	
		    	if(data.result == 1 && data.ecount < 5){
		    		let form = $('<form></form>')
					form.attr("action", "./main");
					form.attr("method", "get");
					
					
					form.appendTo("body");
					
					form.submit();
		        }
		    	
		    	
		        if(data.IDresult == 0){
		            alert("일치하는 아이디가 없습니다.");
		            $(".idInfo").css("color","red");
		            $(".idInfo").text("아이디를 다시 확인해주세요.");            
		            $(".id").focus();
		        }
		        
		        
		        if(data.result == 0){
		            alert("비밀번호를 잘못 입력하셨습니다.");
		            $(".idInfo").css("color","red");
		            $(".idInfo").text("비밀번호를 "+ecount+"/5 회 잘못 입력했습니다. 5회 이상 초과하면 계정이 잠깁니다.");            
		            $(".id").focus();
		            if(ecount > 5){
		                $(".idInfo").css("color","red");
		                $(".idInfo").text("비밀번호를 5회 초과하여 잘못 입력했습니다. 관리자에게 문의하세요.");    
		                $(".loginBtn").hide();
		            }
		        }

		    },
		    error : function(error){
		        alert("ㅠㅠ" + error);
		        
		    }
		});
				
			
	});
});

</script>

</head>
<body>

<h1>로그인</h1>

아이디<input type="text" class="id" name="eid" placeholder="아이디"><br>
<span class="idInfo"></span><br>
비밀번호<input type="password" class="pw" name="epw" placeholder="비밀번호"><br>
<span class="pwInfo"></span><br>
<button class="loginBtn" type="button">전송</button>

</body>
</html>