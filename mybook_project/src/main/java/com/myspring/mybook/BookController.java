package com.myspring.mybook;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.mybook.service.BookService;
import com.mybook.vo.BookVO;
import com.mybook.vo.ReviewVO;

@Controller
public class BookController {
	
	@Autowired
	private BookService BookService;
	
	/**
	 * �뿩 �˻�
	 */
	@RequestMapping(value = "/search.do", method=RequestMethod.GET)
	public ModelAndView search() {
		ModelAndView mv = new ModelAndView();
		
		ArrayList<BookVO> list = BookService.getBookList();
		
		for (int i=0; i<list.size(); i++) {
			String date[] = list.get(i).getBdate().split(" ");
			list.get(i).setYyyy(date[0]);
		}
		
		mv.addObject("list", list);
		mv.setViewName("search/search");
		
		return mv;
	}
	
	/**
	 * �뿩 �뿩
	 */
	@RequestMapping(value = "/rental.do", method=RequestMethod.GET)
	public ModelAndView rental(String bid, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		
		BookVO vo = BookService.getBookContent(bid);
		//�α��� ȸ������ ��������
		String id = (String) session.getAttribute("session_id");
		//�뿩����
		ArrayList<BookVO> list = BookService.getMemberBookList(id);
		for (int i=0; i<list.size(); i++) {
			//�������� ��������
			BookVO bvo = BookService.getBookContent(list.get(i).getBid());
			list.get(i).setBname(bvo.getBname());
			list.get(i).setBfile(bvo.getBfile());
			list.get(i).setBsfile(bvo.getBsfile());
		}
		
		mv.addObject("vo", vo);
		mv.addObject("list", list);
		mv.setViewName("search/rental");
		return mv;
	}
	
	/**
	 * ���� ajax
	 */
	@ResponseBody
	@RequestMapping(value="/search_proc.do", produces = "application/text; charset=utf8", method=RequestMethod.GET)
	public String travel_proc(String search) {
		System.out.print(search);
		ArrayList<BookVO> list = BookService.getBookList(search);
		
		JsonObject jdata = new JsonObject();
		JsonArray jlist = new JsonArray();
		Gson gson = new Gson();
		
		for(BookVO vo : list) {
			JsonObject jobj = new JsonObject();
			jobj.addProperty("bid", vo.getBid());
			jobj.addProperty("bname", vo.getBname());
			jobj.addProperty("status", vo.getStatus());
			jobj.addProperty("bfile", vo.getBfile());
			jobj.addProperty("bsfile", vo.getBsfile());
			jobj.addProperty("bpublish", vo.getBpublish());
			jobj.addProperty("bdate", vo.getBcontent());
			jobj.addProperty("bauthor", vo.getBauthor());
			jobj.addProperty("search", search);
			
			String date[] = vo.getBdate().split(" ");
			jobj.addProperty("yyyy", date[0]);
			
			jlist.add(jobj);
		}
		
		jdata.add("jlist", jlist);

		return gson.toJson(jdata);
		
	}
	
	/**
	 * ���� ������
	 */
	@RequestMapping(value = "/content.do", method=RequestMethod.GET)
	public ModelAndView content(String bid, HttpSession session) {
		//�α��� ȸ������ ��������
		String id = (String) session.getAttribute("session_id");
		ModelAndView mv = new ModelAndView();
		boolean h_result = false;
		boolean r_result = false;
		boolean v_result = false;
		
		int sum = 0;
		
		BookVO vo = BookService.getBookContent(bid);
		ArrayList<ReviewVO> list = BookService.getReivewList(bid);
		int count = BookService.getReviewCount(bid);
		if (count != 0 ) {
			sum = BookService.getReviewSum(bid);			
		}
		
		ReviewVO rvo = new ReviewVO();
		if (id != null) {
			//���ƿ� ���� Ȯ���ϱ�
			BookVO bvo = new BookVO();
			bvo.setId(id); 	 bvo.setBid(bid);
			h_result = BookService.getHeartResult(bvo);			
			//�뿩 ���� Ȯ���ϱ�
			r_result = BookService.getRentalResult(bvo);		
			//���� ���� Ȯ���ϱ�
			v_result = BookService.getReviewResult(bvo);
			if (!v_result) {
				rvo = BookService.getUserReview(bvo);
			}
		}
		
		mv.addObject("count", count);
		mv.addObject("h_result", h_result);
		mv.addObject("r_result", r_result);
		mv.addObject("v_result", v_result);
		mv.addObject("rvo", rvo);
		mv.addObject("vo", vo);
		mv.addObject("list", list);
		mv.addObject("sum", sum);
		mv.setViewName("search/content");
		
		return mv;
	}
	
