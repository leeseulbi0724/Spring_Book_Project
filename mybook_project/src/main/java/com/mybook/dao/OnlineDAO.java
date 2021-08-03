package com.mybook.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mybook.vo.OnlineVO;

@Repository
public class OnlineDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private static String namespace = "mapper.online";
	
	public int getOnlineWrite(OnlineVO vo) {
		return sqlSession.insert(namespace+".online_write", vo);
	}

}
