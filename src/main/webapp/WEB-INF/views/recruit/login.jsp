<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>recruit</title>
</head>
<script type="text/javascript">
		
	$j(document).ready(function(){});
	
	function loginValidate() {
		const name = document.getElementById("name");
		const phone = document.getElementById("phone");
		
		if(name.value.length == 0) {
			alert("이름을 입력해주세요");
			name.focus();
			return false;
		}
		if(phone.value.length == 0) {
			alert("휴대폰번호를 입력해주세요");
			phone.focus();
			return false;
		}
		
		return true;
	}
	
</script>
<body>
	<form  action="/recruit/main.do" method="POST" onsubmit="return loginValidate()">
		<table align="center" border = "1">
			<tr>
				<td width="100" align="center">
					이름
				</td>
				<td width="150" align="right">
					<input type="text" maxlength="15" name="name" id="name"/>
				</td>
			</tr>
			<tr>
				<td width="100" align="center">
					휴대폰번호
				</td>
				<td width="150" align="right">
					<input type="text" name="phone" id="phone"/>
				</td>
			</tr>
			<tr>
				<td width="250" align="center" colspan="2">
					<button type="submit">입사지원</button>
				</td>
			</tr>
		</table>
	</form>	
</body>
</html>