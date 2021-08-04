package com.mybook.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mybook.commons.Criteria;
import com.mybook.vo.BoardVO;
import com.mybook.vo.BookVO;
import com.mybook.vo.NoticeVO;
import com.mybook.vo.RequestVO;

@Repository
public class BoardDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private static String namespace = "mapper.board";
	
	// 자유게시판 글쓰기
	public int getBoardWrite(BoardVO vo) {
		return sqlSession.insert(namespace+".board_write", vo);
	}
	
	// 자유게시판 리스트
	public ArrayList<BoardVO> getBoardList(Criteria cri) {
		List<BoardVO> list = sqlSession.selectList(namespace+".board_list", cri);		
		return (ArrayList<BoardVO>)list;
	}
	
	// 자유게시판 전체갯수
	public int getBoardCount() {
		return sqlSession.selectOne(namespace+".board_count");
	}	
	
	//이름 가져오기
	public String getBoardName(String id) {
		return sqlSession.selectOne(namespace+".board_name", id);
	}
	
	//게시판 상세보기
	public BoardVO getBoardContent(String bid) {
		return sqlSession.selectOne(namespace+".board_content", bid);
	}
	
	//게시판 조회수 올리기
	public int getBoardHit(String bid) {
		return sqlSession.update(namespace+".board_hit", bid);
	}
	
	//댓글 쓰기
	public int getBoardComment(BoardVO vo) {
		return sqlSession.insert(namespace+".board_comment", vo);
	}
	
	//댓글 내용가져오기
	public ArrayList<BoardVO> getBoardCommentContent(String bid) {
		List<BoardVO> list = sqlSession.selectList(namespace+".board_comment_content", bid);
		return (ArrayList<BoardVO>)list;
	}
	
	//프로필 이미지
	public String getProfileImage(String id) {
		return sqlSession.selectOne(namespace+".profile_image", id);
	}
	
	//댓글 갯수가져오기
	public int getCommentCount(String bid) {
		return sqlSession.selectOne(namespace+".comment_count", bid);
	}
	
	//게시판 수정하기
	public int getBoardUpdate(BoardVO vo) {
		return sqlSession.update(namespace+".board_update", vo);
	}
	
	//게시판 삭제
	public int getBoardDelete(String bid) {
		return sqlSession.delete(namespace+".board_delete", bid);
	}
	
	//게시판 댓글 삭제
	public int getBoardCommentDelete(String cid) {
		return sqlSession.delete(namespace+".board_comment_delete", cid);
	}
	
	//알림 테이블 등록
	public int getCommentBell(BoardVO vo) {
		return sqlSession.insert(namespace+".comment_bell", vo);
	}
	
	//댓글 내용 가져오기
	public BoardVO getCommentContent(String cid) {
		return sqlSession.selectOne(namespace+".comment_content", cid);
	}
	
	//댓글 수정하기
	public int getCommentUpdate(BoardVO vo) {
		return sqlSession.update(namespace+".comment_update", vo);
	}
	
	/*
	 * //ajax public ArrayList<BoardVO> getBoardSearchList(String search, String
	 * category) { Map<String, String> param = new HashMap<String, String>();
	 * param.put("search", search); param.put("category", category); List<BoardVO>
	 * list = sqlSession.selectList(namespace+".board_search_list", param); return
	 * (ArrayList<BoardVO>)list; }
	 */
	
	///관리자 ajax
	public ArrayList<BoardVO> getBoardSearchList(String search, String category) {
		Map<Object, Object> param = new HashMap<Object, Object>();
		param.put("search", search);
		param.put("category", category);
		List<BoardVO> list = sqlSession.selectList(namespace+".board_search_count", param);
		return (ArrayList<BoardVO>)list;
	}
	public ArrayList<BoardVO> getBoardSearchList(String search, String category, Criteria cri) {
		Map<Object, Object> param = new HashMap<Object, Object>();
		param.put("search", search);
		param.put("category", category);
		param.put("cri", cri);
		List<BoardVO> list = sqlSession.selectList(namespace+".board_search_list", param);
		return (ArrayList<BoardVO>)list;
	}
}
