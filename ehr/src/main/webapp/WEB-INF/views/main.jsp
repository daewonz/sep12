<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="css/main.css" rel="stylesheet" />
 <script src="./js/jquery-3.7.0.min.js"></script>
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" href="../css/admin.css">
<link rel="stylesheet" href="../css/main.css">

</head>
<body>
<%@ include file="menu.jsp" %>
<div class="layout">
    <article>
	<h1>메인페이지</h1>
	
  <div class="flexbox">
    <div class="item">
    <br><br>
    <img src="./upload/${list.eimg}" width="100px" height="100px"><br>
    <div class="nameset1">${sessionScope.ename }님<br></div>
    <br>
    <div class="myinfo"> 내정보 | 비밀번호변경 </div>
    </div>
    <div class="item">
    <div class="nameset5">공지사항<br></div>
    <img src="./img/notice.png" class="noticeimg">
	    <ul>
	    	<li>공지1</li>
	    	<li>공지1</li>
	    	<li>공지1</li>
	    	<li>공지1</li>
	    	<li>공지1</li>
	    	<li>공지1</li>
	    </ul>
    </div>
    <div class="item">급여지급현황<br>
    	2023.08급여<br>
    	2023.07급여<br>
    	2023.06급여<br>
    	2023.05급여<br>
    </div>
    <div class="item">
     <div class="nameset1">신규입사자<br></div>
    <div class="slideshow-container">

<div class="mySlides fade">
  <div class="numbertext">1 / 2</div>
  <img class="pic" src="./upload/${newM[0].eimg }" style= width:100px" height="100px">
   <br><br><br>
    <div class="nameset2"> ${newM[0].edept }<br></div>
    <div class="nameset3"> ${newM[0].ename }<br></div>
    <div class="nameset4">${newM[0].ehiredate } 입사</div>
</div>

<div class="mySlides fade">
  <div class="numbertext">2 / 2</div>
  <img class="pic" src="./upload/noimg2.png" style="width:100px" height="100px">
  <br><br><br> 
    <div class="nameset2"> ${newM[1].edept }<br></div>
    <div class="nameset3"> ${newM[1].ename }<br></div>
    <div class="nameset4">${newM[1].ehiredate } 입사</div>
</div>


<a class="prev" onclick="plusSlides(-1)">&#10094;</a>
<a class="next" onclick="plusSlides(1)">&#10095;</a>

</div>

    <br><br>
    </div>
  </div>
</article>


</div>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;

<button onclick="location.href='./mypage'">내정보</button>
<button onclick="location.href='./join'">사원등록</button>
<button onclick="location.href='./multiboard'">멀티보드로</button>



<script type="text/javascript">
var slideIndex = 1;
showSlides(slideIndex);

function plusSlides(n) {
  showSlides(slideIndex += n);
}

function currentSlide(n) {
  showSlides(slideIndex = n);
}
function showSlides(n) {
	  var i;
	  var slides = document.getElementsByClassName("mySlides");
	  var dots = document.getElementsByClassName("dot");
	  if (n > slides.length) {slideIndex = 1}    
	  if (n < 1) {slideIndex = slides.length}
	  for (i = 0; i < slides.length; i++) {
	      slides[i].style.display = "none";  
	  }
	  for (i = 0; i < dots.length; i++) {
	      dots[i].className = dots[i].className.replace(" active", "");
	  }
	  slides[slideIndex-1].style.display = "block";  
	  dots[slideIndex-1].className += " active";
	}
</script>

</body>
</html>