	/**
	 * ���� �뿩 DB
	 */
	@ResponseBody
	@RequestMapping(value = "/book_rental_proc.do", method=RequestMethod.POST)
	public boolean book_rental_proc(HttpSession session, HttpServletRequest request) {
		boolean total = false;
		//�α��� ȸ������ ��������
		String id = (String) session.getAttribute("session_id");
		BookVO vo = new BookVO();
		vo.setId(id); vo.setBid(request.getParameter("bid"));	vo.setEndday(request.getParameter("date"));
		boolean result = BookService.getBookRental(vo);
		if (result) {
			//���� �뿩���·� �ٲٱ�
			total = BookService.getBookStatus(request.getParameter("bid"));
		}
		
		return total;		
	}
	
	/**
	 * ���� �ݳ� DB
	 */
	@ResponseBody
	@RequestMapping(value = "/book_return_proc.do", method=RequestMethod.POST)
	public boolean book_return_proc(HttpSession session, HttpServletRequest request) {
		boolean total = false;
		//�α��� ȸ������ ��������
		String id = (String) session.getAttribute("session_id");
		BookVO vo = new BookVO();
		vo.setId(id); vo.setBid(request.getParameter("bid"));
		boolean result = BookService.getBookReturn(vo);
		if (result) {
			//���� �ݳ����·� �ٲٱ�
			total = BookService.getBookReturnStatus(request.getParameter("bid"));
		}
		
		return total;		
	}
	
	/**
	 * ���ƿ� +
	 */
	@ResponseBody
	@RequestMapping(value = "/heart_plus.do", method=RequestMethod.POST)
	public boolean heart_plus(HttpSession session, HttpServletRequest request) {
		boolean total = false;
		//�α��� ȸ������ ��������
		String id = (String) session.getAttribute("session_id");
		String bid = request.getParameter("bid");
		BookVO vo = new BookVO();
		vo.setId(id);
		vo.setBid(bid);		
	
		//���� +
		boolean result = BookService.getBookHeartPlus(bid);
		//heart ���̺� �߰�
		if (result) {
			total = BookService.getHeartPlus(vo);
		}
	
		return total;
	}
	
	@ResponseBody
	@RequestMapping(value = "/heart_minus.do", method=RequestMethod.POST)
	public boolean heart_minus(HttpSession session, HttpServletRequest request) {
		boolean total = false;
		//�α��� ȸ������ ��������
		String id = (String) session.getAttribute("session_id");
		String bid = request.getParameter("bid");
		BookVO vo = new BookVO();
		vo.setId(id);
		vo.setBid(bid);

		//���� -
		boolean result = BookService.getBookHeartMinus(bid);
		//heart ���̺� ����
		if (result) {
			total = BookService.getHeartMinus(vo);
		}

		return total;
	}
	
	/**
	 * �ı� ���ε�
	 */
	@ResponseBody
	@RequestMapping(value = "/review_upload.do", method=RequestMethod.POST)
	public boolean review_upload(HttpSession session, HttpServletRequest request) {
		boolean result = false;
		//�α��� ȸ������ ��������
		String id = (String) session.getAttribute("session_id");
		ReviewVO vo = new ReviewVO();
		vo.setId(id);    vo.setBid(request.getParameter("bid"));
		vo.setContent(request.getParameter("content"));
		vo.setStar(Integer.parseInt(request.getParameter("star")));
		
		result = BookService.getReviewUpload(vo);
		
		return result;
	}
	
	/**
	 * �ı� ������Ʈ
	 */
	@ResponseBody
	@RequestMapping(value = "/review_update.do", method=RequestMethod.POST)
	public boolean review_update(HttpSession session, HttpServletRequest request) {
		boolean result = false;
		//�α��� ȸ������ ��������
		String id = (String) session.getAttribute("session_id");
		ReviewVO vo = new ReviewVO();
		vo.setId(id);    vo.setBid(request.getParameter("bid"));
		vo.setContent(request.getParameter("content"));
		vo.setStar(Integer.parseInt(request.getParameter("star")));
		
		result = BookService.getReviewUpdate(vo);
		
		return result;
	}
	
	/**
	 * �ı� ����
	 */
	@ResponseBody
	@RequestMapping(value = "/review_delete.do", method=RequestMethod.POST)
	public boolean review_delete(HttpServletRequest request) {
		boolean result = false;		
		
		result = BookService.getReviewDelete(request.getParameter("rid"));
		
		return result;
	}
}
