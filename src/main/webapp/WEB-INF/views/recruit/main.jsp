<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>recruit</title>
<style>
.outLineTable > thead > tr > td,
.outLineTable > tbody > tr > td {
	border: none;
}
.outLineTable {
	border-style: double;
}
.outLineTable table:not(#headTable) {
	width: 80%;
}
#headTable {
	margin-top: 20px;
}
.center {
	text-align: center;
	margin: 20px;
}
#name,
#phone {
	pointer-events: none;
}
</style>
</head>
<script type="text/javascript">

	/* ��ȿ�� �˻� ��ü */
	const checkObj = {
		"email"					: false,
		"birth" 				: false,
		"addr"					: false,
		"educationStartPeriod"	: false,
		"educationEndPeriod"	: false,
		"educationSchoolName"	: false,
		"major"					: false,
		"grade"					: false
	}
	
	/* �Ѱ��� �Է� �Ǿ������� ��� �Է�, �ϳ��� �Է� �ȵǾ������� �׳� �Ѿ */
	const checkCareer = {
		"careerStartPeriod"		: false,
		"careerEndPeriod"		: false,
		"careerCompName"		: false,
		"careerTask"			: false,
		"careerLocation"		: false
	}
	
	/* �Ѱ��� �Է� �Ǿ������� ��� �Է�, �ϳ��� �Է� �ȵǾ������� �׳� �Ѿ */
	const checkCertificate = {
		"certificateQualifiName"	: false,
		"certificateAcquDate"		: false,
		"certificateOrganizeName"	: false
	}
	
	/* saveAndSubmitValidate(checkObj) �Լ� ���ο��� ȣ�� */
	/* ���� or ���� ��(�Ⱓ Ȯ�� �Լ�) */
	function checkPeriod(length, key, i, str) {
		console.log("length = " + length);
		console.log("key = " + key);
		console.log("i = " + i);
		console.log("str = " + str);
		
		if(length == 0) {
			alert(str + "�Ⱓ�� �Է����ּ���.");
			document.getElementsByClassName(key)[i].focus();
			saveResult = false;
			return '1';
		} else if(length != 7) {
			alert(str + "�Ⱓ�� (YYYY.MM)���Ŀ� �°� �Է� �Ǿ����� �ٽ� Ȯ�����ּ���.");
			document.getElementsByClassName(key)[i].focus();
			saveResult = false;
			return '1';
		} else {
			const regExp = /^[\d]{4}[\.]{1}[\d]{2}$/;
	   		if(regExp.test(document.getElementsByClassName(key)[i].value)) {
	   		} else {
	   			alert(str + "�Ⱓ�� (YYYY.MM)���Ŀ� �°� �Է����ּ���.");
	   			document.getElementsByClassName(key)[i].focus();
				saveResult = false;
				return '1';
	   		}
		}
	}


	var saveResult = false; /* ���� or ���� ���� ���� ���� */
	/* saveAndSubmit */
	/* ���� or ���� �� Ȯ�� �Լ� */
	function saveAndSubmitValidate(checkObj) {
		
		var keyEl;
		for(let key in checkObj) {
			if(!checkObj[key]) {
				
				switch(key) {
				case"email": case"birth": case"addr": 
					if(key == "email") {
						if(document.getElementById(key).value.length == 0) {
							alert("�̸����� �Է����ּ���.");
						} else {
							alert("�̸����� test@gmail.com ���Ŀ� �°� �Է����ּ���.");
						}
					} else if(key == "birth") {
						if(document.getElementById(key).value.length == 0) {
							alert("��������� �Է����ּ���.");
						} else {
							alert("��������� YYMMDD ���Ŀ� �°� �Է����ּ���.\n (YY = ��, MM = ��(01 ~ 12), DD = ��(01 ~ 31))");
						}
					} else if(key == "addr") {
						alert("�ּҸ� �Է����ּ���.");
					}
					document.getElementById(key).focus();
					saveResult = false;
					return true;
					break;					
				case"educationStartPeriod": case"educationEndPeriod": case"educationSchoolName": case"major": case"grade":
					keyEl = document.getElementsByClassName(key);
					for(let i = 0; i < keyEl.length; i++) {
						
						/* �Լ� ���� */
						if(key == 'educationStartPeriod' || key == 'educationEndPeriod') {
							let length = 0;
							length = keyEl[i].value.length;
							
							var result = checkPeriod(length, key, i, "����");
							console.log(result);
							if(result > 0) {
								return true;
							}
						}
						
						if(keyEl[i].value.length == 0) { /* �Է� �ȵǾ� ������ */
							if(key == "educationSchoolName") {
								alert("�б����� �Է����ּ���.");
							} else if(key == "major") {
								alert("������ �Է����ּ���.");
							} else if(key == "grade") {
								alert("������ �Է����ּ���.");
							}
						
							document.getElementsByClassName(key)[i].focus();
							saveResult = false;
							return true;
						} 
					}; break;
				}; /* switch */
			}; /* if(!checkObj[key]) */
		} /* for(let key in checkObj) */
		
		
		/* ������̺� */
		/* �Ѱ��� �Է� �Ǿ������� ��� �Է�, �ϳ��� �Է� �ȵǾ������� �׳� �Ѿ */
		let count = 0;
		const careerStartPeriod = document.getElementsByClassName("careerStartPeriod");
		for(let i = 0; i < careerStartPeriod.length; i++) {
			
			count = 0;
			for(let key in checkCareer) { /* �ԷµȰ� 1���� �ִ��� Ȯ�� */
				count += document.getElementsByClassName(key)[i].value.length;
			}
			
			if(count > 0) {
				console.log("career �Էµ� ������ ����");
				
				for(let key in checkCareer) {
					let length = 0;
					length = document.getElementsByClassName(key)[i].value.length;

					if(key == 'careerStartPeriod' || key == 'careerEndPeriod') {
						var result = checkPeriod(length, key, i, "�ٹ�");
						console.log(result);
						if(result > 0) {
							return true;
						}
					}
					
					if(length == 0) {
						if(key == "careerCompName") {
							alert("ȸ����� �Է����ּ���.");
						} else if(key == "careerTask") {
							alert("�μ�/����/��å�� �Է����ּ���.");
						} else if(key == "careerLocation") {
							alert("������ �Է����ּ���.");
						}
						
						document.getElementsByClassName(key)[i].focus();
						saveResult = false;
						return true;
					}
				}
			} else {
				console.log("career �Էµ� ������ ����");
			}
		}/* ������̺� �� */
		
		
		
		/* �ڰ������̺� */
		/* �Ѱ��� �Է� �Ǿ������� ��� �Է�, �ϳ��� �Է� �ȵǾ������� �׳� �Ѿ */
		let count1 = 0;
		const certificateQualifiName = document.getElementsByClassName("certificateQualifiName");
		for(let i = 0; i < certificateQualifiName.length; i++) {
			
			count1 = 0;
			for(let key in checkCertificate) { /* �ԷµȰ� 1���� �ִ��� Ȯ�� */
				count1 += document.getElementsByClassName(key)[i].value.length;
			}
			
			if(count1 > 0) {
				console.log("certificate �Էµ� ������ ����");
				
				for(let key in checkCertificate) {
					let length = 0;
					length = document.getElementsByClassName(key)[i].value.length;
					
					if(key == 'certificateAcquDate') {
						var result = checkPeriod(length, key, i, "���");
						console.log(result);
						if(result > 0) {
							return true;
						}
					}
					
					if(length == 0) {
						if(key == "certificateQualifiName") {
							alert("�ڰ������� �Է����ּ���.");
						} else if(key == "certificateOrganizeName") {
							alert("����ó�� �Է����ּ���.");
						}
						
						document.getElementsByClassName(key)[i].focus();
						saveResult = false;
						return true;
					}
				}
			} else {
				console.log("certificate �Էµ� ������ ����");
			}
		}/* �ڰ������̺� �� */
		
		saveResult = true;
	}


	/* ������ Ȯ�� */
	function recruitValidate() {
		if(confirm("�����Ͻø� ������ ���� �ʽ��ϴ�.")) {
			saveAndSubmitValidate(checkObj);
			if (saveResult == true) {
				return true;
			}
		}
			return false;
	}
		
	let tr1Num = 0; /* �з� ���̺� �� ���� (�߰� / ����) */
	let tr2Num = 0; /* ��� ���̺� �� ���� (�߰� / ����) */
	let tr3Num = 0; /* �ڰ��� ���̺� �� ���� (�߰� / ����) */

	/* ���� ����Ʈ */
 	var removeStr1 = "";
	var removeStr2 = "";
	var removeStr3 = "";
	
	
	/* ���ڸ� �Է� */
	function checkNumberCode(event) {
		  const regExp = /[^0-9]/g;
		  const ele = event.target;
		  if (regExp.test(ele.value)) {
		    ele.value = ele.value.replace(regExp, '');
		  }
	};
	/* ����, "."�� �Է� */
	function checkNumberDotCode(event) {
		  const regExp = /[^0-9\.]/g;
		  const ele = event.target;
		  if (regExp.test(ele.value)) {
		    ele.value = ele.value.replace(regExp, '');
		  }
	};
	/* �ּҿ�(�ѱ�, ����)�� �Է� */
	function checkKoreaAddrCode(event) {
		  const regExp = /[^\u3131-\u318E\uAC00-\uD7A30-9\s]/g;
		  const ele = event.target;
		  if (regExp.test(ele.value)) {
		    ele.value = ele.value.replace(regExp, '');
		  }
	};
	/* �ѱ۸� �Է� */
	function checkKoreaCode(event) {
		  const regExp = /[^\u3131-\u318E\uAC00-\uD7A3\s]/g;
		  const ele = event.target;
		  if (regExp.test(ele.value)) {
		    ele.value = ele.value.replace(regExp, '');
		  }
	};
	/* ����, ����, (@, .) �� �Է� */
	function checkEnglishCode(event) {
		  const regExp = /[^0-9a-zA-Z\@\.]/g;
		  const ele = event.target;
		  if (regExp.test(ele.value)) {
		    ele.value = ele.value.replace(regExp, '');
		  }
	};

	
	var keyCode;
	/* keydownHandler */
	function keydownHandler(event) {
		keyCode = event.keyCode || event.which;
		console.log('keydown:' + keyCode);
	}
	 
	/* ************************** �Ⱓ �Է� ��ȿ�� �˻� ************************** */
	function inputDate(obj) {
		console.log("inputDate ����");
		keydownHandler(event);
		
		/* ����, '.'�� �Է� */
		const regExp = /[^0-9\.]/g;
		if (regExp.test(obj.value)) {
			obj.value = obj.value.replace(regExp, '');
			alert("���ڸ� �Է����ּ���.");
		}
			
    	if(obj.value.length == 4) {
    		  const regExp = /^[\d]{4}$/;
    		  if (regExp.test(obj.value)) {
    				const today = new Date();
    				console.log(today.getFullYear());
    				console.log(obj.value.substr(0,4));
    				if(obj.value.substr(0,4) > today.getFullYear()) {
    					alert("����(" + today.getFullYear() + ")���� �̷��� ��¥�� �Է��� �� �����ϴ�.");
    					obj.value = "";
    				    
    				} else if(obj.value.substr(0,4) < 1950) {
    					alert("1950�� ���ķ� �Է� �����մϴ�.");
    					obj.value = "";
    				} else {
    					/* 4�ڸ� ���� �Է��ϸ� 5��° . �ڵ��Է� */
    					obj.value = obj.value.substr(0,4) + '.';
    				
    					/* ���ﶧ 5��° . ���� */
   			            if(keyCode === 8){  
   			            	if(obj.value.substr(4,1) == ".") {
   			            		obj.value = obj.value.substr(0,4);
   			            	}
   			            }
    				}
    		  }
    	}
    	
    	/* 5��°�� . �� �ƴϸ� ���� */
    	if(obj.value.length == 5) {
    		if(obj.value.substr(4, 1) != '.') {
    			obj.value = obj.value.substr(0, 4) + '.';
    		}
    	}
    	
    	/* �ۼ� �Ϸ� Ȯ�� */
	   	if(obj.value.length == 7) {
		const regExp = /^[\d]{4}[\.]{1}[\d]{2}$/;
	   		if(regExp.test(obj.value)) {
		    		console.log(obj.value.substr(5,2));
		    		if(01 > obj.value.substr(5,2) || obj.value.substr(5,2) > 12) {
		    			obj.value = obj.value.substr(0,5);
		    			alert("01�� ~ 12�� ���̷� �Է����ּ���.");
		    		} else {
		    			
		    			/* ���бⰣ, �ٹ��Ⱓ ��ġ���� Ȯ�� */
		    			const checkDate = obj.value.substr(0, 4) + obj.value.substr(5, 2);
		    			
		    			if(obj.className == "dateType educationStartPeriod" || obj.className == "dateType educationEndPeriod") {
		    				if(obj.className == "dateType educationEndPeriod") { /* ���бⰣ �����̸� ���� �� �� ���� */
		    					const str = obj.getAttribute("name"); /* ���бⰣ ���� name��  */
		    					const startStr = str.replace("end", "start"); /* ���бⰣ ���� name��  */
		    					const startCheck = document.getElementsByName(startStr)[0]; /* ���бⰣ ���� ��� */
		    					
		    					/* ���бⰣ ����(�⵵) < ���бⰣ ����(�⵵) */
		    					if(obj.value.substr(0, 4) < startCheck.value.substr(0, 4)) {
		    						alert("���бⰣ �������� ������ ���� ���� �� �����ϴ�.");
		    						obj.value = "";
		    					} else if(obj.value.substr(0, 4) == startCheck.value.substr(0, 4)) {
		    						/* ���бⰣ ����(��) < ���бⰣ ����(��) */
		    						if(obj.value.substr(5, 2) < startCheck.value.substr(5, 2)) {
			    						alert("���бⰣ �������� ������ ���� ���� �� �����ϴ�.");
			    						obj.value = obj.value.substr(0, 4);
		    						/* ���бⰣ ����(��) == ���бⰣ ����(��) */
		    						} else if(obj.value.substr(5, 2) == startCheck.value.substr(5, 2)) {
		    							alert("���бⰣ�� ���� �� �����ϴ�.");
			    						obj.value = obj.value.substr(0, 4);
		    						}
		    					}
		    					
		    				}
		    				
		    				/* ���бⰣ ��ġ���� Ȯ�� */
		    				const educationStartPeriod = document.getElementsByClassName("educationStartPeriod"); /* ���бⰣ ���� */
		    				const educationEndPeriod = document.getElementsByClassName("educationEndPeriod"); /* ���бⰣ ���� */
			    			for(let x = 0; x < educationStartPeriod.length; x++) {
								for(let y = 0; y < educationStartPeriod.length; y++) {
									if(y != x) {
										const startDateCheck = educationStartPeriod[y].value.substr(0, 4) + educationStartPeriod[y].value.substr(5, 2);
										const endDateCheck = educationEndPeriod[y].value.substr(0, 4) + educationEndPeriod[y].value.substr(5, 2);
										if(startDateCheck < checkDate && checkDate < endDateCheck) {
											alert("���бⰣ�� ���Ŀ�. �ٽ� �Է����ּ���.");
											obj.value = "";
											obj.focus();
											return true;
										}
									}
								}
			    			}/* ���бⰣ ��ġ���� Ȯ�� ���� */
			    			
			    			
		    			} else if(obj.className == "dateType careerStartPeriod" || obj.className == "dateType careerEndPeriod") {
		    				if(obj.className == "dateType careerEndPeriod") { /* �ٹ��Ⱓ �����̸� ���� �� �� ���� */
		    					const str = obj.getAttribute("name"); /* �ٹ��Ⱓ ���� name��  */
		    					const startStr = str.replace("end", "start"); /* �ٹ��Ⱓ ���� name��  */
		    					const startCheck = document.getElementsByName(startStr)[0]; /* �ٹ��Ⱓ ���� ��� */
		    					
		    					/* �ٹ��Ⱓ ����(�⵵) < �ٹ��Ⱓ ����(�⵵) */
		    					if(obj.value.substr(0, 4) < startCheck.value.substr(0, 4)) {
		    						alert("�ٹ��Ⱓ �������� ������ ���� ���� �� �����ϴ�.");
		    						obj.value = "";
		    					} else if(obj.value.substr(0, 4) == startCheck.value.substr(0, 4)) {
		    						/* �ٹ��Ⱓ ����(��) < �ٹ��Ⱓ ����(��) */
		    						if(obj.value.substr(5, 2) <= startCheck.value.substr(5, 2)) {
			    						alert("�ٹ��Ⱓ �������� ������ ���� ���� �� �����ϴ�.");
			    						obj.value = obj.value.substr(0, 4);
		    						}
		    					}
		    				}
		    				
		    				 /* �ٹ��Ⱓ ��ġ���� Ȯ�� */
		    				const careerStartPeriod = document.getElementsByClassName("careerStartPeriod");
		    				const careerEndPeriod = document.getElementsByClassName("careerEndPeriod");
		    				for(let x = 0; x < careerStartPeriod.length; x++) {
								for(let y = 0; y < careerStartPeriod.length; y++) {
									if(y != x) {
										const startDateCheck = careerStartPeriod[y].value.substr(0, 4) + careerStartPeriod[y].value.substr(5, 2);
										const endDateCheck = careerEndPeriod[y].value.substr(0, 4) + careerStartPeriod[y].value.substr(5, 2);
										if(startDateCheck < checkDate && checkDate < endDateCheck) {
											alert("�ٹ��Ⱓ�� ���Ŀ�. �ٽ� �Է����ּ���.");
											obj.value = "";
											obj.focus();
											return true;
										}
									}
								}
			    			}/* �ٹ��Ⱓ ��ġ���� Ȯ�� ���� */
		    			}
		    		}
	   		} else {
	   			alert("YYYY.MM �������� �Է����ּ���.");
			}
	   	}
	}; 
	/* ************************** �Ⱓ �Է� ��ȿ�� �˻� ���� ************************** */
	
	
	
	
	
	$j(document).ready(function(){
		/* ----------------------------------------- ��ȿ�� �˻� ----------------------------------------- */
		/* �̸��� ��ȿ�� �˻�(ó�� ȭ�� �Է� �� ����) */
		const email = document.getElementById("email");
		const emailRegExp = /^[\w\-\_]{4,}@[\w\-\_]+(\.\w+){1,3}$/;
		if(emailRegExp.test(email.value)) {
			checkObj.email = true;
			console.log("�̸���" + checkObj.email);
		} else {
			checkObj.email = false;
			console.log("�̸���" + checkObj.email);
		}
		
		/* �̸��� ��ȿ�� �˻� (�Է� ��) */
		$j("#email").on("input", e => {
			checkEnglishCode(e);
			
			const regExp = /^[\w\-\_]{4,}@[\w\-\_]+(\.\w+){1,3}$/;
			if(regExp.test(e.target.value)) {
				checkObj.email = true;
				console.log("input"+checkObj.email);
			} else {
				checkObj.email = false;
				console.log("input"+checkObj.email);
			}
		});
		
		/* ������� ��ȿ�� �˻�(ó�� ȭ�� �Է� �� ����) */
		const birth = document.getElementById("birth");
		const birthRegExp = /^([0-9][0-9])(0[1-9]|1[0-2])(0[1-9]|[12]\d|3[01])$/;
		if(birthRegExp.test(birth.value)) {
			checkObj.birth = true;
			console.log("�������" + checkObj.birth);
		} else {
			checkObj.birth = false;
			console.log("�������" + checkObj.birth);
		}
		
		/* ������� ��ȿ�� �˻� (�Է� ��) */
		$j("#birth").on("input", e => {
			checkNumberCode(e);
 			const regExp = /^([0-9][0-9])(0[1-9]|1[0-2])(0[1-9]|[12]\d|3[01])$/;
			if(regExp.test(e.target.value)) {
				checkObj.birth = true;
				console.log(checkObj.birth);
			} else {
				checkObj.birth = false;
				console.log(checkObj.birth);
			}
		});
		
		/* �ּ� ��ȿ�� �˻�(ó�� ȭ�� �Է� �� ����) */
		const addr = document.getElementById("addr");
		if(addr.value.length != 0) {
			checkObj.addr = true;
			console.log("�ּ�" + checkObj.addr);
		} else {
			checkObj.addr = false;
			console.log("�ּ�" + checkObj.addr);
		}
		
		/* �ּ� (�Է� ��) */
		$j("#addr").on("input", e => {
			checkKoreaAddrCode(e);
			if(e.target.value.length != 0) {
				checkObj.addr = true;
				console.log(checkObj.addr);
			} else {
				checkObj.addr = false;
				console.log(checkObj.addr);
			}
		});

		/* �ѱ۸� �Է� (����, ���� �Է� ����) */
		$j(".checkKorea").on("input", e => {
			checkKoreaCode(e);
		});
		/* ����, "."�� �Է� */
		$j(".checkNumberDot").on("input", e => {
			checkNumberDotCode(e);
		});
		/* ----------------------------------------- ��ȿ�� �˻� �� ----------------------------------------- */
		
		
		
		/* ----------------------------------------- Select(����, ����ٹ���, �ٹ�����) ----------------------------------------- */
		const gender = document.getElementsByClassName("gender")[0].value;
		if(gender != "") {
			$j("#gender").val(gender).prop("selected", true);	
		}
		const location = document.getElementsByClassName("location")[0].value;
		if(location != "") {
			$j("#location").val(location).prop("selected", true);
		}
		const workType = document.getElementsByClassName("workType")[0].value;
		if(workType != "") {
			$j("#workType").val(workType).prop("selected", true);
		}
		/* ----------------------------------------- Select(����, ����ٹ���, �ٹ�����) �� ----------------------------------------- */
		

		
		/* ----------------------------------------- �з»���, ��»���, ����ٹ���/�ٹ�����-----------------------------------------  */
		const educationalHistory = document.getElementById("educationalHistory");
		const totalCareer = document.getElementById("totalCareer");
		const locationAndWorkType = document.getElementById("locationAndWorkType");
		
		/* �з»��� */
		let educationSchoolName = document.getElementsByClassName("educationSchoolName");
		let educationStartPeriod = document.getElementsByClassName("educationStartPeriod");
		let educationEndPeriod = document.getElementsByClassName("educationEndPeriod");
		let educationDivisionText = document.getElementsByClassName("educationDivisionText");
		
		if(educationalHistory.innerHTML == "empty") {
			educationalHistory.innerHTML = "";
			
		} else {
			for(let i = 0; i < educationStartPeriod.length; i++) {
				const eduStartYear = educationStartPeriod[i].value.substr(0, 4);
				const eduEndYear = educationEndPeriod[i].value.substr(0, 4);
				const eduStartMonth = educationStartPeriod[i].value.substr(5, 2);
				const eduEndMonth = educationEndPeriod[i].value.substr(5, 2);
				const eduYear = educationEndPeriod[i].value.substr(0, 4) - educationStartPeriod[i].value.substr(0, 4);
				const eduMonth = educationEndPeriod[i].value.substr(5, 2) - educationStartPeriod[i].value.substr(5, 2);
				
				if(eduStartYear < eduEndYear) { /* ���ۿ��� < ���Ῥ�� */
					if(eduStartMonth < eduEndMonth) { /* �⵵, ������ �������� �� Ŭ�� */
						educationalHistory.innerHTML += educationSchoolName[i].value+"("+eduYear+"�� " + eduMonth +"����) "+educationDivisionText[i].value + "<br/>";
					} else if(eduStartMonth > eduEndMonth) {
						if((eduEndYear - eduStartYear) == 1) { /* 1�� �̳� ���� �� (���� �� > ���� ��)  */
							educationalHistory.innerHTML += educationSchoolName[i].value+"("+ (Number(12-eduStartMonth) + Number(eduEndMonth)) +"����) "+educationDivisionText[i].value + "<br/>";
						} else { /* 1�� �̻� ���� �� (���� �� > ���� ��) */
							educationalHistory.innerHTML += educationSchoolName[i].value+"("+ Number(eduYear - 1) +"�� "+ (Number(12-eduStartMonth) + Number(eduEndMonth)) +"����) "+educationDivisionText[i].value + "<br/>";
						}
					} else if(eduStartMonth == eduEndMonth) { /* 1�� �̻�  (���� �� == ���� ��)  */
						educationalHistory.innerHTML += educationSchoolName[i].value+"("+eduYear+"��) "+educationDivisionText[i].value + "<br/>";
					}
					
				} else if(eduStartYear == eduEndYear) { /* �⵵ ���� */
					if(eduStartMonth < eduEndMonth) {
						educationalHistory.innerHTML += educationSchoolName[i].value+"("+ eduMonth +"����) "+educationDivisionText[i].value + "<br/>";
					}
				
				}
			}
		}
		/* ��»��� */
		let careerStartPeriod = document.getElementsByClassName("careerStartPeriod");
		let careerEndPeriod = document.getElementsByClassName("careerEndPeriod");
		if(totalCareer.innerHTML == "empty") {
			totalCareer.innerHTML = "";
		} else {
			for(let i = 0; i < careerStartPeriod.length; i++) {
				
				const carStartYear = careerStartPeriod[i].value.substr(0, 4);
				const carEndYear = careerEndPeriod[i].value.substr(0, 4);
				const carStartMonth = careerStartPeriod[i].value.substr(5, 2);
				const carEndMonth = careerEndPeriod[i].value.substr(5, 2);
				const carYear = careerEndPeriod[i].value.substr(0, 4) - careerStartPeriod[i].value.substr(0, 4);
				const carMonth = careerEndPeriod[i].value.substr(5, 2) - careerStartPeriod[i].value.substr(5, 2);
				
				if(carStartYear < carEndYear) { /* ���ۿ��� < ���Ῥ�� */
					if(carStartMonth < carEndMonth) { /* �⵵, ������ �������� �� Ŭ�� */
						totalCareer.innerHTML += "��� " + carYear + "�� " + carMonth + "����<br/>";
					} else if(carStartMonth > carEndMonth) {
						if((carEndYear - carStartYear) == 1) { /* 1�� �̳� ���� �� (���� �� > ���� ��)  */
							totalCareer.innerHTML += "��� " + (Number(12-carStartMonth) + Number(carEndMonth)) + "����<br/>";
						} else { /* 1�� �̻� ���� �� (���� �� > ���� ��) */
							totalCareer.innerHTML += "��� " + Number(carYear - 1) + "�� " + (Number(12-carStartMonth) + Number(carEndMonth)) + "����<br/>";
						}
					} else if(carStartMonth == carEndMonth) { /* 1�� �̻�  (���� �� == ���� ��)  */
						totalCareer.innerHTML += "��� " + carYear + "��<br/>";
					}
					
				} else if(carStartYear == carEndYear) { /* �⵵ ���� */
					if(carStartMonth < carEndMonth) {
						totalCareer.innerHTML += "��� " + carMonth + "����<br/>";
					}
				}
				
			}
		}
		/* ������� */
		if(locationAndWorkType.innerHTML == "empty") {
			locationAndWorkType.innerHTML = "";
		} else {
			locationAndWorkType.innerHTML = $j("#location").val() + "��ü <br/>" + $j("#workType").val();
		}
		/* ----------------------------------------- �з»���, ��»���, ����ٹ���/�ٹ����� �� -----------------------------------------  */
		
		
		/* ������ ������ ������ */
		const eduSeq = document.getElementById("eduSeq");
		if(eduSeq.value != "") {
			/* �з� - ���� ���� */
			let educationLocation = document.getElementsByClassName("educationLocation");
			let length = educationLocation[0].options.length;
			let educationLocationText = document.getElementsByClassName("educationLocationText");
			for(let x = 0; x < educationLocation.length; x++) {
				for(let y = 0; y < length; y++) {
					if(educationLocation[x] != null) {
						if(educationLocation[x].options[y].value == educationLocationText[x].value) {
							educationLocation[x].options[y].selected = true;
						}
					}
				}
			}
			/* �з� - �б���(������) ���� */
			let educationDivision = document.getElementsByClassName("educationDivision");
			let length1 = educationDivision[0].options.length;
			let educationDivisionText = document.getElementsByClassName("educationDivisionText");
			for(let x = 0; x < educationDivision.length; x++) {
				for(let y = 0; y < length1; y++) {
					if(educationDivision[x] != null) {
						if(educationDivision[x].options[y].value == educationDivisionText[x].value) {
							educationDivision[x].options[y].selected = true;
						}
					}
				}
			}
		}
		
		/* ������ ������ �ҷ��� ��� */
		if($j(".tr1CheckBox").last().val() > 0) {			
			tr1Num = $j(".tr1CheckBox").last().val();
		}
		if($j(".tr2CheckBox").last().val() > 0) {			
			tr2Num = $j(".tr2CheckBox").last().val();
		}
		if($j(".tr3CheckBox").last().val() > 0) {			
			tr3Num = $j(".tr3CheckBox").last().val();
		}
		
		/* ************** ���� ���� ��� ��Ȱ��ȭ ************** */
		const submit = document.getElementById("submit");
		if(submit.value == 'TRUE') {
			/* input, select, button ��Ȱ��ȭ */
			const input = document.getElementsByTagName("input");
			const select = document.getElementsByTagName("select");
			const button = document.getElementsByTagName("button");
			for(let i = 0; i < input.length; i++) {
				input[i].setAttribute("disabled", true);
				input[i].style.border = "none";
				input[i].style.backgroundColor = "transparent";
			}
			for(let i = 0; i < select.length; i++) {
				select[i].setAttribute("disabled", true);
			}
			for(let i = 0; i < button.length; i++) {
				button[i].setAttribute("disabled", true);
			}
		}/* ************** ���� ���� ��� ��Ȱ��ȭ ************** */
		
		const tr1 = document.getElementsByClassName("tr1"); /* �з� */
		const tr2 = document.getElementsByClassName("tr2"); /* ��� */
		const tr3 = document.getElementsByClassName("tr3"); /* �ڰ��� */

		/* ���̺� �߰� */
		$j(".plusBtn").on("click", function() {
			if($j(this).val() == "tr1PlusBtn") {
				if(tr1[0] == null) {
					table1.innerHTML = "<thead><tr><th></th><th>���бⰣ</th><th>����</th><th>�б���(������)</th><th>����</th><th>����</th></tr></thead><tbody><tr class='tr1 tr1Clone0'><td><input type='hidden'id='eduSeq'value=''/><input type='checkBox'name='tr1CheckBox'class='tr1CheckBox'value='0'/></td><td><input type='text'name='educationVoList[0].startPeriod'class='dateType educationStartPeriod'onkeyup='inputDate(this)'maxlength='7'placeholder='YYYY.MM'/><br/>~<br/><input type='text'name='educationVoList[0].endPeriod'class='dateType educationEndPeriod'onkeyup='inputDate(this)'maxlength='7'placeholder='YYYY.MM'/></td><td><input type='hidden'/><select name='educationVoList[0].division'class='educationDivision'><option value='����'>����</option><option value='����'>����</option><option value='����'>����</option></select></td><td><input type='text'name='educationVoList[0].schoolName'class='checkKorea educationSchoolName'/><br/><input type='hidden'/><select name='educationVoList[0].location'><option value='����'>����</option><option value='�λ�'>�λ�</option><option value='�뱸'>�뱸</option><option value='��õ'>��õ</option><option value='����'>����</option><option value='����'>����</option><option value='���'>���</option><option value='����'>����</option><option value='���'>���</option><option value='�泲'>�泲</option><option value='���'>���</option><option value='����'>����</option><option value='����'>����</option><option value='����'>����</option><option value='�泲'>�泲</option><option value='���'>���</option></select></td><td><input type='text'name='educationVoList[0].major'class='checkKorea major'/></td><td><input type='text'name='educationVoList[0].grade'class='grade'/></td></tr></tbody>";
					table1.style.border = "1px solid black";
					return true;
				}
				
				alert("btn1");
				const tr1Clone = tr1[tr1.length - 1].cloneNode(true);
				
				/* input, select �ʱ�ȭ, name�� ���� */
				const input = tr1Clone.getElementsByTagName("input");
				const select = tr1Clone.getElementsByTagName("select");
				for(let i = 0; i < input.length; i++) {
					input[i].value = "";
				}
				
				++tr1Num;
				input[2].setAttribute("name", "educationVoList[" + tr1Num + "].startPeriod");
				input[3].setAttribute("name", "educationVoList[" + tr1Num + "].endPeriod");
				input[5].setAttribute("name", "educationVoList[" + tr1Num + "].schoolName");
				input[7].setAttribute("name", "educationVoList[" + tr1Num + "].major");
				input[8].setAttribute("name", "educationVoList[" + tr1Num + "].grade");
				select[0].setAttribute("name", "educationVoList[" + tr1Num + "].division");
				select[1].setAttribute("name", "educationVoList[" + tr1Num + "].location");
			
				tr1Clone.classList.add("tr1Clone" + tr1Num);
				tr1Clone.querySelector(".tr1CheckBox").value = tr1Num;
				tr1[tr1.length - 1].after(tr1Clone);
			} else if($j(this).val() == "tr2PlusBtn") {
				if(tr2[0] == null) {
					table2.innerHTML = "<thead><tr><th></th><th>�ٹ��Ⱓ</th><th>ȸ���</th><th>�μ�/����/��å</th><th>����</th></tr></thead><tbody><tr class='tr2 tr2Clone0'><td><!--üũ�ڽ�--><input type='hidden'id='carSeq'value=''/><input type='checkBox'name='tr2CheckBox'class='tr2CheckBox'value='0'/></td><td><!--�ٹ��Ⱓ--><input type='text'name='careerVoList[0].startPeriod'class='dateType careerStartPeriod'onkeyup='inputDate(this)'maxlength='7'placeholder='YYYY.MM'/>~<br/><input type='text'name='careerVoList[0].endPeriod'class='dateType careerEndPeriod'onkeyup='inputDate(this)'maxlength='7'placeholder='YYYY.MM'/></td><td><!--ȸ���--><input type='text'name='careerVoList[0].compName'/></td><td><!--�μ�/����/��å--><input type='text'name='careerVoList[0].task'/><input type='hidden'name='careerVoList[0].salary'/></td><td><!--����--><input type='text'name='careerVoList[0].location'/></td></tr></tbody>";
					table2.style.border = "1px solid black";
					return true;
				}
				
				alert("btn2");
				const tr2Clone = tr2[tr2.length - 1].cloneNode(true);
				
				
				/* input �ʱ�ȭ */
				const input = tr2Clone.getElementsByTagName("input");
				for(let i = 0; i < input.length; i++) {
					input[i].value = "";
				}
				
				++tr2Num;
				input[2].setAttribute("name", "careerVoList[" + tr2Num + "].startPeriod");
				input[3].setAttribute("name", "careerVoList[" + tr2Num + "].endPeriod");
				input[4].setAttribute("name", "careerVoList[" + tr2Num + "].compName");
				input[5].setAttribute("name", "careerVoList[" + tr2Num + "].task");
				input[6].setAttribute("name", "careerVoList[" + tr2Num + "].salary");
				
				tr2Clone.classList.add("tr2Clone" + tr2Num);
				tr2Clone.querySelector(".tr2CheckBox").value = tr2Num;
				tr2[tr2.length - 1].after(tr2Clone);
				
			} else if($j(this).val() == "tr3PlusBtn") {
				if(tr3[0] == null) {
					table3.innerHTML = "<thead><tr><th></th><th>�ڰ�����</th><th>�����</th><th>����ó</th></tr></thead><tbody><tr class='tr3 tr3Clone0'><td><!--üũ�ڽ�--><input type='hidden'id='certSeq'value=''/><input type='checkBox'name='tr3CheckBox'class='tr3CheckBox'value='0'/></td><td><!--�ڰ�����--><input type='text'name='certificateVoList[0].qualifiName'/></td><td><!--�����--><input type='text'name='certificateVoList[0].acquDate'maxlength='7'onkeyup='inputDate(this)'placeholder='YYYY.MM'/></td><td><!--����ó--><input type='text'name='certificateVoList[0].organizeName'/><br/></td></tr></tbody>";
					table3.style.border = "1px solid black";
					return true;
				}
				
				alert("btn3");
				const tr3Clone = tr3[tr3.length - 1].cloneNode(true);
				
				/* input �ʱ�ȭ */
				const input = tr3Clone.getElementsByTagName("input");
				for(let i = 0; i < input.length; i++) {
					input[i].value = "";
				}
				
				++tr3Num;
				input[2].setAttribute("name", "certificateVoList[" + tr3Num + "].qualifiName");
				input[3].setAttribute("name", "certificateVoList[" + tr3Num + "].acquDate");
				input[4].setAttribute("name", "certificateVoList[" + tr3Num + "].organizeName");
				
				tr3Clone.classList.add("tr3Clone" + tr3Num);
				tr3Clone.querySelector(".tr3CheckBox").value = tr3Num;
				tr3[tr3.length - 1].after(tr3Clone);
			}
		});
		
		
		/* ���̺� ���� */
		$j(".minusBtn").on("click", function() {
			let check1 = false;
			let check2 = false;
			let check3 = false;
			
			if($j(this).val() == "tr1MinusBtn") {
				$j(".tr1CheckBox:checked").each(function() {
					const tr1El = document.getElementsByClassName("tr1Clone" + $j(this).val());
					
					/* eduSeq */
					console.log($j(this).prev().val());
					removeStr1 += $j(this).prev().val() + ",";
					
					tr1El[0].remove();
					alert($j(this).val());
					check1 = true;
				});
				
				/* �Ѱ��� üũ �ȵǾ����� ��� �˶� */
				if(!check1) {
					alert("������ �з� �׸��� üũ���ּ���.");
					check1 = false;
				}
				
			} else if($j(this).val() == "tr2MinusBtn") {
				$j(".tr2CheckBox:checked").each(function() {
					const tr2El = document.getElementsByClassName("tr2Clone" + $j(this).val());
					
					/* carSeq */
					console.log($j(this).prev().val());
					removeStr2 += $j(this).prev().val() + ",";
					
					tr2El[0].remove();
					alert($j(this).val());
					check2 = true;
				});
				
				/* �Ѱ��� üũ �ȵǾ����� ��� �˶� */
				if(!check2) {
					alert("������ ��� �׸��� üũ���ּ���.");
					check2 = false;
				}
				
			} else if($j(this).val() == "tr3MinusBtn") {
				$j(".tr3CheckBox:checked").each(function() {
					const tr3El = document.getElementsByClassName("tr3Clone" + $j(this).val());
					
					/* certSeq */
					console.log($j(this).prev().val());
					removeStr3 += $j(this).prev().val() + ",";
					
					tr3El[0].remove();
					alert($j(this).val());
					check3 = true;
				});
				
				/* �Ѱ��� üũ �ȵǾ����� ��� �˶� */
				if(!check3) {
					alert("������ �ڰ��� �׸��� üũ���ּ���.");
					check3 = false;
				}
				
			}
			
			const table1 = document.getElementById("table1");
			const table2 = document.getElementById("table2");
			const table3 = document.getElementById("table3");
			if(tr1[0] == null) {
				table1.innerHTML = "";
				table1.style.border = "none";
			} else if(tr2[0] == null) {
				table2.innerHTML = "";
				table2.style.border = "none";
			} else if(tr3[0] == null) {
				table3.innerHTML = "";
				table3.style.border = "none";
			}
			
		});
		
		
		/* ���� */
		$j("#save").on("click",function(){
			
			saveAndSubmitValidate(checkObj);
			
			if (saveResult == true) {
				const deleteNo1 = document.getElementById("deleteNo1");
				const deleteNo2 = document.getElementById("deleteNo2");
				const deleteNo3 = document.getElementById("deleteNo3");
				deleteNo1.value = removeStr1;
				deleteNo2.value = removeStr2;
				deleteNo3.value = removeStr3;
				
				var $frm = $j('form :input');
				var param = $frm.serialize();
				console.log($frm);			
				console.log("param"+param);
			
				$j.ajax({
				    url : "/recruit/save.do",
				    dataType: "json",
				    type: "POST",
				    data : param,
				    success: function(data, textStatus, jqXHR)
				    {
						alert("���� �Ϸ�");
						window.location.reload();
						/* window.location.href = "/recruit/main.do"; */
				    },
				    error: function (jqXHR, textStatus, errorThrown)
				    {
				    	
				    }
				});
			}
		}); /* ���� */
		
	}); /* $j(document).ready(function() */

	
