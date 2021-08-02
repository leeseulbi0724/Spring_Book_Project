package com.mybook.service;

import java.util.ArrayList;

import com.mybook.commons.Criteria;
import com.mybook.vo.BoardVO;

public interface BoardService {
	
	boolean getBoardWrite(BoardVO vo);
	int getBoardCount();
	ArrayList<BoardVO> getBoardList(Criteria cri);
	String getBoardName(String id);
	BoardVO getBoardContent(String bid);
	int getBoardHit(String bid);
	boolean getBoardComment(BoardVO vo);
	ArrayList<BoardVO> getBoardCommentContent(String bid);
	String getProfileImage(String id);
	int getCommentCount(String bid);
	boolean getBoardUpdate(BoardVO vo);
	boolean getBoardDelete(String bid);
	boolean getBoardCommentDelete(String cid);
	boolean getCommentBell(BoardVO vo);
	BoardVO getCommentContent(String cid);
	boolean getCommentUpdate(BoardVO vo);
}
