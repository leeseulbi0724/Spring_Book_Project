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
	
	//�������
	public int getBookInsert(BookVO vo) {
		return sqlSession.insert(namespace+".book_insert", vo);
	}
	
	//��������Ʈ - ������
	public ArrayList<BookVO> getBookList(Criteria cri) {		
		List<BookVO> list = sqlSession.selectList(namespace+".book_list", cri);			
		return (ArrayList<BookVO>)list;
	}
	
	//���� ����
	public int getBookCount() {
		return sqlSession.selectOne(namespace+".book_count");
	}
	
	//���� ����Ʈ - �����
	public ArrayList<BookVO> getBookList() {
		List<BookVO> list = sqlSession.selectList(namespace+".book_user_list");			
		return (ArrayList<BookVO>)list;
	}
	
	//���� ������
	public BookVO getBookContent(String bid) {
		return sqlSession.selectOne(namespace+".book_content", bid);
	}
	
	//���� �뿩
	public int getBookRental(BookVO vo) {
		return sqlSession.insert(namespace+".book_rental", vo);
	}
	
	//������ ��ü ����Ʈ
	public ArrayList<BookVO> getBookList(String search){		
		List<BookVO> list = sqlSession.selectList(namespace+".book_search_list", search);		
		return (ArrayList<BookVO>)list;
	}
	
	//�α����� ȸ�� �����뿩����
	public ArrayList<BookVO> getMemberBookList(String id) {
		List<BookVO> list = sqlSession.selectList(namespace+".member_book_list", id);			
		return (ArrayList<BookVO>)list;
	}
	
	//���� �ݳ�
	public int getBookReturn(BookVO vo) {
		return sqlSession.delete(namespace+".book_return", vo);
	}	
	
	//��������
	public int getBookDelete(String bid) {
		return sqlSession.delete(namespace+".book_delete", bid);
	}
	
	//���� �̹��� ã��
	public String getOldFile(String bid) {
		return sqlSession.selectOne(namespace+".oldfile", bid);
	}
	
	//���� ��Ʈ +
	public int getBookHeartPlus(String bid) {
		return sqlSession.update(namespace+".book_heart_plus", bid);
	}
	
	//��Ʈ ���̺� �߰�
	public int getHeartPlus(BookVO vo) {
		return sqlSession.insert(namespace+".heart_plus", vo);
	}
	
	//���ƿ� ����Ȯ���ϱ�
	public int getHeartResult(BookVO vo) {
		return sqlSession.selectOne(namespace+".heart_result", vo);
	}
	
	//���� ��Ʈ -
	public int getBookHeartMinus(String bid) {
		return sqlSession.update(namespace+".book_heart_minus", bid);
	}
	
	//��Ʈ ���̺� �߰�
	public int getHeartMinus(BookVO vo) {
		return sqlSession.delete(namespace+".heart_minus", vo);
	}
	
	//�뿩 ���� Ȯ���ϱ�
	public int getRentalResult(BookVO vo) {
		return sqlSession.selectOne(namespace+".rental_result", vo);
	}
	
	//���� ���ε�
	public int getReviewUpload(ReviewVO vo) {
		return sqlSession.insert(namespace+".review_upload", vo);
	}
	
	//���� ��������
	public ArrayList<ReviewVO> getReviewList(String bid) {
		List<ReviewVO> list = sqlSession.selectList(namespace+".review_list", bid);	
		return (ArrayList<ReviewVO>)list;
	}
	
	//���� ����
	public int getReviewResult(BookVO vo) {
		return sqlSession.selectOne(namespace+".review_result", vo);
	}
	
	//�ı� ���� ��������
	public int getReviewCount(String bid) {
		return sqlSession.selectOne(namespace+".review_count", bid);
	}
	
	//�ı� ���� �հ豸�ϱ�
	public int getReviewSum(String bid) {
		return sqlSession.selectOne(namespace+".review_sum", bid);
	}
	
	//�������� --> ������Ʈ
	public int getFileYesUpdate(BookVO vo) {
		return sqlSession.update(namespace+".yes_update", vo);
	}
	
	//���Ϲ����� --> ������Ʈ
	public int getFileNoUpdate(BookVO vo) {
		return sqlSession.update(namespace+".no_update", vo);
	}
	
	//�α��� ȸ�� ���� ��������
	public ReviewVO getUserReview(BookVO vo) {
		return sqlSession.selectOne(namespace+".user_review", vo);
	}
	
	//���� ������Ʈ
	public int getReviewUpdate(ReviewVO vo) {
		return sqlSession.update(namespace+".review_update", vo);
	}
	
	//���� delete
	public int getReviewDelete(String rid) {
		return sqlSession.delete(namespace+".review_delete", rid);
	}
	
	//���� �뿩�ϰ� �ִ��� ���� ��������
	public int getUserRentalList(BookVO vo) {
		return sqlSession.selectOne(namespace+".user_rental_list", vo);
	}
	
	//���� --> �˸����̺� ����
	public int getBookBell(BellVO vo) {
		return sqlSession.insert(namespace+".book_bell", vo);
	}
	
	///������ ajax
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
	
	//�ش� ���� �뿩���� ȸ��
	public ArrayList<BookVO> getBookRentalList(String bid) {
		List<BookVO> list = sqlSession.selectList(namespace+".book_rental_list", bid);
		return (ArrayList<BookVO>)list;
	}
	
	//�ش� ���� �뿩���� ȸ�� ī��Ʈ
	public int getBookRentalListCount(String bid) {
		return sqlSession.selectOne(namespace+".book_rental_list_count", bid);
	}
	
	///������ ajax -- �뿩���� ȸ��
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
