package com.ehr.web.attend;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ehr.web.attend.AttendService;
import com.ehr.web.attend.AttendDTO;

@Controller
public class AttendController {
	@Autowired
	private AttendService attendService;

	@GetMapping("/attend")
	public String attend() {
		return "attend";
	}

	@PostMapping("/attend")
	public String attend(HttpServletRequest request) {
		return "";
	}

	@GetMapping("/attendRegister")
	public String attendRegister(Model model, HttpSession session, @RequestParam(defaultValue = "1") Integer page) {
		if (session.getAttribute("eid") != null) {
			int pageSize = 10;
			String eid = String.valueOf(session.getAttribute("eid"));
			int totalCnt = attendService.getCount(eid); //전체 게시글 개수
			model.addAttribute("totalCnt", totalCnt);

			Paging paging = new Paging(totalCnt, page, pageSize);

			if (page < 0 || page > paging.getTotalPage())
				page = 1;
			if (pageSize < 0 || pageSize > 50)
				pageSize = 10;
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("offset", (page - 1) * pageSize);
			map.put("eid", eid);
			map.put("pageSize", pageSize);
			//System.out.println(map);

			List<AttendDTO> attendList = attendService.attendList(map);
			model.addAttribute("attendList", attendList);			
			model.addAttribute("ph", paging);
			return "attendRegister";
		} else {
			return "redirect:/login";
		}
	}

	@PostMapping("/atapplication")
	public String atapplication(AttendDTO attendDTO, HttpSession session) {
		if (session.getAttribute("eid") != null) {
			attendDTO.setEid(String.valueOf(session.getAttribute("eid")));
			System.out.println(attendDTO);
			attendService.atapplication(attendDTO);
			return "redirect:/attendRegister";
		} else {
			return "redirect:/login";
		}
	}

	@ResponseBody
	@PostMapping("/atcancel")
	public String atcancel(@RequestParam(value = "chkarr[]") List<Integer> atregnoArr) throws JsonProcessingException {
		for (int i = 0; i < atregnoArr.size(); i++) {
			System.out.println("관리번호 : " + atregnoArr.get(i));
			attendService.atcancel(atregnoArr.get(i));
		}
		int result = 0;
		ObjectMapper mapp = new ObjectMapper();
		String json = mapp.writeValueAsString(result);

		return json;
	}

	@ResponseBody
	@PostMapping("/atview")
	public String atview(@RequestParam(value = "chkarr[]") List<Integer> atregnoArr) throws JsonProcessingException {
		int atregno = atregnoArr.get(0);
		AttendDTO result = attendService.attendView(atregno);
		ObjectMapper mapp = new ObjectMapper();
		String json = mapp.writeValueAsString(result);
		return json;
	}

	@ResponseBody
	@PostMapping("/ateditview")
	public String ateditview(@RequestParam(value = "chkarr[]") List<Integer> atregnoArr, Model model) throws JsonProcessingException {
		int atregno = atregnoArr.get(0);
		model.addAttribute("edit-atregno", atregno);
		AttendDTO result = attendService.attendView(atregno);
		ObjectMapper mapp = new ObjectMapper();
		String json = mapp.writeValueAsString(result);
		return json;
	}
	
	@PostMapping("/atedit")
	public String atedit(AttendDTO attendDTO, HttpSession session) {
		attendDTO.setEid(String.valueOf(session.getAttribute("eid")));
		attendService.attendEdit(attendDTO);
		return "redirect:/attendRegister";
	}
}
