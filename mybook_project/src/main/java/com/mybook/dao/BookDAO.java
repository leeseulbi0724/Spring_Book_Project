package com.mybook.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mybook.commons.Criteria;
import com.mybook.vo.BellVO;
import com.mybook.vo.BookVO;
import com.mybook.vo.MemberVO;
import com.mybook.vo.ReviewVO;

@Repository
public class BookDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private static String namespace = "mapper.book";
	
	//도서등록
	public int getBookInsert(BookVO vo) {
		return sqlSession.insert(namespace+".book_insert", vo);
	}
	
	//도서리스트 - 관리자
	public ArrayList<BookVO> getBookList(Criteria cri) {		
		List<BookVO> list = sqlSession.selectList(namespace+".book_list", cri);			
		return (ArrayList<BookVO>)list;
	}
	
	//도서 갯수
	public int getBookCount() {
		return sqlSession.selectOne(namespace+".book_count");
	}
	
	//도서 리스트 - 사용자
	public ArrayList<BookVO> getBookList() {
		List<BookVO> list = sqlSession.selectList(namespace+".book_user_list");			
		return (ArrayList<BookVO>)list;
	}
	
	//도서 상세정보
	public BookVO getBookContent(String bid) {
		return sqlSession.selectOne(namespace+".book_content", bid);
	}
	
	//도서 대여
	public int getBookRental(BookVO vo) {
		return sqlSession.insert(namespace+".book_rental", vo);
	}
	
	//음식점 전체 리스트
	public ArrayList<BookVO> getBookList(String search){		
		List<BookVO> list = sqlSession.selectList(namespace+".book_search_list", search);		
		return (ArrayList<BookVO>)list;
	}
	
	//로그인한 회원 도서대여정보
	public ArrayList<BookVO> getMemberBookList(String id) {
		List<BookVO> list = sqlSession.selectList(namespace+".member_book_list", id);			
		return (ArrayList<BookVO>)list;
	}
	
	//도서 반납
	public int getBookReturn(BookVO vo) {
		return sqlSession.delete(namespace+".book_return", vo);
	}	
	
	//도서삭제
	public int getBookDelete(String bid) {
		return sqlSession.delete(namespace+".book_delete", bid);
	}
	
	//도서 이미지 찾기
	public String getOldFile(String bid) {
		return sqlSession.selectOne(namespace+".oldfile", bid);
	}
	
	//도서 하트 +
	public int getBookHeartPlus(String bid) {
		return sqlSession.update(namespace+".book_heart_plus", bid);
	}
	
	//하트 테이블 추가
	public int getHeartPlus(BookVO vo) {
		return sqlSession.insert(namespace+".heart_plus", vo);
	}
	
	//좋아요 여부확인하기
	public int getHeartResult(BookVO vo) {
		return sqlSession.selectOne(namespace+".heart_result", vo);
	}
	
	//도서 하트 -
	public int getBookHeartMinus(String bid) {
		return sqlSession.update(namespace+".book_heart_minus", bid);
	}
	
	//하트 테이블 추가
	public int getHeartMinus(BookVO vo) {
		return sqlSession.delete(namespace+".heart_minus", vo);
	}
	
	//대여 여부 확인하기
	public int getRentalResult(BookVO vo) {
		return sqlSession.selectOne(namespace+".rental_result", vo);
	}
	
	//리뷰 업로드
	public int getReviewUpload(ReviewVO vo) {
		return sqlSession.insert(namespace+".review_upload", vo);
	}
	
	//리뷰 가져오기
	public ArrayList<ReviewVO> getReviewList(String bid) {
		List<ReviewVO> list = sqlSession.selectList(namespace+".review_list", bid);	
		return (ArrayList<ReviewVO>)list;
	}
	
	//리뷰 여부
	public int getReviewResult(BookVO vo) {
		return sqlSession.selectOne(namespace+".review_result", vo);
	}
	
	//후기 개수 가져오기
	public int getReviewCount(String bid) {
		return sqlSession.selectOne(namespace+".review_count", bid);
	}
	
	//후기 별점 합계구하기
	public int getReviewSum(String bid) {
		return sqlSession.selectOne(namespace+".review_sum", bid);
	}
	
	//파일포함 --> 업데이트
	public int getFileYesUpdate(BookVO vo) {
		return sqlSession.update(namespace+".yes_update", vo);
	}
	
	//파일미포함 --> 업데이트
	public int getFileNoUpdate(BookVO vo) {
		return sqlSession.update(namespace+".no_update", vo);
	}
	
	//로그인 회원 리뷰 가져오기
	public ReviewVO getUserReview(BookVO vo) {
		return sqlSession.selectOne(namespace+".user_review", vo);
	}
	
	//리뷰 업데이트
	public int getReviewUpdate(ReviewVO vo) {
		return sqlSession.update(namespace+".review_update", vo);
	}
	
	//리뷰 delete
	public int getReviewDelete(String rid) {
		return sqlSession.delete(namespace+".review_delete", rid);
	}
	
	//도서 대여하고 있는지 정보 가져오기
	public int getUserRentalList(BookVO vo) {
		return sqlSession.selectOne(namespace+".user_rental_list", vo);
	}
	
	//도서 --> 알림테이블 저장
	public int getBookBell(BellVO vo) {
		return sqlSession.insert(namespace+".book_bell", vo);
	}
	
	///관리자 ajax
	public ArrayList<BookVO> getBookSearchList(String search, String category) {
		Map<Object, Object> param = new HashMap<Object, Object>();
		param.put("search", search);
		param.put("category", category);
		List<BookVO> list = sqlSession.selectList(namespace+".book_search_count", param);
		return (ArrayList<BookVO>)list;
	}
	public ArrayList<BookVO> getBookSearchList(String search, String category, Criteria cri) {
		Map<Object, Object> param = new HashMap<Object, Object>();
		param.put("search", search);
		param.put("category", category);
		param.put("cri", cri);
		List<BookVO> list = sqlSession.selectList(namespace+".admin_book_search_list", param);
		return (ArrayList<BookVO>)list;
	}
	
	//해당 도서 대여중인 회원
	public ArrayList<BookVO> getBookRentalList(String bid) {
		List<BookVO> list = sqlSession.selectList(namespace+".book_rental_list", bid);
		return (ArrayList<BookVO>)list;
	}
	
	//해당 도서 대여중인 회원 카운트
	public int getBookRentalListCount(String bid) {
		return sqlSession.selectOne(namespace+".book_rental_list_count", bid);
	}
	
	///관리자 ajax -- 대여중인 회원
	public ArrayList<BookVO> getBookRentalSearchList(String search, String bid) {
		Map<Object, Object> param = new HashMap<Object, Object>();
		param.put("search", search);
		param.put("bid", bid);
		List<BookVO> list = sqlSession.selectList(namespace+".admin_book_rental_count", param);
		return (ArrayList<BookVO>)list;
	}
	public ArrayList<BookVO> getBookRentalSearchList(String search, String bid, Criteria cri) {
		Map<Object, Object> param = new HashMap<Object, Object>();
		param.put("search", search);
		param.put("cri", cri);
		param.put("bid", bid);
		List<BookVO> list = sqlSession.selectList(namespace+".admin_book_rental_list", param);
		return (ArrayList<BookVO>)list;
	}
	
	public int getRentalBell(String id, String bid) {
		Map<Object, Object> param = new HashMap<Object, Object>();
		param.put("id", id);
		param.put("bid", bid);
		return sqlSession.insert(namespace+".admin_rental_bell", param);
	}
}
