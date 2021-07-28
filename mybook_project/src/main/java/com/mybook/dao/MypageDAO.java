package com.mybook.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mybook.vo.BookVO;
import com.mybook.vo.ReviewVO;

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

}
