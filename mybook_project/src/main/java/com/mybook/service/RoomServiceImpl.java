package com.mybook.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mybook.dao.RoomDAO;
import com.mybook.vo.RoomVO;

@Service("RoomService")
public class RoomServiceImpl implements RoomService {
	
	@Autowired
	private RoomDAO roomDAO;
	
	public boolean getRoomInsert(RoomVO vo) {
		boolean result = false;
		int val = roomDAO.getRoomInsert(vo);
		if (val!=0) {
			result = true;
		}
		return result;
	}
	
	public ArrayList<RoomVO> getRoomResult() {
		return roomDAO.getRoomResult();
	}
	
	public boolean getRoomUpdate(String number) {
		boolean result = false;
		int val = roomDAO.getRoomUpdate(number);
		if (val!=0) {
			result = true;
		}
		return result;
	}
	
	public int getRoomCount() {
		return roomDAO.getRoomCount();
	}
	
	public boolean getRoomUserResult(String id) {
		boolean result = false;
		int val = roomDAO.getRoomUserResult(id);
		if (val==0) {
			result = true;
		}
		return result;
	}
	
	public boolean getRoomCancle(String id) {
		boolean result = false;
		int val = roomDAO.getRoomCancle(id);
		if (val!=0) {
			result = true;
		}
		return result;
	}
	
	public boolean getRoomUpdate2(String number) {
		boolean result = false;
		int val = roomDAO.getRoomUpdate2(number);
		if (val!=0) {
			result = true;
		}
		return result;
	}
	
	public boolean getRoomDelete () {
		int val = roomDAO.getRoomDelete();
		boolean result = false;
		if (val!=0) {
			result = true;
		}
		return result;
	}
	
	public boolean getRoomResetResult() {
		int val = roomDAO.getRoomResetResult();
		boolean result = false;
		if (val!=0) {
			result = true;
		}
		return result;
	}
	
	public boolean getRoomNoResult(String num) {
		int val = roomDAO.getRoomNoResult(num);
		boolean result = false;
		if (val!=0) {
			result = true;
		}
		return result;
	}
	
	public boolean getRoomYesResult(String num) {
		int val = roomDAO.getRoomYesResult(num);
		boolean result = false;
		if (val!=0) {
			result = true;
		}
		return result;
	}
	
	public boolean getRoomIngResult() {
		int val = roomDAO.getRoomIngResult();
		boolean result = false;
		if (val==0) {
			result = true;
		}
		return result;
	}
	
	public boolean getUserRoomIng(RoomVO vo) {
		int val = roomDAO.getUserRoomIng(vo);
		boolean result = false;
		if (val!=0) {
			result = true;
		}
		return result;
	}

}
