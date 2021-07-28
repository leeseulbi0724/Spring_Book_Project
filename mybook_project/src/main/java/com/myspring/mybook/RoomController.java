package com.myspring.mybook;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class RoomController {
	
	@RequestMapping(value ="/room.do", method=RequestMethod.GET)
	public String room() {
		return "room/room";
	}

}
