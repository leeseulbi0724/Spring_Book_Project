package com.mybook.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mybook.commons.Criteria;
import com.mybook.vo.BoardVO;
import com.mybook.vo.NoticeVO;

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

}
