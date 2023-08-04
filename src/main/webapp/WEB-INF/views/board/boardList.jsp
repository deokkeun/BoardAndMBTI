<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>list</title>
<style>
.nextBtn {
	margin: 100px auto;
	padding: 14px 40px;
	width: 300px;
	height: 60px;
	border-radius: 30px;
	display: flex;
	justify-content: center;
	align-items: center;
	font-size: 28.43px;
	font-weight: bold;
	background-color: #88619A;
	border: none;
	color: #ddd;
	text-decoration: none;
}
</style>
</head>
<script type="text/javascript">

	$j(document).ready(function(){
		
		const searchBtn = document.getElementById("searchBtn");
		const AllCodeId = document.getElementsByClassName("codeId");
		const allCheck = document.getElementById("allCheck");
		const boardTable = document.getElementById("boardTable");
		const total = document.getElementById("total");
		
		let checkStr = "";
		let confirm = false;
		
		allCheck.addEventListener("click", function() {
			
			confirm = !confirm;
			console.log(confirm);
			
			if(confirm) {
				
				for(let codeId of AllCodeId) {
					codeId.checked=true;
					/* codeId.setAttribute("checked", true); */
					codeId.setAttribute("checked", true);
					checkStr += codeId.value + ",";
				}
			} else {
				for(let codeId of AllCodeId) {
					/* codeId.removeAttribute("checked"); */
					codeId.checked=false;
					checkStr = "";
				}
			}
			console.log(checkStr);
		});
		
		searchBtn.addEventListener("click", function() {
			
			const listBoardType = document.getElementsByClassName("listBoardType");
			checkStr = "";
			
			for(let codeId of AllCodeId) {
				
				if(codeId.checked) {
					console.log("codeId.value::" + codeId.value);
					if(codeId.value == 'a00') { /* 전체 */
						checkStr = codeId.value;
						console.log(checkStr);
						break;
					} else {
						checkStr += codeId.value + ",";
						console.log(checkStr);
					}
				}
			}
			
			$j.ajax({
			    url : "/board/boardList.do",
			    dataType: "json",
			    type: "POST",
			    data : {"checkStr": checkStr},
			    success: function(data, textStatus, jqXHR)
			    {
			    	total.innerText = "total : " + data.boardList.length;
			    	
			    	boardTable.innerHTML = "";
			    	const tr1 = document.createElement( 'tr' );
			    	tr1.innerHTML = '<tr><td width="80" align="center">Type</td><td width="40" align="center">No</td><td width="300" align="center">Title</td></tr>';
			    	boardTable.append(tr1);
			    	
			    	console.log(data.boardList.length + "길이");
			    	for(let i = 0; i < data.boardList.length; i++) {
				    	/* console.log(data.boardList[i].codeName);
				    	console.log(data.boardList[i].boardNum);
				    	console.log(data.boardList[i].boardType);
				    	console.log(data.boardList[i].boardTitle); */
				    	/* ajaxBoardList.innerHTML = `<tr> <td align="center" class="listBoardType"> ${list.codeName} </td> <td> ${list.boardNum} </td> <td> <a href = "/board/${list.boardType}/${list.boardNum}/boardView.do?pageNo=${pageNo}"> ${data.boardList[i].codeName} </a> </td> </tr>`; */
				    	const tr2 = document.createElement( 'tr' );     data.boardList[i].boardNum
				  		tr2.innerHTML = '<tr> <td align="center" class="listBoardType">' + data.boardList[i].codeName + '</td> <td>' + data.boardList[i].boardNum + '</td> <td> <a href = "/board/' + data.boardList[i].boardType + '/' + data.boardList[i].boardNum + '/boardView.do?pageNo=' + data.pageNo + '">' + data.boardList[i].boardTitle + '</a> </td> </tr>';
				    	boardTable.append(tr2);
			    	}
			    	
			    	/* alert("Success"); */
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
<table  align="center">
	<tr>
		<td align="right" id="total">
			total : ${totalCnt}
		</td>
	</tr>
	<tr>
		<td>
			<table id="boardTable" border = "1">
				<tr>
					<td width="80" align="center">
						Type
					</td>
					<td width="40" align="center">
						No
					</td>
					<td width="300" align="center">
						Title
					</td>
				</tr>
				<c:forEach items="${boardList}" var="list">
					<tr id="ajaxBoardList">
						<td align="center" class="listBoardType">
							${list.codeName}
						</td>
						<td>
							${list.boardNum}
						</td>
						<td>
							<a href = "/board/${list.boardType}/${list.boardNum}/boardView.do?pageNo=${pageNo}">${list.boardTitle}</a>
						</td>
					</tr>	
				</c:forEach>
			</table>
		</td>
	</tr>
	<tr>
		<td align="right">
			<a href ="/board/boardWrite.do">글쓰기</a>
		</td>
	</tr>
	<tr>
		<td>
			<label for="allCheck">
				<input id="allCheck" class="codeId" type="checkBox" value="전체">
				전체
			</label>
			<c:forEach var="typeList" items="${boardTypeList}">
				<label for="${typeList.codeId}">
					<input id="${typeList.codeId}" class="codeId" type="checkBox" value="${typeList.codeId}">
					${typeList.codeName}
				</label>
			</c:forEach>
			<button id="searchBtn" type="button">조회</button>
		</td>
	</tr>
</table>
<a href="/board/mbtiStart.do?boardType0=start" class="nextBtn">mbti test</a>	
</body>
</html>