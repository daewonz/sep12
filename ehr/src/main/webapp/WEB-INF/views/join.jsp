<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/join.css">
<script src="https://code.jquery.com/jquery-3.7.0.min.js" ></script>
<script type="text/javascript">

$(function(){
   $("#eidCheck").click(function(){
      let eid = $("#eid").val();
      let eid_reg = /[^0-9]/g; //숫자만
      
      if (eid == "" || eid.length != 5) {
         $("#eid").focus();
         $("#eidMsg").text("사원번호는 5자리 입니다.");
         $("#eidMsg").css("color", "red");
         return false;
      }
      
      if (eid_reg.test(eid)) {
         $("#eid").focus();
         $("#eidMsg").text("영어, 한글, 특수문자는 사용할 수 없습니다.");
         $("#eidMsg").css("color","red");
         return false;
      }
      
      $.ajax({
         url:"./eidcheck",
         type:"post",
         data:{"eid":eid},
         dataType:"json",
         success:function(data){
            if(data.result==1){
               $("#eidMsg").text("중복된 사번입니다.");
               $('#eid').css("border","1px solid red");
               $('.button_join').attr('disabled', true);
               $('#eemailCheck').attr('disabled', true);
            }else{
               $("#eidMsg").text("사용할 수 있는 사번입니다.");
               $('#eid').css("border","1px solid #666666");
               $('#eemailCheck').attr('disabled', false);
            }
         },
         error:function(request, status, error){
            $("eidMsg").text("오류가 발생함")
         }
      });
   });
   

   $("#eemailCheck").click(function() {
         let eemail = $("#eemail").val();
         let engNum_reg = /^[a-zA-Z0-9]*$/;
         
         if (eemail == "") {
            $("#eemail").focus();
            $("#eemailMsg").text("이메일을 입력해주세요.");
            $("#eemailMsg").css("color", "red");
            return false;
         }
         
         if (!engNum_reg.test(eemail)) {
            $("#eemail").focus();
            $("#eemailMsg").text("영어, 숫자만 사용할 수 있습니다.");
            $("#eemailMsg").css("color","red");
            return false;
         }
         $.ajax({
            url : "./eemailcheck",
            type : "post",
            data : {
               "eemail" : eemail
            },
            dataType : "json",
            success : function(data) {
               if (data.result == 1) {
                  $("#eemailMsg").text("중복된 이메일입니다.");
                  $('#eemail').css("border","1px solid red");
               } else {
                  $("#eemailMsg").text("사용할 수 있는 이메일입니다.");
                  $('.button_join').attr('disabled', false);
                  $('#eemail').css("border","1px solid #666666");
               }
            },
            error : function(request, status, error) {
               $("eidCheck").text("오류가 발생함")
            }
         });
      });
   
    $(".button_join").click(function() {
      let eimg = $("#eimg").val();
      let eid = $("#eid").val();
      let epw = $("#epw").val();
      let ename = $("#ename").val();
      let errn = $("#errn").val();
      let errn2 = $("#errn2").val();
      let eemail = $("#eemail").val();
      let ehiredate = document.getElementById("ehiredate").value;
      let ebirth = document.getElementById("ebirth").value;
      let ephoneno = $("#ephoneno").val();
      let eaccount = $("#eaccount").val();
      let eaddr = $("#eaddr").val();
      let eaddr_detail = $("#eaddr_detail").val();

      let num_reg = /[^0-9]/g; //eid, epw, ephoneno, errn, eaccount
      let ename_reg =  /[^ㄱ-ㅎ|ㅏ-ㅣ|가-힣|a-zA-Z]/; //한글 영어만
      let engNum_reg =  /^[a-zA-Z0-9]*$/ // 영어 숫자만
      
      
      // test()는 인수로 전달된 문자열에 특정 패턴과 일치하는 문자열이 있는지를 검색합니다
       // test()는 패턴과 일치하는 문자열이 있으면 true를, 없으면 false를 반환합니다
       
       if (eid == "" || eid.length != 5) {
         $("#eid").focus();
         $("#eidMsg").text("사원번호는 5자리 입니다.");
         $("#eidMsg").css("color", "red");
         return false;
      } 
      
      if (num_reg.test(eid)) {
         $("#eid").focus();
         $("#eidMsg").text("영어/한글/특수문자는 사용할 수 없습니다.");
         $("#eidMsg").css("color","red");
         return false;
      }
      
      if (eemail == "" ) {
         $("#eemail").focus();
         $("#eemailMsg").text("이메일을 입력해주세요.");
         $("#eemailMsg").css("color", "red");
         return false;
      } 
      
      if (!engNum_reg.test(eemail)) {
         $("#eemail").focus();
         $("#eemailMsg").text("영어, 숫자만 사용할 수 있습니다.");
         $("#eemailMsg").css("color","red");
         return false;
      }
      
      if (epw == "" || epw.length != 5) {
         $("#epw").focus();
         $("#epwMsg").text("비밀번호는 5자리 입니다.");
         $("#epwMsg").css("color", "red");
         return false;
      }else{
         $("#epwMsg").empty();
      }
         
      if (num_reg.test(epw)) {
         $("#epw").focus();
         $("#epwMsg").text("숫자만 입력해주세요.");
         $("#epwMsg").css("color", "red");
         return false;
      }
      
      if (ename == "" || ename.length < 2) {
         $("#ename").focus();
         $("#enameMsg").text("이름은 2글자 이상 한글/영어만");
         $("#enameMsg").css("color", "red");
         return false;
      } else{
         $("#enameMsg").empty();
      }
      
      if (ename_reg.test(ename)) {
         $("#ename").focus();
         $("#enameMsg").text("영어, 한글만 입력해주세요.");
         $("#enameMsg").css("color", "red");
         return false;
      } 
      
       if (errn == "" || errn.length != 6) {
            $("#errn").focus();
            $("#errnMsg").text("주민번호 앞자리는 6자리 입니다.");
            $("#errnMsg").css("color", "red");
            return false;
         }
         
         if (num_reg.test(errn)) {
            $("#errn").focus();
            $("#errnMsg").text("주민번호 앞자리에 영어, 한글, 특수문자는 사용할 수 없습니다.");
            $("#errnMsg").css("color","red");
            return false;
         }
         
         if (errn2 == "" || errn2.length != 7) {
            $("#errn2").focus();
            $("#errnMsg").text("주민번호 뒷자리는 7자리 입니다.");
            $("#errnMsg").css("color", "red");
            return false;
         } else{
            $("#errnMsg").empty();
         }
         
         if (num_reg.test(errn2)) {
            $("#errn2").focus();
            $("#errnMsg").text("주민번호 뒷 자리에 영어, 한글, 특수문자는 사용할 수 없습니다.");
            $("#errnMsg").css("color","red");
            return false;
         }
      
         if (ehiredate === "") {
            $("#ehiredateMsg").focus();
            $("#ehiredateMsg").text("입사일을 선택하세요");
            $("#ehiredateMsg").css("color","red");
            return false;
         }else{
            $("#ehiredateMsg").empty();
         }

         if (eaddr == "") {
            $("#eaddr").focus();
            $("#eaddrMsg").text("주소를 입력해주세요.");
            $("#eaddrMsg").css("color", "red");
            return false;
         }else{
            $("#eaddrMsg").empty();
         }
         
         if (eaddr_detail == "") {
            $("#eaddr_detail").focus();
            $("#eaddrMsg").text("상세주소를 입력해주세요.");
            $("#eaddrMsg").css("color", "red");
            return false;
         }else{
            $("#eaddrMsg").empty();
         }

         if (ebirth === "") {
            $("#ebirthMsg").focus();
            $("#ebirthMsg").text("생년월일을 선택하세요");
            $("#ebirthMsg").css("color","red");
            return false;
         }else{
            $("#ebirthMsg").empty();
         }
         
         if (ephoneno == "" || ephoneno.length != 12) {
            $("#eephoneno").focus();
            $("#ephonenoMsg").text("핸드폰번호는 12자리 입니다.");
            $("#ephonenoMsg").css("color", "red");
            return false;
         }else{
            $("#ephonenoMsg").empty();
         }

         if (num_reg.test(ephoneno)) {
            $("#eephoneno").focus();
            $("#ephonenoMsg").text("핸드폰번호에 숫자만 사용할 수 있습니다.");
            $("#ephonenoMsg").css("color","red");
            return false;
         }
         
         if (eaccount == "" || eaccount.length != 5) {
            $("#eaccount").focus();
            $("#eaccountMsg").text("계좌번호는 5자리 입니다.");
            $("#eaccountMsg").css("color", "red");
            return false;
         }else{
            $("#eaccountMsg").empty();
         }

         if (num_reg.test(ephoneno)) {
            $("#eaccount").focus();
            $("#eaccountoMsg").text("계좌번호에 숫자만 사용할 수 있습니다.");
            $("#eaccountoMsg").css("color","red");
            return false;
         }
         
             if (eimg == "" ) {
                 $("#eimg").focus();
               $("#eimgMsg").text("이미지를 올려주세요.");
               $("#eimgMsg").css("color", "red");
               return false;
            } else{
               $("#eimgMsg").empty();
            }
      })

   });
