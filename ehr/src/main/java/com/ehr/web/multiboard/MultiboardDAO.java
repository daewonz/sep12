package com.ehr.web.multiboard;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MultiboardDAO {

	List<Map<String, Object>> list(int board);

	int mbwrite(Map<String, Object> map);

	Map<String, Object> mbdetail(int mbno);

	List<Map<String, Object>> boardList();

	Map<String, Object> sbgroupname(int board);

}
