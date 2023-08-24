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


	function recruitValidate() {
		if(confirm("�����Ͻø� ������ ���� �ʽ��ϴ�.")) {
			return true;
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
	
	function checkDateCode(event) {
		  const regExp = /[^0-9\.]/g;
		  const ele = event.target;
		  if (regExp.test(ele.value)) {
		    ele.value = ele.value.replace(regExp, '');
		    alert("���ڸ� �Է����ּ���.");
		  }
	};
	/* 5��° - ��ü */
 	function checkDotCode(event) {
		  const regExp = /^[\d]{4}$/;
		 /*  const regExp = /^[\d]{4}[^\.]{1}$/; */
		/*   const regExp1 = /^[\d]{4}[\.]{1}$/; */
		  
		  const ele = event.target;
		  if (regExp.test(ele.value)) {
				const today = new Date();
				console.log(today.getFullYear());
				console.log(ele.value.substr(0,4));
				if(ele.value.substr(0,4) > today.getFullYear()) {
					alert("����(" + today.getFullYear() + ")���� �̷��� ��¥�� �Է��� �� �����ϴ�.");
					ele.value = "";
				    
				} else {
					ele.value = ele.value.substr(0,4) + '.';
					
					$j(ele).keyup(e => {   
			            if(e.keyCode === 8){  
			            	if(ele.value.substr(4,1) == ".") {
			            		ele.value = ele.value.substr(0,4);
			            	}
			            }
				    });
				   /*  ele.value = ele.value.replace(regExp1, ele.value); */
				}
				
		  }
	};

	function checkNumberCode(event) {
		  const regExp = /[^0-9]/g;
		  const ele = event.target;
		  if (regExp.test(ele.value)) {
		    ele.value = ele.value.replace(regExp, '');
		  }
	};
	
	$j(document).ready(function(){

		$j("#birth").on("input", e => {
			checkNumberCode(e);
		})
		
		$j(".dateType").on("input", e => {
			checkDateCode(e);
			
	    	if(e.target.value.length == 4) {
	    		checkDotCode(e);
	    	}
	    	
			 const regExp = /^[\d]{4}[\.]{1}[\d]{2}$/;
	    	if(e.target.value.length == 7) {
	    		if(regExp.test(e.target.value)) {
		    		console.log(e.target.value.substr(5,2));
		    		if(01 > e.target.value.substr(5,2) || e.target.value.substr(5,2) > 12) {
		    			e.target.value = e.target.value.substr(0,5) + "01";
		    			alert("01�� ~ 12�� ���̷� �Է����ּ���.");
		    		} else {
		    			alert("�ۼ��� �ߵǾ�����?");
		    			
		    			/* ���бⰣ, �ٹ��Ⱓ ��ġ���� Ȯ�� */
		    			const checkDate = e.target.value.substr(0, 4) + e.target.value.substr(5, 2);
		    			
		    			console.log(e.target.className);
		    			if(e.target.className == "dateType educationStartPeriod" || e.target.className == "dateType educationEndPeriod") {
			    			for(let x = 0; x < educationStartPeriod.length; x++) {
								for(let y = 0; y < educationStartPeriod.length; y++) {
									if(y != x) {
										const startDateCheck = educationStartPeriod[y].value.substr(0, 4) + educationStartPeriod[y].value.substr(5, 2);
										const endDateCheck = educationEndPeriod[y].value.substr(0, 4) + educationEndPeriod[y].value.substr(5, 2);
										if(startDateCheck < checkDate && checkDate < endDateCheck) {
											alert("���бⰣ�� ���Ŀ�. �ٽ� �Է����ּ���.");
											e.target.value = "";
											e.target.focus();
											return true;
										}
									}
								}
			    			}/* ���бⰣ ��ġ���� Ȯ�� ���� */
			    			
		    			} else if(e.target.className == "dateType careerStartPeriod" || e.target.className == "dateType careerEndPeriod") {
		    				for(let x = 0; x < careerStartPeriod.length; x++) {
								for(let y = 0; y < careerStartPeriod.length; y++) {
									if(y != x) {
										const startDateCheck = careerStartPeriod[y].value.substr(0, 4) + careerStartPeriod[y].value.substr(5, 2);
										const endDateCheck = careerEndPeriod[y].value.substr(0, 4) + careerStartPeriod[y].value.substr(5, 2);
										if(startDateCheck < checkDate && checkDate < endDateCheck) {
											alert("�ٹ��Ⱓ�� ���Ŀ�. �ٽ� �Է����ּ���.");
											e.target.value = "";
											e.target.focus();
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
		})
		
		
		const educationalHistory = document.getElementById("educationalHistory");
		const totalCareer = document.getElementById("totalCareer");
		const locationAndWorkType = document.getElementById("locationAndWorkType");
		
		/* �Ի������� ����, ����ٹ���, �ٹ����� */
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
		
		/* �з»��� */
		let educationSchoolName = document.getElementsByClassName("educationSchoolName");
		let educationStartPeriod = document.getElementsByClassName("educationStartPeriod");
		let educationEndPeriod = document.getElementsByClassName("educationEndPeriod");
		let educationDivisionText = document.getElementsByClassName("educationDivisionText");
		if(educationalHistory.innerHTML == "empty") {
			educationalHistory.innerHTML = "";
		} else {
			for(let i = 0; i < educationStartPeriod.length; i++) {
				const eduYear = educationEndPeriod[i].value.substr(0, 4) - educationStartPeriod[i].value.substr(0, 4);
				const eduMonth = educationEndPeriod[i].value.substr(5, 2) - educationStartPeriod[i].value.substr(5, 2);

				if(eduYear > 0) {
					educationalHistory.innerHTML += educationSchoolName[i].value+"("+eduYear+"��) "+educationDivisionText[i].value + "<br/>";
				} else {
					educationalHistory.innerHTML += "�з»��� ���� <br/>";
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
				const carYear = careerEndPeriod[i].value.substr(0, 4) - careerStartPeriod[i].value.substr(0, 4);
				const carMonth = careerEndPeriod[i].value.substr(5, 2) - careerStartPeriod[i].value.substr(5, 2);
				if(carYear != 0) {
					totalCareer.innerHTML += "��� " + carYear + "�� " + carMonth + "����<br/>";
				} else {
					if(carMonth == 0) {
						totalCareer.innerHTML += "��� ���� <br/>";
					} else {
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
		
		/* ������ ������ ������ */
		const eduSeq = document.getElementById("eduSeq");
		if(eduSeq.value != "") {
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
					table1.innerHTML = "<thead><tr><th></th><th>���бⰣ</th><th>����</th><th>�б���(������)</th><th>����</th><th>����</th></tr></thead><tbody><tr class='tr1 tr1Clone0'><td><input type='hidden'id='eduSeq'value=''/><input type='checkBox'name='tr1CheckBox'class='tr1CheckBox'value='0'/></td><td><input type='text'name='educationVoList[0].startPeriod'class='dateType educationStartPeriod'maxlength='7'placeholder='YYYY.MM'/><br/>~<br/><input type='text'name='educationVoList[0].endPeriod'class='dateType educationEndPeriod'maxlength='7'placeholder='YYYY.MM'/></td><td><input type='hidden'/><select name='educationVoList[0].division'class='educationDivision'><option value='����'>����</option><option value='����'>����</option><option value='����'>����</option></select></td><td><input type='text'name='educationVoList[0].schoolName'class='educationSchoolName'/><br/><input type='hidden'/><select name='educationVoList[0].location'><option value='����'>����</option><option value='�λ�'>�λ�</option><option value='�뱸'>�뱸</option><option value='��õ'>��õ</option><option value='����'>����</option><option value='����'>����</option><option value='���'>���</option><option value='����'>����</option><option value='���'>���</option><option value='�泲'>�泲</option><option value='���'>���</option><option value='����'>����</option><option value='����'>����</option><option value='����'>����</option><option value='�泲'>�泲</option><option value='���'>���</option></select></td><td><input type='text'name='educationVoList[0].major'/></td><td><input type='text'name='educationVoList[0].grade'/></td></tr></tbody>";
					
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
					table2.innerHTML = "<thead><tr><th></th><th>�ٹ��Ⱓ</th><th>ȸ���</th><th>�μ�/����/��å</th><th>����</th></tr></thead><tbody><tr class='tr2 tr2Clone0'><td><!--üũ�ڽ�--><input type='hidden'id='carSeq'value=''/><input type='checkBox'name='tr2CheckBox'class='tr2CheckBox'value='0'/></td><td><!--�ٹ��Ⱓ--><input type='text'name='careerVoList[0].startPeriod'class='dateType careerStartPeriod'maxlength='7'placeholder='YYYY.MM'/>~<br/><input type='text'name='careerVoList[0].endPeriod'class='dateType careerEndPeriod'maxlength='7'placeholder='YYYY.MM'/></td><td><!--ȸ���--><input type='text'name='careerVoList[0].compName'/></td><td><!--�μ�/����/��å--><input type='text'name='careerVoList[0].task'/><input type='hidden'name='careerVoList[0].salary'/></td><td><!--����--><input type='text'name='careerVoList[0].location'/></td></tr></tbody>";
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
					table3.innerHTML = "<thead><tr><th></th><th>�ڰ�����</th><th>�����</th><th>����ó</th></tr></thead><tbody><tr class='tr3 tr3Clone0'><td><!--üũ�ڽ�--><input type='hidden'id='certSeq'value=''/><input type='checkBox'name='tr3CheckBox'class='tr3CheckBox'value='0'/></td><td><!--�ڰ�����--><input type='text'name='certificateVoList[0].qualifiName'/></td><td><!--�����--><input type='text'name='certificateVoList[0].acquDate'maxlength='7'placeholder='YYYY.MM'/></td><td><!--����ó--><input type='text'name='certificateVoList[0].organizeName'/><br/></td></tr></tbody>";
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
					alert("������ �׸��� üũ���ּ���.");
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
				});
				
				/* �Ѱ��� üũ �ȵǾ����� ��� �˶� */
				if(!check2) {
					alert("������ �׸��� üũ���ּ���.");
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
				});
				
				/* �Ѱ��� üũ �ȵǾ����� ��� �˶� */
				if(!check3) {
					alert("������ �׸��� üũ���ּ���.");
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
												<input type='text' name='educationVoList[0].startPeriod' class='dateType educationStartPeriod' maxlength='7' placeholder='YYYY.MM'/><br/>
												~<br/>
												<input type='text' name='educationVoList[0].endPeriod' class='dateType educationEndPeriod' maxlength='7' placeholder='YYYY.MM'/>
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
												<input type='text' name='educationVoList[0].schoolName' class='educationSchoolName'/><br/>
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
												<input type='text' name='educationVoList[0].major'/>
											</td>
											<td>
												<input type='text' name='educationVoList[0].grade'/>
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
													<input type='text' name='educationVoList[${status.index}].startPeriod' class='dateType educationStartPeriod' maxlength='7' placeholder='YYYY.MM' value='${educationList.startPeriod}'/><br/>
													~<br/>
													<input type='text' name='educationVoList[${status.index}].endPeriod' class='dateType educationEndPeriod' maxlength='7' placeholder='YYYY.MM' value='${educationList.endPeriod}'/>
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
													<input type='text' name='educationVoList[${status.index}].schoolName' class='educationSchoolName' value='${educationList.schoolName}'>
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
													<input type='text' name='educationVoList[${status.index}].major' value='${educationList.major}'/>
												</td>
												<td>
													<input type='text' name='educationVoList[${status.index}].grade' value='${educationList.grade}'>
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
												<input type='text' name='careerVoList[0].startPeriod' class='dateType careerStartPeriod' maxlength='7' placeholder='YYYY.MM' />~<br/>
												<input type='text' name='careerVoList[0].endPeriod' class='dateType careerEndPeriod' maxlength='7' placeholder='YYYY.MM' />
											</td>
											<td><!-- ȸ��� -->
												<input type='text'  name='careerVoList[0].compName'/>
											</td>
											<td><!-- �μ�/����/��å -->
												<input type='text' name='careerVoList[0].task'/>
												<input type='hidden' name='careerVoList[0].salary'/>
											</td>
											<td><!-- ���� -->
												<input type='text' name='careerVoList[0].location'/>
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
													<input type="text" name="careerVoList[${status.index}].startPeriod" class='dateType careerStartPeriod' maxlength='7' placeholder='YYYY.MM' value="${careerList.startPeriod}"/>~<br/>
													<input type="text" name="careerVoList[${status.index}].endPeriod" class='dateType careerEndPeriod' maxlength='7' placeholder='YYYY.MM' value="${careerList.endPeriod}"/>
												</td>
												<td><!-- ȸ��� -->
													<input type="text"  name="careerVoList[${status.index}].compName" value="${careerList.compName}"/>
												</td>
												<td><!-- �μ�/����/��å -->
													<input type="text" name="careerVoList[${status.index}].task" value="${careerList.task}"/>
													<input type="hidden" name="careerVoList[${status.index}].salary" value="${careerList.salary}"/>
												</td>
												<td><!-- ���� -->
													<input type="text" name="careerVoList[${status.index}].location" value="${careerList.location}"/>
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
												<input type='text' name='certificateVoList[0].qualifiName'/>
											</td>
											<td><!-- ����� -->
												<input type='text' name='certificateVoList[0].acquDate' maxlength='7' placeholder='YYYY.MM'/>
											</td>
											<td><!-- ����ó -->
												<input type='text' name='certificateVoList[0].organizeName'/><br/>
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
													<input type="text" name="certificateVoList[${status.index}].qualifiName" value="${certificateList.qualifiName}"/>
												</td>
												<td><!-- ����� -->
													<input type="text" name="certificateVoList[${status.index}].acquDate" class="dateType" maxlength='7' placeholder='YYYY.MM' value="${certificateList.acquDate}"/>
												</td>
												<td><!-- ����ó -->
													<input type="text" name="certificateVoList[${status.index}].organizeName" value="${certificateList.organizeName}"/><br/>
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