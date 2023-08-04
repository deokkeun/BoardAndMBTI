<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardWrite</title>
<style>
#container {
	width: 80%;
	margin: auto;
	text-align: center;
}
#title {
	font-size: 40px;
	font-weight: bold;
	margin: 100px;
}
#comment,
.resultComment {
	font-size: 28.43px;
	font-weight: bold;
	margin: 20px;
}
label {
	font-size: 21.33px;
}
.nextBtn,
.reset {
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
<!-- <script type="text/javascript">

	$j(document).ready(function(){});
	
	function mbtiValidate() {
		
		const boardTypeClass = document.getElementsByClassName("boardType");
		var arr = new Array(); 
		for (i = 0; i < boardTypeClass.length; i++) {
			arr[i] = boardTypeClass[i];
		} 

		const mbtiType = document.getElementById("mbtiType");
		
		let sum = 0;
		let startSum = 0;
		let endSum = 0;
		
		let left = 0;
		let leftYes = 0;
		let leftNo = 0;
	
		let right = 0;
		let rightYes = 0;
		let rightNo = 0;
  
		for(let i = 0; i < arr.length; i++) {
			if($j('input:radio[name=' + i + ']').is(":checked") === false) {
				alert("선택사항을 모두 체크해주세요");
				return false;
			}
			/* E < I */
			if(arr[i].value.charCodeAt(0) < arr[i].value.charCodeAt(1)) {
				/* 0, 1, 2 (EI 유형) / EX) 평균(-4) 중간 낮으면 E, 높으면 I */
				left = parseInt(document.querySelector('input[name="' + i + '"]:checked').value) - 4;
				if(left >= 0) {
					/* EX) I 플러스점수 */
					leftNo = Math.abs(left);
					endSum += leftNo;
					alert("I 점수" + leftNo);
				} else {
					/* EX) E 플러스점수 */
					leftYes = Math.abs(left);
					startSum += leftYes;
					alert("E 점수" + leftYes);
				}
			} else { /* E > I */
				/* 3, 4 (IE 유형) / EX) 평균(-4) 중간 낮으면 I, 높으면 E */
				right = parseInt(document.querySelector('input[name="' + i + '"]:checked').value) - 4;
				if(right >= 0) {
					/* EX) E 플러스점수 */
					rightNo = Math.abs(right);
					startSum += rightNo;
					alert("E 점수" + rightNo);
				} else {
					/* EX) I 플러스점수 */
					rightYes = Math.abs(right);
					endSum += rightYes;
					alert("I 점수" + rightYes);
				}
			}
		}
		
		/* 알파벳 빠른순 총합 점수로 E / I 결과 */
		alert("E 합산점수" + startSum)
		alert("I 합산점수" + endSum)
		
		sum = startSum - endSum;
		
		alert("합계 결과" + sum);
		
		const fast = Math.min(boardType.value.charCodeAt(0), boardType.value.charCodeAt(1));
		const low = Math.max(boardType.value.charCodeAt(0), boardType.value.charCodeAt(1));
		const fastWord = String.fromCharCode(fast); /* 빠른 알파벳 EX) E */
		const lowWord = String.fromCharCode(low); /* 느린 알파벳 EX) I */
		const startWord = fastWord + lowWord; /* EI */
		const endWord = lowWord + fastWord; /* IE */
		
		if(boardType.value == "EI" || boardType.value == "IE") {
			if(sum >= 0) {
				mbtiType.value = fastWord;
			} else {
				mbtiType.value = lowWord;
			};
			boardType.value = "NS";
		} else if(boardType.value == "NS" || boardType.value == "SN") {
			if(sum >= 0) {
				mbtiType.value += fastWord;
			} else {
				mbtiType.value += lowWord;
			};
			boardType.value = "FT";
		} else if(boardType.value == "FT" || boardType.value == "TF") {
			if(sum >= 0) {
				mbtiType.value += fastWord;
			} else {
				mbtiType.value += lowWord;
			};
			boardType.value = "JP";
		} else if(boardType.value == "JP" || boardType.value == "PJ") {
			if(sum >= 0) {
				mbtiType.value += fastWord;
			} else {
				mbtiType.value += lowWord;
			};
			boardType.value = "result";
		}
		return true;
	};
</script> -->
<body>
<!-- JS 계산 (MBTI) -->
<%-- 	<form action="/board/mbtiStart.do?boardType=${boardList[0].boardType}" method="GET" onsubmit="return mbtiValidate()"> --%>
	<form action="/board/mbtiStart.do?boardType=${boardList[0].boardType}" method="GET">
		<c:forEach var="list" items="${boardList}" varStatus="status">
			<input type="text" name="boardType${status.index}" id="boardType${status.index}" class="boardType" value="${list.boardType}" />
		</c:forEach>
		<input type="text" name="mbtiType" id="mbtiType" value="${mbtiType}" />
		
		<div id="container">
			<c:if test="${!empty boardList}">
				<div id="title">
					무료성격 유형 검사
				</div>
			</c:if>
			<c:if test="${empty boardList}">
				<div id="title">
					당신의 성격 유형은:
				</div>
				<div class="resultComment">			
					${mbtiType}
				</div>
			</c:if>
			<c:forEach var="list" items="${boardList}">
				<div id="comment">
					${list.boardComment}
				</div>
				<div>
					<label for="yes">
						동의
						<input type="radio" name="${list.boardNum}" id="yes" value="1">
					</label>
						<input type="radio" name="${list.boardNum}" value="2">
						<input type="radio" name="${list.boardNum}" value="3">
						<input type="radio" name="${list.boardNum}" value="4">
						<input type="radio" name="${list.boardNum}" value="5">
						<input type="radio" name="${list.boardNum}" value="6">
					<label for="No">
						<input type="radio" name="${list.boardNum}" id="No" value="7">
						비동의
					</label>
				</div>
				<hr/>
			</c:forEach>
		</div>
		<c:if test="${!empty boardList}">
			<button type="submit" class="nextBtn">다음</button>
		</c:if>
		<c:if test="${empty boardList}">
			<a href="/board/boardList.do" class="reset">처음으로</a>
		</c:if>
	</form>
</body>
</html>