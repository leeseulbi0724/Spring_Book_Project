package com.myspring.mybook;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mybook.service.MypageService;
import com.mybook.service.RoomService;
import com.mybook.vo.BellVO;
import com.mybook.vo.RoomVO;

@Controller
public class RoomController {
	
	@Autowired
	private RoomService RoomService;
	@Autowired
	private MypageService MypageService;
	
	@RequestMapping(value ="/room.do", method=RequestMethod.GET)
	public ModelAndView room(HttpSession session) throws Exception {
		Date now = new Date();		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        String date = format.format(now);
	   	Date Today = format.parse(date);    	 
	   	
	   	//�α��� ȸ������ ��������
  		String id = (String) session.getAttribute("session_id");
  		
  		ModelAndView mv = new ModelAndView();
  		
  		if (id!= null) {
			ArrayList<BellVO> bell_list = MypageService.getBellList(id);
			for (int i=0; i<bell_list.size(); i++) {
				String name = bell_list.get(i).getCategory();
				if (name.equals("�Խ���")) {
					bell_list.get(i).setContent("ȸ������ �Խñۿ� ����� �޷Ƚ��ϴ�");		
					String bdate = bell_list.get(i).getBdate();
					Date Bdate = format.parse(bdate);    	 
					long Day = (Today.getTime() - Bdate.getTime()) / (24*60*60*1000);
				    bell_list.get(i).setDay(String.valueOf(Day));
				} else if (name.equals("�������")) {
					bell_list.get(i).setContent("ȸ������ ��û�Ͻ� ��������� ��ϵǾ����ϴ�");	
					String bdate = bell_list.get(i).getBdate();
					Date Bdate = format.parse(bdate);    	 
					long Day = (Today.getTime() - Bdate.getTime()) / (24*60*60*1000);
				    bell_list.get(i).setDay(String.valueOf(Day));
				}
			}		
			//�˸�����
			int count = MypageService.getBellResult(id);		
			mv.addObject("bell_list", bell_list);
			mv.addObject("b_count", count);		
  		}
		
		 boolean result = true;

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
		//�α��� ȸ������ ��������
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
		//�α��� ȸ������ ��������
		String id = (String) session.getAttribute("session_id");
		String number = request.getParameter("number");
		
		result = RoomService.getRoomCancle(id);
		if (result) {
			result = RoomService.getRoomUpdate2(number);
		}
		
		return result;
	}

}
