package com.myspring.mybook;

import java.io.File;
import java.util.ArrayList;
import java.util.UUID;

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
import com.mybook.service.BookService;
import com.mybook.service.MemberService;
import com.mybook.service.NoticeService;
import com.mybook.vo.BookVO;
import com.mybook.vo.MemberVO;
import com.mybook.vo.NoticeVO;

@Controller
public class AdminController {
	
	@Autowired
	private MemberService MemberService;
	
	@Autowired
	private NoticeService NoticeService;
	
	@Autowired
	private BookService BookService;

	/**
	 * ������ �α���
	 */
	@RequestMapping(value = "/admin_login.do", method=RequestMethod.GET)
	public String admin_login() {
		return "admin/admin_login";
	}
	
	/**
	 * ������ ����
	 */
	@RequestMapping(value = "/admin_main.do", method=RequestMethod.GET)
	public String admin_main() {		
		return "admin/admin_main";
	}
	
	/**
	 * ������ ȸ������
	 */
	@RequestMapping(value = "/admin_user.do", method=RequestMethod.GET)
	public ModelAndView admin_user(Criteria cri) throws Exception {
		ModelAndView mv = new ModelAndView();
        
	    PageMaker pageMaker = new PageMaker();
	    pageMaker.setCri(cri);
	    pageMaker.setTotalCount(MemberService.getCountResult());
	        
	    ArrayList<MemberVO> list =MemberService.getMemberList(cri);
	    mv.addObject("list", list);
	    mv.addObject("pageMaker", pageMaker);
	    mv.setViewName("admin/user/admin_user");
		
		return mv;
	}
	
	/**
	 * ������ ȸ�� Ż��ó��
	 */
	@ResponseBody
	@RequestMapping(value="/member_drop.do", method=RequestMethod.POST)
	public boolean member_drop(HttpServletRequest request) {
		
		boolean result = MemberService.getMemberDrop(request.getParameter("id"));
		
		return result;
	}
	
	/**
	 * ������ �������װ���
	 */
	@RequestMapping(value = "/admin_notice.do", method=RequestMethod.GET)
	public ModelAndView admin_notice(Criteria cri) throws Exception {
		ModelAndView mv = new ModelAndView();
        
	    PageMaker pageMaker = new PageMaker();
	    pageMaker.setCri(cri);
	    pageMaker.setTotalCount(NoticeService.getCountResult());
	        
	    ArrayList<NoticeVO> list =NoticeService.getNoticeList(cri);
	    mv.addObject("list", list);
	    mv.addObject("pageMaker", pageMaker);
	    mv.setViewName("admin/notice/admin_notice");
		
		return mv;
	}
	
	/**
	 * ������ �������ױ۾���
	 */
	@RequestMapping(value = "/admin_notice_write.do", method=RequestMethod.GET)
	public String admin_notice_write() {
		return "admin/notice/admin_notice_write";
	}	
	
	/**
	 * ������ �������ױ۾��� - DB
	 */
	@RequestMapping(value ="/admin_notice_write_process.do", method=RequestMethod.POST) 
	public ModelAndView admin_notice_write_process(HttpServletRequest request, NoticeVO vo, HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView();
		System.out.print(vo.getNcategory());
		System.out.print(vo.getNtitle());
		System.out.print(vo.getNcontent());
		//���� ����
		String root_path = request.getSession().getServletContext().getRealPath("/");
		String attach_path = "\\resources\\upload\\";
		
		UUID uuid = UUID.randomUUID();
			//rfname �ߺ����� ó��			
			System.out.println((vo.getFile1().getOriginalFilename()));
			System.out.println((uuid +"_"+vo.getFile1().getOriginalFilename()));	
		
		if (vo.getFile1().getOriginalFilename() != "") {
			//DB����
			vo.setNfile(vo.getFile1().getOriginalFilename());
			vo.setNsfile(uuid+ "_"+vo.getFile1().getOriginalFilename());
		}
		
		boolean result = NoticeService.getNoticeInsert(vo);
		
		//DB���� �Ϸ� �� ������ �����ϱ�
		if (result) {
			System.out.println(root_path + attach_path + uuid +"_"+vo.getFile1().getOriginalFilename());
			
			if (vo.getFile1().getOriginalFilename() != "") {
				File file = new File(root_path + attach_path + uuid
						+"_"+vo.getFile1().getOriginalFilename()); vo.getFile1().transferTo(file);
			}
		}			
		
		mv.setViewName("redirect:/admin_notice.do");
		return mv;
		
	}
	
