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

/* 유효성 검사 객체 */
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
	
	
	/* 아이디 중복검사 */
	userIdDupCheck.addEventListener("click", function() {
		if(userId.value.length == 0) {
			alert("아이디를 입력해주세요.");
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
			    		alert("이미 사용중인 아이디 입니다.");
			    		userId.focus();
			    		checkObj.userId = false;
			    		userId.classList.add("error");
			    		userId.classList.remove("confirm");
			    	} else {
			    		alert("사용 가능한 아이디 입니다.");
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
			alert("영어또는 숫자를 이용하여 4~15자 이내로 작성해주세요.");
			userId.value = "";
			userId.classList.add("error");
			userId.classList.remove("confirm");
		}
	}); /* 아이디 중복검사 끝 */
	

	/* 비밀번호 중복검사 */
	userPw.addEventListener("input", function() {
		if(userPw.value.length == 0) {
			alert("Pw 는 6자리 ~ 12자리");
			userPwMessage.innerText = "Pw 는 6자리 ~ 12자리";
			checkObj.userPw = false;
			return;
		}
		
		const regExp = /^[\w!@#_-]{6,12}$/;
		
		if(regExp.test(userPw.value)) {
			userPwMessage.innerText = "";
			checkObj.userPw = true;
			
			if(userPw1.value != 0) {
				/* 비밀번호 확인 */
				checkPw();
			}
		} else {
			userPwMessage.innerText = "Pw 는 6자리 ~ 12자리";
			checkObj.userPw = false;
		}
		
	})

	/* 비밀번호 확인 */
	userPw1.addEventListener("input", checkPw);
	function checkPw() {
		if(userPw1.value == userPw.value) {
			userPw1Message.innerText = "";
			checkObj.userPw1 = true;
		} else {
			userPw1Message.innerText = "Pw 는 6자리 ~ 12자리";
			checkObj.userPw1 = false;
		}
	}
	
	/* 이름 입력 확인 */
	userName.addEventListener("input", function() {
		if(userName.value.length != 0) {
			checkObj.userName = true;
		} else {
			checkObj.userName = false;
		}
	});

	/* 전화번호2 4자리 */	
	userPhone2.addEventListener("input", function() {
		const regExp = /^[\d]{4}$/;
		if(regExp.test(userPhone2.value)) {
			checkObj.userPhone2 = true;
		} else {
			checkObj.userPhone2 = false;
		}
	});
	
	/* 전화번호3 4자리 */
	userPhone3.addEventListener("input", function() {
		const regExp = /^[\d]{4}$/;
		if(regExp.test(userPhone3.value)) {
			checkObj.userPhone3 = true;
		} else {
			checkObj.userPhone3 = false;
		}
	});

	/* 우편번호 XXX-XXX */
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
	
	/* 주소 */
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
			case"userId": 			str="아이디가"; break;
			case"userPw": 			str="비밀번호가"; break;
			case"userPw1": 			str="비밀번호 확인이"; break;
			case"userName": 		str="이름이"; break;
			case"userPhone2": 		str="전화번호가"; break;
			case"userPhone3": 		str="전화번호가"; break;
			case"userAddr1": 		str="우편번호가"; break;
			case"userAddr2": 		str="주소가"; break;
			case"userCompany": 		str="회사명이"; break;
			}
			
			str += " 유효하지 않습니다.";
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
						<button type="button" id="userIdDupCheck">중복 확인</button>
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