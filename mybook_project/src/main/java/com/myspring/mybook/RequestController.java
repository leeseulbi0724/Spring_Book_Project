package com.myspring.mybook;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mybook.commons.Criteria;
import com.mybook.commons.PageMaker;
import com.mybook.service.BoardService;
import com.mybook.service.BookService;
import com.mybook.service.MypageService;
import com.mybook.service.RequestService;
import com.mybook.vo.BellVO;
import com.mybook.vo.RequestVO;

@Controller
public class RequestController {
	
	@Autowired
	private MypageService MypageService;
	@Autowired
	private RequestService RequestService;
	@Autowired
	private BoardService BoardService;
	@Autowired
	private BookService BookService;

	/**
	 * 도서 요청
	 */
	@RequestMapping(value="/request.do", method=RequestMethod.GET)
	public ModelAndView request(HttpSession session, Criteria cri) throws Exception {
		Date now = new Date();		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        String date = format.format(now);
	   	Date Today = format.parse(date);    	 
	   	
	   	//로그인 회원정보 가져오기
  		String id = (String) session.getAttribute("session_id");
  		
  		ModelAndView mv = new ModelAndView();
  		
  		if (id!= null) {
			ArrayList<BellVO> bell_list = MypageService.getBellList(id);
			for (int i=0; i<bell_list.size(); i++) {
				String name = bell_list.get(i).getCategory();
				if (name.equals("게시판")) {
					bell_list.get(i).setContent("회원님의 게시글에 댓글이 달렸습니다");		
					String bdate = bell_list.get(i).getBdate();
					Date Bdate = format.parse(bdate);    	 
					long Day = (Today.getTime() - Bdate.getTime()) / (24*60*60*1000);
				    bell_list.get(i).setDay(String.valueOf(Day));
				} else if (name.equals("희망도서")) {
					bell_list.get(i).setContent("회원님이 신청하신 희망도서가 등록되었습니다");	
					String bdate = bell_list.get(i).getBdate();
					Date Bdate = format.parse(bdate);    	 
					long Day = (Today.getTime() - Bdate.getTime()) / (24*60*60*1000);
				    bell_list.get(i).setDay(String.valueOf(Day));
				} else if (name.equals("대여")) {
					bell_list.get(i).setContent("회원님이 대여하신 도서의 반납일이 지났습니다");	
					String bdate = bell_list.get(i).getBdate();
					Date Bdate = format.parse(bdate);    	 
					long Day = (Today.getTime() - Bdate.getTime()) / (24*60*60*1000);
				    bell_list.get(i).setDay(String.valueOf(Day));
				} 
			}		
			//알림여부
			int count = MypageService.getBellResult(id);		
			mv.addObject("bell_list", bell_list);
			mv.addObject("b_count", count);		
  		}
  		PageMaker pageMaker = new PageMaker();
 	    pageMaker.setCri(cri);
 	    pageMaker.setTotalCount(RequestService.getRequestTotal());
 	        
 	    ArrayList<RequestVO> list = RequestService.getRequestList(cri);
 	    //이름 가져오기
 	    for(int i=0; i<list.size(); i++) {
 	    	String name = BoardService.getBoardName(list.get(i).getId());
 	    	list.get(i).setName(name);
 	    }	    
 	   mv.addObject("pageMaker", pageMaker);
  		mv.addObject("list", list);
  		mv.setViewName("request/request");
		return mv;
	}
	
