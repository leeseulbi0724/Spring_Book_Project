package com.myspring.mybook;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.mybook.commons.Criteria;
import com.mybook.commons.PageMaker;
import com.mybook.service.BoardService;
import com.mybook.service.MypageService;
import com.mybook.vo.BellVO;
import com.mybook.vo.BoardVO;
import com.mybook.vo.NoticeVO;

@Controller
public class BoardController {	
	
	@Autowired
	private BoardService BoardService;	
	@Autowired
	private MypageService MypageService;

	/**
	 * �����Խ���
	 */
	@RequestMapping(value = "/board.do", method= {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView board(HttpSession session, Criteria cri, String search, String category) throws Exception {
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
	    ArrayList<BoardVO> list = new ArrayList<BoardVO>();
	    
	    if (search == null || search.equals("") || search.equals("null")) {			
	    	 pageMaker.setTotalCount(BoardService.getBoardCount());
		     list = BoardService.getBoardList(cri);
			 mv.addObject("count", "all");
		} else {
			list = BoardService.getBoardSearchList(search, category);
	    	pageMaker.setTotalCount(list.size());
	    	list = BoardService.getBoardSearchList(search, category, cri);
		    mv.addObject("count", "search");
		    mv.addObject("search", search);
		    mv.addObject("category", category);
		}        	        	        
	   
	    //�̸� ��������
	    for(int i=0; i<list.size(); i++) {
	    	String name = BoardService.getBoardName(list.get(i).getId());
	    	list.get(i).setName(name);
	    	//��� ������������
	    	int count = BoardService.getCommentCount(list.get(i).getBid());
	    	list.get(i).setCount(count);
	    }	    
	    
	    
	    mv.addObject("pageMaker", pageMaker);
		mv.addObject("list", list);
		mv.setViewName("board/board");
		
		return mv;
	}
	
	/**
	 * �����Խ��� �۾���
	 */
	@RequestMapping(value = "/board_write.do", method=RequestMethod.GET)
	public ModelAndView board_write(HttpSession session) throws Exception {
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
  		mv.setViewName("board/board_write");
		return mv;
	}
	
	/**
	 * �����Խ��� �۾��� DB
	 */
	@RequestMapping(value = "/board_write_proc.do", method=RequestMethod.POST)
	public ModelAndView board_write_proc(HttpSession session, MultipartHttpServletRequest request, @RequestParam("file") MultipartFile[] file) throws Exception {
		ModelAndView mv = new ModelAndView();		
		//�α��� ȸ������ ��������
		String id = (String) session.getAttribute("session_id");
		
		String root_path = request.getSession().getServletContext().getRealPath("/");
		System.out.print(root_path);
		String attach_path = "\\resources\\upload\\";
		String fileOriginName = ""; 
		String fileMultiName = "";
		String fileMultiUplodaName= "";
		
		UUID uuid = UUID.randomUUID();

		for(int i=0; i<file.length; i++) { 
			fileOriginName = file[i].getOriginalFilename(); 
			System.out.println("���� ���ϸ� : "+fileOriginName); 
			File f = new File(root_path + attach_path + uuid +"_"+ fileOriginName); 
			file[i].transferTo(f);
			if(i==0) { 
				fileMultiName += fileOriginName; 
				if (!fileOriginName.equals("")) {
					fileMultiUplodaName += uuid +"_"+fileOriginName;
				}
			} else { 
				fileMultiName += ","+fileOriginName; 
				if (!fileOriginName.equals("")) {
					fileMultiUplodaName += "," + uuid +"_"+fileOriginName;
				}
			} 
		}

		BoardVO vo = new BoardVO();
		vo.setBfile(fileMultiName);
		vo.setBsfile(fileMultiUplodaName);
		vo.setBtitle(request.getParameter("btitle"));
		vo.setBcontent(request.getParameter("bcontent"));
		vo.setId(id);
		
		boolean result = BoardService.getBoardWrite(vo);
		
		mv.setViewName("redirect:/board.do");
		
		return mv;
		
	}
	
	/**
	 * �����Խ��� �󼼺���
	 */
	@RequestMapping(value="/board_content.do", method=RequestMethod.GET)
	public ModelAndView board_content(String bid, HttpSession session) throws Exception {
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
		
		String img[] = null;
		//��ȸ�� �ø���
		BoardService.getBoardHit(bid);
		
		BoardVO vo = BoardService.getBoardContent(bid);
		String name = BoardService.getBoardName(vo.getId());
		vo.setName(name);		
		if (vo.getBfile() != null) {
			img = vo.getBsfile().split(",");		
		}
		
		//��� ��������
		ArrayList<BoardVO> list = BoardService.getBoardCommentContent(bid);
		for (int i=0; i<list.size(); i++) {
			String n = BoardService.getBoardName(list.get(i).getId());
			String image = BoardService.getProfileImage(list.get(i).getId());
			list.get(i).setName(n);    list.get(i).setImg(image);
		}
		
		mv.setViewName("board/board_content");
		mv.addObject("img", img);
		mv.addObject("list", list);
		mv.addObject("vo", vo);
		
		return mv;
	}
	
	/**
	 * ��� DB
	 */
	@ResponseBody
	@RequestMapping(value="/board_comment.do", method=RequestMethod.POST)
	public boolean board_comment(HttpSession session, HttpServletRequest request){
		//�α��� ȸ������ ��������
		String id = (String) session.getAttribute("session_id");
		BoardVO vo = new BoardVO();
		vo.setId(id);   vo.setCcontent(request.getParameter("comment"));
		vo.setBid(request.getParameter("bid"));

		boolean result = BoardService.getBoardComment(vo);
		
		if (result) {
			vo.setId(request.getParameter("id"));
			vo.setCategory("�Խ���");
			result = BoardService.getCommentBell(vo);
		}
		
		return result;
		
	}
	
	/**
	 * �Խ��� ����
	 */
	@RequestMapping(value="/board_update.do", method=RequestMethod.GET)
	public ModelAndView board_update(String bid, HttpSession session) throws Exception {
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
				String name[] = bell_list.get(i).getKinds().split("_");
				if (name[0].equals("b")) {				
					bell_list.get(i).setContent("ȸ������ �Խñۿ� ����� �޷Ƚ��ϴ�");		
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
		
		BoardVO vo = BoardService.getBoardContent(bid);
		if (vo.getBfile()!= null) {
			String file[] = vo.getBfile().split(",");
			String sfile[] = vo.getBsfile().split(",");
			ArrayList<BoardVO> list = new ArrayList<BoardVO>();
			for (int i=0; i<file.length; i++) {
				BoardVO bvo = new BoardVO();
				bvo.setBfile(file[i]);	bvo.setBsfile(sfile[i]);
				list.add(bvo);
			}
			mv.addObject("list", list);
		}
		
		
		mv.setViewName("board/board_update");		
		mv.addObject("vo", vo);
		
		return mv;
	}
	
	/**
	 * �Խ��� ���� DB
	 */
	@RequestMapping(value="/board_update_proc.do", method= {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView board_update_proc(MultipartHttpServletRequest request, @RequestParam("file") MultipartFile[] file) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		System.out.println("�����̸�" + request.getParameter("bfile"));
		System.out.print("���ϰ��" + request.getParameter("bsfile"));
		
		String fileOldName=request.getParameter("bfile");
		String fileOldRoot = request.getParameter("bsfile");
		
		String root_path = request.getSession().getServletContext().getRealPath("/");
		System.out.print(root_path);
		String attach_path = "\\resources\\upload\\";
		String fileOriginName = ""; 
		String fileMultiName = "";
		String fileMultiUplodaName= "";
		
		UUID uuid = UUID.randomUUID();
		
		System.out.print(file.length);

		for(int i=0; i<file.length; i++) { 
			fileOriginName = file[i].getOriginalFilename(); 
			System.out.println("���� ���ϸ� : "+fileOriginName); 
			File f = new File(root_path + attach_path + uuid +"_"+ fileOriginName); 
			file[i].transferTo(f);
			if (fileOriginName != "") {
				if(i==0) { 
					fileMultiName += fileOriginName; 
					fileMultiUplodaName += uuid +"_"+fileOriginName;
				} else { 
					fileMultiName += ","+fileOriginName; 
					fileMultiUplodaName += "," + uuid +"_"+fileOriginName;
				} 
			}
		}
		
		String old_name = request.getParameter("old_name");
		String old[] = old_name.split(",");
		for (int i=0; i<old.length; i++) {
			File old_file = new File(root_path+attach_path+old[i]);
			if ( old_file.exists()) {
				old_file.delete();
			}
		}

		BoardVO vo = new BoardVO();
		vo.setBfile(fileOldName+fileMultiName);
		vo.setBsfile(fileOldRoot+fileMultiUplodaName);
		vo.setBid(request.getParameter("bid"));
		vo.setBtitle(request.getParameter("btitle"));
		vo.setBcontent(request.getParameter("bcontent"));
		
		boolean result = BoardService.getBoardUpdate(vo);
		
		mv.setViewName("redirect:/board_content.do?bid="+vo.getBid());
		return mv;
	}
	
	/**
	 * �Խ��� ���� DB
	 */
	@ResponseBody
	@RequestMapping(value = "/board_delete.do", method=RequestMethod.POST)
	public boolean board_delete(HttpServletRequest request) {
		String bid = request.getParameter("bid");			
		String root_path = request.getSession().getServletContext().getRealPath("/");
		String attach_path = "\\resources\\upload\\";
		
		BoardVO vo = BoardService.getBoardContent(bid);
		
		if (vo.getBfile() != null) {
			String img[] = vo.getBsfile().split(",");
			
			for (int i=0; i<img.length; i++) {
				String old_name = img[i];
				File old_file = new File(root_path+attach_path+old_name);
				if ( old_file.exists()) {
					old_file.delete();
				}			
			}
		}
		
		boolean result = BoardService.getBoardDelete(bid);
		
		return result;
	}
	
	/**
	 * ��� ���� DB
	 */
	@ResponseBody
	@RequestMapping(value = "/board_comment_delete.do", method=RequestMethod.POST)
	public boolean board_comment_delete(HttpServletRequest request) {
		String cid = request.getParameter("cid");
		
		boolean result = BoardService.getBoardCommentDelete(cid);
		
		return result;
	}
	
	/**
	 * ��� ����
	 */
	@ResponseBody
	@RequestMapping(value="/board_comment_update.do", method=RequestMethod.POST)
	public BoardVO board_comment_update(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		
		String cid = request.getParameter("cid");		
		BoardVO vo = BoardService.getCommentContent(cid);
		
		return vo;
	}
	
	/**
	 * ��� ���� DB
	 */
	@ResponseBody
	@RequestMapping(value="/board_comment_update_proc.do", method=RequestMethod.POST)
	public boolean board_comment_update_porc(HttpServletRequest request) {
		String cid = request.getParameter("cid");
		String content = request.getParameter("content");
		BoardVO vo = new BoardVO();
		vo.setCid(cid);    vo.setCcontent(content);
		
		boolean result = BoardService.getCommentUpdate(vo);
		
		return result;
	}

}
