package com.spring.recruit.service;

import java.util.List;

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

}