	/**
	 * 도서 요청 글쓰기
	 */
	@RequestMapping(value="/request_write.do", method=RequestMethod.GET)
	public ModelAndView request_write(HttpSession session) throws Exception {
		Date now = new Date();		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        String date = format.format(now);
	   	Date Today = format.parse(date);    	 
	   	
	   	//로그인 회원정보 가져오기
  		String id = (String) session.getAttribute("session_id");
  		
  		ModelAndView mv = new ModelAndView();
  		
  		if (id!= null) {
			ArrayList<BellVO> bell_list = MypageService.getBellList(id);
			for (int i=0; i<bell_list.size(); i++) {
				String name = bell_list.get(i).getCategory();
				if (name.equals("게시판")) {
					bell_list.get(i).setContent("회원님의 게시글에 댓글이 달렸습니다");		
					String bdate = bell_list.get(i).getBdate();
					Date Bdate = format.parse(bdate);    	 
					long Day = (Today.getTime() - Bdate.getTime()) / (24*60*60*1000);
				    bell_list.get(i).setDay(String.valueOf(Day));
				} else if (name.equals("희망도서")) {
					bell_list.get(i).setContent("회원님이 신청하신 희망도서가 등록되었습니다");	
					String bdate = bell_list.get(i).getBdate();
					Date Bdate = format.parse(bdate);    	 
					long Day = (Today.getTime() - Bdate.getTime()) / (24*60*60*1000);
				    bell_list.get(i).setDay(String.valueOf(Day));
				} else if (name.equals("대여")) {
					bell_list.get(i).setContent("회원님이 대여하신 도서의 반납일이 지났습니다");	
					String bdate = bell_list.get(i).getBdate();
					Date Bdate = format.parse(bdate);    	 
					long Day = (Today.getTime() - Bdate.getTime()) / (24*60*60*1000);
				    bell_list.get(i).setDay(String.valueOf(Day));
				} 
			}		
			//알림여부
			int count = MypageService.getBellResult(id);		
			mv.addObject("bell_list", bell_list);
			mv.addObject("b_count", count);		
  		}
  		mv.setViewName("request/request_write");
		return mv;
	}
	
	/**
	 * 도서 찾기
	 */
	@RequestMapping(value="/request_search.do", method=RequestMethod.GET)
	public String request_search() {
		return "request/request_search";		
	}
	
	/**
	 * 도서 요청 글쓰기 DB
	 */
	@RequestMapping(value="/request_write_proc.do", method=RequestMethod.POST)
	public ModelAndView request_write_proc(HttpSession session, RequestVO vo) {
		ModelAndView mv = new ModelAndView();
	   	//로그인 회원정보 가져오기
  		String id = (String) session.getAttribute("session_id");  		
  		vo.setId(id);
		boolean result = RequestService.getRequestWrite(vo);
		
		mv.setViewName("redirect:/request.do");
		return mv;
	}
	
	/**
	 * 상세보기
	 */
	@RequestMapping(value="/request_content.do", method=RequestMethod.GET)
	public ModelAndView request_content(String rid, HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		Date now = new Date();		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        String date = format.format(now);
	   	Date Today = format.parse(date);    	 
	   	
	   	//로그인 회원정보 가져오기
  		String id = (String) session.getAttribute("session_id");
  		
  		if (id!= null) {
			ArrayList<BellVO> bell_list = MypageService.getBellList(id);
			for (int i=0; i<bell_list.size(); i++) {
				String name = bell_list.get(i).getCategory();
				if (name.equals("게시판")) {
					bell_list.get(i).setContent("회원님의 게시글에 댓글이 달렸습니다");		
					String bdate = bell_list.get(i).getBdate();
					Date Bdate = format.parse(bdate);    	 
					long Day = (Today.getTime() - Bdate.getTime()) / (24*60*60*1000);
				    bell_list.get(i).setDay(String.valueOf(Day));
				} else if (name.equals("희망도서")) {
					bell_list.get(i).setContent("회원님이 신청하신 희망도서가 등록되었습니다");	
					String bdate = bell_list.get(i).getBdate();
					Date Bdate = format.parse(bdate);    	 
					long Day = (Today.getTime() - Bdate.getTime()) / (24*60*60*1000);
				    bell_list.get(i).setDay(String.valueOf(Day));
				} else if (name.equals("대여")) {
					bell_list.get(i).setContent("회원님이 대여하신 도서의 반납일이 지났습니다");	
					String bdate = bell_list.get(i).getBdate();
					Date Bdate = format.parse(bdate);    	 
					long Day = (Today.getTime() - Bdate.getTime()) / (24*60*60*1000);
				    bell_list.get(i).setDay(String.valueOf(Day));
				} 
			}		
			//알림여부
			int count = MypageService.getBellResult(id);		
			mv.addObject("bell_list", bell_list);
			mv.addObject("b_count", count);		
  		}
		
		RequestVO vo = RequestService.getRequestContent(rid);
		String bid = RequestService.getRequestNameResult(vo.getBname());
		
		mv.addObject("vo", vo);
		mv.addObject("bid", bid);
		mv.setViewName("request/request_content");
		
		return mv;
	}	
	
