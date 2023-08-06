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
	"userAddr1"		: false,
	"userAddr2"		: false,
	"userCompany"	: true
}


$j(document).ready(function(){
	
	const userId = document.getElementById("userId");
	const userIdDupCheck = document.getElementById("userIdDupCheck");
	const userPw = document.getElementById("userPw");
	const userPw1 = document.getElementById("userPw1");
	const userPwMessage = document.getElementById("userPwMessage");
	const userPw1Message = document.getElementById("userPw1Message");
	const userName = document.getElementById("userName");
	const userPhone2 = document.getElementById("userPhone2");
	const userPhone3 = document.getElementById("userPhone3");
	const userAddr1 = document.getElementById("userAddr1");
	const userAddr2 = document.getElementById("userAddr2");
	const userAddr1Message = document.getElementById("userAddr1Message");
	const userCompany = document.getElementById("userCompany");
	
	
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
			userId.value = "";
			userId.classList.add("error");
			userId.classList.remove("confirm");
		}
	}); /* ���̵� �ߺ��˻� �� */
	

	/* ��й�ȣ �ߺ��˻� */
	userPw.addEventListener("input", function() {
		if(userPw.value.length == 0) {
			alert("Pw �� 6�ڸ� ~ 12�ڸ�");
			userPwMessage.innerText = "Pw �� 6�ڸ� ~ 12�ڸ�";
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
			userPwMessage.innerText = "Pw �� 6�ڸ� ~ 12�ڸ�";
			checkObj.userPw = false;
		}
		
	})

	/* ��й�ȣ Ȯ�� */
	userPw1.addEventListener("input", checkPw);
	function checkPw() {
		if(userPw1.value == userPw.value) {
			userPw1Message.innerText = "";
			checkObj.userPw1 = true;
		} else {
			userPw1Message.innerText = "Pw �� 6�ڸ� ~ 12�ڸ�";
			checkObj.userPw1 = false;
		}
	}
	
	/* �̸� �Է� Ȯ�� */
	userName.addEventListener("input", function() {
		if(userName.value.length != 0) {
			checkObj.userName = true;
		} else {
			checkObj.userName = false;
		}
	});

	/* ��ȭ��ȣ2 4�ڸ� */	
	userPhone2.addEventListener("input", function() {
		const regExp = /^[\d]{4}$/;
		if(regExp.test(userPhone2.value)) {
			checkObj.userPhone2 = true;
		} else {
			checkObj.userPhone2 = false;
		}
	});
	
	/* ��ȭ��ȣ3 4�ڸ� */
	userPhone3.addEventListener("input", function() {
		const regExp = /^[\d]{4}$/;
		if(regExp.test(userPhone3.value)) {
			checkObj.userPhone3 = true;
		} else {
			checkObj.userPhone3 = false;
		}
	});

	/* �����ȣ XXX-XXX */
	userAddr1.addEventListener("input", function() {
		const regExp = /^[\d]{3}-[\d]{3}$/;
		if(regExp.test(userAddr1.value)) {
			checkObj.userAddr1 = true;
			userAddr1Message.innerText = "";
		} else {
			checkObj.userAddr1 = false;
			userAddr1Message.innerText = "EX ) 123-456";
		}
	});
	
	/* �ּ� */
	userAddr2.addEventListener("input", function() {
		if(userAddr2.value.length != 0) {
			checkObj.userAddr2 = true;
		} else {
			checkObj.userAddr2 = false;
		}
	});

	
	
	
});





	
/* join */
function joinValidate() {
	
	let str;
	
	for(let key in checkObj) {
		if(!checkObj[key]) {
			switch(key) {
			case"userId": 			str="���̵�"; break;
			case"userPw": 			str="��й�ȣ��"; break;
			case"userPw1": 			str="��й�ȣ Ȯ����"; break;
			case"userName": 		str="�̸���"; break;
			case"userPhone2": 		str="��ȭ��ȣ��"; break;
			case"userPhone3": 		str="��ȭ��ȣ��"; break;
			case"userAddr1": 		str="�����ȣ��"; break;
			case"userAddr2": 		str="�ּҰ�"; break;
			case"userCompany": 		str="ȸ�����"; break;
			}
			
			str += " ��ȿ���� �ʽ��ϴ�.";
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
						<input type="text" name="userId" id="userId"/>
						<button type="button" id="userIdDupCheck">�ߺ� Ȯ��</button>
					</td>
				</tr>
				<tr>
					<td width="100" align="center">
						pw
					</td>
					<td width="150" align="right">
						<input type="text" name="userPw" id="userPw"/>
						<div id="userPwMessage"></div>
					</td>
				</tr>
				<tr>
					<td width="100" align="center">
						pw check
					</td>
					<td width="150" align="right">
						<input type="text" name="userPw1" id="userPw1"/>
						<div id="userPw1Message"></div>
					</td>
				</tr>
				<tr>
					<td width="100" align="center">
						name
					</td>
					<td width="150" align="right">
						<input type="text" name="userName" id="userName"/>
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
						<input type="text" name="userPhone2" id="userPhone2" class="phone1" />
						-
						<input type="text" name="userPhone3" id="userPhone3" class="phone1" />
					</td>
				</tr>
				<tr>
					<td width="100" align="center">
						postNo
					</td>
					<td width="150" align="right">
						<input type="text" name="userAddr1" id="userAddr1"/>
						<div id="userAddr1Message"></div>
					</td>
				</tr>
				<tr>
					<td width="100" align="center">
						address
					</td>
					<td width="150" align="right">
						<input type="text" name="userAddr2" id="userAddr2"/>
					</td>
				</tr>
				<tr>
					<td width="100" align="center">
						company
					</td>
					<td width="150" align="right">
						<input type="text" name="userCompany" id="userCompany"/>
					</td>
				</tr>
			</table>
			<button type="submit">join</button>
		</div>
	</form>	
</body>
</html>