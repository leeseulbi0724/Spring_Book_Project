package com.myspring.mybook;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
				String name[] = bell_list.get(i).getKinds().split("_");
				if (name[0].equals("b")) {				
					bell_list.get(i).setContent("회원님의 게시글에 댓글이 달렸습니다");		
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
				String name[] = bell_list.get(i).getKinds().split("_");
				if (name[0].equals("b")) {				
					bell_list.get(i).setContent("회원님의 게시글에 댓글이 달렸습니다");		
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
	public ModelAndView request_content(String rid) {
		ModelAndView mv = new ModelAndView();
		
		RequestVO vo = RequestService.getRequestContent(rid);
		
		mv.addObject("vo", vo);
		mv.setViewName("request/request_content");
		
		return mv;
	}	
	
}
