package com.mybook.service;

import java.util.ArrayList;

import com.mybook.commons.Criteria;
import com.mybook.vo.BellVO;
import com.mybook.vo.BookVO;
import com.mybook.vo.NoticeVO;
import com.mybook.vo.ReviewVO;

public interface BookService {
	
	boolean getBookInsert(BookVO vo);
	ArrayList<BookVO> getBookList(Criteria cri);
	int getBookCount();
	ArrayList<BookVO> getBookList();
	BookVO getBookContent(String bid);
	boolean getBookRental(BookVO vo);
	ArrayList<BookVO> getMemberBookList(String id);
	boolean getBookReturn(BookVO vo);
	boolean getBookDelete(String bid);
	String getOldFile(String bid);
	boolean getBookHeartPlus(String bid);
	boolean getHeartPlus(BookVO vo);
	boolean getHeartResult(BookVO vo);
	boolean getBookHeartMinus(String bid);
	boolean getHeartMinus(BookVO vo);
	boolean getRentalResult(BookVO vo);
	boolean getReviewUpload(ReviewVO vo);
	ArrayList<ReviewVO> getReivewList(String bid);
	boolean getReviewResult(BookVO vo);
	int getReviewCount(String bid);
	int getReviewSum(String bid);
	boolean getFileYesUpdate(BookVO vo);
	boolean getFileNoUpdate(BookVO vo);
	ArrayList<BookVO> getBookList(String search);
	ReviewVO getUserReview(BookVO vo);
	boolean getReviewUpdate(ReviewVO vo);
	boolean getReviewDelete(String rid);
	int getUserRentalList(BookVO vo);
	boolean getBookBell(BellVO vo);
	ArrayList<BookVO> getBookSearchList(String search, String category);
	ArrayList<BookVO> getBookSearchList(String search, String category, Criteria cri);
	ArrayList<BookVO> getBookRentalList(String bid);
	int getBookRentalListCount(String bid);
	ArrayList<BookVO> getBookRentalSearchList(String search, String bid, Criteria cri);
	ArrayList<BookVO> getBookRentalSearchList(String search, String bid);
	boolean getRentalBell(String id, String bid);
	ArrayList<BookVO> getBookBest();

}
