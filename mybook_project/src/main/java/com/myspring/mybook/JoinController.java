package com.myspring.mybook;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mybook.service.MemberService;
import com.mybook.vo.MemberVO;

@Controller
public class JoinController {
	@Autowired
	private MemberService memberService;

	/**
	 * 회원가입
	 */
	@RequestMapping( value = "/join.do", method=RequestMethod.GET)
	public String join() {
		return "join/join";
	}
	
	/**
	 * 회원가입 DB연동
	 */
	@RequestMapping ( value = "/join_proc.do", method=RequestMethod.POST)
	public String join_proc(MemberVO vo) {
		String result = "";
		
		boolean value = memberService.getJoinResult(vo);
		
		if ( value ) {
			result= "index";
		}
		
		return result;
	}
	
	/**
	 * 아이디 중복체크
	 */
	@ResponseBody
	@RequestMapping (value = "/id_check.do", method=RequestMethod.POST)
	public boolean id_check(HttpServletRequest request) {
		
		boolean result = false;
		
		int value = memberService.getIdCheckResult(request.getParameter("id"));
		
		if (value == 0) {
			result = true;
		}
		
		return result;
		
	}

}
