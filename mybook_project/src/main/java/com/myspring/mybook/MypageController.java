package com.myspring.mybook;

import java.io.File;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.mybook.service.BoardService;
import com.mybook.service.BookService;
import com.mybook.service.MemberService;
import com.mybook.service.MypageService;
import com.mybook.service.RoomService;
import com.mybook.vo.BookVO;
import com.mybook.vo.MemberVO;
import com.mybook.vo.ReviewVO;
import com.mybook.vo.RoomVO;
import com.mybook.vo.SessionVO;

@Controller
public class MypageController {
	@Autowired
	private MemberService MemberService;
	@Autowired
	private BookService BookService;
	@Autowired
	private MypageService MypageService;
	@Autowired
	private RoomService RoomService;
	@Autowired
	private BoardService BoardService;
	
	/**
	 * 마이페이지 메인
	 */
	@RequestMapping (value = "/mypage.do", method=RequestMethod.GET)
	public ModelAndView mypage(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		//로그인 회원정보 가져오기
		String id = (String) session.getAttribute("session_id");
		//프로필 사진 가져오기
		MemberVO vo = MemberService.getLoginContent(id);
		
		mv.setViewName("mypage/mypage_main");
		mv.addObject("vo", vo);
		return mv;
	}
	
	/**
	 * 마이페이지 정보수정
	 */
	@RequestMapping (value = "/mypage_info.do", method=RequestMethod.GET)
	public String mypage_info() {
		return "mypage/mypage_info";
	}
	
	/**
	 * 마이페이지 정보수정 비밀번호 확인 후 페이지
	 */
	@RequestMapping (value = "/mypage_info_content.do", method=RequestMethod.GET)
	public ModelAndView mypage_info_content(HttpSession session) {
		//로그인 회원정보 가져오기
		String id = (String) session.getAttribute("session_id");
		
		ModelAndView mv = new ModelAndView();
		
		MemberVO vo = MemberService.getLoginContent(id);
		String email[] = vo.getEmail().split("@");
		vo.setEmail1(email[0]);
		vo.setEmail2(email[1]);
		
		String hp[] = vo.getHp().split("-");
		vo.setHp1(hp[0]);
		vo.setHp2(hp[1]);
		vo.setHp3(hp[2]);
		
		String one = vo.getBirth().substring(0, 2);
		String two = vo.getBirth().substring(2, 4);
		String three = vo.getBirth().substring(4, 6);
		vo.setBirth("19"+one+"년 "+two+"월 "+three+"일");
		
		mv.setViewName("mypage/mypage_info_content");
		mv.addObject("vo", vo);
		
		return mv;
	}
	
	/**
	 * 마이페이지 비밀번호 변경
	 */
	@RequestMapping (value = "/mypage_pass.do", method=RequestMethod.GET)
	public String mypage_pass() {
		return "mypage/mypage_pass";
	}
	
	/**
	 * 마이페이지 도서대여
	 */
	@RequestMapping (value = "/mypage_book.do", method=RequestMethod.GET)
	public ModelAndView mypage_book(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		//로그인 회원정보 가져오기
		String id = (String) session.getAttribute("session_id");
		//대여정보
		ArrayList<BookVO> list = BookService.getMemberBookList(id);
		for (int i=0; i<list.size(); i++) {
			//도서정보 가져오기
			BookVO vo = BookService.getBookContent(list.get(i).getBid());
			list.get(i).setBname(vo.getBname());
			list.get(i).setBfile(vo.getBfile());
			list.get(i).setBsfile(vo.getBsfile());
		}
		//열람실예약정보
		RoomVO vo = new RoomVO();
		boolean result = RoomService.getRoomUserResult(id);
		if (!result) {
			vo = MypageService.getRoomResult(id);
		}
		mv.addObject("result", result);
		mv.addObject("list", list);
		mv.addObject("vo", vo);
		mv.setViewName("mypage/mypage_book");
		return mv;
	}
	
	/**
	 * 마이페이지 비밀번호 확인
	 */
	@ResponseBody
	@RequestMapping (value = "/pass_check.do", method=RequestMethod.POST)
	public boolean id_check(HttpSession session, HttpServletRequest request) {
		//로그인 회원정보 가져오기
		String id = (String) session.getAttribute("session_id");
		
		SessionVO vo = new SessionVO();
		vo.setId(id);
		vo.setPass(request.getParameter("pass"));
				
		boolean result = MemberService.getPassCheckResult(vo);
		
		
		return result;
		
	}
	
	/**
	 * 마이페이지 정보수정
	 */
	@ResponseBody
	@RequestMapping (value = "/info_update.do", method=RequestMethod.POST)
	public boolean info_update(HttpSession session, HttpServletRequest request) {
		//로그인 회원정보 가져오기
		String id = (String) session.getAttribute("session_id");
		MemberVO vo = new MemberVO();
		
		vo.setId(id);
		vo.setEmail1(request.getParameter("email1"));
		vo.setEmail2(request.getParameter("email2"));
		vo.setHp1(request.getParameter("hp1"));
		vo.setHp2(request.getParameter("hp2"));
		vo.setHp3(request.getParameter("hp3"));
		vo.setAddr1(request.getParameter("addr1"));
		vo.setAddr2(request.getParameter("addr2"));
				
		boolean result = MemberService.getInfoUpdateResult(vo);
		
		
		return result;
		
	}
	
