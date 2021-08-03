package com.myspring.mybook;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mybook.service.BookService;
import com.mybook.service.MypageService;
import com.mybook.service.NoticeService;
import com.mybook.vo.BellVO;
import com.mybook.vo.BookVO;
import com.mybook.vo.NoticeVO;

@Controller
public class IndexController {
	
	@Autowired
	private NoticeService NoticeService;	
	@Autowired
	private MypageService MypageService;	

	/**
	 * 메인화면
	 */
	@RequestMapping(value="/index.do", method=RequestMethod.GET)
	public ModelAndView index(HttpSession session) throws Exception {
		Date now = new Date();
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        String date = format.format(now);
	   	 Date Today = format.parse(date);
        
		//로그인 회원정보 가져오기
		String id = (String) session.getAttribute("session_id");
		
		ModelAndView mv = new ModelAndView();
		
		ArrayList<NoticeVO> spcl_list = NoticeService.getSpclList();
		
		if (id!= null) {
			//마감임박 알려주기
			/* ArrayList<BookVO> book_list = BookService.getMemberBookList(id);
			for (int i=0; i<book_list.size(); i++) {
				Date EndDay = format.parse(book_list.get(i).getEndday());
				int compare = Today.compareTo(EndDay);
				if (compare > 0) {
					BellVO vo = new BellVO();
					vo.setId(book_list.get(i).getId());
					vo.setCategory("도서");
					vo.setKinds(book_list.get(i).getBid());
					boolean result = BookService.getBookBell(vo);
				}
			} */
			
			ArrayList<BellVO> bell_list = MypageService.getBellList(id);
			for (int i=0; i<bell_list.size(); i++) {
				String name = bell_list.get(i).getCategory();
				if (name.equals("게시판")) {
					bell_list.get(i).setContent("회원님의 게시글에 댓글이 달렸습니다");		
					String bdate = bell_list.get(i).getBdate();
					Date Bdate = format.parse(bdate);    	 
					long Day = (Today.getTime() - Bdate.getTime()) / (24*60*60*1000);
				    bell_list.get(i).setDay(String.valueOf(Day));
				} 
				/* else if (name.equals("도서")) {
					bell_list.get(i).setContent("대여하신 도서의 반납일자가 지났습니다");	
					String bdate = bell_list.get(i).getBdate();
					Date Bdate = format.parse(bdate);    	 
					long Day = (Today.getTime() - Bdate.getTime()) / (24*60*60*1000);
				    bell_list.get(i).setDay(String.valueOf(Day));
				} */
			}		
			//알림여부
			int count = MypageService.getBellResult(id);		
			mv.addObject("bell_list", bell_list);
			mv.addObject("b_count", count);
		}
		
		mv.addObject("list", spcl_list);
		mv.setViewName("index");
		
		return mv;
	}
	
	/**
	 * 알림 읽음
	 */
	@ResponseBody
	@RequestMapping(value="/bell_update.do", method=RequestMethod.POST)
	public boolean bell_update(HttpSession session) {
		//로그인 회원정보 가져오기
		String id = (String) session.getAttribute("session_id");
		
		boolean result = MypageService.getBellUpdate(id);
		
		return result;
	}

}
