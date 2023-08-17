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
	
		System.out.println("recruit::"+recruit);
		
		if(recruit == null) { // insert
			System.out.println("recruit=null::"+recruit);
			System.out.println("recruitVo.getName::"+recruitVo.getName());
			System.out.println("recruitVo.getName::"+recruitVo.getPhone());
			int result = recruitService.insertInfo(recruitVo);
			if(result > 0) { // insert Success
				System.out.println("recruitVo.getName::"+recruitVo.getName());
				System.out.println("recruitVo.getName::"+recruitVo.getPhone());
				recruit = recruitService.main(recruitVo);
			}
		} else {
			if(recruit.getSeq() != null) {
				List<EducationVo> educationVoList = recruitService.educationVoList(recruit.getSeq()); // select
				model.addAttribute("educationVoList", educationVoList);
			}
		}
		model.addAttribute("recruit", recruit);
		
		return "recruit/main";
	}
	
	// 저장
	@ResponseBody
	@RequestMapping(value = "/save.do", method = RequestMethod.POST)
	public int save(Model model, RecruitVo recruitVo, EducationVo educationVo) throws Exception {


		int updateRecruit = recruitService.updateRecruit(recruitVo); // update
		if(updateRecruit > 0) {
			RecruitVo recruit = recruitService.main(recruitVo);
			model.addAttribute("recruit", recruit);
			System.out.println("updateRecruit::"+updateRecruit);
		}
		
		
		int result = 0;
		if(educationVo.getEducationVoList() != null) {
			
			// 저장시 삭제
			List<String> eduSeqList = recruitService.selectEduSeq(recruitVo.getSeq());
			
			for(EducationVo education : educationVo.getEducationVoList()) {
				System.out.println("eduSeqList.contains(education.getEduSeq())::"+eduSeqList.contains(education.getEduSeq()));
			
				
				education.setSeq(recruitVo.getSeq());
				
				if(education != null) {
					if(education.getEduSeq() != null) { // update
						System.out.println("update");
						result = recruitService.updateEducation(education);
					} else { // insert
						System.out.println("insert");
						result = recruitService.insertEducation(education);
					}
				} 
				System.out.println("result::"+result);
			}
			
		}
		
		return result;
	}
	
	// 제출
	@RequestMapping(value = "/submit.do", method = RequestMethod.POST)
	public String submit(RecruitVo recruitVo, Model model) throws Exception {
		System.out.println("recruit::"+recruitVo.getName());
		System.out.println("recruit::"+recruitVo.getAddr());
		System.out.println("recruit::"+recruitVo.getBirth());
		System.out.println("recruit::"+recruitVo.getEmail());
		System.out.println("recruit::"+recruitVo.getGender());
		System.out.println("recruit::"+recruitVo.getLocation());
		System.out.println("recruit::"+recruitVo.getPhone());
		System.out.println("recruit::"+recruitVo.getSeq());
		System.out.println("recruit::"+recruitVo.getSubmit());
		System.out.println("recruit::"+recruitVo.getWorkType());
		
		model.addAttribute("message", "제출 완료!");
		
		return "recruit/main";
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
