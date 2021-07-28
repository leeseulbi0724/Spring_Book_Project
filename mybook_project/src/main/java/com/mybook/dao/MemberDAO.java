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
	
	/** ȸ������ **/
	public int getJoinResult(MemberVO vo) {
		return sqlSession.insert(namespace+".join", vo);
	}
	
	/** �α��� **/
	public int getLoginResult(MemberVO vo) {
		return sqlSession.selectOne(namespace+".login", vo);
		
	}
	
	/** ���̵� ã�� (�޴���) **/
	public String getIdPhoneSearch(MemberVO vo) {
		return sqlSession.selectOne(namespace+".phone_id_search", vo);
	}
	
	/** ���̵� ã�� (�̸���) **/
	public String getIdEmailSearch(MemberVO vo) {
		return sqlSession.selectOne(namespace+".email_id_search", vo);
	}
	
	/** ��й�ȣ ã�� (�޴���) **/
	public String getPassPhoneSearch(MemberVO vo) {
		return sqlSession.selectOne(namespace+".phone_pass_search", vo);
	}
	
	/** ��й�ȣ ã�� (�̸���) **/
	public String getPassEmailSearch(MemberVO vo) {
		return sqlSession.selectOne(namespace+".email_pass_search", vo);
	}
	
	/** ��й�ȣ ã�� (����) **/
	public int getPassResult(MemberVO vo) {
		return sqlSession.update(namespace+".pass_result", vo);
	}
	
	/** ���̵� �ߺ�üũ **/
	public int getIdCheckResult(String id) {
		return sqlSession.selectOne(namespace+".id_check", id);
	}
	
	/** ���� ��й�ȣ Ȯ�� **/
	public int getPassCheckResult(SessionVO vo) {
		return sqlSession.selectOne(namespace+".pass_check", vo);
	}
	
	/** ���� �α��� ���� ���� �������� **/
	public MemberVO getLoginContent(String id) {
		return sqlSession.selectOne(namespace+".login_content", id);
	}
	
	/** ȸ������ �����ϱ� **/
	public int getInfoUpdateResult(MemberVO vo) {
		return sqlSession.update(namespace+".info_update", vo);
	}
	
	/** ȸ��Ż�� **/
	public int getInfoDelete(String id) {
		return sqlSession.update(namespace+".info_delete", id);
	}
	
	/** ȸ��Ż�� ��� **/
	public int getInfoDeleteReset(String id) {
		return sqlSession.update(namespace+".info_delete_reset", id);
	}
	
	
	
	
	
	/** ������ ȸ������Ʈ **/
	public ArrayList<MemberVO> getMemberList(Criteria cri) {
		List<MemberVO> list = sqlSession.selectList(namespace+".member_list", cri);		
		return (ArrayList<MemberVO>)list;
	}
	
	/** ȸ�� ����Ʈ ���� **/
	public int getCountResult() {
		return sqlSession.selectOne(namespace+".count");
	}
	
	/** ȸ��Ż�� ó�� - ������ **/
	public int getMemberDrop(String id) {
		return sqlSession.delete(namespace+".member_drop", id);
	}
	



}
