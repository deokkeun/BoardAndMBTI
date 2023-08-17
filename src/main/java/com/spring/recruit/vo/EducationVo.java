package com.spring.recruit.vo;

import java.util.List;

public class EducationVo {
	
	private String eduSeq;
	private String seq;
	private String startPeriod;
	private String endPeriod;
	private String division;
	private String schoolName;
	private String location;
	private String major;
	private String grade;
	private List<EducationVo> educationVoList;
	
	public String getEduSeq() {
		return eduSeq;
	}
	public void setEduSeq(String eduSeq) {
		this.eduSeq = eduSeq;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getSchoolName() {
		return schoolName;
	}
	public void setSchoolName(String schoolName) {
		this.schoolName = schoolName;
	}
	public String getDivision() {
		return division;
	}
	public void setDivision(String division) {
		this.division = division;
	}
	public String getStartPeriod() {
		return startPeriod;
	}
	public void setStartPeriod(String startPeriod) {
		this.startPeriod = startPeriod;
	}
	public String getEndPeriod() {
		return endPeriod;
	}
	public void setEndPeriod(String endPeriod) {
		this.endPeriod = endPeriod;
	}
	public String getMajor() {
		return major;
	}
	public void setMajor(String major) {
		this.major = major;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public List<EducationVo> getEducationVoList() {
		return educationVoList;
	}
	public void setEducationVoList(List<EducationVo> educationVoList) {
		this.educationVoList = educationVoList;
	}

}
