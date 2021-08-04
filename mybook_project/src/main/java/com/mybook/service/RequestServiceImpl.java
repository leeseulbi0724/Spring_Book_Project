package com.mybook.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mybook.commons.Criteria;
import com.mybook.dao.RequestDAO;
import com.mybook.vo.RequestVO;

@Service("RequestService")
public class RequestServiceImpl implements RequestService {
	
	@Autowired
	private RequestDAO requestDAO;
	
	public boolean getRequestWrite(RequestVO vo) {
		int val = requestDAO.getRequestWrite(vo);
		boolean result = false;
		if (val!=0) {
			result = true;
		}
		return result;
	}
	
	public int getRequestTotal() {
		return requestDAO.getRequestTotal();
	}
	
	public ArrayList<RequestVO> getRequestList(Criteria cri) {
		return requestDAO.getRequestList(cri);
	}
	
	public RequestVO getRequestContent(String rid) {
		return requestDAO.getRequestContent(rid);
	}
	
	public boolean getRequestStatus(String rid) {
		int val= requestDAO.getRequestStatus(rid);
		boolean result = false;
		if (val!=0) {
			result = true;
		}
		return result;
	}
	
	public ArrayList<RequestVO> getRequestSearchList(String search) {
		return requestDAO.getRequestSearchList(search);
	}
	public ArrayList<RequestVO> getRequestSearchList(String search, Criteria cri) {
		return requestDAO.getRequestSearchList(search, cri);
	}

}
