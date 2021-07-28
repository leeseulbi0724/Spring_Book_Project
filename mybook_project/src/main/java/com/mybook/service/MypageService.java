package com.mybook.service;

import java.util.ArrayList;

import com.mybook.vo.BookVO;
import com.mybook.vo.ReviewVO;

public interface MypageService {
	
	ArrayList<BookVO> getHeartList(String id);
	ArrayList<ReviewVO> getReviewList(String id);
}
