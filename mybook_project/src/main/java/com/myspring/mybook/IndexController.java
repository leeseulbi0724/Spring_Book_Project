package com.myspring.mybook;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.mybook.service.NoticeService;
import com.mybook.vo.NoticeVO;

@Controller
public class IndexController {
	
	@Autowired
	private NoticeService NoticeService;	

	/**
	 * 메인화면
	 */
	@RequestMapping(value="/index.do", method=RequestMethod.GET)
	public ModelAndView index() {
		ModelAndView mv = new ModelAndView();
		
		ArrayList<NoticeVO> spcl_list = NoticeService.getSpclList();
		mv.addObject("list", spcl_list);
		mv.setViewName("index");
		
		return mv;
	}

}
