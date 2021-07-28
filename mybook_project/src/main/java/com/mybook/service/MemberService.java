package com.mybook.service;

import java.util.ArrayList;

import com.mybook.commons.Criteria;
import com.mybook.vo.MemberVO;
import com.mybook.vo.SessionVO;

public interface MemberService {
	
	boolean getJoinResult(MemberVO vo);
	boolean getLoginResult(MemberVO vo);
	String getIdPhoneSearch(MemberVO vo);
	String getIdEmailSearch(MemberVO vo);
	String getPassPhoneSearch(MemberVO vo);
	String getPassEmailSearch(MemberVO vo);
	boolean getPassResult(MemberVO vo);
	int getIdCheckResult(String id);
	boolean getPassCheckResult(SessionVO vo);
	MemberVO getLoginContent(String id);
	boolean getInfoUpdateResult(MemberVO vo);
	ArrayList<MemberVO> getMemberList(Criteria cri);
	int getCountResult();
	boolean getInfoDelete(String id);
	boolean getInfoDeleteReset(String id);
	boolean getMemberDrop(String id);

}
