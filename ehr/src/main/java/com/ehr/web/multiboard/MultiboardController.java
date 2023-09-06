package com.ehr.web.multiboard;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MultiboardController {

	@Autowired
	private MultiboardService mbService ;
	
	@GetMapping("/multiboard")
	public String multiboard(@RequestParam(value="board",required=false,defaultValue = "1") int board, Model m) {
		
	List<Map<String, Object>> boardlist = mbService.boardlist();
	List<Map<String, Object>> list = mbService.list(board);
	Map<String, Object> sbgroupname = mbService.sbgroupname(board);
	m.addAttribute("boardlist", boardlist);
	m.addAttribute("list", list);
	m.addAttribute("sbgroupname", sbgroupname);
	
		return "multiboard";
	}
	
	
	@GetMapping("/mbwrite")
	public String mbWrtie(@RequestParam(value = "board", required = false, defaultValue = "1") int board, Model m,
			HttpSession session) {

		if (session.getAttribute("eid") != null) {
			m.addAttribute("board", board);
			return "mbwrite";
		} else {
			return "redirect:/login?error=login";
		}
	}

	@PostMapping("/mbwrite") 
	public String mbWrite(@RequestParam Map<String,Object> map, HttpSession session) {
	  
		if (session.getAttribute("eid") != null) {
			map.put("eid", session.getAttribute("eid"));
			mbService.mbwrite(map); // selectKey 기법
			System.out.println(map); // System.out.println(mb_no);
			return "redirect:/mbdetail?board=" + map.get("mbboard") + "&mbno=" + map.get("mbno");
		} else {
			return "redirect:/login.sik?error=login";
		}
	}

	@GetMapping("/mbdetail")
	public String mbDetail(@RequestParam(value = "mbno", required = true) int mbno, Model m) {
		System.out.println(mbno);
		Map<String, Object> detail = mbService.mbdetail(mbno);
		m.addAttribute("detail", detail);
		System.out.println(detail);
		return "mbdetail";
	}
	 
}
