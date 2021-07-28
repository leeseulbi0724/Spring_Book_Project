package com.mybook.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mybook.commons.Criteria;
import com.mybook.dao.NoticeDAO;
import com.mybook.vo.MemberVO;
import com.mybook.vo.NoticeVO;

@Service("NoticeService")
public class NoticeServiceImpl implements NoticeService {
	
	@Autowired
	private NoticeDAO noticeDAO;
	
	
	//�������� �۾���
	@Override
	public boolean getNoticeInsert(NoticeVO vo) {
		boolean result = false;
		int val = noticeDAO.getNoticeInsert(vo);
		
		if (val!=0) {
			result = true;
		}
		return result;
	}
	
	//�������� ����Ʈ
	@Override
	public ArrayList<NoticeVO> getNoticeList(Criteria cri) {
		return noticeDAO.getNoticeList(cri);
	}
	
	//�������� ����
	@Override
	public int getCountResult() {
		return noticeDAO.getCountResult();
	}
	
	//�������� �󼼺���
	@Override
	public NoticeVO getNoticeContent(String nid) {
		return noticeDAO.getNoticeContent(nid);
	}
	
	//�������� ���� ��������
	@Override
	public String getOldFile(String nid) {
		return noticeDAO.getOldFile(nid);
	}
	
	//�������� --> ������Ʈ
	public boolean getFileYesUpdate(NoticeVO vo) {
		int val = noticeDAO.getFileYesUpdate(vo);
		boolean result = false;
		
		if (val!=0) {
			result = true;
		}
		return result;
	}
	
	//���Ϲ����� --> ������Ʈ
	public boolean getFileNoUpdate(NoticeVO vo) {
		int val = noticeDAO.getFileNoUpdate(vo);		
		boolean result = false;
		
		if (val!=0) {
			result = true;
		}
		return result;
	}
	
	//�������� ����
	public boolean getNoticeDelete(String nid) {
		int val = noticeDAO.getNoticeDelete(nid);
		boolean result = false;
		
		if (val!=0) {
			result = true;
		}
		return result;
	}
	
	//�������� - ���� ����Ʈ
	public ArrayList<NoticeVO> getSpclList() {
		return noticeDAO.getSpclList();
	}
	
	//�������� - �Ϲ� ����Ʈ
	public ArrayList<NoticeVO> getNormalList(Criteria cri) {
		return noticeDAO.getNormalList(cri);
	}
	
	//�������� - �Ϲ� ����
	public  int getNormalCountResult() {
		return noticeDAO.getNormalCountResult();
	}
	
	//�������� ��ȸ��
	public  int getNoticeHit(String nid) {
		return noticeDAO.getNoticeHit(nid);
	}
	
	//�������� ������
	 public NoticeVO getPrevNoticeNormal(String rno) {
		 return noticeDAO.getPrevNoticeNormal(rno);
	 }
	 
	 //�������� ������
	 public NoticeVO getNextNoticeNormal(String rno) {
		 return noticeDAO.getNextNoticeNormal(rno);
	 }
	 
	//�������� ������
	 public NoticeVO getPrevNoticeSpcl(String rno) {
		 return noticeDAO.getPrevNoticeSpcl(rno);
	 }
	 
	 //�������� ������
	 public NoticeVO getNextNoticeSpcl(String rno) {
		 return noticeDAO.getNextNoticeSpcl(rno);
	 }


}
