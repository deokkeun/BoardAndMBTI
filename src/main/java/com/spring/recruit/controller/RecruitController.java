package com.spring.recruit.controller;

import java.io.UnsupportedEncodingException;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.spring.board.HomeController;
import com.spring.recruit.service.RecruitService;
import com.spring.recruit.vo.CareerVo;
import com.spring.recruit.vo.CertificateVo;
import com.spring.recruit.vo.EducationVo;
import com.spring.recruit.vo.RecruitVo;

@Controller
@RequestMapping("/recruit")
@SessionAttributes({"recruit"})
public class RecruitController {

	@Autowired
	RecruitService recruitService;
	
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	// 로그인 페이지 이동
	@RequestMapping(value = "/login.do", method = RequestMethod.GET)
	public String login() throws Exception {
		return "recruit/login";
	}
	// 로그인
	@RequestMapping(value = "/main.do", method = RequestMethod.POST)
	public String main(Model model, RecruitVo recruitVo) throws Exception {
		
		recruitVo.setName(uni2ksc(recruitVo.getName()));
		RecruitVo recruit = recruitService.main(recruitVo); // select
	
		if(recruit == null) { // insert
			int result = recruitService.insertInfo(recruitVo);
			if(result > 0) { // insert Success(select)
				recruit = recruitService.main(recruitVo);
			}
		} else {
			if(recruit.getSeq() != null) {
				List<EducationVo> educationVoList = recruitService.educationVoList(recruit.getSeq()); // select
				model.addAttribute("educationVoList", educationVoList);
				List<CareerVo> careerVoList = recruitService.careerVoList(recruit.getSeq()); // select
				if(careerVoList.size() != 0) {
					model.addAttribute("careerVoList", careerVoList);
				}
				List<CertificateVo> certificateVoList = recruitService.certificateVoList(recruit.getSeq()); // select
				if(certificateVoList.size() != 0) {
					model.addAttribute("certificateVoList", certificateVoList);
				}
			}
		}
		model.addAttribute("recruit", recruit);
		
		return "recruit/main";
	}
	
	// 저장
	@ResponseBody
	@RequestMapping(value = "/save.do", method = RequestMethod.POST)
	public int save(Model model, RecruitVo recruitVo, EducationVo educationVo, CareerVo careerVo, CertificateVo certificateVo) throws Exception {
		
		String[] deleteNo1 = recruitVo.getDeleteNo1().split(",");
		String[] deleteNo2 = recruitVo.getDeleteNo2().split(",");
		String[] deleteNo3 = recruitVo.getDeleteNo3().split(",");
		
		if(deleteNo1.length != 0) { // education
			System.out.println("delete1::"+deleteNo1.length);
			for(int i = 0; i < deleteNo1.length; i++) {
				int delete1 = recruitService.deleteTable1(deleteNo1[i]);
			}
		}
		if(deleteNo2.length != 0) { //career
			for(int i = 0; i < deleteNo2.length; i++) {
				int delete2 = recruitService.deleteTable2(deleteNo2[i]);
			}
		}
		if(deleteNo3.length != 0) { // certificate
			for(int i = 0; i < deleteNo3.length; i++) {
				int delete3 = recruitService.deleteTable3(deleteNo3[i]);
			}
		}
		
		// recruit 테이블
		int updateRecruit = recruitService.updateRecruit(recruitVo); // update
		if(updateRecruit > 0) {
			RecruitVo recruit = recruitService.main(recruitVo);
			model.addAttribute("recruit", recruit);
		}
		
		// education 테이블
		int result = 0;
		if(educationVo.getEducationVoList() != null) {
			for(EducationVo education : educationVo.getEducationVoList()) {
				
				if(education.getDivision() != null) {
					education.setSeq(recruitVo.getSeq());
					
					if(education.getEduSeq() != null) { // update
						result = recruitService.updateEducation(education);
					} else { // insert
						result = recruitService.insertEducation(education);
					}
				} 
			}
		}
		
		// career 테이블
		if(careerVo.getCareerVoList() != null) {
			for(CareerVo career : careerVo.getCareerVoList()) {
				if(career.getCompName() != null) {
					career.setSeq(recruitVo.getSeq());
					
					if(career.getCarSeq() != null) { // update
						int careerResult = recruitService.updateCareer(career);
					} else { // insert
						if(career.getLocation() == null) {
							career.setLocation("");
						}
						int careerResult = recruitService.insertCareer(career);
					}
				}
			}
		}
		
		// certificate 테이블
		if(certificateVo.getCertificateVoList() != null) {
			for(CertificateVo certificate : certificateVo.getCertificateVoList()) {
				if(certificate.getQualifiName() != null) {
					certificate.setSeq(recruitVo.getSeq());
					
					if(certificate.getCertSeq() != null) { // update
						int certificateResult = recruitService.updateCertificate(certificate);
					} else { // insert
						int certificateResult = recruitService.insertCertificate(certificate);
					}
				}
			}
		}
		return result;
	}
	
	// 제출
	@RequestMapping(value = "/submit.do", method = RequestMethod.POST)
	public String submit(RecruitVo recruitVo, Model model) throws Exception {
		
		
		int result = recruitService.submit(recruitVo.getSeq());
		
		model.addAttribute("message", "제출 완료!");
		
		return "recruit/login";
	}
	
	
	// 유니코드를 한글코드로 변환
	protected String uni2ksc (String Unicodestr) throws UnsupportedEncodingException {
	return new String (Unicodestr.getBytes("8859_1"),"KSC5601");
	}
	
	// 한글코드를 유니코드로 변환
	protected String ksc2uni(String str) throws UnsupportedEncodingException {
	return new String( str.getBytes("KSC5601"), "8859_1");
	}
	
	
	
}
