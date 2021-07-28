package com.myspring.mybook;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class BoardController {

	/**
	 * 자유게시판
	 */
	@RequestMapping(value = "/board.do", method=RequestMethod.GET)
	public String board() {
		return "board/board";
	}
	
	/**
	 * 자유게시판 글쓰기
	 */
	@RequestMapping(value = "/board_write.do", method=RequestMethod.GET)
	public String board_write() {
		return "board/board_write";
	}

}
