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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.mybook.commons.Criteria;
import com.mybook.commons.PageMaker;
import com.mybook.service.BoardService;
import com.mybook.vo.BoardVO;

@Controller
public class BoardController {
	
	@Autowired
	private BoardService BoardService;

	/**
	 * �����Խ���
	 */
	@RequestMapping(value = "/board.do", method=RequestMethod.GET)
	public ModelAndView board(Criteria cri) {
		ModelAndView mv = new ModelAndView();
        
	    PageMaker pageMaker = new PageMaker();
	    pageMaker.setCri(cri);
	    pageMaker.setTotalCount(BoardService.getBoardCount());
	        
	    ArrayList<BoardVO> list = BoardService.getBoardList(cri);
	    //�̸� ��������
	    for(int i=0; i<list.size(); i++) {
	    	String name = BoardService.getBoardName(list.get(i).getId());
	    	list.get(i).setName(name);
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
	public String board_write() {
		return "board/board_write";
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
	public ModelAndView board_content(String bid) {
		ModelAndView mv = new ModelAndView();
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
		
		return result;
		
	}

}
