package com.ehr.web.multiboard;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MultiboardService {

	@Autowired
	private MultiboardDAO mbDAO;

	public List<Map<String, Object>> list(int board) {

		return mbDAO.list(board);
	}

	public int mbwrite(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return mbDAO.mbwrite(map);
	}

	public Map<String, Object> mbdetail(int mbno) {
		return mbDAO.mbdetail(mbno);
	}

	public List<Map<String, Object>> boardlist() {
		return mbDAO.boardList();
	}

	public Map<String, Object> sbgroupname(int board) {
		return mbDAO.sbgroupname(board);
	}
}
