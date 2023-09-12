<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>${list.ename }님 정보 페이지</h1><br>
	<div class="nav_container">
		<div class="content_join" id="div_content">
			<div class="board_head"></div>
			<h3 class="form_title">
				내정보수정<span class="title_tip"></span>
			</h3>
			<form action="./mypageupdate" method="post" enctype="multipart/form-data">
				<div class="form topline">
				<img src="./upload/${list.eimg}" width="100px" height="100px"> <br>
				사진<input type="file" name="eimg"><br>
					<table>
						<tr>
							<th class="id">이름</th>
							<td><input type="text" value="${list.ename}" disabled="disabled"></td>
							<th class="id">생년월일</th>
							<td><input type="text" value="${list.ebirth}" disabled="disabled"></td>
							<th class="id">나이</th>
							<td><input type="text" value="28" disabled="disabled"></td>
						</tr>
						<tr>
							<th class="id">사번</th>
							<td><input type="text" value="${list.eid}" disabled="disabled"></td>
							<th class="id">재직상태</th>
							<td><input type="text" value="${list.eid}" disabled="disabled"></td>
							<th class="id">입사구분</th>
							<td><input type="text" value="${list.eid}" disabled="disabled"></td>
						</tr>
						<tr>
							<th class="id">입사일</th>
							<td><input type="text" value="${list.ehiredate}" disabled="disabled"></td>
							<th class="id">근속년월</th>
							<td><input type="text" value="" disabled="disabled"></td>

						</tr>
						<tr>
							<th class="id">근무부서</th>
							<td colspan="3"><input type="text" value="${list.edept}" disabled="disabled"></td>
							<th class="id">직무</th>
							<td><input type="text" value="${list.edept}" disabled="disabled"></td>
						</tr>
						<tr>
							<th class="id">주소</th>
							<td><input type="text" value="${list.eaddr}" id="eaddr" name="eaddr"></td>
							
							
							<th class="id">전화번호</th>
							<td><input type="text" value="${list.ephoneno}" name="ephoneno"></td>
						</tr>
						<tr>
						<th class="id">상세주소</th>
						<td ><input type="text" value="" id="eaddr_detail" name="eaddr_detail"></td>
						</tr>
					</table>
				</div>
				<div class="form_button">
					<button type="button" onclick="location.href='./main'">메인으로</button>
					<button type="submit" onclick="location.href='./mypageupdate'">정보수정</button>
				</div>
			</form>
		</div>
	</div>

</body>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
window.onload = function(){
    document.getElementById("eaddr").addEventListener("click", function(){ //주소입력칸을 클릭하면
        //카카오 지도 발생
        new daum.Postcode({
            oncomplete: function(data) { //선택시 입력값 세팅
                document.getElementById("eaddr").value = data.address; // 주소 넣기
                document.querySelector("input[name=eaddr_detail]").focus(); //상세입력 포커싱
            }
        }).open();
    });
}
</script>
</html>