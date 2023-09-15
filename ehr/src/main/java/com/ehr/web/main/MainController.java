package com.ehr.web.main;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class MainController {
@Autowired
private MainService mainService;



@GetMapping("/")
public String home() {
	return "/login";
}

/*
 * @PostMapping("/login") public String login(@RequestParam Map<String, Object>
 * map, Model model) { Map<String, Object> result = mainService.login(map);
 * System.out.println("로그인 메소드의 결과값은 : "+result); model.addAttribute("list",
 * result); return "main"; }
 */


//이것도 임시로 만듬 dw
@GetMapping("/main")
public String main(HttpSession session, Model model) {
	if(session.getAttribute("eid") != null && session.getAttribute("eid") != "") {
		String eid = String.valueOf(session.getAttribute("eid"));
		Map<String, Object> result = mainService.login(eid);
		List<Map<String, Object>> newMember = mainService.newMember();
		System.out.println(String.valueOf(newMember.get(0).get("ehiredate")).substring(0, 10));
		newMember.get(0).put("ehiredate", String.valueOf(newMember.get(0).get("ehiredate")).substring(0, 10));
		newMember.get(1).put("ehiredate", String.valueOf(newMember.get(1).get("ehiredate")).substring(0, 10));
		System.out.println(newMember);
		model.addAttribute("newM", newMember);
	    model.addAttribute("ehiredate", String.valueOf(result.get("ehiredate")).substring(0, 10));
		model.addAttribute("list", result);
		return "/main";
	}
	
	return "login";
}
//로그인 확인하기 dw
@ResponseBody
@PostMapping("/loginCheck")
public String loginCheck(@RequestParam Map<String, Object> map, HttpSession session) {
	JSONObject json = new JSONObject();
	//일치하는 아이디가 있는지 ?
	int IDresult = mainService.IDresult(map);
	//System.out.println("★IDresult의 값은 : " + IDresult);
	//System.out.println("★map의 값은: " + map);
	if(IDresult ==0) {
		json.put("IDresult", 0);
		return json.toString();
	}else {
		int ecount = mainService.eCount(map);
		System.out.println("ecount의 값은 : " + ecount);
		//5회 이상 틀린 사람 아이디 잠궈버리기
		if(ecount > 5 ) {
			String uuid = UUID.randomUUID().toString().substring(0, 8);
			map.put("uuid", uuid);
			int result = mainService.ecountPW(map);
			//System.out.println("UUID로 바꿔버린 비밀번호 : " + map.get("id"));
			json.put("ecount", ecount);
			json.put("result", 1);
			return json.toString();
		}
		int PWresult = mainService.PWresult(map);
		if(PWresult == 1) {
			Map<String, Object> loginCheck = mainService.loginCheck(map);
			//System.out.println("★로그인 했을때 값은 : " + loginCheck);
			
			
				//ecount를 0으로 초기화
				int result = mainService.eCountReset(map);
				//System.out.println("이카운트 결과 값은 : " + result);
				session.setAttribute("ename", loginCheck.get("ename"));
				session.setAttribute("eid", map.get("id"));
				session.setAttribute("edept", loginCheck.get("edept"));
				session.setAttribute("eno", loginCheck.get("eno"));
			
				json.put("ecount", ecount);
				json.put("result", 1);
				return json.toString();
		}else {
			int result0 = mainService.eCountPlus(map);
			json.put("result", 0);
			json.put("ecount", ecount);
			return json.toString();
		}
	}
}



@GetMapping("/join")
public String join() {
	return "/join";
}

@PostMapping("/join")
public String join(@RequestParam(value="eimg",required = false) MultipartFile eimg,@RequestParam Map<String, Object> map, Model m) {
	System.out.println(map);
	System.out.println(map.get("errn"));
	System.out.println(map.get("errn2"));
	String eemail = String.valueOf(map.get("eemail"))+"@ehr.net";
	   map.put("eemail", eemail);
	   
	   String eaddr = String.valueOf(map.get("eaddr"))+"-"+ String.valueOf(map.get("eaddr_detail"));
	   map.put("eaddr", eaddr);
	String errn = String.valueOf(map.get("errn")) + String.valueOf(map.get("errn2"));
	map.put("errn", errn);
	if (!eimg.isEmpty()) {
		// 저장할 경로명 뽑기 request뽑기
		HttpServletRequest req = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
				.getRequest();
		String path = req.getServletContext().getRealPath("/upload");
		//System.out.println("=======================================================");
		System.out.println("실제경로:" + path);
		// upfile 정보 보기
		System.out.println(eimg.getOriginalFilename());
		//System.out.println(eimg.getSize());
		//System.out.println(eimg.getContentType());
		
		LocalDateTime ldt = LocalDateTime.now();
		String format = ldt.format(DateTimeFormatter.ofPattern("YYYYMMddHHmmss"));
		String realFileName = format + eimg.getOriginalFilename();

		File newFileName = new File(path, realFileName);
		
		try {
		} catch (Exception e) {
			e.printStackTrace();
		}

		try {
			FileCopyUtils.copy(eimg.getBytes(), newFileName);
		} catch (IOException e) {
			e.printStackTrace();
		}

		// #{upFile}, #{realFile}
		//map.put("upFile", upfile.getOriginalFilename());
		//map.put("realFile", realFileName);
		System.out.println(realFileName);
		map.put("realFile", realFileName);
		m.addAttribute("realFile",realFileName);
	}
	System.out.println("이미지가 비어있나요? : "+eimg.isEmpty());
	if(eimg.isEmpty()) {
		map.put("realFile", "noimg2.png");
	}
	
	mainService.join(map);

	return "redirect:/main";
}

@ResponseBody
@PostMapping("/eidcheck")
public String eidcheck(@RequestParam("eid") String eid) {
	int result = mainService.eidcheck(eid);
	
	JSONObject json = new JSONObject();
	json.put("result",result);
	return json.toString();
}

@ResponseBody
@PostMapping("/eemailcheck")
public String eemailcheck(@RequestParam("eemail") String eemail) {
	int result = mainService.eemailcheck(eemail);
	
	JSONObject json = new JSONObject();
	json.put("result",result);
	return json.toString();
}

@GetMapping("/mypage")
public String mypage(HttpSession session, Model model) {
   if(session.getAttribute("eid") != null && session.getAttribute("eid") != "") {
      String eid = String.valueOf(session.getAttribute("eid"));
      Map<String, Object> result = mainService.login(eid);
      model.addAttribute("ebirth", String.valueOf(result.get("ebirth")).substring(0, 10));
      model.addAttribute("ehiredate", String.valueOf(result.get("ehiredate")).substring(0, 10));
      model.addAttribute("list", result);
      
      String[] arr = {"사원","주임","대리","과장","차장","부장","부사장","사장","관리자"};
      model.addAttribute("egrade", arr[Integer.parseInt(String.valueOf(result.get("egrade")))]);
            
      return "/mypage";
   }
   
   return "login";
	}

@GetMapping("/logout")
public String logout(HttpSession session) {
   if(session.getAttribute("eid") != null) {
   session.invalidate();
   }
   return "redirect:/";
}

@GetMapping("/findID")
public String findID() {
	return "findID";
}
@GetMapping("/findPW")
public String findPW() {
	return "findPW";
}
@GetMapping("/mypageupdate")
public String mypageupdate(HttpSession session, Model model) {
   if(session.getAttribute("eid") != null && session.getAttribute("eid") != "") {
      String eid = String.valueOf(session.getAttribute("eid"));
      Map<String, Object> result = mainService.login(eid);
      System.out.println(result);
    result.put("ehiredate", String.valueOf(result.get("ehiredate")).substring(0, 10)); 
    result.put("ebirth", String.valueOf(result.get("ebirth")).substring(0, 10)); 
      model.addAttribute("list", result);
   }
   return "mypageupdate";
}

@PostMapping("/mypageupdate")
public String mypageupdate(HttpSession session, Model model, @RequestParam(value="eimg",required = false) MultipartFile eimg, @RequestParam Map<String, Object> map) {
   System.out.println(map);
   
   if (!eimg.isEmpty()) {
      // 저장할 경로명 뽑기 request뽑기
      HttpServletRequest req = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
            .getRequest();
      String path = req.getServletContext().getRealPath("/upload");
      //System.out.println("=======================================================");
      System.out.println("실제경로:" + path);
      // upfile 정보 보기
      System.out.println(eimg.getOriginalFilename());
      //System.out.println(eimg.getSize());
      //System.out.println(eimg.getContentType());
      
      LocalDateTime ldt = LocalDateTime.now();
      String format = ldt.format(DateTimeFormatter.ofPattern("YYYYMMddHHmmss"));
      String realFileName = format + eimg.getOriginalFilename();

      File newFileName = new File(path, realFileName);
      
      try {
      } catch (Exception e) {
         e.printStackTrace();
      }

      try {
         FileCopyUtils.copy(eimg.getBytes(), newFileName);
      } catch (IOException e) {
         e.printStackTrace();
      }

      System.out.println(realFileName);
      map.put("realFile", realFileName);
      model.addAttribute("realFile",realFileName);
   }
   
   map.put("eid",session.getAttribute("eid"));
   String eaddr = String.valueOf(map.get("eaddr"))+"-"+ String.valueOf(map.get("eaddr_detail"));
   map.put("eaddr", eaddr);
   mainService.mypageupdate(map);
   
   return "redirect:/mypage";
}

//2023-09-12 추가
@ResponseBody
@PostMapping("/findID")
public String findID(@RequestParam Map<String, Object> map) {
	JSONObject json = new JSONObject();
	System.out.println(map);
	Map<String, Object> result =  mainService.findID(map);
	System.out.println(result);
	json.put("result", result);
	return json.toString();
}


} //컨트롤러 끝










