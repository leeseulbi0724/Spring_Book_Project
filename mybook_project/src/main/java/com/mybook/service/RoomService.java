package com.mybook.service;

import java.util.ArrayList;

import com.mybook.vo.RoomVO;

public interface RoomService {
	
	boolean getRoomInsert(RoomVO vo);
	ArrayList<RoomVO> getRoomResult();
	boolean getRoomUpdate(String number);
	int getRoomCount();
	boolean getRoomUserResult(String id);
	boolean getRoomCancle(String id);
	boolean getRoomUpdate2(String number);

}
