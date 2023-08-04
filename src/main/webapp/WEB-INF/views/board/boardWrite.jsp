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

	function changeFn(){
		var codeId = document.getElementById("codeId");
		var codeIdType = document.getElementById("codeIdType");
		var selectCodeIdType = (codeIdType.options[codeIdType.selectedIndex].value);
		/* alert("selectCodeIdType = "+selectCodeIdType); */
		codeId.value = selectCodeIdType;
	}
	
	$j(document).ready(function(){
	
		$j("#submit").on("click",function(){
			var $frm = $j('.boardWrite :input');
			var param = $frm.serialize();
			console.log($frm);			
			console.log(param);
			
			$j.ajax({
			    url : "/board/boardWriteAction.do",
			    dataType: "json",
			    type: "POST",
			    data : param,
			    success: function(data, textStatus, jqXHR)
			    {
			    	if(data.update == 'Y') {
			    		console.log(data);
						alert("수정완료");
						console.log(data);
						alert("update:"+data.success);
			    	}
			    	if(data.success == 'Y') {
			    		console.log(data);
						alert("작성완료");
						console.log(data);
						alert("Success:"+data.success);
			    	}
			    	
					location.href = "/board/boardList.do";
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("Error");
			    }
			});
		});
	});
	

</script>
<body>
<form class="boardWrite">

	<c:if test="${type == 'update'}"> 
		<input name="boardType" type="hidden" value="${boardType}" />
		<input name="boardNum" type="hidden" value="${boardNum}" />
	</c:if>

	<input name="codeId" id="codeId" type="hidden" value="${boardType}" />

	<table align="center">
		<tr>
			<td align="right">
				<input name="type" id="type" type="hidden" value="${type}" />
				
				<c:if test="${type == 'write'}"> 
					<input id="submit" type="button" value="작성 완료">
				</c:if>
				<c:if test="${type == 'update'}"> 
					<input id="submit" type="button" value="수정 완료 ">
				</c:if>
			</td>
		</tr>
		<tr>
			<td>
				<table border ="1"> 
					<tr>
						<td width="120" align="center">
						Type
						</td>
						<td width="400">
							<select id="codeIdType" onchange="changeFn()">
								<c:forEach var="typeList" items="${boardTypeList}">
									<c:choose>
										<c:when test="${!empty board.boardType}">
											<c:if test="${board.boardType.equals(typeList.codeId)}">
												<option name="codeIdType" value="${board.boardType}" selected>${board.codeName}</option>
											</c:if>
											<c:if test="${!board.boardType.equals(typeList.codeId)}">
												<option name="codeIdType" value="${typeList.codeId}">${typeList.codeName}</option>
											</c:if>
										</c:when>
										<c:otherwise>
											<option name="codeIdType" value="${typeList.codeId}">${typeList.codeName}</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
						Title
						</td>
						<td width="400">
						<input name="boardTitle" type="text" size="50" value="${board.boardTitle}"> 
						</td>
					</tr>
					<tr>
						<td height="300" align="center">
						Comment
						</td>
						<td valign="top">
						<textarea name="boardComment"  rows="20" cols="55">${board.boardComment}</textarea>
						</td>
					</tr>
					<tr>
						<td align="center">
						Writer
						</td>
						<td>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="right">
				<a href="/board/boardList.do">List</a>
			</td>
		</tr>
	</table>
</form>	
</body>
</html>