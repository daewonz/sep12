<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" ></script>
<script type="text/javascript">

$(function(){
	$("#eidCheck").click(function(){
		let eid = $("#eid").val();
		
		$.ajax({
			url:"./eidcheck",
			type:"post",
			data:{"eid":eid},
			dataType:"json",
			success:function(data){
				if(data.result==1){
					alert("중복된 사번");
				}else{
					alert("사용할 수 있는 사번");
				}
			},
			error:function(request, status, error){
				$("eidCheck").text("오류가 발생함")
			}
		});
	});
	

	$("#eemailCheck").click(function() {
			let eemail = $("#eemail").val();
			$.ajax({
				url : "./eemailcheck",
				type : "post",
				data : {
					"eemail" : eemail
				},
				dataType : "json",
				success : function(data) {
					if (data.result == 1) {
						alert("중복된 이메일");
					} else {
						alert("사용할 수 있는 이메일");
					}
				},
				error : function(request, status, error) {
					$("eidCheck").text("오류가 발생함")
				}
			});
		});
	
	$(".button_join").click(function() {
		let eid = $("#eid").val();
		let epw = $("#epw").val();
		let ename = $("#ename").val();
		let ephoneno = $("#ephoneno").val();
		let errn = $("#errn").val();
		let eemail = $("#eemail").val();
		let ehiredate = $("#ehiredate").val();
		let eaddr = $("#eaddr").val();
		let ebirth = $("#ebirth").val();
		let eaccount = $("#eaccount").val();

		let num_reg = /[^0-9]/g; //eid, epw, ephoneno, errn, eaccount
		let ename_reg =  /[^ㄱ-ㅎ|ㅏ-ㅣ|가-힣|a-zA-Z]/; //한글 영어만
		
		// test()는 인수로 전달된 문자열에 특정 패턴과 일치하는 문자열이 있는지를 검색합니다
       // test()는 패턴과 일치하는 문자열이 있으면 true를, 없으면 false를 반환합니다
		
       if (eid == "" || eid.length < 2) {
			$("#mphone").focus();
			$("#mphoneMsg").text("번호를 입력해주세요");
			$("#mphoneMsg").css("color", "red");
			return false;
		}
		
		if (mname == "" || mname.length < 2) {
			$("#mname").focus();
			$("#mnameMsg").text("이름은 2글자 이상 한글/영어만");
			$("#mnameMsg").css("color", "red");
			return false;
		} else{
			$("#mnameMsg").empty();
		}
		
		if (mname_reg.test(mname)) {
			$("#mname").focus();
			$("#mnameMsg").text("영어/한글만 입력해주세요.");
			$("#mnameMsg").css("color", "red");
			return false;
		} 

		if (mpw == "" || mpw.length != 5) {
			$("#mpw").focus();
			$("#mpwMsg").text("비밀번호는 5자리 입니다.");
			$("#mpwMsg").css("color", "red");
			return false;
		} else{
			$("#mpwMsg").empty();
		}
		
		if (mpw_reg.test(mpw)) {
			$("#mpw").focus();
			$("#mpwMsg").text("숫자만 입력해주세요.");
			$("#mpwMsg").css("color", "red");
			return false;

		}
		
		if (mpw2 == "" || mpw2.length != 5) {
			$("#mpw2").focus();
			$("#mpwMsg2").text("비밀번호는 5자리입니다.");
			$("#mpwMsg2").css("color", "red");
			return false;
		}  else{
			$("#mpwMsg").empty();
		}

		if (mpw_reg.test(mpw2)) {
			$("#mpw2").focus();
			$("#mpwMsg2").text("숫자만 입력해주세요.");
			$("#mpwMsg2").css("color", "red");
			return false;

		} 

	})

});
</script>
</head>
<body>
<%@ include file="menu.jsp" %>
<h1>관리자 - 회원등록페이지</h1>
<form action="./join" method="post" enctype="multipart/form-data">
사진<input type="file" name="eimg"><br>
사원번호<input type="text" name="eid" id="eid" placeholder="사원번호">
<button type="button" id="eidCheck">중복체크</button><br>
비밀번호<input type="password" name="epw" id="epw" placeholder="비밀번호"><br>
이름<input type="text" name="ename" id="ename" placeholder="이름"><br>
주민등록번호<input type="text" name="errn" id="errn" placeholder="주민등록번호">-<input type="password" name="errn2" placeholder="주민등록번호"><br>
이메일<input type="text" name="eemail" id="eemail" placeholder="이메일" value="@ehr.net">
<button type="button" id="eemailCheck">중복체크</button><br>
자격증<input type="text" name="ecertificate" placeholder="자격증" value="없음"><br>
부서<select name="edept">
	<option value="경영관리실">경영관리실</option>
	<option value="솔루션개발팀">솔루션개발팀</option>
	<option value="ICT사업팀">ICT사업팀</option>
	<option value="헬스케어개발팀">헬스케어개발팀</option>
	<option value="디자인UI-UX팀">디자인UI-UX팀</option>
	<option value="마케팅팀">마케팅팀</option>
</select><br>
직급<select name="egrade">
	<option value="0">사원</option>
	<option value="1">주임</option>
	<option value="2">대리</option>
	<option value="3">과장</option>
	<option value="4">차장</option>
	<option value="5">부장</option>
	<option value="6">부사장</option>
	<option value="7">사장</option>
	<option value="8">관리자</option>
</select><br>
입사일<input type="date" name="ehiredate"id="ehiredate"  placeholder="입사일" ><br>
주소<input type="text" name="eaddr" id="addr" placeholder="주소" ><br>
생일<input type="date" name="ebirth" id="ebirth" placeholder="생일"><br>
성별<select name="egender">
	<option value="man">남자</option>
	<option value="woman">여자</option>
</select><br>
핸드폰번호<input type="text" name="ephoneno" id="ephoneno" placeholder="핸드폰번호"><br>
은행이름<select name="ebank">
	<option value="국민은행">국민은행</option>
	<option value="신한은행">신한은행</option>
	<option value="신한은행">농협</option>
	<option value="카카오뱅크">카카오뱅크</option>
	<option value="토스뱅크">토스뱅크</option>
</select><br>
계좌번호<input type="text" name="eaccount" id="eaccount" placeholder="계좌번호"><br>
<button type="submit" class="button_join">회원등록</button>
</form>

</body>
</html>