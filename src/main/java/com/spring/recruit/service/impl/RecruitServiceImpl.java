package com.spring.recruit.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.recruit.dao.RecruitDao;
import com.spring.recruit.service.RecruitService;
import com.spring.recruit.vo.CareerVo;
import com.spring.recruit.vo.CertificateVo;
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

	@Override
	public int deleteTable1(String str) throws Exception {
		// TODO Auto-generated method stub
		return recruitDao.deleteTable1(str);
	}

	@Override
	public int submit(String seq) throws Exception {
		// TODO Auto-generated method stub
		return recruitDao.submit(seq);
	}

	@Override
	public int insertCareer(CareerVo career) throws Exception {
		// TODO Auto-generated method stub
		return recruitDao.insertCareer(career);
	}

	@Override
	public int insertCertificate(CertificateVo certificate) throws Exception {
		// TODO Auto-generated method stub
		return recruitDao.insertCertificate(certificate);
	}

	@Override
	public List<CareerVo> careerVoList(String seq) throws Exception {
		// TODO Auto-generated method stub
		return recruitDao.careerVoList(seq);
	}

	@Override
	public List<CertificateVo> certificateVoList(String seq) throws Exception {
		// TODO Auto-generated method stub
		return recruitDao.certificateVoList(seq);
	}

	@Override
	public int deleteTable2(String str) throws Exception {
		// TODO Auto-generated method stub
		return recruitDao.deleteTable2(str);
	}

	@Override
	public int deleteTable3(String str) throws Exception {
		// TODO Auto-generated method stub
		return recruitDao.deleteTable3(str);
	}

	@Override
	public int updateCareer(CareerVo career) throws Exception {
		// TODO Auto-generated method stub
		return recruitDao.updateCareer(career);
	}

	@Override
	public int updateCertificate(CertificateVo certificate) throws Exception {
		// TODO Auto-generated method stub
		return recruitDao.updateCertificate(certificate);
	}
	
	
}
