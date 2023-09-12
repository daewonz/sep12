<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>근태 신청</title>
<script src="./js/jquery-3.7.0.min.js"></script>
<link rel="stylesheet" href="./css/attendRegister.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<style type="text/css">
.modal {
    display: none;
    position: fixed;
    top: 100px;
    left: 400px;
    width: 1600px;
    height: 800px;
    background-color: white;
    justify-content: center;
    align-items: center;
    text-align:center;
    border: 1px solid #ccc;
}
</style>
<script type="text/javascript">
$(function(){
	$(".apBtn").click(function(){
		$('#Modal').modal('show');
	});
	
	$(".btn-close").click(function() {
		$('#Modal').modal('hide');
    });
	
	$("#cbx_chkAll").click(function() {
		if($("#cbx_chkAll").is(":checked")) $("input[name=chk]").prop("checked", true);
		else $("input[name=chk]").prop("checked", false);
	});

	$("input[name=chk]").click(function() {
		var total = $("input[name=chk]").length;
		var checked = $("input[name=chk]:checked").length;

		if(total != checked) $("#cbx_chkAll").prop("checked", false);
		else $("#cbx_chkAll").prop("checked", true); 
	});
	
	$(".currentDate").val(new Date().toISOString().substring(0,10));
	
	$(".editBtn").click(function(){
		let chks = [];
		$("input[name=chk]:checked").each(function() {
			if($(this).closest('tr').find('td:eq(10)').text().indexOf("승인") > 0){
				alert("승인된 신청항목은 수정할 수 없습니다.");
				return false;
			} else if($(this).closest('tr').find('td:eq(10)').text().indexOf("취소") > 0){
				alert("취소된 신청항목은 수정할 수 없습니다.");
				return false;
			} else if($(this).closest('tr').find('td:eq(10)').text().indexOf("반려") > 0){
				alert("반려된 신청항목은 수정할 수 없습니다.");
				return false;
			} else {
		        let atregno = $(this).closest('tr').find('td:eq(1)').html();
		        chks.push(atregno);
			}
	    });
		
		if(chks.length == 0){
			alert("수정할 신청항목을 선택하세요.")
		} else if(chks.length > 1){
			alert("한가지 신청항목만 선택하세요.")
		} else {
			$.ajax({
				url: "./ateditview",
				type: "post",
				data: {"chkarr":chks},
				dataType: "json",
				success: function(data){
					$('#editModal').modal('show');
				},
				error: function(request, status, error){
					alert("error");
				}
			});
		}
	});
});
function check(){
	alert($(".td-atregcontent").html());
}
function atcancel(){
	let chks = [];
	$("input[name=chk]:checked").each(function() {
		if($(this).closest('tr').find('td:eq(10)').text().indexOf("승인") > 0){
			alert("승인된 신청항목은 취소할 수 없습니다.");
			return false;
		} else if($(this).closest('tr').find('td:eq(10)').text().indexOf("취소") > 0){
			alert("이미 취소된 신청항목입니다.");
			return false;
		} else if($(this).closest('tr').find('td:eq(10)').text().indexOf("반려") > 0){
			alert("반려된 신청항목은 취소할 수 없습니다.");
			return false;
		} else {
	        let atregno = $(this).closest('tr').find('td:eq(1)').html();
	        let atregacpt = $(this).closest('tr').find('td:eq(10)');
	       	let cancel = "취소";
	        chks.push(atregno);
		}
    });
	
	if(chks.length == 0){
		alert("취소할 신청항목을 선택하세요.")
	} else {
		if(confirm("해당 신청항목을 취소하시겠습니까?")){
			let chksData = {"chkarr":chks};
			$.ajax({
				url: "./atcancel",
				type: "post",
				data: chksData,
				dataType: "json",
				success: function(data){
					alert("취소가 완료되었습니다.");
					//atregacpt.html(cancel);
					location.href="./attendRegister";
				},
				error: function(request, status, error){
					
				}
			});
		}
	}
}

