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
<img src="./upload/${list.eimg}"> <br>
사원번호 : ${list.eid} <br>
나이 : ${list.eage }<br>
생일 : ${ebirth} <br>
직급 : ${egrade} <br>
이메일 : ${list.eemail} <br>
부서 : ${list.edept} <br>
핸드폰번호 : ${list.ephoneno} <br>
입사일 : ${ehiredate} <br>
주소 : ${list.eaddr } <br>
<button onclick="location.href='./main'">메인으로</button>
</body>
</html>