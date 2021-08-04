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
	
	//��� ������������
	public int getCommentCount(String bid) {
		return sqlSession.selectOne(namespace+".comment_count", bid);
	}
	
	//�Խ��� �����ϱ�
	public int getBoardUpdate(BoardVO vo) {
		return sqlSession.update(namespace+".board_update", vo);
	}
	
	//�Խ��� ����
	public int getBoardDelete(String bid) {
		return sqlSession.delete(namespace+".board_delete", bid);
	}
	
	//�Խ��� ��� ����
	public int getBoardCommentDelete(String cid) {
		return sqlSession.delete(namespace+".board_comment_delete", cid);
	}
	
	//�˸� ���̺� ���
	public int getCommentBell(BoardVO vo) {
		return sqlSession.insert(namespace+".comment_bell", vo);
	}
	
	//��� ���� ��������
	public BoardVO getCommentContent(String cid) {
		return sqlSession.selectOne(namespace+".comment_content", cid);
	}
	
	//��� �����ϱ�
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
	
	///������ ajax
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
