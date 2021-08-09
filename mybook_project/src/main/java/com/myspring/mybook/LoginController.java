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
	 * �α���
	 */
	@RequestMapping(value = "/login.do", method=RequestMethod.GET)
	public String login() {
		return "login/login";
	}
	
	/**
	 * ���̵�, ��й�ȣ ã��
	 */
	@RequestMapping(value = "/find.do", method=RequestMethod.GET)
	public ModelAndView find_id(String type) {
		
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("login/find");
		mv.addObject("type", type);
		
		return mv;
	}
	
	/**
	 * sms ����
	 */
	@ResponseBody
    @RequestMapping(value = "/sendSms.do", method = RequestMethod.POST)
     public void sendSms(HttpServletRequest request) throws Exception {
		messageService.sendMessage((String)request.getParameter("to"), (String)request.getParameter("text"));
	}
	
	/**
	 * �޴��� ����
	 */
    @RequestMapping(value = "/find_phone.do", method = RequestMethod.GET)
     public ModelAndView find_phone(String type) {
    	
    	ModelAndView mv = new ModelAndView();
    	
    	mv.setViewName("login/find_phone");
    	mv.addObject("type", type);
    	
		return mv;
	}
    
    /**
	 * �̸��� ����
	 */
    @RequestMapping(value = "/find_email.do", method = RequestMethod.GET)
     public ModelAndView find_email(String type) {
    	
    	ModelAndView mv = new ModelAndView();
    	
    	mv.setViewName("login/find_email");
    	mv.addObject("type", type);
    	
		return mv;
	}
    
    /**
	 * email ����
	 */
	@ResponseBody
    @RequestMapping(value = "/sendEmail.do", method = RequestMethod.POST)
     public void sendEmail(HttpServletRequest request) throws Exception {
		//���� �̸��ϰ� ������ȣ�� Service�� ����
		SendEmailService.sendEmail(request.getParameter("email"), request.getParameter("text"));
	}
    
    /**
     * ���̵�, ��й�ȣ ã�� - ����������
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
     * �α��� DB
     */
    @ResponseBody
	 @RequestMapping(value = "/login_proc.do", method=RequestMethod.POST)
	 public  boolean login_proc(HttpServletRequest request) {
    	
		 HttpSession session = request.getSession(); //���� ����
		 
		 MemberVO vo = new MemberVO();		 
		 vo.setId(request.getParameter("id"));
		 vo.setPass(request.getParameter("pass"));
		 
		 boolean result = MemberService.getLoginResult(vo); //�α��� ��������
		 
		 if (result ) { //�α��� true�̸� session_id��� �̸����� �α��� ���̵� ����
			 session.setAttribute("session_id", vo.getId());
		 }
		 
	     return result;		 
		 
	 }
	 
	 /**
	  * �α׾ƿ� ���� ����
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
	  * ���̵�ã�� DB ( �޴��� )
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
	  * ��й�ȣã�� DB ( �޴��� )
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
	  * ���̵�ã�� DB ( �̸��� )
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
	  * ��й�ȣã�� DB ( �̸��� )
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
	  * ��й�ȣ ã�� - ����
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
