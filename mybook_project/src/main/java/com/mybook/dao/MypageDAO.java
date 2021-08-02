package com.mybook.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mybook.vo.BellVO;
import com.mybook.vo.BoardVO;
import com.mybook.vo.BookVO;
import com.mybook.vo.MemberVO;
import com.mybook.vo.ReviewVO;
import com.mybook.vo.RoomVO;

@Repository
public class MypageDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private static String namespace = "mapper.mypage";
	
	public ArrayList<BookVO> getHeartList(String id) {
		List<BookVO> list = sqlSession.selectList(namespace+".heart_list", id);		
		return (ArrayList<BookVO>)list;
	}
	
	public ArrayList<ReviewVO> getReviewList(String id) {
		List<ReviewVO> list = sqlSession.selectList(namespace+".review_list", id);		
		return (ArrayList<ReviewVO>)list;
	}
	
	public RoomVO getRoomResult(String id) {
		return sqlSession.selectOne(namespace+".room_result", id);
	}
	
	public int getProfileUpdate(MemberVO vo) {
		return sqlSession.update(namespace+".profile_update", vo);
	}
	
	public ArrayList<BoardVO> getBoardList(String id) {
		List<BoardVO> list = sqlSession.selectList(namespace+".board_list", id);		
		return (ArrayList<BoardVO>)list;
	}
	
	public ArrayList<BoardVO> getCommentList(String id) {
		List<BoardVO> list = sqlSession.selectList(namespace+".comment_list", id);		
		return (ArrayList<BoardVO>)list;
	}
	
	public ArrayList<BellVO> getBellList(String id) {
		List<BellVO> list = sqlSession.selectList(namespace+".bell_list", id);		
		return (ArrayList<BellVO>)list;
	}
	
	public int getBellUpdate(String id) {
		return sqlSession.update(namespace+".bell_update", id);
	}
	
	public int getBellResult(String id) {
		return sqlSession.selectOne(namespace+".bell_result", id);
	}
	
	public int getBookEx(BookVO vo) {
		return sqlSession.update(namespace+".book_ex", vo);
	}

}