</script>

</head>
<body>
<%-- <%@ include file="menu.jsp" %> --%>
   <div class="nav_container">
      <div class="content_join" id="div_content">
         <div class="reg_text">관리자 - 회원등록페이지</div>
         <div class="board_head"></div>
         <h3 class="form_title">
            사원정보입력<span class="title_tip"></span>
         </h3>
         <form action="./join" method="post" enctype="multipart/form-data">
         <div class="form topline">
               <table>
                  <tbody>
                     <tr>         
                        <th class="id">사원번호</th>
                           <td>
                              <input type="text" name="eid" id="eid" placeholder="사원번호" maxlength="5">
                              <button type="button" id="eidCheck"> 중복확인</button>
                              <br>
                              <span id="eidMsg" class="tip"></span>
                           </td>
                        </tr>
                         <tr>
                        <th class="id">이메일</th>
                           <td>
                              <input type="text" name="eemail" id="eemail" placeholder="이메일" maxlength="12">
                              <input type="text" name="eemail2" value="@ehr.net" disabled="disabled">
                              <button type="button" id="eemailCheck" disabled="disabled" class="eemailCheck">중복확인</button>
                              <br>
                              <span id="eemailMsg" class="tip"></span>
                           </td>
                        </tr>
                     <tr>
                        <th class="id">비밀번호</th>
                           <td>
                              <input type="password" name="epw" id="epw" placeholder="비밀번호"  maxlength="5"><br>
                              <span id="epwMsg" class="tip"></span>
                           </td>
                     </tr>
                     <tr>
                        <th class="id">이름</th>
                           <td>
                              <input type="text" name="ename" id="ename" placeholder="이름" maxlength="10">
                              <span id="enameMsg" class="tip"></span>
                           </td>
                     </tr>
                     <tr>
                        <th class="id">주민등록번호</th>
                           <td>
                              <input type="text" name="errn" id="errn" placeholder="주민등록번호" maxlength="6">-
                              <input type="password" name="errn2" id="errn2"  placeholder="주민등록번호" maxlength="7">
                              <span id="errnMsg" class="tip"></span>
                           </td>
                     </tr>
                        <tr>
                        <th class="id">자격증</th>
                           <td>
                              <input type="text" name="ecertificate" placeholder="자격증" value="없음">
                           </td>
                        </tr>
                     <tr>
                        <th class="id">부서</th>
                           <td>
                              <select name="edept" class="edept">
                                 <option value="경영관리실">경영관리실</option>
                                 <option value="솔루션개발팀">솔루션개발팀</option>
                                 <option value="ICT사업팀">ICT사업팀</option>
                                 <option value="헬스케어개발팀">헬스케어개발팀</option>
                                 <option value="디자인UI-UX팀">디자인UI-UX팀</option>
                                 <option value="마케팅팀">마케팅팀</option>
                              </select>
                           </td>
                     </tr>
                     <tr>
                        <th class="id">직급</th>
                           <td>
                              <select name="egrade" class="egrade">
                                 <option value="0">사원</option>
                                 <option value="1">주임</option>
                                 <option value="2">대리</option>
                                 <option value="3">과장</option>
                                 <option value="4">차장</option>
                                 <option value="5">부장</option>
                                 <option value="6">부사장</option>
                                 <option value="7">사장</option>
                                 <option value="8">관리자</option>
                              </select>
                           </td>
                     </tr>
                     <tr>
                        <th class="id">입사일</th>
                           <td>
                              <input type="date" name="ehiredate" id="ehiredate" placeholder="입사일">
                              <span id="ehiredateMsg" class="tip"></span>
                           </td>
                     </tr>
                     <tr>
                        <th class="id">주소</th>
                           <td>
                              <input type="text" name="eaddr" id="eaddr" placeholder="주소" maxlength="25"><br>
                              <input type="text" name="eaddr_detail" id="eaddr_detail" placeholder="상세주소"  maxlength="25">
                              <span id="eaddrMsg" class="tip"></span>
                           </td>
                     </tr>
                     <tr>
                        <th class="id">생년월일</th>
                           <td>
                              <input type="date" name="ebirth" id="ebirth" placeholder="생일">
                              <span id="ebirthMsg" class="tip"></span>
                           </td>
                     </tr>
                     <tr>
                        <th class="id">성별</th>
                           <td>
                              <select name="egender" class="egender">
                                 <option value="man">남자</option>
                                 <option value="woman">여자</option>
                              </select>
                           </td>
                     </tr>
                     <tr>
                        <th class="id">핸드폰번호</th>
                           <td>
                              <input type="text" name="ephoneno" id="ephoneno" placeholder="핸드폰번호" maxlength="12">
                              <span id="ephonenoMsg" class="tip"></span>
                           </td>
                     </tr>
                     <tr>
                        <th class="id">은행이름</th>
                           <td>
                              <select name="ebank" class="ebank">
                                 <option value="국민은행">국민은행</option>
                                 <option value="신한은행">신한은행</option>
                                 <option value="신한은행">농협</option>
                                 <option value="카카오뱅크">카카오뱅크</option>
                                 <option value="토스뱅크">토스뱅크</option>
                              </select>
                           </td>
                     </tr>
                     <tr>
                        <th class="id">계좌번호</th>
                           <td>
                              <input type="text" name="eaccount" id="eaccount" placeholder="계좌번호" maxlength="5">
                              <span id="eaccountMsg" class="tip"></span>
                           </td>
                     </tr>
                     <tr>
                        <th class="id">사진</th>
                           <td>
                              <input type="file" name="eimg" id="eimg"><br>
                              <span id="eimgMsg" class="tip"></span>
                           </td>
                           </tr>
                     <tr>
                  </tbody>
               </table>
            </div>
            <div class="form_button">
               <button type="submit" class="button_join" disabled="disabled" >회원등록</button>
               <button type="button" class="register_cancel_button" onclick="location.href='./'">취소</button>
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