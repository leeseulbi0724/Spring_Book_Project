package com.mybook.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mybook.dao.MypageDAO;
import com.mybook.vo.BookVO;
import com.mybook.vo.ReviewVO;
import com.mybook.vo.RoomVO;

@Service("MypageService")
public class MypageServiceImpl implements MypageService {
	
	@Autowired
	private MypageDAO mypageDAO;
	
	@Override
	public ArrayList<BookVO> getHeartList(String id) {
		return mypageDAO.getHeartList(id);
	}
	
	@Override
	public ArrayList<ReviewVO> getReviewList(String id) {
		return mypageDAO.getReviewList(id);
	}
	
	@Override
	public  RoomVO getRoomResult(String id) {
		return mypageDAO.getRoomResult(id);
	}

}
