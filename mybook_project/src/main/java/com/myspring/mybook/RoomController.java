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

import com.mybook.service.RoomService;
import com.mybook.vo.RoomVO;

@Controller
public class RoomController {
	
	@Autowired
	private RoomService RoomService;
	
	@RequestMapping(value ="/room.do", method=RequestMethod.GET)
	public ModelAndView room(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		 boolean result = true;
		//로그인 회원정보 가져오기
		String id = (String) session.getAttribute("session_id");

		result = RoomService.getRoomUserResult(id);

		ArrayList<RoomVO> list = RoomService.getRoomResult();
		int count = RoomService.getRoomCount();
		
		mv.addObject("list", list);
		mv.addObject("count",count);
		mv.addObject("result", result);
		mv.setViewName("room/room");
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value = "/room_proc.do", method=RequestMethod.POST)
	public boolean room_proc(HttpSession session, HttpServletRequest request) {
		boolean result = false;
		//로그인 회원정보 가져오기
		String id = (String) session.getAttribute("session_id");
		String number = request.getParameter("number");
		String start = request.getParameter("time");
		
		RoomVO vo = new RoomVO();
		vo.setId(id);    vo.setSeat_number(number);
		vo.setStart_time(start);
		
		String time[] = start.split(":");
		if (Integer.parseInt(time[0]) >= 15) {
			vo.setEnd_time("18:00");
		} else {
			vo.setEnd_time((Integer.parseInt(time[0])+3)+":"+time[1]);
		}
		
		result = RoomService.getRoomInsert(vo);
		if (result) {
			result = RoomService.getRoomUpdate(number);
		}
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "/room_cancle_proc.do", method=RequestMethod.POST)
	public boolean room_cancle_proc(HttpSession session, HttpServletRequest request) {
		boolean result = false;
		//로그인 회원정보 가져오기
		String id = (String) session.getAttribute("session_id");
		String number = request.getParameter("number");
		
		result = RoomService.getRoomCancle(id);
		if (result) {
			result = RoomService.getRoomUpdate2(number);
		}
		
		return result;
	}

}
