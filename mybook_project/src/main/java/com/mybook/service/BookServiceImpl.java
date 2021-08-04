package com.mybook.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mybook.commons.Criteria;
import com.mybook.dao.BookDAO;
import com.mybook.vo.BellVO;
import com.mybook.vo.BookVO;
import com.mybook.vo.ReviewVO;

@Service("BookService")
public class BookServiceImpl implements BookService {
	
	@Autowired
	private BookDAO bookDAO;
	
	@Override
	public boolean getBookInsert(BookVO vo) {
		int val = bookDAO.getBookInsert(vo);
		boolean result = false;
		if ( val!= 0) {
			result = true;
		}
		return result;
	}
	
	@Override
	public ArrayList<BookVO> getBookList(Criteria cri) {
		return bookDAO.getBookList(cri);
	}
	
	@Override
	public int getBookCount() {
		return bookDAO.getBookCount();
	}
	
	@Override
	public ArrayList<BookVO> getBookList()  {
		return bookDAO.getBookList();
	}
	
	@Override
	public  BookVO getBookContent(String bid) {
		return bookDAO.getBookContent(bid);
	}
	
	@Override
	public boolean getBookRental(BookVO vo) {
		int val = bookDAO.getBookRental(vo);
		boolean result = false;
		if (val!=0) {
			result = true;
		}
		return result;
	}
	
	@Override
	public ArrayList<BookVO> getMemberBookList(String id) {
		return bookDAO.getMemberBookList(id);
	}
	
	@Override
	public boolean getBookReturn(BookVO vo) {
		int val = bookDAO.getBookReturn(vo);
		boolean result = false;
		if (val!=0) {
			result = true;
		}
		return result;
	}
	
	@Override
	public boolean getBookDelete(String bid) {
		int val = bookDAO.getBookDelete(bid);
		boolean result = false;
		if (val!=0) {
			result = true;
		}
		return result;
	}
	
	@Override
	public String getOldFile(String bid) {
		return bookDAO.getOldFile(bid);
	}
	
	@Override
	public boolean getBookHeartPlus(String bid) {
		int val = bookDAO.getBookHeartPlus(bid);
		boolean result = false;
		if(val!=0) {
			result = true;
		}
		return result;
	}
	
	@Override
	public boolean getHeartPlus(BookVO vo) {
		int val = bookDAO.getHeartPlus(vo);
		boolean result = false;
		if(val!=0) {
			result = true;
		}
		return result;
	}
	
	@Override
	public boolean getHeartResult(BookVO vo) {
		int val = bookDAO.getHeartResult(vo);
		boolean result = false;
		if(val!=0) {
			result = true;
		}
		return result;
	}
	
	@Override
	public boolean getBookHeartMinus(String bid) {
		int val = bookDAO.getBookHeartMinus(bid);
		boolean result = false;
		if(val!=0) {
			result = true;
		}
		return result;
	}
	
	@Override
	public boolean getHeartMinus(BookVO vo) {
		int val = bookDAO.getHeartMinus(vo);
		boolean result = false;
		if(val!=0) {
			result = true;
		}
		return result;
	}
	
	@Override
	public boolean getRentalResult(BookVO vo) {
		int val = bookDAO.getRentalResult(vo);
		boolean result = false;
		if(val!=0) {
			result = true;
		}
		return result;
	}
	
	@Override
	public boolean getReviewUpload(ReviewVO vo) {
		int val = bookDAO.getReviewUpload(vo);
		boolean result = false;
		if(val!=0) {
			result = true;
		}
		return result;
	}
	
	@Override
	public ArrayList<ReviewVO> getReivewList(String bid) {
		return bookDAO.getReviewList(bid);
	}
	
	@Override
	public boolean getReviewResult(BookVO vo) {
		int val = bookDAO.getReviewResult(vo);
		boolean result = false;
		if(val==0) {
			result = true;
		}
		return result;
		
	}
	
	@Override
	public  int getReviewCount(String bid) {
		return bookDAO.getReviewCount(bid);
	}
	
	@Override
	public  int getReviewSum(String bid) {
		return bookDAO.getReviewSum(bid);
	}
	
	@Override
	public boolean getFileYesUpdate(BookVO vo) {
		int val = bookDAO.getFileYesUpdate(vo);
		boolean result = false;
		if(val != 0) {
			result = true;
		}
		return result;
	}
	
	@Override
	public boolean getFileNoUpdate(BookVO vo) {
		int val = bookDAO.getFileNoUpdate(vo);
		boolean result = false;
		if(val==0) {
			result = true;
		}
		return result;
		
	}
	
	@Override
	public ArrayList<BookVO> getBookList(String search) {
		return bookDAO.getBookList(search);
	}
	
	@Override
	public ReviewVO getUserReview(BookVO vo) {
		return bookDAO.getUserReview(vo);
	}
	
	@Override
	public boolean getReviewUpdate(ReviewVO vo) {
		int val = bookDAO.getReviewUpdate(vo);
		boolean result = false;
		if(val!=0) {
			result = true;
		}
		return result;
	}
	
	@Override
	public boolean getReviewDelete(String rid) {
		int val = bookDAO.getReviewDelete(rid);
		boolean result = false;
		if(val!=0) {
			result = true;
		}
		return result;
	}
	
	public int getUserRentalList(BookVO vo) {
		return bookDAO.getUserRentalList(vo);
	}
	
	public boolean getBookBell(BellVO vo) {
		int val = bookDAO.getBookBell(vo);
		boolean result = false;
		if(val!=0) {
			result = true;
		}
		return result;
	}
	
	public ArrayList<BookVO> getBookSearchList(String search, String category) {
		return bookDAO.getBookSearchList(search, category);
	}
	
	public ArrayList<BookVO> getBookSearchList(String search, String category, Criteria cri) {
		return bookDAO.getBookSearchList(search, category, cri);
	}

}
