package com.ehr.web.attend;

import lombok.Data;

@Data
public class AttendDTO {
	private int atmgno, atmgsts, eno, atregno, atregsts, atregacpt, egrade, rowNum;
	private String atmgdate, atmgstr, atmgend, ename, edept, atregdate, atregrestdate, atregcontent, eid;
}
