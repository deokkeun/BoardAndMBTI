package com.spring.board.dao.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.board.dao.BoardDao;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.PageVo;
import com.spring.board.vo.UserVo;

@Repository
public class BoardDaoImpl implements BoardDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public String selectTest() throws Exception {
		// TODO Auto-generated method stub
		
		String a = sqlSession.selectOne("board.boardList");
		
		return a;
	}
	/**
	 * 
	 * */
	@Override
	public List<BoardVo> selectBoardList(PageVo pageVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("board.boardList",pageVo);
	}
	
	@Override
	public int selectBoardCnt(PageVo pageVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.boardTotal", pageVo);
	}
	
	@Override
	public BoardVo selectBoard(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.boardView", boardVo);
	}
	
	@Override
	public int boardInsert(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert("board.boardInsert", boardVo);
	}
	@Override
	public int boardUpdate(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.update("board.boardUpdate", boardVo);
	}
	@Override
	public int boardDelete(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.delete("board.boardDelete", boardVo);
	}
	@Override
	public List<BoardVo> selectBoardType() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("board.selectBoardType");
	}
	
//	MBTI
	@Override
	public List<BoardVo> selectMbtiBoardList(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("board.selectMbtiBoardList", boardVo);
	}
	// 로그인
	@Override
	public UserVo login(UserVo loginMember) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.login", loginMember);	
	}
	// 아이디 중복검사
	@Override
	public int userIdDupCheck(String userId) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.userIdDupCheck", userId);
	}
	@Override
	public int join(UserVo inputMember) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert("board.join", inputMember);
	}
	@Override
	public List<UserVo> phoneList() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("board.phoneList");
	}
	
	
	
}
