package com.spring.recruit.service;

import java.util.List;

import com.spring.recruit.vo.CareerVo;
import com.spring.recruit.vo.CertificateVo;
import com.spring.recruit.vo.EducationVo;
import com.spring.recruit.vo.RecruitVo;

public interface RecruitService {

	RecruitVo main(RecruitVo recruitVo) throws Exception;

	int insertInfo(RecruitVo recruitVo) throws Exception;

	int insertEducation(EducationVo education) throws Exception;

	List<EducationVo> educationVoList(String seq) throws Exception;

	int updateRecruit(RecruitVo recruitVo) throws Exception;

	int updateEducation(EducationVo education) throws Exception;

	List<String> selectEduSeq(String seq) throws Exception;

	int deleteTable1(String str) throws Exception;

	int submit(String seq) throws Exception;

	int insertCareer(CareerVo career) throws Exception;

	int insertCertificate(CertificateVo certificate) throws Exception;

	List<CareerVo> careerVoList(String seq) throws Exception;

	List<CertificateVo> certificateVoList(String seq) throws Exception;

	int deleteTable2(String str) throws Exception;

	int deleteTable3(String str) throws Exception;

	int updateCareer(CareerVo career) throws Exception;

	int updateCertificate(CertificateVo certificate) throws Exception;

}