function atview(){
	let chks = [];
	$("input[name=chk]:checked").each(function() {
		let atregno = $(this).closest('tr').find('td:eq(1)').html();
	    chks.push(atregno);
    });
	
	if(chks.length == 0){
		alert("조회할 신청항목을 선택하세요.")
	} else if(chks.length > 1){
		alert("한가지 신청항목만 조회할 수 있습니다.")
	} else {
		let chksData = {"chkarr":chks};
		let egrade = "";
		let atregsts = "";
		let atregacpt = "";
		$.ajax({
			url: "./atview",
			type: "post",
			data: chksData,
			dataType: "json",
			success: function(data){
				if(data.egrade == 0){egrade = "사원";} 
				else if(data.egrade == 1){egrade = "주임";} 
				else if(data.egrade == 2){egrade = "대리";} 
				else if(data.egrade == 3){egrade = "과장";} 
				else if(data.egrade == 4){egrade = "차장";} 
				else if(data.egrade == 5){egrade = "부장";} 
				else if(data.egrade == 6){egrade = "부사장";} 
				else {egrade = "사장";}
				
				if(data.atregsts == 0){atregsts = "병가";} 
				else if(data.atregsts == 1){atregsts = "공가";} 
				else if(data.atregsts == 2){atregsts = "휴가";} 
				else if(data.atregsts == 3){atregsts = "반차";} 
				else{atregsts = "연차";}
				
				if(data.atregacpt == 0){atregacpt = "대기";} 
				else if(data.atregacpt == 1){atregacpt = "승인";} 
				else if(data.atregacpt == 2){atregacpt = "취소";} 
				else{atregacpt = "반려";}				
				
				let viewContent = '<table><tr><td>관리번호</td><td colspan="2"><input type="text" disabled value="'+data.atregno+'"></td><td>신청일자</td><td colspan="2"><input type="text" disabled value="'+data.atregdate+'"></td></tr>';
				viewContent += '<tr><td>이름</td><td><input type="text" disabled value="'+data.ename+'"></td><td>부서</td><td><input type="text" disabled value="'+data.edept+'"></td><td>직급</td><td><input type="text" disabled value="'+egrade+'"></td></tr>';
				viewContent += '<tr><td>근태일자</td><td><input type="text" disabled value="'+data.atregrestdate+'"></td><td>근태구분</td><td><input type="text" disabled value="'+atregsts+'"></td><td>신청상태</td><td><input type="text" disabled value="'+atregacpt+'"></td></tr>';
				viewContent += '<tr><td colspan="6" style="text-align:left;">신청사유</td</tr>';
				viewContent += '<tr><td colspan="6"><input type="text" disabled style="width:100%; height:100px; text-align:left;" value="'+data.atregcontent+'"></td></tr></table>';
                $(".view-body").html(viewContent);
				$('#viewModal').modal('show');
			},
			error: function(request, status, error){
				alert("error");
			}
		});
	}
}

function getAtregno(){
	$("input[name=chk]:checked").each(function() {
		let atregno = $(this).closest('tr').find('td:eq(1)').html();
		$("#edit-atregno").val(atregno);
    });
}

