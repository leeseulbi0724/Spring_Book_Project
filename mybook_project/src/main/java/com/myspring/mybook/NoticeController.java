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
	 * ��������
	 */
	@RequestMapping(value = "/notice.do", method=RequestMethod.GET)
	public ModelAndView notice(Criteria cri, HttpSession session, String search) throws Exception {
		Date now = new Date();		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        String date = format.format(now);
	   	Date Today = format.parse(date);    	 
	   	
	   	//�α��� ȸ������ ��������
  		String id = (String) session.getAttribute("session_id");
  		
  		ModelAndView mv = new ModelAndView();
  		
  		if (id!= null) {
			ArrayList<BellVO> bell_list = MypageService.getBellList(id);
			for (int i=0; i<bell_list.size(); i++) {
				String name = bell_list.get(i).getCategory();
				if (name.equals("�Խ���")) {
					bell_list.get(i).setContent("ȸ������ �Խñۿ� ����� �޷Ƚ��ϴ�");		
					String bdate = bell_list.get(i).getBdate();
					Date Bdate = format.parse(bdate);    	 
					long Day = (Today.getTime() - Bdate.getTime()) / (24*60*60*1000);
				    bell_list.get(i).setDay(String.valueOf(Day));
				} else if (name.equals("�������")) {
					bell_list.get(i).setContent("ȸ������ ��û�Ͻ� ��������� ��ϵǾ����ϴ�");	
					String bdate = bell_list.get(i).getBdate();
					Date Bdate = format.parse(bdate);    	 
					long Day = (Today.getTime() - Bdate.getTime()) / (24*60*60*1000);
				    bell_list.get(i).setDay(String.valueOf(Day));
				} else if (name.equals("�뿩")) {
					bell_list.get(i).setContent("ȸ������ �뿩�Ͻ� ������ �ݳ����� �������ϴ�");	
					String bdate = bell_list.get(i).getBdate();
					Date Bdate = format.parse(bdate);    	 
					long Day = (Today.getTime() - Bdate.getTime()) / (24*60*60*1000);
				    bell_list.get(i).setDay(String.valueOf(Day));
				} 
			}		
			//�˸�����
			int count = MypageService.getBellResult(id);		
			mv.addObject("bell_list", bell_list);
			mv.addObject("b_count", count);		
  		}
  		
  		
		
	    PageMaker pageMaker = new PageMaker();
	    pageMaker.setCri(cri);
	    
	    if (search == null || search.equals("") || search.equals("null")) {	
	    	//�˻� �ϱ� �� ����Ʈ ����¡
	    	 pageMaker.setTotalCount(NoticeService.getCountResult());
	    	 ArrayList<NoticeVO> spcl_list = NoticeService.getSpclList();
	    	 ArrayList<NoticeVO> normal_list = NoticeService.getNormalList(cri);
			 mv.addObject("count", "all");
			 mv.addObject("normal_list", normal_list);
			 mv.addObject("spcl_list", spcl_list);
		} else {
			//�˻� �� ����Ʈ ����¡
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
	 * �������� �󼼺���
	 */
	@RequestMapping(value = "/notice_content.do", method=RequestMethod.GET)
	public ModelAndView notice_content(String nid, String rno, String type, HttpSession session) throws Exception {
		Date now = new Date();		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        String date = format.format(now);
	   	Date Today = format.parse(date);    	 
	   	
	   	//�α��� ȸ������ ��������
  		String id = (String) session.getAttribute("session_id");
  		
  		ModelAndView mv = new ModelAndView();
  		
  		if (id!= null) {
			ArrayList<BellVO> bell_list = MypageService.getBellList(id);
			for (int i=0; i<bell_list.size(); i++) {
				String name = bell_list.get(i).getCategory();
				if (name.equals("�Խ���")) {
					bell_list.get(i).setContent("ȸ������ �Խñۿ� ����� �޷Ƚ��ϴ�");		
					String bdate = bell_list.get(i).getBdate();
					Date Bdate = format.parse(bdate);    	 
					long Day = (Today.getTime() - Bdate.getTime()) / (24*60*60*1000);
				    bell_list.get(i).setDay(String.valueOf(Day));
				} else if (name.equals("�������")) {
					bell_list.get(i).setContent("ȸ������ ��û�Ͻ� ��������� ��ϵǾ����ϴ�");	
					String bdate = bell_list.get(i).getBdate();
					Date Bdate = format.parse(bdate);    	 
					long Day = (Today.getTime() - Bdate.getTime()) / (24*60*60*1000);
				    bell_list.get(i).setDay(String.valueOf(Day));
				} else if (name.equals("�뿩")) {
					bell_list.get(i).setContent("ȸ������ �뿩�Ͻ� ������ �ݳ����� �������ϴ�");	
					String bdate = bell_list.get(i).getBdate();
					Date Bdate = format.parse(bdate);    	 
					long Day = (Today.getTime() - Bdate.getTime()) / (24*60*60*1000);
				    bell_list.get(i).setDay(String.valueOf(Day));
				} 
			}		
			//�˸�����
			int count = MypageService.getBellResult(id);		
			mv.addObject("bell_list", bell_list);
			mv.addObject("b_count", count);		
  		}
		
		NoticeVO vo = NoticeService.getNoticeContent(nid);
		NoticeService.getNoticeHit(nid);
		NoticeVO pvo = new NoticeVO();
		NoticeVO nvo = new NoticeVO();
		if (type.equals("normal")) {
			//������ -- �Ϲ�
			pvo = NoticeService.getPrevNoticeNormal(rno);
			//������ -- �Ϲ�
			nvo = NoticeService.getNextNoticeNormal(rno);
		} else {
			//������ -- ����
			pvo = NoticeService.getPrevNoticeSpcl(rno);
			//������ -- ����
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
	 * �������� ���� �ٿ�ε�
	 */
	private static final String FILE_SERVER_PATH = 
			"C:/dev/spring_workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/mybook_project/resources/upload";
	
	@RequestMapping(value="/fileDownLoad.do",method=RequestMethod.GET)
	public ModelAndView download(@RequestParam HashMap<Object, Object> params) {
		ModelAndView mv = new ModelAndView();
		String fileName = (String) params.get("fileName"); //�����̸�
		String fullPath = FILE_SERVER_PATH + "/" + fileName; //�н� + �����̸�
		File file = new File(fullPath);	 //���Ϸ� ����
		
		String name[] = fileName.split("_"); //�ٿ�ε� �� �̸������� ���� "_"�� ������ �� �̸��� ������
		String fullPath2 = name[1];
		File file2 = new File(fullPath2);
		
		mv.setViewName("downloadView");
		mv.addObject("downloadFile", file);
		mv.addObject("downloadFile2", file2);
		return mv;
	}	

}
