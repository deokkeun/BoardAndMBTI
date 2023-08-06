package com.spring.board.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.board.dao.BoardDao;
import com.spring.board.service.boardService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.PageVo;
import com.spring.board.vo.UserVo;

@Service
public class boardServiceImpl implements boardService{
	
	@Autowired
	BoardDao boardDao;
	
	@Override
	public String selectTest() throws Exception {
		// TODO Auto-generated method stub
		return boardDao.selectTest();
	}
	
	@Override
	public List<BoardVo> SelectBoardList(PageVo pageVo) throws Exception {
		// TODO Auto-generated method stub
		
		return boardDao.selectBoardList(pageVo);
	}
	
	@Override
	public int selectBoardCnt(PageVo pageVo) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.selectBoardCnt(pageVo);
	}
	
	@Override
	public BoardVo selectBoard(String boardType, int boardNum) throws Exception {
		// TODO Auto-generated method stub
		BoardVo boardVo = new BoardVo();
		
		boardVo.setBoardType(boardType);
		boardVo.setBoardNum(boardNum);
		
		return boardDao.selectBoard(boardVo);
	}
	
	@Override
	public int boardInsert(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.boardInsert(boardVo);
	}

	@Override
	public int boardUpdate(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.boardUpdate(boardVo);
	}

	@Override
	public int boardDelete(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.boardDelete(boardVo);
	}

	@Override
	public List<BoardVo> selectBoardType() throws Exception {
		// TODO Auto-generated method stub
		return boardDao.selectBoardType();
	}

//	MBTI
	@Override
	public List<BoardVo> selectMbtiBoardList(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.selectMbtiBoardList(boardVo);
	}

	@Override
	public UserVo login(UserVo loginMember) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.login(loginMember);
	}

	@Override
	public int userIdDupCheck(String userId) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.userIdDupCheck(userId);
	}

	@Override
	public int join(UserVo inputMember) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.join(inputMember);
	}
	
	
	
	
}
