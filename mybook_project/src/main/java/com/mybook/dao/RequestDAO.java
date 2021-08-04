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
import com.mybook.vo.RequestVO;

@Repository
public class RequestDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private static String namespace = "mapper.request";
	
	public int getRequestWrite(RequestVO vo) {
		return sqlSession.insert(namespace+".request_write", vo);
	}
	
	public int getRequestTotal() {
		return sqlSession.selectOne(namespace+".request_total");
	}
	
	public ArrayList<RequestVO> getRequestList(Criteria cri) {
		List<RequestVO> list = sqlSession.selectList(namespace+".request_list", cri);		
		return (ArrayList<RequestVO>)list;
	}
	
	public RequestVO getRequestContent(String rid) {
		return sqlSession.selectOne(namespace+".request_content", rid);
	}
	
	public int getRequestStatus(String rid) {
		return sqlSession.update(namespace+".request_status", rid);
	}
	
	///관리자 ajax
	public ArrayList<RequestVO> getRequestSearchList(String search) {
		List<RequestVO> list = sqlSession.selectList(namespace+".request_search_count", search);
		return (ArrayList<RequestVO>)list;
	}
	public ArrayList<RequestVO> getRequestSearchList(String search, Criteria cri) {
		Map<Object, Object> param = new HashMap<Object, Object>();
		param.put("search", search);
		param.put("cri", cri);
		List<RequestVO> list = sqlSession.selectList(namespace+".request_search_list", param);
		return (ArrayList<RequestVO>)list;
	}
	
	//등록 후 알림메세지
	public int getRequestBell(RequestVO vo) {
		return sqlSession.insert(namespace+".request_bell", vo);
	}
	
	public String getRequestNameResult(String name) {
		return sqlSession.selectOne(namespace+".request_name", name);
	}

}
