package com.mybook.service;

import java.util.ArrayList;

import com.mybook.vo.BellVO;
import com.mybook.vo.BoardVO;
import com.mybook.vo.BookVO;
import com.mybook.vo.MemberVO;
import com.mybook.vo.ReviewVO;
import com.mybook.vo.RoomVO;

public interface MypageService {
	
	ArrayList<BookVO> getHeartList(String id);
	ArrayList<ReviewVO> getReviewList(String id);
	RoomVO getRoomResult(String id);
	boolean getProfileUpdate(MemberVO vo);
	ArrayList<BoardVO> getBoardList(String id);
	ArrayList<BoardVO> getCommentList(String id);
	ArrayList<BellVO> getBellList(String id);
	boolean getBellUpdate(String id);
	int getBellResult(String id);
}