/*
function ateditview(){
	let chks = [];
	let today = new Date().toISOString().substring(0,10);
	$("input[name=chk]:checked").each(function() {
		if($(this).closest('tr').find('td:eq(10)').text().indexOf("승인") > 0){
			alert("승인된 신청항목은 수정할 수 없습니다.");
			return false;
		} else if($(this).closest('tr').find('td:eq(10)').text().indexOf("취소") > 0){
			alert("취소된 신청항목은 수정할 수 없습니다.");
			return false;
		} else if($(this).closest('tr').find('td:eq(10)').text().indexOf("반려") > 0){
			alert("반려된 신청항목은 수정할 수 없습니다.");
			return false;
		} else {
	        let atregno = $(this).closest('tr').find('td:eq(1)').html();
	        chks.push(atregno);
		}
    });
	
	if(chks.length == 0){
		alert("수정할 신청항목을 선택하세요.")
	} else if(chks.length > 1){
		alert("한가지 신청항목만 선택하세요.")
	} else {
		$.ajax({
			url: "./ateditview",
			type: "post",
			data: {"chkarr":chks},
			dataType: "json",
			success: function(data){
				$('#editModal').modal('show');
			},
			error: function(request, status, error){
				alert("error");
			}
		});
	}
}
*/
</script>
</head>
<body>
	<div class="atList">
	<h1>근태 신청 현황</h1>
	<table>
		<tbody>
			<tr>
				<th style="width:5%;"><input type="checkbox" id="cbx_chkAll"></th>
				<th>신청번호</th>
				<th>신청자</th>
				<th>부서</th>
				<th>직급</th>
				<th class="date">신청일자</th>
				<th class="date">근태일자</th>
				<th>근태구분</th>
				<th>신청사유</th>
				<th>승인여부</th>
			</tr>
		</tbody>
		<tbody>
		<c:forEach items="${attendList }" var="l" varStatus="status">
			<tr onclick="atDetail(${l.atregno})">
				<td><input type="checkbox" name="chk" id="chk"></td>
				<td hidden="hidden" id="atregno">${l.atregno }</td>
				<td>${l.rowNum }</td>
				<td>${l.ename }</td>
				<td>${l.edept }</td>
				<td><c:if test="${l.egrade eq 0 }">사원</c:if>
				<c:if test="${l.egrade eq 1 }">주임</c:if>
				<c:if test="${l.egrade eq 2 }">대리</c:if>
				<c:if test="${l.egrade eq 3 }">과장</c:if>
				<c:if test="${l.egrade eq 4 }">차장</c:if>
				<c:if test="${l.egrade eq 5 }">부장</c:if>
				<c:if test="${l.egrade eq 6 }">부사장</c:if>
				<c:if test="${l.egrade eq 7 }">사장</c:if></td>
				<td>${l.atregdate }</td>
				<td>${l.atregrestdate }</td>
				<td><c:if test="${l.atregsts eq 0 }">병가</c:if>
				<c:if test="${l.atregsts eq 1 }">공가</c:if>
				<c:if test="${l.atregsts eq 2 }">휴가</c:if>
				<c:if test="${l.atregsts eq 3 }">반차</c:if>
				<c:if test="${l.atregsts eq 4 }">연차</c:if></td>
				<td class="td-atregcontent">${l.atregcontent }</td>
				<td class="atregacpt"><c:if test="${l.atregacpt eq 0 }">대기</c:if>
				<c:if test="${l.atregacpt eq 1 }">승인</c:if>
				<c:if test="${l.atregacpt eq 2 }">취소</c:if>
				<c:if test="${l.atregacpt eq 3 }">반려</c:if></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="page-div">
		<c:if test="${ph.showPrev}">
            <button class="page" onclick="location.href='./attendRegister?page=${ph.startPage-1}'">이전</button>
        </c:if>
		<c:forEach var="i" begin="${ph.startPage}" end="${ph.endPage}">
			<button onclick="location.href='./attendRegister?page=${i}&pageSize=${ph.pageSize}'">${i}</button>
		</c:forEach>
		<c:if test="${ph.showNext}">
            <button class="page" onclick="location.href='./attendRegister?page=${ph.endPage+1}'">다음</button>
        </c:if>
	</div>
	<button type="button" class="viewBtn" onclick="return atview()" data-target="#viewModal">조회</button>
	<button type="button" class="editBtn" onclick="getAtregno();" data-target="#editModal">수정</button>
	<button type="button" class="delBtn" onclick="return atcancel()">신청취소</button>
	<button type="button" class="apBtn" data-toggle="modal" data-target="#Modal">근태신청</button>
	</div>
	<!-- Modal -->
	<div class="modal" id="Modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <!-- 모달 내용 -->
    <div class="modal-dialog modal-lg" style="text-align:center;">
    <form action="./atapplication" method="post" onsubmit="return check()">
        <div class="modal-content">
            <div class="header">
                <h1 class="title" id="exampleModalLabel">근태 신청</h1>
            </div>
            <div class="modal-body" style="width:1000px; text-align:center;">
            <table>
            <tr>
            	<td colspan="6" style="text-align:left;"><b>신청자 정보</b></td>
            </tr>
            <tr>
            	<td class="ename">이름</td><td><input type="text" name="ename" value="${sessionScope.ename }" disabled></td>
            	<td class="edept">부서</td><td><input type="text" name="edept" value=${sessionScope.edept } disabled></td>
            	<td class="egrade">직급</td><td><input type="text" name="egrade" id="egrade" 
            	value="<c:if test="${attendList[0].egrade eq 0}">사원</c:if><c:if test="${attendList[0].egrade eq 1}">주임</c:if>
            	<c:if test="${attendList[0].egrade eq 2}">대리</c:if><c:if test="${attendList[0].egrade eq 3}">과장</c:if>
            	<c:if test="${attendList[0].egrade eq 4}">차장</c:if><c:if test="${attendList[0].egrade eq 5}">부장</c:if>
            	<c:if test="${attendList[0].egrade eq 6}">부사장</c:if><c:if test="${attendList[0].egrade eq 7}">사장</c:if>" disabled></td>
            </tr>
            <tr>
            	<td colspan="6" style="text-align:left;"><b>신청 정보</b></td>
            </tr>
            <tr>
            	<td class="today">신청일자</td><td><input type="date" class="currentDate" disabled></td>
            	<td class="atregrestdate">근태일자</td><td><input type="date" name="atregrestdate" required="required"></td>
            	<td class="atregsts">근태구분</td><td><select name="atregsts" id="atregsts" required="required">
					<option value="0">병가</option>
					<option value="1">공가</option>
					<option value="2">휴가</option>
					<option value="3">반차</option>
					<option value="4">연차</option>
				</select></td>
            </tr>
            <tr>
            	<td class="atregcontent" colspan="6" style="text-align:left;"><b>신청사유</b></td>
            </tr>
            <tr>            
            	<td colspan="6"><input type="text" class="td-atregcontent" name="atregcontent" style="text-align:left; width:100%; height:100px;" required="required"></td>
            </tr>
            </table></div>
			<div class="modal-footer">
				<button type="submit" class="apBtn2" data-bs-dismiss="modal">신청하기</button>
				<button type="button" class="closeBtn" data-bs-dismiss="modal">닫기</button>
			</div>
        </div>
    </form>
    </div>
	</div>
	
	<!-- Modal -->
	<div class="modal" id="viewModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <!-- 모달 내용 -->
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="header">
                <h1 class="title" id="exampleModalLabel">근태 세부 내역</h1>
            </div>
            <div class="modal-body view-body"></div>
			<div class="modal-footer view-footer">
				<button type="button" class="closeBtn" data-bs-dismiss="modal">닫기</button>
			</div>
        </div>
    </div>
	</div>
	
	<!-- Modal -->
	<div class="modal" id="editModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <!-- 모달 내용 -->
    <div class="modal-dialog modal-lg">
    <form action="./atedit" method="post" onsubmit="return editCheck()">
        <div class="modal-content">
            <div class="header">
                <h1 class="title" id="exampleModalLabel">내역 수정</h1>
            </div>
            <div class="modal-body edit-body">
            	<table><tr><td>관리번호</td><td colspan="2"><input type="text" id="edit-atregno" name="atregno" value="" readonly></td><td>신청일자</td><td colspan="2"><input type="date" class="currentDate" disabled></td></tr>
				<tr><td>이름</td><td><input type="text" name="ename" value="${sessionScope.ename }" disabled></td><td>부서</td><td><input type="text" name="edept" value="${sessionScope.edept }" disabled></td><td>직급</td><td><input type="text" value="<c:if test="${attendList[0].egrade eq 0}">사원</c:if><c:if test="${attendList[0].egrade eq 1}">주임</c:if>
            	<c:if test="${attendList[0].egrade eq 2}">대리</c:if><c:if test="${attendList[0].egrade eq 3}">과장</c:if>
            	<c:if test="${attendList[0].egrade eq 4}">차장</c:if><c:if test="${attendList[0].egrade eq 5}">부장</c:if>
            	<c:if test="${attendList[0].egrade eq 6}">부사장</c:if><c:if test="${attendList[0].egrade eq 7}">사장</c:if>" disabled></td></tr>
				<tr><td>근태일자</td><td colspan="2"><input type="date" class="edit-atregrestdate" name="atregrestdate"></td><td>근태구분</td><td colspan="2"><select name="atregsts" id="edit-atregsts">
					<option value="0">병가</option>
					<option value="1">공가</option>
					<option value="2">휴가</option>
					<option value="3">반차</option>
					<option value="4">연차</option>
				</select></td></tr>
				<tr><td colspan="6" style="text-align:left;">신청사유</td></tr>
				<tr><td colspan="6"><input type="text" class="edit-atregcontent" name="atregcontent" style="width:100%; height:100px; text-align:left;" required="required"></td></tr></table>
            </div>
			<div class="modal-footer edit-footer">
				<button type="submit" class="apBtn3" data-bs-dismiss="modal">제출</button>
				<button type="button" class="closeBtn" data-bs-dismiss="modal">닫기</button>
			</div>
        </div>
    </form>
    </div>
	</div>
</body>
</html>