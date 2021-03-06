package com.mybook.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mybook.commons.Criteria;
import com.mybook.dao.BoardDAO;
import com.mybook.vo.BoardVO;

@Service("BoardService")
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardDAO boardDAO;
	
	public boolean getBoardWrite(BoardVO vo) {
		int val = boardDAO.getBoardWrite(vo);
		boolean result = false;
		if (val!=0) {
			result = true;
		}
		return result;
	}
	
	public int getBoardCount() {
		return boardDAO.getBoardCount();
	}
	
	public ArrayList<BoardVO> getBoardList(Criteria cri) {
		return boardDAO.getBoardList(cri);
	}
	
	public String getBoardName(String id) {
		return boardDAO.getBoardName(id);
	}
	
	public BoardVO getBoardContent(String bid) {
		return boardDAO.getBoardContent(bid);
	}
	
	public int getBoardHit(String bid) {
		return boardDAO.getBoardHit(bid);
	}
	
	public boolean getBoardComment(BoardVO vo) {
		int val = boardDAO.getBoardComment(vo);
		boolean result = false;
		if ( val!=0) {
			result = true;
		}
		return result;
	}
	
	public ArrayList<BoardVO> getBoardCommentContent(String bid) {
		return boardDAO.getBoardCommentContent(bid);
	}
	
	public String getProfileImage(String id) {
		return boardDAO.getProfileImage(id);
	}
	
	public  int getCommentCount(String bid) {
		return boardDAO.getCommentCount(bid);
	}
	
	public boolean getBoardUpdate(BoardVO vo) {
		int val = boardDAO.getBoardUpdate(vo);
		boolean result = false;
		if (val!=0) {
			result = true;
		}
		return result;
	}
	
	public boolean getBoardDelete(String bid) {
		int val = boardDAO.getBoardDelete(bid);
		boolean result = false;
		if (val!=0) {
			result = true;
		}
		return result;
	}
	
	public boolean getBoardCommentDelete(String cid) {
		int val = boardDAO.getBoardCommentDelete(cid);
		boolean result = false;
		if (val!=0) {
			result = true;
		}
		return result;
	}
	
	public boolean getCommentBell(BoardVO vo) {
		int val = boardDAO.getCommentBell(vo);
		boolean result = false;
		if (val!=0) {
			result = true;
		}
		return result;
	}
	
	public BoardVO getCommentContent(String cid) {
		return boardDAO.getCommentContent(cid);
	}
	
	public boolean getCommentUpdate(BoardVO vo) {
		int val = boardDAO.getCommentUpdate(vo);
		
		boolean result = false;
		
		if (val!=0) {
			result = true;
		}
		return result;
	}
	
	public ArrayList<BoardVO> getBoardSearchList(String search, String category) {
		return boardDAO.getBoardSearchList(search, category);
	}
	
	public ArrayList<BoardVO> getBoardSearchList(String search, String category, Criteria cri) {
		return boardDAO.getBoardSearchList(search, category, cri);
	}

}