	/**
	 * 도서 요청 수정하기
	 */
	@RequestMapping(value="/request_update.do", method=RequestMethod.GET)
	public ModelAndView request_update(HttpSession session, String rid) throws Exception {
		Date now = new Date();		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        String date = format.format(now);
	   	Date Today = format.parse(date);    	 
	   	
	   	//로그인 회원정보 가져오기
  		String id = (String) session.getAttribute("session_id");
  		
  		ModelAndView mv = new ModelAndView();
  		
  		if (id!= null) {
			ArrayList<BellVO> bell_list = MypageService.getBellList(id);
			for (int i=0; i<bell_list.size(); i++) {
				String name = bell_list.get(i).getCategory();
				if (name.equals("게시판")) {
					bell_list.get(i).setContent("회원님의 게시글에 댓글이 달렸습니다");		
					String bdate = bell_list.get(i).getBdate();
					Date Bdate = format.parse(bdate);    	 
					long Day = (Today.getTime() - Bdate.getTime()) / (24*60*60*1000);
				    bell_list.get(i).setDay(String.valueOf(Day));
				} else if (name.equals("희망도서")) {
					bell_list.get(i).setContent("회원님이 신청하신 희망도서가 등록되었습니다");	
					String bdate = bell_list.get(i).getBdate();
					Date Bdate = format.parse(bdate);    	 
					long Day = (Today.getTime() - Bdate.getTime()) / (24*60*60*1000);
				    bell_list.get(i).setDay(String.valueOf(Day));
				} else if (name.equals("대여")) {
					bell_list.get(i).setContent("회원님이 대여하신 도서의 반납일이 지났습니다");	
					String bdate = bell_list.get(i).getBdate();
					Date Bdate = format.parse(bdate);    	 
					long Day = (Today.getTime() - Bdate.getTime()) / (24*60*60*1000);
				    bell_list.get(i).setDay(String.valueOf(Day));
				} 
			}		
			//알림여부
			int count = MypageService.getBellResult(id);		
			mv.addObject("bell_list", bell_list);
			mv.addObject("b_count", count);		
  		}
  		RequestVO vo = RequestService.getRequestContent(rid); 		
  		
  		mv.addObject("vo", vo);
  		mv.setViewName("request/request_update");
		return mv;
	}
	
	/**
	 * 도서 요청 수정 DB
	 */
	@RequestMapping(value="/request_update_proc.do", method=RequestMethod.POST)
	public ModelAndView request_update_proc(HttpSession session, RequestVO vo) {
		ModelAndView mv = new ModelAndView();
	   	//로그인 회원정보 가져오기
  		String id = (String) session.getAttribute("session_id");  		
  		vo.setId(id);
		boolean result = RequestService.getRequestUpdate(vo);
		
		mv.setViewName("redirect:/request_content.do?rid="+vo.getRid());
		return mv;
	}
	
	/**
	 * 도서 요청 삭제 DB
	 */
	@ResponseBody
	@RequestMapping(value="/request_delete.do", method=RequestMethod.POST)
	public boolean request_delete(HttpServletRequest request) {
		String rid= request.getParameter("rid");
		boolean result = RequestService.getRequestDelete(rid);
		
		return result;
	}
	
}
