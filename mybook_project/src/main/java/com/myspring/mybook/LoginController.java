package com.myspring.mybook;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mybook.service.MemberService;
import com.mybook.service.MessageService;
import com.mybook.service.SendEmailService;
import com.mybook.vo.MemberVO;
import com.mybook.vo.SessionVO;

@Controller
public class LoginController {
	
	@Autowired
	private MessageService messageService;
	
	@Autowired
	private SendEmailService SendEmailService;
	
	@Autowired
	private MemberService MemberService;
	
	/**
	 * 로그인
	 */
	@RequestMapping(value = "/login.do", method=RequestMethod.GET)
	public String login() {
		return "login/login";
	}
	
	/**
	 * 아이디, 비밀번호 찾기
	 */
	@RequestMapping(value = "/find.do", method=RequestMethod.GET)
	public ModelAndView find_id(String type) {
		
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("login/find");
		mv.addObject("type", type);
		
		return mv;
	}
	
	/**
	 * sms 인증
	 */
	@ResponseBody
    @RequestMapping(value = "/sendSms.do", method = RequestMethod.POST)
     public void sendSms(HttpServletRequest request) throws Exception {
		messageService.sendMessage((String)request.getParameter("to"), (String)request.getParameter("text"));
	}
	
	/**
	 * 휴대폰 인증
	 */
    @RequestMapping(value = "/find_phone.do", method = RequestMethod.GET)
     public ModelAndView find_phone(String type) {
    	
    	ModelAndView mv = new ModelAndView();
    	
    	mv.setViewName("login/find_phone");
    	mv.addObject("type", type);
    	
		return mv;
	}
    
    /**
	 * 이메일 인증
	 */
    @RequestMapping(value = "/find_email.do", method = RequestMethod.GET)
     public ModelAndView find_email(String type) {
    	
    	ModelAndView mv = new ModelAndView();
    	
    	mv.setViewName("login/find_email");
    	mv.addObject("type", type);
    	
		return mv;
	}
    
    /**
	 * email 인증
	 */
	@ResponseBody
    @RequestMapping(value = "/sendEmail.do", method = RequestMethod.POST)
     public void sendEmail(HttpServletRequest request) throws Exception {
		//보낼 이메일과 인증번호를 Service로 전달
		SendEmailService.sendEmail(request.getParameter("email"), request.getParameter("text"));
	}
    
    /**
     * 아이디, 비밀번호 찾기 - 성공페이지
     */
    @RequestMapping(value = "/find_success.do", method = RequestMethod.GET)
    public ModelAndView find_success(String type, String id) {
   	
	   	ModelAndView mv = new ModelAndView();
	   	
	   	mv.setViewName("login/find_success");
	   	mv.addObject("type", type);
	   	mv.addObject("id", id);
	   	
		return mv;
	}
    
    /**
     * 로그인 DB
     */
    @ResponseBody
	 @RequestMapping(value = "/login_proc.do", method=RequestMethod.POST)
	 public  boolean login_proc(HttpServletRequest request) {
    	
		 HttpSession session = request.getSession(); //세션 생성
		 
		 MemberVO vo = new MemberVO();		 
		 vo.setId(request.getParameter("id"));
		 vo.setPass(request.getParameter("pass"));
		 
		 boolean result = MemberService.getLoginResult(vo); //로그인 성공여부
		 
		 if (result ) { //로그인 true이면 session_id라는 이름으로 로그인 아이디를 저장
			 session.setAttribute("session_id", vo.getId());
		 }
		 
	     return result;		 
		 
	 }
	 
	 /**
	  * 로그아웃 세션 종료
	  */
	 @RequestMapping(value = "/logout.do", method=RequestMethod.GET)
	 public ModelAndView logout(HttpServletRequest request) {
		 ModelAndView mv = new ModelAndView();
		 HttpSession session = request.getSession();
	     session.invalidate();
	     
	     mv.setViewName("redirect:/index.do");

	     return mv;

	 }
	 
	 /**
	  * 아이디찾기 DB ( 휴대폰 )
	  */
	 @RequestMapping(value = "/phone_id_proc.do", method=RequestMethod.POST)
	 public ModelAndView phone_id_proc(MemberVO vo) {
		  
		 String id = MemberService.getIdPhoneSearch(vo);
		 
		 
		 ModelAndView mv = new ModelAndView();
		 mv.setViewName("login/find_success");
		 mv.addObject("id", id);
		 mv.addObject("type","id");
		 
		 return mv;		 
		 
	 }
	 
	 /**
	  * 비밀번호찾기 DB ( 휴대폰 )
	  */
	 @RequestMapping(value = "/phone_pass_proc.do", method=RequestMethod.POST)
	 public ModelAndView phone_pass_proc(MemberVO vo) {
		 
		 String id = MemberService.getPassPhoneSearch(vo);
		 
		 
		 ModelAndView mv = new ModelAndView();
		 mv.setViewName("login/find_success");
		 mv.addObject("id", id);
		 mv.addObject("type","pass");
		 
		 return mv;		 
		 
	 }
	 
	 /**
	  * 아이디찾기 DB ( 이메일 )
	  */
	 @RequestMapping(value = "/email_id_proc.do", method=RequestMethod.POST)
	 public ModelAndView email_id_proc(MemberVO vo) {
		 
		 String id = MemberService.getIdEmailSearch(vo);
		 
		 
		 ModelAndView mv = new ModelAndView();
		 mv.setViewName("login/find_success");
		 mv.addObject("id", id);
		 mv.addObject("type","id");
		 
		 return mv;		 
		 
	 }
	 
	 /**
	  * 비밀번호찾기 DB ( 이메일 )
	  */
	 @RequestMapping(value = "/email_pass_proc.do", method=RequestMethod.POST)
	 public ModelAndView email_pass_proc(MemberVO vo) {
		 		 
		 String id = MemberService.getPassEmailSearch(vo);
		 
		 
		 ModelAndView mv = new ModelAndView();
		 mv.setViewName("login/find_success");
		 mv.addObject("id", id);
		 mv.addObject("type","pass");
		 
		 return mv;		 
		 
	 }
	 
	 /**
	  * 비밀번호 찾기 - 변경
	  */
	 @RequestMapping(value = "/pass_update_proc.do", method=RequestMethod.POST)
	 public String pass_update_proc(MemberVO vo) {
		 
		 String result = "";
		 
		 boolean value = MemberService.getPassResult(vo);
		 
		 if ( value ) {
			 result = "login/pass_result";
		 }
		 
		 return result;		 
		 
	 }
	 
	 
     

}
