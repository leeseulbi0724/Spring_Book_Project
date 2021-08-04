package com.mybook.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mybook.commons.Criteria;
import com.mybook.vo.MemberVO;
import com.mybook.vo.NoticeVO;
import com.mybook.vo.RequestVO;

@Repository
public class NoticeDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private static String namespace = "mapper.notice";
	
	// �������� �۾���
	public int getNoticeInsert(NoticeVO vo) {
		return sqlSession.insert(namespace+".notice_insert", vo);
	}
	
	// �������� ����Ʈ
	public ArrayList<NoticeVO> getNoticeList(Criteria cri) {
		List<NoticeVO> list = sqlSession.selectList(namespace+".notice_list", cri);
		
		return (ArrayList<NoticeVO>)list;
	}
	
	// �������� ��ü����
	public int getCountResult() {
		return sqlSession.selectOne(namespace+".count");
	}	
	
	//�������� �󼼺���
	public NoticeVO getNoticeContent(String nid) {
		return sqlSession.selectOne(namespace+".notice_content", nid);
	}
	
	//�������� �̹��� ã��
	public String getOldFile(String nid) {
		return sqlSession.selectOne(namespace+".oldfile", nid);
	}
	
	//�������� --> ������Ʈ
	public int getFileYesUpdate(NoticeVO vo) {
		return sqlSession.update(namespace+".yes_update", vo);
	}
	
	//���Ϲ����� --> ������Ʈ
	public int getFileNoUpdate(NoticeVO vo) {
		return sqlSession.update(namespace+".no_update", vo);
	}
	
	//�������� �����ϱ�
	public int getNoticeDelete(String nid) {
		return sqlSession.delete(namespace+".notice_delete", nid);
	}
	
	//�������� - ���� �κ� �ҷ�����
	public ArrayList<NoticeVO> getSpclList() {
		List<NoticeVO> list = sqlSession.selectList(namespace+".spcl_list");
		
		return (ArrayList<NoticeVO>)list;
	}
	
	// �������� - �Ϲ� �κкҷ����� 
	public ArrayList<NoticeVO> getNormalList(Criteria cri) {
		List<NoticeVO> list = sqlSession.selectList(namespace+".normal_list", cri);
		
		return (ArrayList<NoticeVO>)list;
	}
	
	// �������� �Ϲ� ��ü����
	public int getNormalCountResult() {
		return sqlSession.selectOne(namespace+".normal_count");
	}	
	
	//�������� ��ȸ��
	public int getNoticeHit(String nid) {
		return sqlSession.update(namespace+".notice_hit", nid);
	}
	
	//�������� ������ -- �Ϲ�
	public NoticeVO getPrevNoticeNormal(String rno) {
		return sqlSession.selectOne(namespace+".notice_prev_normal", rno);
	}
	
	//�������� ������ -- �Ϲ�
	public NoticeVO getNextNoticeNormal(String rno) {
		return sqlSession.selectOne(namespace+".notice_next_normal", rno);
	}
	
	//�������� ������ -- ����
	public NoticeVO getPrevNoticeSpcl(String rno) {
		return sqlSession.selectOne(namespace+".notice_prev_spcl", rno);
	}
	
	//�������� ������ -- �Ϲ�
	public NoticeVO getNextNoticeSpcl(String rno) {
		return sqlSession.selectOne(namespace+".notice_next_spcl", rno);
	}
	
	/*
	 * //�������� ajax public ArrayList<NoticeVO> getNoticeSearchList(String search) {
	 * List<NoticeVO> list = sqlSession.selectList(namespace+".notice_search_list",
	 * search); return (ArrayList)list; }
	 */
	
	///������ ajax
	public ArrayList<NoticeVO> getNoticeSearchList(String search) {
		List<NoticeVO> list = sqlSession.selectList(namespace+".notice_search_count", search);
		return (ArrayList<NoticeVO>)list;
	}
	public ArrayList<NoticeVO> getNoticeSearchList(String search, Criteria cri) {
		Map<Object, Object> param = new HashMap<Object, Object>();
		param.put("search", search);
		param.put("cri", cri);
		List<NoticeVO> list = sqlSession.selectList(namespace+".notice_search_list", param);
		return (ArrayList<NoticeVO>)list;
	}

}