	/**
	 * 비밀번호 변경
	 */
	@ResponseBody
	@RequestMapping(value = "/mypass_update_proc.do", method=RequestMethod.POST)
	public boolean pass_update_proc2(HttpSession session, HttpServletRequest request) {
		// 로그인 회원정보 가져오기
		String id = (String) session.getAttribute("session_id");
		MemberVO vo = new MemberVO();
		
		vo.setId(id);
		vo.setPass(request.getParameter("pass"));
		
		boolean result = MemberService.getPassResult(vo);
		
		return result;
	
	}
	
	/**
	 * 마이페이지 회원탈퇴 신청
	 */
	@ResponseBody
	@RequestMapping(value = "/info_delete.do", method=RequestMethod.POST)
	public boolean info_delete(HttpSession session) {
		// 로그인 회원정보 가져오기
		String id = (String) session.getAttribute("session_id");
		
		boolean result = MemberService.getInfoDelete(id);
		
		return result;
	
	}
	
	/**
	 * 마이페이지 회원탈퇴 신청 취소
	 */
	@ResponseBody
	@RequestMapping(value = "/info_delete_reset.do", method=RequestMethod.POST)
	public boolean info_delete_reset(HttpSession session) {
		// 로그인 회원정보 가져오기
		String id = (String) session.getAttribute("session_id");
		
		boolean result = MemberService.getInfoDeleteReset(id);
		
		return result;
	
	}
	
	/**
	 * 마이페이지 좋아요
	 */
	@RequestMapping(value="/mypage_heart.do", method=RequestMethod.GET)
	public ModelAndView mypage_heart(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		// 로그인 회원정보 가져오기
		String id = (String) session.getAttribute("session_id");
		
		ArrayList<BookVO> list = MypageService.getHeartList(id);
		for ( int i=0; i<list.size(); i++) {
			BookVO vo = BookService.getBookContent(list.get(i).getBid());
			list.get(i).setBname(vo.getBname());
		}		
		mv.addObject("list", list);
		mv.setViewName("mypage/mypage_heart");
		return mv;
	}
	
	/**
	 * 마이페이지 후기
	 */
	@RequestMapping(value="/mypage_review.do", method=RequestMethod.GET)
	public ModelAndView mypage_review(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		// 로그인 회원정보 가져오기
		String id = (String) session.getAttribute("session_id");
		
		ArrayList<ReviewVO> list = MypageService.getReviewList(id);
		for ( int i=0; i<list.size(); i++) {
			BookVO vo = BookService.getBookContent(list.get(i).getBid());
			list.get(i).setBname(vo.getBname());
		}
		mv.addObject("list", list);
		mv.setViewName("mypage/mypage_review");
		return mv;
	}
	
	/**
	 * 마이페이지 게시글
	 */
	@RequestMapping(value="/mypage_board.do", method=RequestMethod.GET)
	public String mypage_board() {
		return "mypage/mypage_board";
	}
	
	/**
	 * 프로필 사진 변경하기
	 */
	@RequestMapping(value = "/mypage_profile.do", method=RequestMethod.POST)
	public ModelAndView mypage_profile(HttpSession session, HttpServletRequest request, MemberVO vo)  throws Exception {
		ModelAndView mv = new ModelAndView();
		// 로그인 회원정보 가져오기
		String id = (String) session.getAttribute("session_id");
		String root_path = request.getSession().getServletContext().getRealPath("/");
		String attach_path = "\\resources\\upload\\";
		
		//rfname 중복방지 처리			
		UUID uuid = UUID.randomUUID();
		
		System.out.print(vo.getFile1().getOriginalFilename());
		
		//DB저장
		vo.setMfile(vo.getFile1().getOriginalFilename());
		vo.setMsfile(uuid+ "_"+vo.getFile1().getOriginalFilename());
		vo.setId(id);
		
		String old_bsfile = BoardService.getProfileImage(id);
		boolean result = MypageService.getProfileUpdate(vo);
		
		//DB저장 완료 후 폴더에 저장하기
		if (result) {
			System.out.println(root_path + attach_path + uuid +"_"+vo.getFile1().getOriginalFilename());

			File f = new File(root_path + attach_path + uuid
					+"_"+vo.getFile1().getOriginalFilename()); vo.getFile1().transferTo(f);
					
			//기존 upload 폴더에 존재하는 파일 삭제
			File old_file = new File(root_path+attach_path+old_bsfile);
			if ( old_file.exists()) {
				old_file.delete();
			}
		}
		mv.setViewName("redirect:/mypage.do");
		return mv;
	}
	
	


}
