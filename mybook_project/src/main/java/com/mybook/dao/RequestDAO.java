package com.mybook.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mybook.commons.Criteria;
import com.mybook.vo.BoardVO;
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

}
