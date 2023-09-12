<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/join.css">
<link rel="stylesheet" href="../css/menu.css">
</head>
<body>
 <%@ include file="menu.jsp" %>
<h1>${list.ename }님 정보 페이지</h1><br>
	<div class="nav_container">
		<div class="content_join" id="div_content">
			<div class="board_head"></div>
			<h3 class="form_title">
				내정보수정<span class="title_tip"></span>
			</h3>
			<form action="./join" method="post" enctype="multipart/form-data">
				<div class="form topline">
					<table>
						<tr>
							<td><img src="./upload/${list.eimg}" width="100px" height="100px"></td>
						</tr>
						<tr>
							<th class="id">이름</th>
							<td>${list.ename}</td>
							<th class="id">생년월일</th>
							<td>${ebirth}</td>
							<th class="id">나이</th>
							<td>30</td>
						</tr>
						<tr>
							<th class="id">사번</th>
							<td>${list.eid}</td>
							<th class="id">재직상태</th>
							<td>재직</td>
							<th class="id">입사구분</th>
							<td>정규직</td>
						</tr>
						<tr>
							<th class="id">입사일</th>
							<td>${ehiredate}</td>
							<th class="id">근속년월</th>
							<td>${ehiredate}</td>
							<th class="id">퇴사일</th>
							<td>${ehiredate}</td>
						</tr>
						<tr>
							<th class="id">근무부서</th>
							<td colspan="3">${list.edept}</td>
							<th class="id">직무</th>
							<td>${list.edept}</td>
						</tr>
						<tr>
							<th class="id">주소</th>
							<td colspan="3">${list.eaddr}</td>
							<th class="id">전화번호</th>
							<td>${list.ephoneno}</td>
						</tr>
					</table>
				</div>
				<div class="form_button">
					<button type="button" onclick="location.href='./main'">메인으로</button>
					<button type="button" onclick="location.href='./mypageupdate'">정보수정</button>
				</div>
			</form>
		</div>
	</div>

</body>
</html>