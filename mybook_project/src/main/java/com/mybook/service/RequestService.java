package com.mybook.service;

import java.util.ArrayList;

import com.mybook.commons.Criteria;
import com.mybook.vo.RequestVO;

public interface RequestService {
	
	boolean getRequestWrite(RequestVO vo);
	int getRequestTotal();
	ArrayList<RequestVO> getRequestList(Criteria cri);
	RequestVO getRequestContent(String rid);
	boolean getRequestStatus(String rid);
	ArrayList<RequestVO> getRequestSearchList(String search);
	ArrayList<RequestVO> getRequestSearchList(String search, Criteria cri);
	boolean getRequestBell(RequestVO vo);
	String getRequestNameResult(String name);
	boolean getRequestUpdate(RequestVO vo);
	boolean getRequestDelete(String rid);

}
