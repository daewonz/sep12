<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> 글쓰기</title>
<script src="./js/jquery-3.7.0.min.js"></script>

</head>
<body>

	글번호 : ${detail.mbno }<br>
	제목 : ${detail.mbtitle }<br>
	이름 : ${detail.ename }<br>
	날짜 : ${detail.mbdate }<br>
	내용 : ${detail.mbcontent }<br>
	<button onclick="location.href='./multiboard?board=${param.board}'">멀티보드로</button>
	
</body>
</html>