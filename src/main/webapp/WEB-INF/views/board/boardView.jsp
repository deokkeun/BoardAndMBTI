<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardView</title>
</head>
<body>
<table align="center">
	<tr>
		<td>
			<table border ="1">
				<tr>
					<td width="120" align="center">
					Type
					</td>
					<td width="400">
						${board.codeName}
					</td>
				</tr>
				<tr>
					<td width="120" align="center">
					Title
					</td>
					<td width="400">
					${board.boardTitle}
					</td>
				</tr>
				<tr>
					<td height="300" align="center">
					Comment
					</td>
					<td>
					${board.boardComment}
					</td>
				</tr>
				<tr>
					<td align="center">
					Writer
					</td>
					<td>
					${board.creator}
					<!-- SYSTEM이 아닌경우 -->
					<%-- <c:if test="${board.creator != 'SYSTEM'}">
					</c:if> --%>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="right">
			<a href="/board/boardList.do">List</a>
			
			<c:if test="${board.creator.equals(loginMember.userName)}">
				<form action="/board/boardWrite.do" method="GET" onsubmit="typeValidate('update')">
					<button type="submit" id="boardUpdate">Update</button>
					<input name="boardType" type="hidden" value="${boardType}">
					<input name="boardNum"  type="hidden" value="${boardNum}">
				</form>
				<form action="/board/${boardType}/${boardNum}/boardDelete.do" method="GET" onsubmit="typeValidate('delete')">
					<button type="submit" id="boardDelete">Delete</button>
	 				<input name="type" type="hidden" value="delete">
	 				<input name="boardType" type="hidden" value="${boardType}">
					<input name="boardNum"  type="hidden" value="${boardNum}">
				</form>
			</c:if>
			<c:if test="${!board.creator.equals(loginMember.userName)}">
			
			</c:if>
			<c:if test="${empty loginMember.userName}">
				<c:if test='${board.creator.equals("SYSTEM")}'>
					<form action="/board/boardWrite.do" method="GET" onsubmit="typeValidate('update')">
						<button type="submit" id="boardUpdate">Update</button>
						<input name="boardType" type="hidden" value="${boardType}">
						<input name="boardNum"  type="hidden" value="${boardNum}">
					</form>
					<form action="/board/${boardType}/${boardNum}/boardDelete.do" method="GET" onsubmit="typeValidate('delete')">
						<button type="submit" id="boardDelete">Delete</button>
		 				<input name="type" type="hidden" value="delete">
		 				<input name="boardType" type="hidden" value="${boardType}">
						<input name="boardNum"  type="hidden" value="${boardNum}">
					</form>
				</c:if>
			</c:if>
			<script>
				function typeValidate(type) {

					if(type == "update") {
						if(confirm("update?")) {
							alert("update!!!");
							
							return true;
						}
					} else if(type == "delete") {
						if(confirm("delete?")) {
							alert("delete!!!");
							return true;
						}
					}
				}
			</script>
		</td>
	</tr>
</table>	
</body>
</html>