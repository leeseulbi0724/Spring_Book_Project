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
	
	//ȸ������
	@Override
	public boolean getJoinResult(MemberVO vo) {
		boolean result = false;
		int value = memberDAO.getJoinResult(vo);
		
		if ( value != 0) {
			result = true;
		}
		
		return result;
	}
	
	//�α���
	@Override
	public boolean getLoginResult(MemberVO vo) {
		int val = memberDAO.getLoginResult(vo);
		
		boolean result = false;
		
		if ( val != 0 ) {
			result = true;
		}
		return result;
	}
	
	//�޴��� - ���̵�ã��
	@Override
	public String getIdPhoneSearch(MemberVO vo) {
		return memberDAO.getIdPhoneSearch(vo);
	}
	
	//�̸��� - ���̵�ã��
	@Override
	public String getIdEmailSearch(MemberVO vo) {
		return memberDAO.getIdEmailSearch(vo);
	}
	
	//�޴��� - ��й�ȣã��
	@Override
	public String getPassPhoneSearch(MemberVO vo) {
		return memberDAO.getPassPhoneSearch(vo);
	}
	
	//�̸��� - ��й�ȣã��
	@Override
	public String getPassEmailSearch(MemberVO vo) {
		return memberDAO.getPassEmailSearch(vo);
	}
	
	//��й�ȣã�� - ����
	@Override
	public boolean getPassResult(MemberVO vo) {
		int value = memberDAO.getPassResult(vo);
		
		boolean result = false;
		
		if ( value != 0 ) {
			result = true;
		}
		return result;
	}
	
	//���̵� �ߺ�üũ
	@Override
	public int getIdCheckResult(String id) {
		return memberDAO.getIdCheckResult(id);
	}
	
	//���� ��й�ȣ üũ
	@Override
	public boolean getPassCheckResult(SessionVO vo) {
		int value = memberDAO.getPassCheckResult(vo);
		
		boolean result = false;
		
		if ( value != 0) {
			result = true;
		}
		return result;
	}
	
	//ȸ������ ��������
	@Override
	public MemberVO getLoginContent(String id) {
		return memberDAO.getLoginContent(id);
	}
	
	//ȸ������ �����ϱ�
	@Override
	public boolean getInfoUpdateResult(MemberVO vo) {
		int value = memberDAO.getInfoUpdateResult(vo);
		
		boolean result = false;
		
		if ( value != 0) {
			result = true;
		}
		return result;
	}
	
	//������ - ȸ������Ʈ
	@Override
	public ArrayList<MemberVO> getMemberList(Criteria cri) {
		return memberDAO.getMemberList(cri);
	}
	
	//������ - ȸ������Ʈ ����
	@Override
	public int getCountResult() {
		return memberDAO.getCountResult();
	}
	
	//ȸ��Ż�� ��û
	@Override
	public boolean getInfoDelete(String id) {
		int val = memberDAO.getInfoDelete(id);
		boolean result = false;
		
		if ( val !=0) {
			result = true;
		}
		return result;
	}
	
	//ȸ��Ż�� ��û ���
	@Override
	public boolean getInfoDeleteReset(String id) {
		int val = memberDAO.getInfoDeleteReset(id);
		boolean result = false;
		
		if ( val !=0) {
			result = true;
		}
		return result;
	}
	
	//������ - ȸ��Ż��ó��
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
