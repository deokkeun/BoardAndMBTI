package com.spring.recruit.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.recruit.dao.RecruitDao;
import com.spring.recruit.service.RecruitService;
import com.spring.recruit.vo.EducationVo;
import com.spring.recruit.vo.RecruitVo;

@Service
public class RecruitServiceImpl implements RecruitService{

	@Autowired
	private RecruitDao recruitDao;

	@Override
	public RecruitVo main(RecruitVo recruitVo) throws Exception {
		// TODO Auto-generated method stub
		return recruitDao.main(recruitVo);
	}

	@Override
	public int insertInfo(RecruitVo recruitVo) throws Exception {
		// TODO Auto-generated method stub
		return recruitDao.insertInfo(recruitVo);
	}

	@Override
	public int insertEducation(EducationVo education) throws Exception {
		// TODO Auto-generated method stub
		return recruitDao.insertEducation(education);
	}

	@Override
	public List<EducationVo> educationVoList(String seq) throws Exception {
		// TODO Auto-generated method stub
		return recruitDao.educationVoList(seq);
	}

	@Override
	public int updateRecruit(RecruitVo recruitVo) throws Exception {
		// TODO Auto-generated method stub
		return recruitDao.updateRecruit(recruitVo);
	}

	@Override
	public int updateEducation(EducationVo education) throws Exception {
		// TODO Auto-generated method stub
		return recruitDao.updateEducation(education);
	}

	@Override
	public List<String> selectEduSeq(String seq) throws Exception {
		// TODO Auto-generated method stub
		return recruitDao.selectEduSeq(seq);
	}
	
	
}
