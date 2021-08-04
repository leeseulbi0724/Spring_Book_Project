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
	
	// 공지사항 글쓰기
	public int getNoticeInsert(NoticeVO vo) {
		return sqlSession.insert(namespace+".notice_insert", vo);
	}
	
	// 공지사항 리스트
	public ArrayList<NoticeVO> getNoticeList(Criteria cri) {
		List<NoticeVO> list = sqlSession.selectList(namespace+".notice_list", cri);
		
		return (ArrayList<NoticeVO>)list;
	}
	
	// 공지사항 전체갯수
	public int getCountResult() {
		return sqlSession.selectOne(namespace+".count");
	}	
	
	//공지사항 상세보기
	public NoticeVO getNoticeContent(String nid) {
		return sqlSession.selectOne(namespace+".notice_content", nid);
	}
	
	//공지사항 이미지 찾기
	public String getOldFile(String nid) {
		return sqlSession.selectOne(namespace+".oldfile", nid);
	}
	
	//파일포함 --> 업데이트
	public int getFileYesUpdate(NoticeVO vo) {
		return sqlSession.update(namespace+".yes_update", vo);
	}
	
	//파일미포함 --> 업데이트
	public int getFileNoUpdate(NoticeVO vo) {
		return sqlSession.update(namespace+".no_update", vo);
	}
	
	//공지사항 삭제하기
	public int getNoticeDelete(String nid) {
		return sqlSession.delete(namespace+".notice_delete", nid);
	}
	
	//공지사항 - 공지 부분 불러오기
	public ArrayList<NoticeVO> getSpclList() {
		List<NoticeVO> list = sqlSession.selectList(namespace+".spcl_list");
		
		return (ArrayList<NoticeVO>)list;
	}
	
	// 공지사항 - 일반 부분불러오기 
	public ArrayList<NoticeVO> getNormalList(Criteria cri) {
		List<NoticeVO> list = sqlSession.selectList(namespace+".normal_list", cri);
		
		return (ArrayList<NoticeVO>)list;
	}
	
	// 공지사항 일반 전체갯수
	public int getNormalCountResult() {
		return sqlSession.selectOne(namespace+".normal_count");
	}	
	
	//공지사항 조회수
	public int getNoticeHit(String nid) {
		return sqlSession.update(namespace+".notice_hit", nid);
	}
	
	//공지사항 이전글 -- 일반
	public NoticeVO getPrevNoticeNormal(String rno) {
		return sqlSession.selectOne(namespace+".notice_prev_normal", rno);
	}
	
	//공지사항 다음글 -- 일반
	public NoticeVO getNextNoticeNormal(String rno) {
		return sqlSession.selectOne(namespace+".notice_next_normal", rno);
	}
	
	//공지사항 이전글 -- 공지
	public NoticeVO getPrevNoticeSpcl(String rno) {
		return sqlSession.selectOne(namespace+".notice_prev_spcl", rno);
	}
	
	//공지사항 다음글 -- 일반
	public NoticeVO getNextNoticeSpcl(String rno) {
		return sqlSession.selectOne(namespace+".notice_next_spcl", rno);
	}
	
	/*
	 * //공지사항 ajax public ArrayList<NoticeVO> getNoticeSearchList(String search) {
	 * List<NoticeVO> list = sqlSession.selectList(namespace+".notice_search_list",
	 * search); return (ArrayList)list; }
	 */
	
	///관리자 ajax
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
