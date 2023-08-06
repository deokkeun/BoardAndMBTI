package com.spring.board.dao;

import java.util.List;
import java.util.Map;

import com.spring.board.vo.BoardVo;
import com.spring.board.vo.PageVo;
import com.spring.board.vo.UserVo;

public interface BoardDao {

	public String selectTest() throws Exception;

	public List<BoardVo> selectBoardList(PageVo pageVo) throws Exception;

	public BoardVo selectBoard(BoardVo boardVo) throws Exception;

	public int selectBoardCnt(PageVo pageVo) throws Exception;

	public int boardInsert(BoardVo boardVo) throws Exception;

	public int boardUpdate(BoardVo boardVo) throws Exception;

	public int boardDelete(BoardVo boardVo) throws Exception;

	public List<BoardVo> selectBoardType() throws Exception;

	// MBTI
	public List<BoardVo> selectMbtiBoardList(BoardVo boardVo) throws Exception;

	// 로그인
	public UserVo login(UserVo userVo) throws Exception;

	// 아이디 중복 검사
	public int userIdDupCheck(String userId) throws Exception;

	// 회원가입
	public int join(UserVo inputMember) throws Exception;

}
