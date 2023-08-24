package com.spring.recruit.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.recruit.dao.RecruitDao;
import com.spring.recruit.vo.CareerVo;
import com.spring.recruit.vo.CertificateVo;
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

	@Override
	public int deleteTable1(String str) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.delete("recruit.deleteTable1", str);
	}

	@Override
	public int submit(String seq) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.update("recruit.submit", seq);
	}

	@Override
	public int insertCareer(CareerVo career) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert("recruit.insertCareer", career);
	}

	@Override
	public int insertCertificate(CertificateVo certificate) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert("recruit.insertCertificate", certificate);
	}

	@Override
	public List<CareerVo> careerVoList(String seq) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("recruit.careerVoList", seq);
	}

	@Override
	public List<CertificateVo> certificateVoList(String seq) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("recruit.certificateVoList", seq);
	}

	@Override
	public int deleteTable2(String str) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.delete("recruit.deleteTable2", str);
	}

	@Override
	public int deleteTable3(String str) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.delete("recruit.deleteTable3", str);
	}

	@Override
	public int updateCareer(CareerVo career) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.update("recruit.updateCareer", career);
	}

	@Override
	public int updateCertificate(CertificateVo certificate) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.update("recruit.updateCertificate", certificate);
	}

	@Override
	public int phoneCheck(String phone) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("recruit.phoneCheck", phone);
	}


}
