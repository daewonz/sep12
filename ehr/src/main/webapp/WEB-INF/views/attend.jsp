<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>근태 관리 현황</title>
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.9.0/main.css' rel='stylesheet' />
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.9.0/main.js'></script>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.9.0/locales/ko.js'></script>
<script src="./js/jquery-3.7.0.min.js"></script>
<script src='js/index.global.min.js'></script>
<style>
.area {
    width: 80%;
    padding: 0 50px;
    font-size: small;
}

.modal {
    z-index: 10;
    display: none;
    position: fixed;
    top: 250px;
    left: 650px;
    width: 500px;
    height: 500px;
    background-color: white;
    justify-content: center;
    align-items: center;
    border: 1px solid #ccc; /* 테두리 추가 */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 그림자 효과 추가 */
}

.modal-content {
    background-color: #fff;
    padding: 20px;
    border-radius: 5px;
}

.close {
    position: absolute;
    top: 10px;
    right: 10px;
    cursor: pointer;
}

.detail-detail {
    text-align: center;
}

/* 버튼 스타일 */
.btn-in,
.btn-out {
    padding: 5px 15px;
    margin: 5px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

.btn-in {
    background-color: #5cb85c; /* 출근 버튼 배경색 */
    color: white;
}

.btn-out {
    background-color: #d9534f; /* 퇴근 버튼 배경색 */
    color: white;
}

</style>
</head>
<body>
<h1>근태 관리</h1>

<div class="area">
    <div id="calendar">
    
    </div>
</div>

<script>
// 날짜별 출근 및 퇴근 정보를 저장할 객체
var attendanceData = {};

document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');
    var calendar = new FullCalendar.Calendar(calendarEl, {
        initialView : 'dayGridMonth',
        dateClick : function(info) {
            var modal = $('#myModal');
            modal.modal('show'); // 모달 창 열기

            // 선택한 날짜의 출근 정보 가져오기
            var selectedDate = info.dateStr;
            var attendance = attendanceData[selectedDate];

            // 모달 내용 설정
            var modalContent = $('.modal-content');
            var detailName = modalContent.find('.detail-name');
            var detailDate = modalContent.find('.detail-date');
            var detailDate2 = modalContent.find('.detail-date2');
            
            // 모달에 날짜 업데이트
            function updateModalDate(date) {
                detailName.text('근무 날짜: ' + date);
                if (attendance && attendance.inTime) {
                    detailDate.text('출근 시간: ' + attendance.inTime);
                }
            }

            updateModalDate(selectedDate);

            // 출근 버튼 클릭 이벤트
            var btnIn = modalContent.find('.btn-in');
            btnIn.off('click'); // 이전 이벤트 핸들러 제거
            btnIn.show(); // 출근 버튼 보이기
            btnIn.on('click', function() {
                // 현재 시간 표시
                var currentTime = new Date().toLocaleTimeString();
                detailDate.text('출근 시간: ' + currentTime);
                btnIn.hide(); // 출근 버튼 숨김
                // 출근 정보 저장
                if (attendance) {
                    attendance.inTime = currentTime;
                } else {
                    attendanceData[selectedDate] = { inTime: currentTime };
                }
                // 퇴근 버튼 보이기
                btnOut.show();
            });

            // 퇴근 버튼 클릭 이벤트
            var btnOut = modalContent.find('.btn-out');
            btnOut.off('click'); // 이전 이벤트 핸들러 제거
            if (attendance && attendance.outTime) {
                btnIn.hide(); // 이미 출근 처리된 경우 출근 버튼 숨김
                btnOut.hide(); // 이미 퇴근 처리된 경우 퇴근 버튼 숨김
            } else {
                btnOut.show(); // 퇴근 버튼 보이기
                btnOut.on('click', function() {
                    // 현재 시간 표시
                    var currentTime = new Date().toLocaleTimeString();
                    detailDate2.text('퇴근 시간: ' + currentTime);
                    btnOut.hide(); // 퇴근 버튼 숨김
                    // 퇴근 정보 저장
                    if (attendance) {
                        attendance.outTime = currentTime;
                    } else {
                        attendanceData[selectedDate] = { outTime: currentTime };
                    }
                });
            }

            // 모달 닫기 버튼
            var closeBtn = $('.btn-close');
            closeBtn.on('click', function() {
                modal.modal('hide'); // 모달 창 닫기
            });
        }
    });

    calendar.render();
});
</script>

<!-- Modal -->
<div class="modal" id="myModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">

    <!-- 모달 내용 -->
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="header">
                <h5 class="title" id="exampleModalLabel"></h5>
            </div>
            <div class="modal-body">
                <div class="detail-detail">
                    <div class="detail-name"></div>
                    <div class="detail-date-read">
                        <div class="detail-date"></div>
                        <div class="detail-date2"></div>
                        <div class="detail-in-time"></div>
                        <div class="detail-out-time"></div>
                    </div>
                    <br>
                    <div style="text-align: center;">
                        <button type="button" class="btn-in">출근</button>
                        <button type="button" class="btn-out">퇴근</button>
                    </div>
                </div>
            </div>
            <div style="text-align: center;">
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">닫기</button>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/scripts.js"></script>
<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
</body>
</html>