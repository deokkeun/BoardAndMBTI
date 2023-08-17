package com.spring.recruit.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.recruit.dao.RecruitDao;
import com.spring.recruit.vo.EducationVo;
import com.spring.recruit.vo.RecruitVo;

@Repository
public class RecruitDaoImpl implements RecruitDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public RecruitVo main(RecruitVo recruitVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("recruit.main", recruitVo);
	}

	@Override
	public int insertInfo(RecruitVo recruitVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert("recruit.insertInfo", recruitVo);
	}

	@Override
	public int insertEducation(EducationVo education) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert("recruit.insertEducation", education);
	}

	@Override
	public List<EducationVo> educationVoList(String seq) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("recruit.educationVoList", seq);
	}

	@Override
	public int updateRecruit(RecruitVo recruitVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.update("recruit.updateRecruit", recruitVo);
	}

	@Override
	public int updateEducation(EducationVo education) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.update("recruit.updateEducation", education);
	}

	@Override
	public List<String> selectEduSeq(String seq) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("recruit.selectEduSeq", seq);
	}
}