	/**
	 * ������ �������� �����ϱ�
	 */
	@RequestMapping(value = "/admin_notice_update.do", method=RequestMethod.GET)
	public ModelAndView admin_notice_udpate(String nid) {
		ModelAndView mv = new ModelAndView();
		
		NoticeVO vo = NoticeService.getNoticeContent(nid);
		mv.addObject("vo", vo);
		mv.setViewName("admin/notice/admin_notice_update");
		
		return mv;
	}
	
	/**
	 * ������ �������� �����ϱ� - DB 
	 */
	@RequestMapping(value = "/admin_notice_update_proc.do", method=RequestMethod.POST)
	public ModelAndView free_update_proc(HttpServletRequest request, NoticeVO vo) throws Exception {
			ModelAndView mv = new ModelAndView();
			
			if (vo.getFile1().getOriginalFilename() != "") {
				//���� ����
				String root_path = request.getSession().getServletContext().getRealPath("/");
				String attach_path = "\\resources\\upload\\";
				System.out.print(root_path);
					
				//rfname �ߺ����� ó��			
				UUID uuid = UUID.randomUUID();
				System.out.println((vo.getFile1().getOriginalFilename()));
				System.out.println((uuid +"_"+vo.getFile1().getOriginalFilename()));	
					
				//DB����
				vo.setNfile(vo.getFile1().getOriginalFilename());
				vo.setNsfile(uuid+ "_"+vo.getFile1().getOriginalFilename());
		
				//BoardDAO dao = new BoardDAO();
				String old_bsfile = NoticeService.getOldFile(vo.getNid());
				boolean result = NoticeService.getFileYesUpdate(vo);
				
				//DB���� �Ϸ� �� ������ �����ϱ�
				if (result) {
					File file = new File(root_path+attach_path+vo.getNsfile());
					vo.getFile1().transferTo(file);
					
					//���� upload ������ �����ϴ� ���� ����
					File old_file = new File(root_path+attach_path+old_bsfile);
					if ( old_file.exists()) {
						old_file.delete();
					}
				}
				
			} else {
				//���� ������ ������Ʈ
				boolean result = NoticeService.getFileNoUpdate(vo);
			}	
		
			mv.setViewName("redirect:/admin_notice.do");
			return mv;
		
	}
	
	/**
	 * ������ �������� �����ϱ� - DB
	 */
	@ResponseBody
	@RequestMapping(value="notice_delete_proc.do", method=RequestMethod.POST) 
		public boolean notice_delete_proc(HttpServletRequest request) {
			ModelAndView mv = new ModelAndView();
			
			String old_bsfile = NoticeService.getOldFile(request.getParameter("nid"));
			
			String root_path = request.getSession().getServletContext().getRealPath("/");
			String attach_path = "\\resources\\upload\\";
			
			File old_file = new File(root_path+attach_path+old_bsfile);
			if ( old_file.exists()) {
				old_file.delete();
			}
			
			boolean result = NoticeService.getNoticeDelete(request.getParameter("nid"));
						
			return result;
	}
	
	
	/**
	 * ������ ��������
	 */
	@RequestMapping(value = "/admin_book.do", method=RequestMethod.GET)
	public ModelAndView admin_book(Criteria cri) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		  PageMaker pageMaker = new PageMaker();
		  pageMaker.setCri(cri);
		  pageMaker.setTotalCount(BookService.getBookCount());
		    
		 ArrayList<BookVO> list =BookService.getBookList(cri);
		 
