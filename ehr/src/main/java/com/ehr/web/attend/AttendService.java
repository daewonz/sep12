package com.ehr.web.attend;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ehr.web.attend.AttendDAO;
import com.ehr.web.attend.AttendDTO;

@Service
public class AttendService {
	@Autowired
	private AttendDAO attendDAO;

	public List<AttendDTO> attendList(Map<String, Object> map) {
		return attendDAO.attendList(map);
	}

	public void atapplication(AttendDTO attendDTO) {
		attendDAO.atapplication(attendDTO);
	}

	public void atcancel(int atregno) {
		attendDAO.atcancel(atregno);
	}

	public AttendDTO attendView(int atregno) {
		return attendDAO.attendView(atregno);
	}

	public void attendEdit(AttendDTO attendDTO) {
		attendDAO.attendEdit(attendDTO);
	}

	public int getCount(String eid) {
		return attendDAO.getCount(eid);
	}	
}
