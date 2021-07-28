package com.myspring.mybook;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class BoardController {

	/**
	 * �����Խ���
	 */
	@RequestMapping(value = "/board.do", method=RequestMethod.GET)
	public String board() {
		return "board/board";
	}
	
	/**
	 * �����Խ��� �۾���
	 */
	@RequestMapping(value = "/board_write.do", method=RequestMethod.GET)
	public String board_write() {
		return "board/board_write";
	}

}
