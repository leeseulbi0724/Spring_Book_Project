package com.myspring.mybook;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class RequestController {

	/**
	 * ���� ��û
	 */
	@RequestMapping(value="/request.do", method=RequestMethod.GET)
	public String request() {
		return "request/request";
	}
	
	/**
	 * ���� ��û �۾���
	 */
	@RequestMapping(value="/request_write.do", method=RequestMethod.GET)
	public String request_write() {
		return "request/request_write";
	}
}
