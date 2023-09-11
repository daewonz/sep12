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
	$(".findPW").hide();
	$(".findID").hide();
	
	
	$(".loginBtn").click(function(){
		$(".findPW").hide();
		$(".findID").hide();
		let id = $(".signin_id").val();
		let pw = $(".signin_pw").val();

		
		$(".pwInfo").text("");
		$(".idInfo").text("");
		if($(".signin_id")==null||$(".signin_id").val().length != 5){
			alert("사번은 5자리여야 합니다.");
			$(".signin_id").val("");
			$(".idInfo").css("color","red");
			$(".idInfo").text("올바른 사번을 입력해주세요");			
			$(".signin_id").focus();
			return false;
		}
		if( $(".signin_pw").length == null ||$(".signin_pw").val().length < 5){
			alert("비밀번호은 5자리 이상입니다.");
			$(".signin_pw").val("");
			$(".pwInfo").css("color","red");
			$(".pwInfo").text("올바른 비밀번호를 입력해주세요");			
			$(".signin_pw").focus();
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
		            $(".idInfo").text("비밀번호를 5회 초과하여 잘못 입력했습니다. 관리팀(0000-0000)에 문의하세요.");
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
		            $(".idInfo").text("사번을 다시 확인해주세요.");            
		            $(".id").focus();
		            $(".pwInfo").text("사번을 잊으셨나요?");
		            $(".findID").show();
		        }
		        
		        
		        if(data.result == 0){
		            alert("비밀번호를 잘못 입력하셨습니다.");
		            $(".idInfo").css("color","red");
		            $(".idInfo").text("비밀번호를 "+ecount+"/5 회 잘못 입력했습니다. 5회를 초과하면 계정이 잠깁니다.");            
		            $(".id").focus();
		            $(".pwInfo").text("비밀번호를 잊으셨나요?");
		            $(".findPW").show();
		            if(ecount > 5){
		                $(".idInfo").css("color","red");
		                $(".idInfo").text("비밀번호를 5회 초과하여 잘못 입력했습니다. 관리팀(0000-0000)에 문의하세요.");    
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
<link rel="stylesheet" href="../css/login.css">
</head>
<body>
<body>

   <div class="nav_container">
      <div class="content_signin">
         <div class="signin_selection_group">
            <div class="login_form">
               <div class="signin_swiper" id="otp">
                  <div class="signin-section">
                     <div>
                        <h2 class="signin_title">게시판 로그인</h2>
                        <div class="signin-section">
                           <input type="text" class="signin_id" name="eid" placeholder="아이디">
                           <span class="idInfo"></span><br>
                           <input type="password" class="signin_pw" name="epw" placeholder="비밀번호">
                          <span class="pwInfo"></span><a class="findID" href="./findID">사번 찾기</a><a class="findPW" href="./findPW">비밀번호 찾기</a><br>
                          <br><br><br><br><br><br>
                          <button class="loginBtn" type="button">로그인</button>
                           <span id="msg"></span>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>

</body>
</html>
