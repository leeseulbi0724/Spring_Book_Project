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
	
	// �����Խ��� �۾���
	public int getBoardWrite(BoardVO vo) {
		return sqlSession.insert(namespace+".board_write", vo);
	}
	
	// �����Խ��� ����Ʈ
	public ArrayList<BoardVO> getBoardList(Criteria cri) {
		List<BoardVO> list = sqlSession.selectList(namespace+".board_list", cri);		
		return (ArrayList<BoardVO>)list;
	}
	
	// �����Խ��� ��ü����
	public int getBoardCount() {
		return sqlSession.selectOne(namespace+".board_count");
	}	
	
	//�̸� ��������
	public String getBoardName(String id) {
		return sqlSession.selectOne(namespace+".board_name", id);
	}
	
	//�Խ��� �󼼺���
	public BoardVO getBoardContent(String bid) {
		return sqlSession.selectOne(namespace+".board_content", bid);
	}
	
	//�Խ��� ��ȸ�� �ø���
	public int getBoardHit(String bid) {
		return sqlSession.update(namespace+".board_hit", bid);
	}
	
	//��� ����
	public int getBoardComment(BoardVO vo) {
		return sqlSession.insert(namespace+".board_comment", vo);
	}
	
	//��� ���밡������
	public ArrayList<BoardVO> getBoardCommentContent(String bid) {
		List<BoardVO> list = sqlSession.selectList(namespace+".board_comment_content", bid);
		return (ArrayList<BoardVO>)list;
	}
	
	//������ �̹���
	public String getProfileImage(String id) {
		return sqlSession.selectOne(namespace+".profile_image", id);
	}

}
