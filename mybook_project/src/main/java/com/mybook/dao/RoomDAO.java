package com.mybook.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mybook.vo.BookVO;
import com.mybook.vo.RoomVO;

@Repository
public class RoomDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private static String namespace = "mapper.room";
	
	public int getRoomInsert(RoomVO vo) {
		return sqlSession.insert(namespace+".room_insert", vo);
	}
	
	public ArrayList<RoomVO> getRoomResult() {
		List<RoomVO> list = sqlSession.selectList(namespace+".room_list");			
		return (ArrayList<RoomVO>)list;
	}
	
	public int getRoomUpdate(String number) {
		return sqlSession.update(namespace+".room_update", number);
	}
	
	public int getRoomCount() {
		return sqlSession.selectOne(namespace+".room_count");
	}
	
	public int getRoomUserResult(String id) {
		return sqlSession.selectOne(namespace+".room_user_result", id);
	}
	
	public int getRoomCancle(String id) {
		return sqlSession.delete(namespace+".room_cancle", id);
	}
	
	public int getRoomUpdate2(String number) {
		return sqlSession.update(namespace+".room_update2", number);
	}
	
	public int getRoomDelete () {
		return sqlSession.delete(namespace+".room_delete");
	}
	
	public int getRoomDeleteResult() {
		return sqlSession.update(namespace+".room_delete_result");
	}
	
	public int getRoomNoResult(String num) {
		return sqlSession.update(namespace+".room_no_result", num);
	}
	
	public int getRoomYesResult(String num) {
		return sqlSession.update(namespace+".room_yes_result", num);
	}
	
	public int getRoomIngResult() {
		return sqlSession.selectOne(namespace+".room_ing_result");
	}

}
