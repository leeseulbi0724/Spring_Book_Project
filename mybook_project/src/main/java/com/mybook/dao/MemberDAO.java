package com.mybook.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mybook.commons.Criteria;
import com.mybook.vo.MemberVO;
import com.mybook.vo.SessionVO;

@Repository
public class MemberDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private static String namespace = "mapper.member";
	
	/** 회원가입 **/
	public int getJoinResult(MemberVO vo) {
		return sqlSession.insert(namespace+".join", vo);
	}
	
	/** 로그인 **/
	public int getLoginResult(MemberVO vo) {
		return sqlSession.selectOne(namespace+".login", vo);
		
	}
	
	/** 아이디 찾기 (휴대폰) **/
	public String getIdPhoneSearch(MemberVO vo) {
		return sqlSession.selectOne(namespace+".phone_id_search", vo);
	}
	
	/** 아이디 찾기 (이메일) **/
	public String getIdEmailSearch(MemberVO vo) {
		return sqlSession.selectOne(namespace+".email_id_search", vo);
	}
	
	/** 비밀번호 찾기 (휴대폰) **/
	public String getPassPhoneSearch(MemberVO vo) {
		return sqlSession.selectOne(namespace+".phone_pass_search", vo);
	}
	
	/** 비밀번호 찾기 (이메일) **/
	public String getPassEmailSearch(MemberVO vo) {
		return sqlSession.selectOne(namespace+".email_pass_search", vo);
	}
	
	/** 비밀번호 찾기 (변경) **/
	public int getPassResult(MemberVO vo) {
		return sqlSession.update(namespace+".pass_result", vo);
	}
	
	/** 아이디 중복체크 **/
	public int getIdCheckResult(String id) {
		return sqlSession.selectOne(namespace+".id_check", id);
	}
	
	/** 현재 비밀번호 확인 **/
	public int getPassCheckResult(SessionVO vo) {
		return sqlSession.selectOne(namespace+".pass_check", vo);
	}
	
	/** 현재 로그인 세션 정보 가져오기 **/
	public MemberVO getLoginContent(String id) {
		return sqlSession.selectOne(namespace+".login_content", id);
	}
	
	/** 회원정보 수정하기 **/
	public int getInfoUpdateResult(MemberVO vo) {
		return sqlSession.update(namespace+".info_update", vo);
	}
	
	/** 회원탈퇴 **/
	public int getInfoDelete(String id) {
		return sqlSession.update(namespace+".info_delete", id);
	}
	
	/** 회원탈퇴 취소 **/
	public int getInfoDeleteReset(String id) {
		return sqlSession.update(namespace+".info_delete_reset", id);
	}
	
	
	
	
	
	/** 관리자 회원리스트 **/
	public ArrayList<MemberVO> getMemberList(Criteria cri) {
		List<MemberVO> list = sqlSession.selectList(namespace+".member_list", cri);		
		return (ArrayList<MemberVO>)list;
	}
	
	/** 회원 리스트 갯수 **/
	public int getCountResult() {
		return sqlSession.selectOne(namespace+".count");
	}
	
	/** 회원탈퇴 처리 - 관리자 **/
	public int getMemberDrop(String id) {
		return sqlSession.delete(namespace+".member_drop", id);
	}
	



}
