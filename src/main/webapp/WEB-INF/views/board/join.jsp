<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardWrite</title>
</head>
<style>
	.joinBox {
		display: flex;
		flex-direction: column;
		justify-content: center;
	}
	form {
		display: flex;
		justify-content: center;
	}
	.phone {
		width: 50px;
	}
	.phone1 {
		width: 35px;
	}
	table tr td:nth-child(2) {
		width: 250px;
		text-align: left;
	}
	.confirm {
		border: 2px solid green;
		outline: none;
	}
	.error {
		border: 2px solid red;
		outline: none;
	}
</style>
<script type="text/javascript">

/* ��ȿ�� �˻� ��ü */
const checkObj = {
	"userId"		: false,
	"userPw"		: false,
	"userPw1" 		: false,
	"userName"		: false,
	"userPhone2"	: false,
	"userPhone3"	: false,
	"userAddr1"		: true,
	"userAddr2"		: true,
	"userCompany"	: true
}


$j(document).ready(function(){
	
	const userId = document.getElementById("userId");
	const userIdMessage = document.getElementById("userIdMessage");
	const userIdDupCheck = document.getElementById("userIdDupCheck");
	const userPw = document.getElementById("userPw");
	const userPw1 = document.getElementById("userPw1");
	const userPwMessage = document.getElementById("userPwMessage");
	const userPw1Message = document.getElementById("userPw1Message");
	const userName = document.getElementById("userName");
	const userNameMessage = document.getElementById("userNameMessage");
	const userPhone2 = document.getElementById("userPhone2");
	const userPhone3 = document.getElementById("userPhone3");
	const userPhone2Message = document.getElementById("userPhone2Message");
	const userPhone3Message = document.getElementById("userPhone3Message");
	const userAddr1 = document.getElementById("userAddr1");
	const userAddr2 = document.getElementById("userAddr2");
	const userAddr1Message = document.getElementById("userAddr1Message");
	const userCompany = document.getElementById("userCompany");
	
	
	function checkEnglishCode(event) {
		  const regExp = /[^0-9a-zA-Z]/g;
		  const ele = event.target;
		  if (regExp.test(ele.value)) {
		    ele.value = ele.value.replace(regExp, '');
		  }
	};
	function checkKoreaCode(event) {
		  const regExp = /[^\u3131-\u318E\uAC00-\uD7A3]/g;
		  const ele = event.target;
		  if (regExp.test(ele.value)) {
		    ele.value = ele.value.replace(regExp, '');
		  }
	};
	function checkNumberCode(event) {
		  const regExp = /[^0-9]/g;
		  const ele = event.target;
		  if (regExp.test(ele.value)) {
		    ele.value = ele.value.replace(regExp, '');
		  }
	};
	
	/* \u3131-\u318E */
	/* \uAC00-\uD7A3 */
	/* ���̵� �Է� Ȯ�� */
	userId.addEventListener("keyup", e => {
		
		checkEnglishCode(e);
		
		if(checkObj.userId = true) {
			checkObj.userId = false;
		}
		
		/* regExp1 = /^[\u3131-\u318E]/g; */
		regExp = /^[a-zA-Z0-9]{4,15}$/;
		
		if(regExp.test(userId.value)) {
			userIdMessage.innerText = "";
		} else {
			userIdMessage.innerText = "����Ǵ� ���ڸ� �̿��Ͽ� 4~15�� �̳��� �ۼ����ּ���.";
		}
	});
	


	/* ���̵� �ߺ��˻� */
	userIdDupCheck.addEventListener("click", function() {
		
		if(userId.value.length == 0) {
			alert("���̵� �Է����ּ���.");
			userId.focus();
			checkObj.userId = false;
			userId.classList.remove("confirm", "error");
			return true;
		}
		
		const regExp = /^[\w]{4,15}$/;
		
		if(regExp.test(userId.value)) {
			$j.ajax({
			    url : "/board/userIdDupCheck.do",
			    dataType: "json",
			    type: "POST",
			    data : {"userId": userId.value},
			    success: function(data, textStatus, jqXHR)
			    {
			    	if(data > 0) {
			    		alert("�̹� ������� ���̵� �Դϴ�.");
			    		userId.focus();
			    		checkObj.userId = false;
			    		userId.classList.add("error");
			    		userId.classList.remove("confirm");
			    	} else {
			    		alert("��� ������ ���̵� �Դϴ�.");
			    		userPw.focus();
			    		checkObj.userId = true;
			    		userId.classList.add("confirm");
			    		userId.classList.remove("error");
			    	}
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("Error");
			    }
			});
		} else {
			alert("����Ǵ� ���ڸ� �̿��Ͽ� 4~15�� �̳��� �ۼ����ּ���.");
			userId.classList.add("error");
			userId.classList.remove("confirm");
		}
	}); /* ���̵� �ߺ��˻� �� */
	

	/* ��й�ȣ �ߺ��˻� */
	userPw.addEventListener("input", function() {
		if(userPw.value.length == 0) {
			userPwMessage.innerText = "��й�ȣ�� 6 ~ 12�ڸ��� �Է����ּ���.";
			checkObj.userPw = false;
			return;
		}
		const regExp = /^[\w!@#_-]{6,12}$/;
		
		if(regExp.test(userPw.value)) {
			userPwMessage.innerText = "";
			checkObj.userPw = true;
			
			if(userPw1.value != 0) {
				/* ��й�ȣ Ȯ�� */
				checkPw();
			}
		} else {
			userPwMessage.innerText = "��й�ȣ�� 6 ~ 12�ڸ��� �Է����ּ���.";
			checkObj.userPw = false;
		}
		
	})

	/* ��й�ȣ Ȯ�� */
	userPw1.addEventListener("input", checkPw);
	function checkPw() {
		if(userPw1.value.length == 0) {
			userPw1Message.innerText = "��й�ȣ Ȯ���� �Է����ּ���.";
			checkObj.userPw1 = false;
			return;
		}
		
		if(userPw1.value == userPw.value) {
			userPw1Message.innerText = "";
			checkObj.userPw1 = true;
		} else {
			userPw1Message.innerText = "��й�ȣ�� ��ġ���� �ʽ��ϴ�.";
			checkObj.userPw1 = false;
		}
	}
	
	/* �̸� �Է� Ȯ�� */
	userName.addEventListener("keyup", e => {
		
		if(userName.value.length == 6) {
			userName.value = userName.value.substr(0,5);
		}
		
		checkKoreaCode(e);
		
		regExp = /^[\uac00-\ud7a3]{2,5}$/;
		if(regExp.test(userName.value)) {
			userNameMessage.innerText = "";
			checkObj.userName = true;
		} else {
			userNameMessage.innerText = "�ѱ� 2 ~ 5�ڸ� �̳��� �Է����ּ���.";
			checkObj.userName = false;
		}
	});
	
	/* ��ȭ��ȣ2 4�ڸ� */	
	userPhone2.addEventListener("input", e => {
		
		const regExp = /^[\d]{4}$/;
		if(regExp.test(userPhone2.value)) {
			checkObj.userPhone2 = true;
			userPhone2Message.innerText = "";
		} else {
			checkObj.userPhone2 = false;
			/* userPhone2.value = ""; */
			userPhone2Message.innerText = "��� ���� 4�ڸ�";
		}
		checkNumberCode(e);
	});
	
	/* ��ȭ��ȣ3 4�ڸ� */
	userPhone3.addEventListener("input", e => {
		const regExp = /^[\d]{4}$/;
		if(regExp.test(userPhone3.value)) {
			checkObj.userPhone3 = true;
			userPhone3Message.innerText = "";
		} else {
			checkObj.userPhone3 = false;
			userPhone3Message.innerText = "������ ���� 4�ڸ�";
		}
		checkNumberCode(e);
	});

	/* �����ȣ XXX-XXX */
	userAddr1.addEventListener("input", e => {
		
    	checkAddressCode(e);
    	
    	if(userAddr1.value.length == 4) {
    		checkDashCode(e);
    	}
		checkObj.userAddr1 = false;
		
		$j(document).keyup(e => {   
            if(e.keyCode === 8){   
            	userAddressCheck();
            	/* �ѹ��� ����� */
            	/* userAddr1.value = ""; */
            } else {
            	userAddressCheck();
            }
	    });
	});
	
	function checkAddressCode(event) {
		  const regExp = /[^0-9\-]/g;
		  const ele = event.target;
		  if (regExp.test(ele.value)) {
		    ele.value = ele.value.replace(regExp, '');
		  }
	};
	
	/* 4��° - ��ü */
 	function checkDashCode(event) {
		  const regExp = /^[\d]{3}[^\-]{1}$/;
		  const regExp1 = /^[\d]{3}[\-]{1}$/;
		  
		  const ele = event.target;
		  if (regExp.test(ele.value)) {
			ele.value = ele.value.substr(0,3) + '-';
		    ele.value = ele.value.replace(regExp1, ele.value);
		  }
	};
	
	function userAddressCheck() {
		const regExp = /^[\d]{3}[\-]{1}[\d]{3}$/;
		if(regExp.test(userAddr1.value)) {
			checkObj.userAddr1 = true;
			userAddr1Message.innerText = "";
		} else {
			
			checkObj.userAddr1 = false;
			userAddr1Message.innerText = "EX ) 123-456";
			
			if(userAddr1.value.length == 0) {
				checkObj.userAddr1 = true;
				userAddr1Message.innerText = "";
			}
		}
	}
	
	
});

	
/* join */
function joinValidate() {
	
	let str;
	
	for(let key in checkObj) {
		if(!checkObj[key]) {
			switch(key) {
			
			case"userId": 			str="���̵� �ߺ�Ȯ���� ���ּ���."; break;
			case"userPw": 			str="��й�ȣ�� 6�ڸ� ~ 12�ڸ��� �Է� �Ǿ����� Ȯ�����ּ���."; break;
			case"userPw1": if(userPw1.value.length == 0) {
								str="��й�ȣ Ȯ���� �Է����ּ���."; break;
							} else {
								str="��й�ȣ�� ��ġ�ϴ��� �ٽ� Ȯ�����ּ���."; break;
							}; break;
			case"userName": 		str="�̸��� �ѱ�(2~5��)�� �Է� �Ǿ����� Ȯ�����ּ���."; break;
			case"userPhone2": 		str="��ȭ��ȣ��  ���� 4�ڸ��� �ԷµǾ����� Ȯ�����ּ���."; break;
			case"userPhone3": 		str="��ȭ��ȣ�� ���� 4�ڸ��� �ԷµǾ����� Ȯ�����ּ���."; break;
			case"userAddr1": 		str="�����ȣ�� EX ) 123-456 ���·� �ùٸ��� �Է� �Ǿ����� Ȯ�����ּ���."; break;
			case"userAddr2": 		str="�ּҰ�"; break;
			case"userCompany": 		str="ȸ�����"; break;
			}
			
			alert(str);
			document.getElementById(key).focus();
			return false;
		}
	}
	return true;
}

</script>
<body>
	<form  action="/board/join.do" method="POST" onsubmit="return joinValidate()">
		<div class="joinBox">
			<a href="/board/boardList.do">List</a>
			<table align="center" border = "1">
				<tr>
					<td width="100" align="center">
						id
					</td>
					<td width="150" align="right">
						<input type="text" maxlength="15" name="userId" id="userId"/>
						<button type="button" id="userIdDupCheck">�ߺ� Ȯ��</button>
						<div id="userIdMessage"></div>
					</td>
				</tr>
				<tr>
					<td width="100" align="center">
						pw
					</td>
					<td width="150" align="right">
						<input type="password" maxlength="12" name="userPw" id="userPw" style="ime-mode:disabled;" autocomplete="false"/>
						<div id="userPwMessage"></div>
					</td>
				</tr>
				<tr>
					<td width="100" align="center">
						pw check
					</td>
					<td width="150" align="right">
						<input type="password" maxlength="12" name="userPw1" id="userPw1" style="ime-mode:disabled;" autocomplete="false"/>
						<div id="userPw1Message"></div>
					</td>
				</tr>
				<tr>
					<td width="100" align="center">
						name
					</td>
					<td width="150" align="right">
						<input type="text" maxlength="5" name="userName" id="userName" style="ime-mode:active"/>
						<div id="userNameMessage"></div>
					</td>
				</tr>
				<tr>
					<td width="100" align="center">
						phone
					</td>
					<td width="150" align="right">
						<select  name="userPhone1" id="userPhone1" class="phone">
							<c:forEach var="phone" items="${phoneList}">
								<option value="${phone.codeId}">${phone.codeName}</option>
							</c:forEach>
						</select>
						-
						<input type="text" maxlength="4" name="userPhone2" id="userPhone2" class="phone1" />
						-
						<input type="text" maxlength="4" name="userPhone3" id="userPhone3" class="phone1" />
					<div id="userPhone2Message"></div>
					<div id="userPhone3Message"></div>
					</td>
				</tr>
				<tr>
					<td width="100" align="center">
						postNo
					</td>
					<td width="150" align="right">
						<input type="text" maxlength="7" name="userAddr1" id="userAddr1"/>
						<div id="userAddr1Message"></div>
					</td>
				</tr>
				<tr>
					<td width="100" align="center">
						address
					</td>
					<td width="150" align="right">
						<input type="text" maxlength="50" name="userAddr2" id="userAddr2"/>
					</td>
				</tr>
				<tr>
					<td width="100" align="center">
						company
					</td>
					<td width="150" align="right">
						<input type="text" maxlength="30" name="userCompany" id="userCompany"/>
					</td>
				</tr>
			</table>
			<button type="submit">join</button>
		</div>
	</form>	
</body>
</html>