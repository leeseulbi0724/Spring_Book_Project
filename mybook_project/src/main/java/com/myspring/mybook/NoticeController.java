package com.myspring.mybook;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.mybook.commons.Criteria;
import com.mybook.commons.PageMaker;
import com.mybook.service.DownloadView;
import com.mybook.service.MypageService;
import com.mybook.service.NoticeService;
import com.mybook.vo.BellVO;
import com.mybook.vo.BookVO;
import com.mybook.vo.NoticeVO;

@Controller
public class NoticeController {
	
	@Autowired
	private NoticeService NoticeService;		
	@Autowired
	private DownloadView downloadView;
	@Autowired
	private MypageService MypageService;
	
	/**
	 * 공지사항
	 */
	@RequestMapping(value = "/notice.do", method=RequestMethod.GET)
	public ModelAndView notice(Criteria cri, HttpSession session, String search) throws Exception {
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
	    
	    if (search == null || search.equals("") || search.equals("null")) {	
	    	//검색 하기 전 리스트 페이징
	    	 pageMaker.setTotalCount(NoticeService.getCountResult());
	    	 ArrayList<NoticeVO> spcl_list = NoticeService.getSpclList();
	    	 ArrayList<NoticeVO> normal_list = NoticeService.getNormalList(cri);
			 mv.addObject("count", "all");
			 mv.addObject("normal_list", normal_list);
			 mv.addObject("spcl_list", spcl_list);
		} else {
			//검색 후 리스트 페이징
			ArrayList<NoticeVO> list = NoticeService.getNoticeSearchList(search);
	    	pageMaker.setTotalCount(list.size());
	    	list = NoticeService.getNoticeSearchList(search, cri);
		    mv.addObject("count", "search");
		    mv.addObject("search", search);
		    mv.addObject("list", list);
		}	 
	    pageMaker.setTotalCount(NoticeService.getNormalCountResult());
	    
	    int count = NoticeService.getCountResult();
	    mv.addObject("pageMaker", pageMaker);
	    mv.addObject("total", count);
		
		mv.setViewName("notice/notice");
		
		return mv;
	}
	
	/**
	 * 공지사항 상세보기
	 */
	@RequestMapping(value = "/notice_content.do", method=RequestMethod.GET)
	public ModelAndView notice_content(String nid, String rno, String type, HttpSession session) throws Exception {
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
		
		NoticeVO vo = NoticeService.getNoticeContent(nid);
		NoticeService.getNoticeHit(nid);
		NoticeVO pvo = new NoticeVO();
		NoticeVO nvo = new NoticeVO();
		if (type.equals("normal")) {
			//이전글 -- 일반
			pvo = NoticeService.getPrevNoticeNormal(rno);
			//다음글 -- 일반
			nvo = NoticeService.getNextNoticeNormal(rno);
		} else {
			//이전글 -- 공지
			pvo = NoticeService.getPrevNoticeSpcl(rno);
			//다음글 -- 공지
			nvo = NoticeService.getNextNoticeSpcl(rno);			
		}
		if (vo.getNsfile()!= null) {
			String ext = vo.getNsfile().substring(vo.getNsfile().lastIndexOf(".") + 1);
			mv.addObject("ext", ext);
		}
		
		mv.addObject("vo", vo);
		mv.addObject("pvo", pvo);
		mv.addObject("nvo", nvo);
		mv.addObject("rno", rno);
		mv.addObject("type", type);		
		mv.setViewName("notice/notice_content");
		
		return mv;
	}
	
	/**
	 * 공지사항 파일 다운로드
	 */
	private static final String FILE_SERVER_PATH = 
			"C:/dev/spring_workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/mybook_project/resources/upload";
	
	@RequestMapping(value="/fileDownLoad.do",method=RequestMethod.GET)
	public ModelAndView download(@RequestParam HashMap<Object, Object> params) {
		ModelAndView mv = new ModelAndView();
		String fileName = (String) params.get("fileName"); //파일이름
		String fullPath = FILE_SERVER_PATH + "/" + fileName; //패스 + 파일이름
		File file = new File(fullPath);	 //파일로 생성
		
		String name[] = fileName.split("_"); //다운로드 시 이름설정을 위해 "_"를 제외한 앞 이름을 꺼내기
		String fullPath2 = name[1];
		File file2 = new File(fullPath2);
		
		mv.setViewName("downloadView");
		mv.addObject("downloadFile", file);
		mv.addObject("downloadFile2", file2);
		return mv;
	}	

}
