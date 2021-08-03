package com.mybook.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mybook.dao.OnlineDAO;
import com.mybook.vo.OnlineVO;

@Service("OnlineService")
public class OnlineServiceImpl implements OnlineService {
	
	@Autowired
	private OnlineDAO onlineDAO;
	
	public boolean getOnlineWrite(OnlineVO vo) {
		int val = onlineDAO.getOnlineWrite(vo);
		boolean result = false;
		if (val!=0) {
			result = true;
		}
		return result;
	}
	
	

}
