<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
</head>
<body>
<form action="./mbwrite" method="post" id="form">
제목<input type="text" id="mbtitle" name="mbtitle"><br>
내용<textarea name="mbcontent"></textarea><br>
<input type="hidden" name="mbboard" value="${board }">
<button type="submit">저장</button>
</form>

</body>
</html>