		 mv.addObject("list", list);
		 mv.addObject("pageMaker", pageMaker);
		 mv.setViewName("admin/book/admin_book");
		return mv;
	}
	
	/**
	 * ������ �������
	 */
	@RequestMapping(value = "/admin_book_write.do", method=RequestMethod.GET)
	public String admin_book_write() {
		return "admin/book/admin_book_write";
	}
	
	/**
	 * ������ ������� DB
	 */
	@RequestMapping(value = "/admin_book_write_proc.do", method=RequestMethod.POST) 
	public ModelAndView admin_book_write_proc(BookVO vo, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		String date[] = vo.getBdate().split("-");
		vo.setBdate(date[0]+"�� "+date[1]+"�� "+date[2]+"��");

		String root_path = request.getSession().getServletContext().getRealPath("/");
		String attach_path = "\\resources\\upload\\";
		
		UUID uuid = UUID.randomUUID();
		//rfname �ߺ����� ó��			
		System.out.println((vo.getFile1().getOriginalFilename()));
		System.out.println((uuid +"_"+vo.getFile1().getOriginalFilename()));		
	
		//DB����
		vo.setBfile(vo.getFile1().getOriginalFilename());
		vo.setBsfile(uuid+ "_"+vo.getFile1().getOriginalFilename());
		
		boolean result = BookService.getBookInsert(vo);
		
		//DB���� �Ϸ� �� ������ �����ϱ�
		if (result) {
			System.out.println(root_path + attach_path + uuid +"_"+vo.getFile1().getOriginalFilename());
			
			if (vo.getFile1().getOriginalFilename() != "") {
				File file = new File(root_path + attach_path + uuid
						+"_"+vo.getFile1().getOriginalFilename()); vo.getFile1().transferTo(file);
			}
		}		
		
		mv.setViewName("redirect:admin_book.do");
		
		return mv;
	}
	
	/**
	 * ���� ���� 
	 */
	@RequestMapping(value="/admin_book_update.do", method=RequestMethod.GET)
	public ModelAndView admin_book_update(String bid) {
		ModelAndView mv = new ModelAndView();
		
		BookVO vo = BookService.getBookContent(bid);
		String bdate[] = vo.getBdate().split(" ");
		String yyyy[] = bdate[0].split("��");
		String mm[] = bdate[1].split("��");
		String dd[] = bdate[2].split("��");
		vo.setYyyy(yyyy[0]);   vo.setMm(mm[0]);   vo.setDd(dd[0]);
		
		mv.addObject("vo", vo);
		mv.setViewName("admin/book/admin_book_update");
		return mv;
	}
	
	/**
	 * ���� ���� DB
	 */
	@RequestMapping(value = "/admin_book_update_proc.do", method=RequestMethod.POST)
	public ModelAndView admin_book_update_proc(HttpServletRequest request, BookVO vo) throws Exception {
		ModelAndView mv = new ModelAndView();
		String bid = vo.getBid();
		boolean result = false;
		if (vo.getFile1().getOriginalFilename() != "") {
			//���� ����
			String root_path = request.getSession().getServletContext().getRealPath("/");
			String attach_path = "\\resources\\upload\\";
			System.out.print(root_path);
			
			//rfname �ߺ����� ó��			
			UUID uuid = UUID.randomUUID();
			System.out.println((vo.getFile1().getOriginalFilename()));
			System.out.println((uuid +"_"+vo.getFile1().getOriginalFilename()));	
				
			//DB����
			vo.setBfile(vo.getFile1().getOriginalFilename());
			vo.setBsfile(uuid+ "_"+vo.getFile1().getOriginalFilename());
	
			//BoardDAO dao = new BoardDAO();
			BookVO bvo = BookService.getBookContent(bid);
			String old_bsfile = bvo.getBsfile();
			result = BookService.getFileYesUpdate(vo);
			
			//DB���� �Ϸ� �� ������ �����ϱ�
			if (result) {
				File file = new File(root_path+attach_path+vo.getBsfile());
				vo.getFile1().transferTo(file);
				
				//���� upload ������ �����ϴ� ���� ����
				File old_file = new File(root_path+attach_path+old_bsfile);
				if ( old_file.exists()) {
					old_file.delete();
				}
			}
			
		} else {
			//���� ������ ������Ʈ
			result = BookService.getFileNoUpdate(vo);
		}	
		
		
		mv.setViewName("redirect:/admin_book.do");
		return mv;
	
}
	
	/**
	 * ���� ���� DB
	 */
	@ResponseBody
	@RequestMapping(value="/book_delete_proc.do", method=RequestMethod.POST)
	public boolean book_delete_proc(HttpServletRequest request) {
		String old_bsfile = BookService.getOldFile(request.getParameter("bid"));		
		String root_path = request.getSession().getServletContext().getRealPath("/");
		String attach_path = "\\resources\\upload\\";
		
		File old_file = new File(root_path+attach_path+old_bsfile);
		if ( old_file.exists()) {
			old_file.delete();
		}
		
		boolean result = BookService.getBookDelete(request.getParameter("bid"));
		
		return result;
	}
	
	/**
	 * ������ ��û����
	 */
	@RequestMapping(value = "/admin_request.do", method=RequestMethod.GET)
	public String admin_request() {
		return "admin/request/admin_request";
	}
	
	/**
	 * ������ �Խ��ǰ���
	 */
	@RequestMapping(value = "/admin_board.do", method=RequestMethod.GET)
	public String admin_board() {
		return "admin/board/admin_board";
	}

}