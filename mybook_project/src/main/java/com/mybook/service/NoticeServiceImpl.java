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
	
	
	//공지사항 글쓰기
	@Override
	public boolean getNoticeInsert(NoticeVO vo) {
		boolean result = false;
		int val = noticeDAO.getNoticeInsert(vo);
		
		if (val!=0) {
			result = true;
		}
		return result;
	}
	
	//공지사항 리스트
	@Override
	public ArrayList<NoticeVO> getNoticeList(Criteria cri) {
		return noticeDAO.getNoticeList(cri);
	}
	
	//공지사항 갯수
	@Override
	public int getCountResult() {
		return noticeDAO.getCountResult();
	}
	
	//공지사항 상세보기
	@Override
	public NoticeVO getNoticeContent(String nid) {
		return noticeDAO.getNoticeContent(nid);
	}
	
	//공지사항 파일 가져오기
	@Override
	public String getOldFile(String nid) {
		return noticeDAO.getOldFile(nid);
	}
	
	//파일포함 --> 업데이트
	public boolean getFileYesUpdate(NoticeVO vo) {
		int val = noticeDAO.getFileYesUpdate(vo);
		boolean result = false;
		
		if (val!=0) {
			result = true;
		}
		return result;
	}
	
	//파일미포함 --> 업데이트
	public boolean getFileNoUpdate(NoticeVO vo) {
		int val = noticeDAO.getFileNoUpdate(vo);		
		boolean result = false;
		
		if (val!=0) {
			result = true;
		}
		return result;
	}
	
	//공지사항 삭제
	public boolean getNoticeDelete(String nid) {
		int val = noticeDAO.getNoticeDelete(nid);
		boolean result = false;
		
		if (val!=0) {
			result = true;
		}
		return result;
	}
	
	//공지사항 - 공지 리스트
	public ArrayList<NoticeVO> getSpclList() {
		return noticeDAO.getSpclList();
	}
	
	//공지사항 - 일반 리스트
	public ArrayList<NoticeVO> getNormalList(Criteria cri) {
		return noticeDAO.getNormalList(cri);
	}
	
	//공지사항 - 일반 갯수
	public  int getNormalCountResult() {
		return noticeDAO.getNormalCountResult();
	}
	
	//공지사항 조회수
	public  int getNoticeHit(String nid) {
		return noticeDAO.getNoticeHit(nid);
	}
	
	//공지사항 이전글
	 public NoticeVO getPrevNoticeNormal(String rno) {
		 return noticeDAO.getPrevNoticeNormal(rno);
	 }
	 
	 //공지사항 다음글
	 public NoticeVO getNextNoticeNormal(String rno) {
		 return noticeDAO.getNextNoticeNormal(rno);
	 }
	 
	//공지사항 이전글
	 public NoticeVO getPrevNoticeSpcl(String rno) {
		 return noticeDAO.getPrevNoticeSpcl(rno);
	 }
	 
	 //공지사항 다음글
	 public NoticeVO getNextNoticeSpcl(String rno) {
		 return noticeDAO.getNextNoticeSpcl(rno);
	 }


}
