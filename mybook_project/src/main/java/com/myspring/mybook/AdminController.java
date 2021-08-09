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
import com.mybook.service.BoardService;
import com.mybook.service.BookService;
import com.mybook.service.MemberService;
import com.mybook.service.NoticeService;
import com.mybook.service.RequestService;
import com.mybook.service.RoomService;
import com.mybook.vo.BoardVO;
import com.mybook.vo.BookVO;
import com.mybook.vo.MemberVO;
import com.mybook.vo.NoticeVO;
import com.mybook.vo.RequestVO;
import com.mybook.vo.ReviewVO;
import com.mybook.vo.RoomVO;

@Controller
public class AdminController {
	
	@Autowired
	private MemberService MemberService;	
	@Autowired
	private NoticeService NoticeService;	
	@Autowired
	private BookService BookService;	
	@Autowired
	private BoardService BoardService;
	@Autowired
	private RequestService RequestService;
	@Autowired
	private RoomService RoomService;


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
	@RequestMapping(value = "/admin_user.do", method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView admin_user(Criteria cri, String search, String category) throws Exception {
		ModelAndView mv = new ModelAndView();        
		ArrayList<MemberVO> list = new ArrayList<MemberVO>();
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
	    if (search == null || search.equals("") || search.equals("null")) {		   
		    pageMaker.setTotalCount(MemberService.getCountResult());		     
		    list =MemberService.getMemberList(cri);		    
		    mv.addObject("count", "all");
	    } else {		   
	    	list = MemberService.getMemberSearchList(search, category);
	    	pageMaker.setTotalCount(list.size());
	    	list = MemberService.getMemberSearchList(search, category, cri);
		    mv.addObject("count", "search");
		    mv.addObject("search", search);
		    mv.addObject("category", category);
	    }
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
	@RequestMapping(value = "/admin_notice.do", method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView admin_notice(Criteria cri, String search) throws Exception {
		ModelAndView mv = new ModelAndView();
        
	    PageMaker pageMaker = new PageMaker();
	    pageMaker.setCri(cri);
	    
	    ArrayList<NoticeVO> list = new ArrayList<NoticeVO>();
	    
	    if (search == null || search.equals("") || search.equals("null")) {			
	    	 pageMaker.setTotalCount(NoticeService.getCountResult());
	    	 list =NoticeService.getNoticeList(cri);
			 mv.addObject("count", "all");
		} else {
			list = NoticeService.getNoticeSearchList(search);
	    	pageMaker.setTotalCount(list.size());
	    	list = NoticeService.getNoticeSearchList(search, cri);
		    mv.addObject("count", "search");
		    mv.addObject("search", search);
		}	 
	    
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
	 * ������ �����˻�
	 */
	@RequestMapping(value="/admin_book_search.do", method=RequestMethod.GET)
	public String admin_book_search() {
		return "admin/book/admin_book_search";
	}
	
	
	/**
	 * ������ ��������
	 */
	@RequestMapping(value = "/admin_book.do", method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView admin_book(Criteria cri, String search, String category) throws Exception {
		ModelAndView mv = new ModelAndView();
		 ArrayList<BookVO> list = new ArrayList<BookVO>();
		 
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		
		if (search == null || search.equals("") || search.equals("null")) {			
			 pageMaker.setTotalCount(BookService.getBookCount());		    
			 list =BookService.getBookList(cri);			
			  mv.addObject("count", "all");
		} else {
			list = BookService.getBookSearchList(search, category);
	    	pageMaker.setTotalCount(list.size());
	    	list = BookService.getBookSearchList(search, category, cri);
		    mv.addObject("count", "search");
		    mv.addObject("search", search);
		    mv.addObject("category", category);
		}
		
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
		String date[] = vo.getBdate().split("-");
		vo.setBdate(date[0]+"�� "+date[1]+"�� "+date[2]+"��");
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
	 * ���� �󼼺���
	 */
	@RequestMapping(value="/admin_book_content.do", method=RequestMethod.GET)
	public ModelAndView admin_book_content(String bid) {
		ModelAndView mv = new ModelAndView();
		int sum = 0;
		
		BookVO vo = BookService.getBookContent(bid);
		int count = BookService.getReviewCount(bid);
		if (count != 0 ) {
			sum = BookService.getReviewSum(bid);			
		}
		ArrayList<ReviewVO> list = BookService.getReivewList(bid);
		
		mv.addObject("vo", vo);
		mv.addObject("sum", sum);
		mv.addObject("count", count);
		mv.addObject("list", list);
		mv.setViewName("admin/book/admin_book_content");
		return mv;
	}
	
	/**
	 * ���� �뿩���� ȸ��
	 */
	@RequestMapping(value="/admin_book_rental.do", method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView admin_book_rental(String bid, String search, Criteria cri) {
		ModelAndView mv = new ModelAndView();
		
		ArrayList<BookVO> list = new ArrayList<BookVO>();
		
		PageMaker pageMaker = new PageMaker();
	    pageMaker.setCri(cri);
	    
	    if (search == null || search.equals("") || search.equals("null")) {			
	    	 pageMaker.setTotalCount(BookService.getBookRentalListCount(bid));
	    	 list =BookService.getBookRentalList(bid);
			 mv.addObject("count", "all");
		} else {
			list = BookService.getBookRentalSearchList(search, bid);
	    	pageMaker.setTotalCount(list.size());
	    	list = BookService.getBookRentalSearchList(search, bid, cri);
		    mv.addObject("count", "search");
		    mv.addObject("search", search);
		}	 
		
		mv.addObject("list", list);
		mv.addObject("bid", bid);
		mv.addObject("pageMaker", pageMaker);
		mv.setViewName("admin/book/admin_book_rental");
		return mv;
	}
	
	
	/**
	 * �ݳ� �˸� DB
	 */
	@ResponseBody
	@RequestMapping(value="/admin_rental_bell.do", method=RequestMethod.POST)
	public boolean admin_rental_bell(HttpServletRequest request) {
		String bid = request.getParameter("bid");
		String id = request.getParameter("id");	
		
		boolean result = BookService.getRentalBell(id, bid); //�˸����̺� ����
		
		return result;
	}
	
	
	
	
	/**
	 * ������ ������� ����
	 */
	@RequestMapping(value = "/admin_request.do", method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView admin_request(Criteria cri, String search) throws Exception {
		ModelAndView mv = new ModelAndView();
        
	    PageMaker pageMaker = new PageMaker();
	    pageMaker.setCri(cri);	   
	    
	    ArrayList<RequestVO> list = new ArrayList<RequestVO>();	   
		
		if (search == null || search.equals("") || search.equals("null")) {			
			 pageMaker.setTotalCount(RequestService.getRequestTotal());    
			 list =RequestService.getRequestList(cri);		
			 mv.addObject("count", "all");
		} else {
			list = RequestService.getRequestSearchList(search);
	    	pageMaker.setTotalCount(list.size());
	    	list = RequestService.getRequestSearchList(search, cri);
		    mv.addObject("count", "search");
		    mv.addObject("search", search);
		}	        
	    
	    mv.addObject("list", list);
	    mv.addObject("pageMaker", pageMaker);
	    mv.setViewName("admin/request/admin_request");
		
		return mv;
	}
	
	/**
	 * ������ ������� ��û
	 */
	@RequestMapping(value="/admin_request_content.do", method=RequestMethod.GET)
	public ModelAndView admin_request_content(String rid) {
		ModelAndView mv = new ModelAndView();
		
		RequestVO vo = RequestService.getRequestContent(rid);
		mv.addObject("vo", vo);
		mv.setViewName("admin/request/admin_request_content");
		
		return mv;
	}
	
	/**
	 * ������ �Խ��ǰ���
	 */
	@RequestMapping(value = "/admin_board.do", method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView admin_board(Criteria cri, String search, String category) {
		ModelAndView mv = new ModelAndView();       

	    
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
		mv.setViewName("admin/board/admin_board");
		
		return mv;
	}
	
	/**
	 * ������ ������� ��� DB
	 */
	@RequestMapping(value = "/admin_request_write_proc.do", method=RequestMethod.POST) 
	public ModelAndView admin_request_write_proc(BookVO vo, HttpServletRequest request) throws Exception {
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
			
			result = RequestService.getRequestStatus(vo.getRid());
			
			if (result) {
				RequestVO rvo = RequestService.getRequestContent(vo.getRid());
				result = RequestService.getRequestBell(rvo);
			}
		}		
		
		mv.setViewName("redirect:admin_request.do");
		
		return mv;
	}
	
	/**
	 * �Խ��� �󼼺���
	 */
	@RequestMapping(value="/admin_board_content.do", method=RequestMethod.GET)
	public ModelAndView admin_board_content(String bid) {
		ModelAndView mv = new ModelAndView();
		ArrayList<BoardVO> img_list = new ArrayList<BoardVO>();
		
		BoardVO vo = BoardService.getBoardContent(bid);
		if (vo.getBfile() != null) {			
			String img []= vo.getBsfile().split(",");
			for (int i=0; i<img.length; i++) {
				BoardVO bvo = new BoardVO();
				String name[ ] = img[i].split("_");
				bvo.setBfile(name[1]);
				bvo.setBsfile(img[i]);
				img_list.add(bvo);
			}
		}
		ArrayList<BoardVO> list = BoardService.getBoardCommentContent(bid);
		
		mv.addObject("vo", vo);
		mv.addObject("list", list);
		mv.addObject("img_list", img_list);
		mv.setViewName("admin/board/admin_board_content");
		return mv;
	}
	
	/**
	 * �����ǰ���
	 */
	@RequestMapping(value="/admin_room.do", method=RequestMethod.GET)
	public ModelAndView admin_room() {
		ModelAndView mv = new ModelAndView();
		ArrayList<RoomVO> list = RoomService.getRoomResult();
		//������� �¼�����Ȯ��
		boolean result = RoomService.getRoomIngResult();
		mv.addObject("list", list);
		mv.addObject("result", result);
		mv.setViewName("admin/room/admin_room");
		return mv;
	}
	
	/**
	 * ���������� DB
	 */
	@ResponseBody
	@RequestMapping(value="/admin_room_reset.do", method=RequestMethod.GET)
	public boolean admin_room_reset() {
		boolean result = RoomService.getRoomDelete(); //�� ���̺��� ���� ��� delete
		if (result) {
			result = RoomService.getRoomResetResult();
		}
		
		return result;
	}
	
	
	/**
	 * �������¼� ���Ұ� DB
	 */
	@ResponseBody
	@RequestMapping(value="/admin_room_no.do", method=RequestMethod.POST)
	public boolean admin_room_no(HttpServletRequest request) {		
		String number = request.getParameter("number");
		
		boolean result = RoomService.getRoomNoResult(number);

		
		return result;
	}
	
	/**
	 * �������¼� ��밡�� DB
	 */
	@ResponseBody
	@RequestMapping(value="/admin_room_yes.do", method=RequestMethod.POST)
	public boolean admin_room_yes(HttpServletRequest request) {		
		String number = request.getParameter("number");
		
		boolean result = RoomService.getRoomYesResult(number);

		
		return result;
	}

}
