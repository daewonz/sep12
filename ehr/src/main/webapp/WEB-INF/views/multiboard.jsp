<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> <!--c태그는 길이를 뽑는게 없기 때문에 이걸 붙여줘야함-->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> multi board</title>
  
    <script src="./js/jquery-3.7.0.min.js"></script>
  
</head>
<body>
<h1>${sbgroupname.sbgroupname}</h1>
	<c:forEach items="${boardlist}" var="l">
		<button onclick="location.href='/multiboard?board=${l.sbgroup }'">${l.sbgroupname }</button>
	</c:forEach>

	<c:choose>
		<c:when test="${fn:length(list) gt 0}">
			<table class="table table-dark table-hover table-striped">
				<thead>
					<tr class="row">
						<th class="col-1">번호</th>
						<th class="col-6">제목</th>
						<th class="col-2">글쓴이</th>
						<th class="col-2">날짜</th>
						<th class="col-1">읽음</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list }" var="row">
						<tr class="row detail"
							onclick="location.href='./mbdetail?board=${param.board}&mbno=${row.mbno}'">
							<td class="col-1">${row.rowNum}</td>
							<td class="col-6 title">${row.mbtitle}</td>
							<td class="col-2">${row.ename}</td>
							<td class="col-2">${row.mbdate}</td>
							<td class="col-1">${row.mbread}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:when>
		<c:otherwise>
			<h1>게시판에 글이 없습니다.</h1>
		</c:otherwise>
	</c:choose>
	<c:if test="${sessionScope.eid ne null }">
		<button type="button" class="btn btn-secondary"
			onclick="location.href='./mbwrite?board=${param.board}'">글쓰기</button>
	</c:if>

</body>
</html>