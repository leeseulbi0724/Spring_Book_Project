package com.mybook.service;

import java.util.ArrayList;

import com.mybook.commons.Criteria;
import com.mybook.vo.MemberVO;
import com.mybook.vo.NoticeVO;

public interface NoticeService {
	
	boolean getNoticeInsert(NoticeVO vo);
	ArrayList<NoticeVO> getNoticeList(Criteria cri);
	int getCountResult();
	NoticeVO getNoticeContent(String nid);
	String getOldFile(String nid);
	boolean getFileYesUpdate(NoticeVO vo);
	boolean getFileNoUpdate(NoticeVO vo);
	boolean getNoticeDelete(String nid);
	ArrayList<NoticeVO> getSpclList();
	ArrayList<NoticeVO> getNormalList(Criteria cri);
	 int getNormalCountResult();
	 int getNoticeHit(String nid);
	 NoticeVO getPrevNoticeNormal(String rno);
	 NoticeVO getNextNoticeNormal(String rno);
	 NoticeVO getPrevNoticeSpcl(String rno);
	 NoticeVO getNextNoticeSpcl(String rno);
}
