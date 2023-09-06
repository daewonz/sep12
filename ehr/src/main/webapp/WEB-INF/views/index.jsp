<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FULL CALENDAR</title>
<script src="./js/jquery-3.7.0.min.js"></script>
<script src='js/index.global.min.js'></script>
<script type="text/javascript">
	  
</script>
<style>
.area {
	width: 80%;
	padding: 0 50px;
	font-size: small;
}
</style>
</head>
<body>
<div class = "area">
	<div id='calendar'>
	
	</div>
</div>
<script>
document.addEventListener('DOMContentLoaded', function() {
	var calendarEl = document.getElementById('calendar');
	var calendar = new FullCalendar.Calendar(calendarEl, {
		initialView: 'dayGridMonth'
	});
	
	calendar.addEvent({ title: '차승리 사원 출장', start: '2023-09-01'});
	calendar.addEvent({ title: '${event}', start: '${eventday}' });
	
	calendar.addEvent({
      title  : '차승리 사원 휴가',
      start  : '2023-09-05',
      end    : '2023-09-07'
    });
	calendar.addEvent({
	      title  : '${event}',
	      start  : '${estartday}',
	      end    : '${eendday}'
	    });
	
	calendar.addEvent({
      title  : '주간 회의',
      start  : '2023-09-04T12:30:00',
    });
	
	calendar.render();

});
</script>

</body>
</html>