</script>
<body>
	<form action="/recruit/submit.do" method="POST" onsubmit="return recruitValidate()"><!-- ���� -->
		<input type="hidden" name="seq" value="${recruit.seq}"/>
		<input type="hidden" name="submit" id="submit" value="${recruit.submit}"/>
		<input type="hidden" class="gender" value="${recruit.gender}"/>
		<input type="hidden" class="location" value="${recruit.location}"/>
		<input type="hidden" class="workType" value="${recruit.workType}"/>
		<input type="hidden" name="deleteNo1" id="deleteNo1"/>
		<input type="hidden" name="deleteNo2" id="deleteNo2"/>
		<input type="hidden" name="deleteNo3" id="deleteNo3"/>
		
		<h1 class="center">�Ի�������</h1>
		<table width="100%" class="outLineTable">
			<thead>
				<tr>
					<td>
						<table align="center" border = "1" id="headTable">
							<tr>
								<td width="100" align="center">
									�̸�
								</td>
								<td width="150" align="left">
									<input type="text" maxlength="15" name="name" id="name" value="${recruit.name}"/>
								</td>
								<td width="100" align="center">
									�������
								</td>
								<td width="150" align="left">
									<input type="text" maxlength="6" name="birth" id="birth" value="${recruit.birth}" placeholder="YYMMDD"/>
								</td>
							</tr>
							<tr>
								<td width="100" align="center">
									����
								</td>
								<td width="150" align="left">
									<select name="gender" id="gender">
										<option value="����">����</option>
										<option value="����">����</option>
									</select>
								</td>
								<td width="100" align="center">
									����ó
								</td>
								<td width="150" align="left">
									<input type="text"name="phone" id="phone" maxlength="11" value="${recruit.phone}"/>
								</td>
							</tr>
							<tr>
								<td width="100" align="center">
									email
								</td>
								<td width="150" align="left">
									<input type="text" maxlength="30" name="email" id="email" value="${recruit.email}"/>
								</td>
								<td width="100" align="center">
									�ּ�
								</td>
								<td width="150" align="left">
									<input type="text" maxlength="12" name="addr" id="addr" value="${recruit.addr}"/>
								</td>
							</tr>
							<tr>
								<td width="100" align="center">
									����ٹ���
								</td>
								<td width="150" align="left">
									 <select name="location" id="location" >
							            <option value='����'>����</option>
							            <option value='�λ�'>�λ�</option>
							            <option value='�뱸'>�뱸</option>
							            <option value='��õ'>��õ</option>
							            <option value='����'>����</option>
							            <option value='����'>����</option>
							            <option value='���'>���</option>
							            <option value='����'>����</option>
							            <option value='���'>���</option>
							            <option value='�泲'>�泲</option>
							            <option value='���'>���</option>
							            <option value='����'>����</option>
							            <option value='����'>����</option>
							            <option value='����'>����</option>
							            <option value='�泲'>�泲</option>
							            <option value='���'>���</option>
							        </select>
								</td>
								<td width="100" align="center">
									�ٹ�����
								</td>
								<td width="150" align="left">
									<select name="workType" id="workType">
										<option value="������">������</option>
										<option value="�����">�����</option>
									</select>
								</td>
							</tr>
						</table> 
						<c:choose>
							<c:when test="${empty educationVoList}">
								<div id="educationalHistory">empty</div>
								<div id="totalCareer">empty</div>
								<div id="locationAndWorkType">empty</div>
							</c:when>
							<c:otherwise>
								<table align="center" border = "1" >
									<thead>
										<tr>
											<th>�з»���</th>
											<th>��»���</th>
											<th>�������</th>
											<th>����ٹ���/�ٹ�����</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td id="educationalHistory"></td>
											<td id="totalCareer"></td>
											<td>ȸ�系�Կ� ����</td>
											<td id="locationAndWorkType"></td>
										</tr>
									</tbody>
								</table>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</thead>
			
			<tbody><!-- �з�, ���, �ڰ��� -->
				<tr>
					<td>
						<h1>�з�</h1>
					</td>
				</tr>
				<tr align="right">
					<td>
						<button type="button" class="plusBtn" value="tr1PlusBtn">�߰�</button>
						<button type="button" class="minusBtn" value="tr1MinusBtn">����</button>
					</td>
				</tr>
				<tr>
					<td>
						<table border="1" align="center" id="table1">
							<c:choose>
								<c:when test='${empty educationVoList}'>
									<thead>
										<tr>
											<th></th>
											<th>���бⰣ</th>
											<th>����</th>
											<th>�б���(������)</th>
											<th>����</th>
											<th>����</th>
										</tr>
									</thead>
									<tbody>
										<tr class='tr1 tr1Clone0'>
											<td>
												<input type='hidden' id='eduSeq' value=''/>
												<input type='checkBox' name='tr1CheckBox' class='tr1CheckBox' value='0'/>
											</td>
											<td>
												<input type='text' name='educationVoList[0].startPeriod' class='dateType educationStartPeriod' onkeyup='inputDate(this)' maxlength='7' placeholder='YYYY.MM'/><br/>
												~<br/>
												<input type='text' name='educationVoList[0].endPeriod' class='dateType educationEndPeriod' onkeyup='inputDate(this)' maxlength='7' placeholder='YYYY.MM'/>
											</td>
											<td>
												<input type='hidden'/>
												<select name='educationVoList[0].division' class='educationDivision'>
													<option value='����'>����</option>
													<option value='����'>����</option>
													<option value='����'>����</option>
												</select>
											</td>
											<td>
												<input type='text' name='educationVoList[0].schoolName' class='checkKorea educationSchoolName'/><br/>
												<input type='hidden'/>
												  <select name='educationVoList[0].location'>
									             	<option value='����'>����</option>
										            <option value='�λ�'>�λ�</option>
										            <option value='�뱸'>�뱸</option>
										            <option value='��õ'>��õ</option>
										            <option value='����'>����</option>
										            <option value='����'>����</option>
										            <option value='���'>���</option>
										            <option value='����'>����</option>
										            <option value='���'>���</option>
										            <option value='�泲'>�泲</option>
										            <option value='���'>���</option>
										            <option value='����'>����</option>
										            <option value='����'>����</option>
										            <option value='����'>����</option>
										            <option value='�泲'>�泲</option>
										            <option value='���'>���</option>
										        </select>
											</td>
											<td>
												<input type='text' name='educationVoList[0].major' class='checkKorea major'/>
											</td>
											<td>
												<input type='text' name='educationVoList[0].grade' class='grade checkNumberDot' maxlength='3'/>
											</td>
										</tr>
									</tbody>
								</c:when>
								<c:otherwise>
									<thead>
										<tr>
											<th></th>
											<th>���бⰣ</th>
											<th>����</th>
											<th>�б���(������)</th>
											<th>����</th>
											<th>����</th>
										</tr>
									</thead>
										<tbody>
										<c:forEach var="educationList" items="${educationVoList}" varStatus="status">
											<tr class='tr1 tr1Clone${status.index}'>
												<td>
													<input type='hidden' name='educationVoList[${status.index}].eduSeq' id='eduSeq' value='${educationList.eduSeq}'/>
													<input type='checkBox' name='tr1CheckBox' class='tr1CheckBox' value='${status.index}'/>
												</td>
												<td>
													<input type='text' name='educationVoList[${status.index}].startPeriod' class='dateType educationStartPeriod' onkeyup='inputDate(this)' maxlength='7' placeholder='YYYY.MM' value='${educationList.startPeriod}'/><br/>
													~<br/>
													<input type='text' name='educationVoList[${status.index}].endPeriod' class='dateType educationEndPeriod' onkeyup='inputDate(this)' maxlength='7' placeholder='YYYY.MM' value='${educationList.endPeriod}'/>
												</td>
												<td>
													<input type='hidden' value='${educationList.division}' class='educationDivisionText'/>
													<select name='educationVoList[${status.index}].division' class='educationDivision'>
														<option value='����'>����</option>
														<option value='����'>����</option>
														<option value='����'>����</option>
													</select>
												</td>
												<td>
													<input type='text' name='educationVoList[${status.index}].schoolName' class='checkKorea educationSchoolName' value='${educationList.schoolName}'>
													<br/>
													<input type='hidden' value='${educationList.location}' class='educationLocationText'>
													  <select name='educationVoList[${status.index}].location' class='educationLocation'>
										             	<option value='����'>����</option>
											            <option value='�λ�'>�λ�</option>
											            <option value='�뱸'>�뱸</option>
											            <option value='��õ'>��õ</option>
											            <option value='����'>����</option>
											            <option value='����'>����</option>
											            <option value='���'>���</option>
											            <option value='����'>����</option>
											            <option value='���'>���</option>
											            <option value='�泲'>�泲</option>
											            <option value='���'>���</option>
											            <option value='����'>����</option>
											            <option value='����'>����</option>
											            <option value='����'>����</option>
											            <option value='�泲'>�泲</option>
											            <option value='���'>���</option>
											        </select>
												</td>
												<td>
													<input type='text' name='educationVoList[${status.index}].major' class='checkKorea major' value='${educationList.major}'/>
												</td>
												<td>
													<input type='text' name='educationVoList[${status.index}].grade' class='grade checkNumberDot' maxlength='3' value='${educationList.grade}'/>
												</td>
											</tr>
										</c:forEach>
										</tbody>
								</c:otherwise>
							</c:choose>
						</table>
					</td>
				</tr> <!-- �з� �� -->
				
				<tr>
					<td>
						<h1>���</h1>
					</td>
				</tr>
				<tr align="right">
					<td>
						<button type="button" class="plusBtn" value="tr2PlusBtn">�߰�</button>
						<button type="button" class="minusBtn" value="tr2MinusBtn">����</button>
					</td>
				</tr>
				<tr>
					<td>
						<table border="1" align="center" id="table2">
							<c:choose>
								<c:when test='${empty careerVoList}'>
									<thead>
										<tr>
											<th></th>
											<th>�ٹ��Ⱓ</th>
											<th>ȸ���</th>
											<th>�μ�/����/��å</th>
											<th>����</th>
										</tr>
									</thead>
									<tbody>
										<tr class='tr2 tr2Clone0'>
											<td><!-- üũ�ڽ� -->
												<input type='hidden' id='carSeq' value=''/>
												<input type='checkBox' name='tr2CheckBox' class='tr2CheckBox' value='0'/>
											</td>
											<td><!-- �ٹ��Ⱓ -->
												<input type='text' name='careerVoList[0].startPeriod' class='dateType careerStartPeriod' onkeyup='inputDate(this)' maxlength='7' placeholder='YYYY.MM' />~<br/>
												<input type='text' name='careerVoList[0].endPeriod' class='dateType careerEndPeriod' onkeyup='inputDate(this)' maxlength='7' placeholder='YYYY.MM' />
											</td>
											<td><!-- ȸ��� -->
												<input type='text'  name='careerVoList[0].compName' class='careerCompName'/>
											</td>
											<td><!-- �μ�/����/��å -->
												<input type='text' name='careerVoList[0].task' class='careerTask'/>
												<input type='hidden' name='careerVoList[0].salary' class='careerSalary'/>
											</td>
											<td><!-- ���� -->
												<input type='text' name='careerVoList[0].location' class='careerLocation'/>
											</td>
										</tr>
									</tbody>
								</c:when>
								<c:otherwise>
									<thead>
										<tr>
											<th></th>
											<th>�ٹ��Ⱓ</th>
											<th>ȸ���</th>
											<th>�μ�/����/��å</th>
											<th>����</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="careerList" items="${careerVoList}" varStatus="status">
											<tr class="tr2 tr2Clone${status.index}">
												<td><!-- üũ�ڽ� -->
													<input type="hidden" name="careerVoList[${status.index}].carSeq" value="${careerList.carSeq}"/>
													<input type="checkBox" name="tr2CheckBox" class="tr2CheckBox" value="${status.index}"/>
												</td>
												<td><!-- �ٹ��Ⱓ -->
													<input type="text" name="careerVoList[${status.index}].startPeriod" class='dateType careerStartPeriod' onkeyup='inputDate(this)' maxlength='7' placeholder='YYYY.MM' value="${careerList.startPeriod}"/>~<br/>
													<input type="text" name="careerVoList[${status.index}].endPeriod" class='dateType careerEndPeriod' onkeyup='inputDate(this)' maxlength='7' placeholder='YYYY.MM' value="${careerList.endPeriod}"/>
												</td>
												<td><!-- ȸ��� -->
													<input type="text"  name="careerVoList[${status.index}].compName" class='careerCompName' value="${careerList.compName}"/>
												</td>
												<td><!-- �μ�/����/��å -->
													<input type="text" name="careerVoList[${status.index}].task" class='careerTask' value="${careerList.task}"/>
													<input type="hidden" name="careerVoList[${status.index}].salary"  class='careerSalary' value="${careerList.salary}"/>
												</td>
												<td><!-- ���� -->
													<input type="text" name="careerVoList[${status.index}].location" class='careerLocation' value="${careerList.location}"/>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</c:otherwise>
							</c:choose>
						
						</table>
					</td>
				</tr> <!-- ��� �� -->
				
				<tr>
					<td>
						<h1>�ڰ���</h1>
					</td>
				</tr>
				<tr align="right">
					<td>
						<button type="button" class="plusBtn" value="tr3PlusBtn">�߰�</button>
						<button type="button" class="minusBtn" value="tr3MinusBtn">����</button>
					</td>
				</tr>
				<tr>
					<td>
						<table border="1" align="center" id="table3">
							<c:choose>
								<c:when test='${empty certificateVoList}'>
									<thead>
										<tr>
											<th></th>
											<th>�ڰ�����</th>
											<th>�����</th>
											<th>����ó</th>
										</tr>
									</thead>
									<tbody>
										<tr class='tr3 tr3Clone0'>
											<td><!-- üũ�ڽ� -->
												<input type='hidden' id='certSeq' value=''/>
												<input type='checkBox' name='tr3CheckBox' class='tr3CheckBox' value='0'/>
											</td>
											<td><!-- �ڰ����� -->
												<input type='text' name='certificateVoList[0].qualifiName' class='certificateQualifiName'/>
											</td>
											<td><!-- ����� -->
												<input type='text' name='certificateVoList[0].acquDate' class='certificateAcquDate' maxlength='7' onkeyup='inputDate(this)' placeholder='YYYY.MM'/>
											</td>
											<td><!-- ����ó -->
												<input type='text' name='certificateVoList[0].organizeName' class='certificateOrganizeName'/><br/>
											</td>
										</tr>
									</tbody>
								</c:when>
								<c:otherwise>
									<thead>
										<tr>
											<th></th>
											<th>�ڰ�����</th>
											<th>�����</th>
											<th>����ó</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="certificateList" items="${certificateVoList}" varStatus="status">
											<tr class="tr3 tr3Clone${status.index}">
												<td><!-- üũ�ڽ� -->
													<input type="hidden" name="certificateVoList[${status.index}].certSeq" value="${certificateList.certSeq}"/>
													<input type="checkBox" name="tr3CheckBox" class="tr3CheckBox" value="${status.index}"/>
												</td>
												<td><!-- �ڰ����� -->
													<input type="text" name="certificateVoList[${status.index}].qualifiName" class='certificateQualifiName' value="${certificateList.qualifiName}"/>
												</td>
												<td><!-- ����� -->
													<input type="text" name="certificateVoList[${status.index}].acquDate" class="dateType certificateAcquDate" onkeyup='inputDate(this)' maxlength='7' placeholder='YYYY.MM' value="${certificateList.acquDate}"/>
												</td>
												<td><!-- ����ó -->
													<input type="text" name="certificateVoList[${status.index}].organizeName" class='certificateOrganizeName' value="${certificateList.organizeName}"/><br/>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</c:otherwise>
							</c:choose>
						</table>
					</td>
				</tr> <!-- �ڰ��� �� -->
				
			</tbody>
		</table>
		<div class="center">
			<button type="button" id="save">����</button>
			<button type="submit">����</button>
		</div>
	</form>	
</body>
</html>