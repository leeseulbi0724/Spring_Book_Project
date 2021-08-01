package com.myspring.mybook;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class OnlineController {
	
	/**
	 * �¶��� ���
	 */
	@RequestMapping(value = "/online.do", method=RequestMethod.GET)
	public String online() {
		return "online/online";
	}
}