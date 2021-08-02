package com.mybook.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mybook.dao.MypageDAO;
import com.mybook.vo.BellVO;
import com.mybook.vo.BoardVO;
import com.mybook.vo.BookVO;
import com.mybook.vo.MemberVO;
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
	
	@Override
	public boolean getProfileUpdate(MemberVO vo) {
		int val = mypageDAO.getProfileUpdate(vo);
		boolean result = false;
		if (val != 0) {
			result = true;
		}
		return result;
	}
	
	public ArrayList<BoardVO> getBoardList(String id) {
		return mypageDAO.getBoardList(id);
	}
	public ArrayList<BoardVO> getCommentList(String id) {
		return mypageDAO.getCommentList(id);
	}
	
	public ArrayList<BellVO> getBellList(String id) {
		return mypageDAO.getBellList(id);
	}
	
	public boolean getBellUpdate(String id) {
		int val = mypageDAO.getBellUpdate(id);
		boolean result = false;
		if (val != 0) {
			result = true;
		}
		return result;
	}
	
	public int getBellResult(String id) {
		return mypageDAO.getBellResult(id);
	}
	
	public boolean getBookEx(BookVO vo) {
		int val = mypageDAO.getBookEx(vo);
		boolean result = false;
		if (val!=0) {
			result = true;
		}
		return result;
	}

}
