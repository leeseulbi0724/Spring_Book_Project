package com.mybook.service;

import java.util.ArrayList;

import com.mybook.commons.Criteria;
import com.mybook.vo.RequestVO;

public interface RequestService {
	
	boolean getRequestWrite(RequestVO vo);
	int getRequestTotal();
	ArrayList<RequestVO> getRequestList(Criteria cri);

}
