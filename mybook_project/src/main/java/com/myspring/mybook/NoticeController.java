package com.myspring.mybook;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mybook.commons.Criteria;
import com.mybook.commons.PageMaker;
import com.mybook.service.DownloadView;
import com.mybook.service.NoticeService;
import com.mybook.vo.NoticeVO;

@Controller
public class NoticeController {
	
	@Autowired
	private NoticeService NoticeService;	
	
	@Autowired
	private DownloadView downloadView;	
	
	/**
	 * 공지사항
	 */
	@RequestMapping(value = "/notice.do", method=RequestMethod.GET)
	public ModelAndView notice(Criteria cri) {
		ModelAndView mv = new ModelAndView();
		
		ArrayList<NoticeVO> spcl_list = NoticeService.getSpclList();
        
	    PageMaker pageMaker = new PageMaker();
	    pageMaker.setCri(cri);
	    pageMaker.setTotalCount(NoticeService.getNormalCountResult());
	        
	    ArrayList<NoticeVO> normal_list =NoticeService.getNormalList(cri);
	    int count = NoticeService.getCountResult();
	    
	    mv.addObject("normal_list", normal_list);
	    mv.addObject("pageMaker", pageMaker);
	    mv.addObject("total", count);
		mv.addObject("spcl_list", spcl_list);
		mv.setViewName("notice/notice");
		
		return mv;
	}
	
	/**
	 * 공지사항 상세보기
	 */
	@RequestMapping(value = "/notice_content.do", method=RequestMethod.GET)
	public ModelAndView notice_content(String nid, String rno, String type) {
		ModelAndView mv = new ModelAndView();
		
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
	private static final String FILE_SERVER_PATH = "C:/dev/spring_workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/mybook_project/resources/upload";
	
	@RequestMapping(value="/fileDownLoad.do",method=RequestMethod.GET)
	public ModelAndView download(@RequestParam HashMap<Object, Object> params) {
		ModelAndView mv = new ModelAndView();
		String fileName = (String) params.get("fileName");
		String fullPath = FILE_SERVER_PATH + "/" + fileName;
		File file = new File(fullPath);		
		
		String name[] = fileName.split("_");
		String fullPath2 = name[1];
		File file2 = new File(fullPath2);
		
		mv.setViewName("downloadView");
		mv.addObject("downloadFile", file);
		mv.addObject("downloadFile2", file2);
		return mv;
	}

	

}
