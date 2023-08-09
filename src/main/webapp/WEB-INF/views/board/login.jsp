<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardWrite</title>
</head>
<script type="text/javascript">
		
/* 		$j.ajax({
		    url : "/board/userIdDupCheck.do",
		    dataType: "json",
		    type: "POST",
		    data : {"userId": userId.value},
		    success: function(data, textStatus, jqXHR)
		    {
		    	if(data == 0) {
		    		alert("아이디를 다시 확인해주세요.");
		    		return false;
		    	}
		    },
		    error: function (jqXHR, textStatus, errorThrown)
		    {
		    	alert("Error");
		    }
		}); */

	$j(document).ready(function(){
		const userId = document.getElementById("userId");
		const userPw = document.getElementById("userPW");
	});
		
		function loginValidate() {
			if(userId.value.length == 0) {
				alert("아이디를 입력해주세요.");
				userId.focus();
				return false;
			}
			
			if(userPw.value.length == 0) {
				alert("비밀번호를 입력해주세요.");
				userPw.focus();
				return false;
			}
		}
		

	
	
</script>
<body>


<form  action="/board/login.do" method="POST" onsubmit="return loginValidate()">
	<table align="center" border = "1">
		<tr>
			<td width="100" align="center">
				id
			</td>
			<td width="150" align="right">
				<input type="text" maxlength="15" name="userId" id="userId"/>
			</td>
		</tr>
		<tr>
			<td width="100" align="center">
				pw
			</td>
			<td width="150" align="right">
				<input type="password" maxlength="12" name="userPw" id="userPw" style="ime-mode:disabled;" autocomplete="false"/>
			</td>
		</tr>
	</table>
	<table align="center">
		<tr>
			<td width="100" ></td>
			<td width="150" align="right">
				<button type="submit">login</button>
			</td>
		</tr>
	</table>
</form>	
</body>
</html>