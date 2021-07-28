package com.mybook.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mybook.commons.Criteria;
import com.mybook.dao.MemberDAO;
import com.mybook.vo.MemberVO;
import com.mybook.vo.SessionVO;

@Service("MemberService")
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberDAO memberDAO;
	
	//회원가입
	@Override
	public boolean getJoinResult(MemberVO vo) {
		boolean result = false;
		int value = memberDAO.getJoinResult(vo);
		
		if ( value != 0) {
			result = true;
		}
		
		return result;
	}
	
	//로그인
	@Override
	public boolean getLoginResult(MemberVO vo) {
		int val = memberDAO.getLoginResult(vo);
		
		boolean result = false;
		
		if ( val != 0 ) {
			result = true;
		}
		return result;
	}
	
	//휴대폰 - 아이디찾기
	@Override
	public String getIdPhoneSearch(MemberVO vo) {
		return memberDAO.getIdPhoneSearch(vo);
	}
	
	//이메일 - 아이디찾기
	@Override
	public String getIdEmailSearch(MemberVO vo) {
		return memberDAO.getIdEmailSearch(vo);
	}
	
	//휴대폰 - 비밀번호찾기
	@Override
	public String getPassPhoneSearch(MemberVO vo) {
		return memberDAO.getPassPhoneSearch(vo);
	}
	
	//이메일 - 비밀번호찾기
	@Override
	public String getPassEmailSearch(MemberVO vo) {
		return memberDAO.getPassEmailSearch(vo);
	}
	
	//비밀번호찾기 - 변경
	@Override
	public boolean getPassResult(MemberVO vo) {
		int value = memberDAO.getPassResult(vo);
		
		boolean result = false;
		
		if ( value != 0 ) {
			result = true;
		}
		return result;
	}
	
	//아이디 중복체크
	@Override
	public int getIdCheckResult(String id) {
		return memberDAO.getIdCheckResult(id);
	}
	
	//현재 비밀번호 체크
	@Override
	public boolean getPassCheckResult(SessionVO vo) {
		int value = memberDAO.getPassCheckResult(vo);
		
		boolean result = false;
		
		if ( value != 0) {
			result = true;
		}
		return result;
	}
	
	//회원정보 가져오기
	@Override
	public MemberVO getLoginContent(String id) {
		return memberDAO.getLoginContent(id);
	}
	
	//회원정보 수정하기
	@Override
	public boolean getInfoUpdateResult(MemberVO vo) {
		int value = memberDAO.getInfoUpdateResult(vo);
		
		boolean result = false;
		
		if ( value != 0) {
			result = true;
		}
		return result;
	}
	
	//관리자 - 회원리스트
	@Override
	public ArrayList<MemberVO> getMemberList(Criteria cri) {
		return memberDAO.getMemberList(cri);
	}
	
	//관리자 - 회원리스트 갯수
	@Override
	public int getCountResult() {
		return memberDAO.getCountResult();
	}
	
	//회원탈퇴 신청
	@Override
	public boolean getInfoDelete(String id) {
		int val = memberDAO.getInfoDelete(id);
		boolean result = false;
		
		if ( val !=0) {
			result = true;
		}
		return result;
	}
	
	//회원탈퇴 신청 취소
	@Override
	public boolean getInfoDeleteReset(String id) {
		int val = memberDAO.getInfoDeleteReset(id);
		boolean result = false;
		
		if ( val !=0) {
			result = true;
		}
		return result;
	}
	
	//관리자 - 회원탈퇴처리
	@Override
	public boolean getMemberDrop(String id) {
		int val = memberDAO.getMemberDrop(id);
		boolean result = false;
		
		if ( val !=0) {
			result = true;
		}
		return result;
	}
	

}
