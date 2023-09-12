package com.ehr.web.attend;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AttendDAO {

	List<AttendDTO> attendList(Map<String, Object> map);

	void atapplication(AttendDTO attendDTO);

	void atcancel(int atregno);

	AttendDTO attendView(int atregno);

	void attendEdit(AttendDTO attendDTO);

	int getCount(String eid);

	List<Map<String, Object>> getPage(Map<String, Object> map);
	
}
