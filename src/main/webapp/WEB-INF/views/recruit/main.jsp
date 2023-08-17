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

</style>
</head>
<script type="text/javascript">
		
	let tr1Num = 0; /* �з� ���̺� �� ���� (�߰� / ����) */
	let tr2Num = 0; /* ��� ���̺� �� ���� (�߰� / ����) */
	let tr3Num = 0; /* �ڰ��� ���̺� �� ���� (�߰� / ����) */
	
	$j(document).ready(function(){
		tr1Num = $j(".tr1CheckBox").last().val();
		
		/* ************** ���� ���� ��� ��Ȱ��ȭ ************** */
		const submit = document.getElementById("submit");
		if(submit.value == 'TRUE') {
			/* input, select, button ��Ȱ��ȭ */
			const input = document.getElementsByTagName("input");
			const select = document.getElementsByTagName("select");
			const button = document.getElementsByTagName("button");
			for(let i = 0; i < input.length; i++) {
				input[i].setAttribute("disabled", true);
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
					table1.innerHTML = "<thead><tr><th></th><th>���бⰣ</th><th>����</th><th>�б���(������)</th><th>����</th><th>����</th></tr></thead><tbody><tr class='tr1 tr1Clone0'><td><input type='checkBox'name='tr1CheckBox'class='tr1CheckBox'value='0'/></td><td><input type='text'name='educationVoList[0].startPeriod'/><br/>~<br/><input type='text'name='educationVoList[0].endPeriod'/></td><td><select name='educationVoList[0].division'><option value='����'>����</option><option value='����'>����</option><option value='����'>����</option></select></td><td><input type='text'name='educationVoList[0].schoolName'/><br/><select name='educationVoList[0].location'><option value='����'>����</option><option value='�λ�'>�λ�</option><option value='�뱸'>�뱸</option><option value='��õ'>��õ</option><option value='����'>����</option><option value='����'>����</option><option value='���'>���</option><option value='����'>����</option><option value='���'>���</option><option value='�泲'>�泲</option><option value='���'>���</option><option value='����'>����</option><option value='����'>����</option><option value='����'>����</option><option value='�泲'>�泲</option><option value='���'>���</option></select></td><td><input type='text'name='educationVoList[0].major'/></td><td><input type='text'name='educationVoList[0].grade'/></td></tr></tbody>";
					table1.style.border = "1px solid black";
					return true;
				}
				
				alert("btn1");
				const tr1Clone = tr1[tr1.length - 1].cloneNode(true);
				
				++tr1Num;
				
				/* input, select �ʱ�ȭ, name�� ���� */
				const input = tr1Clone.getElementsByTagName("input");
				const select = tr1Clone.getElementsByTagName("select");
				for(let i = 0; i < input.length; i++) {
					input[i].value = "";
				}
				input[2].setAttribute("name", "educationVoList[" + tr1Num + "].startPeriod");
				input[3].setAttribute("name", "educationVoList[" + tr1Num + "].endPeriod");
				input[4].setAttribute("name", "educationVoList[" + tr1Num + "].schoolName");
				input[5].setAttribute("name", "educationVoList[" + tr1Num + "].major");
				input[6].setAttribute("name", "educationVoList[" + tr1Num + "].grade");
				select[0].setAttribute("name", "educationVoList[" + tr1Num + "].division");
				select[1].setAttribute("name", "educationVoList[" + tr1Num + "].location");
			
				tr1Clone.classList.add("tr1Clone" + tr1Num);
				tr1Clone.querySelector(".tr1CheckBox").value = tr1Num;
				tr1[tr1.length - 1].after(tr1Clone);
			} else if($j(this).val() == "tr2PlusBtn") {
				if(tr2[0] == null) {
					table2.innerHTML = "main.jsp 86��° ��";
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
				tr2Clone.classList.add("tr2Clone" + tr2Num);
				tr2Clone.querySelector(".tr2CheckBox").value = tr2Num;
				tr2[tr2.length - 1].after(tr2Clone);
				
			} else if($j(this).val() == "tr3PlusBtn") {
				if(tr3[0] == null) {
					table3.innerHTML = "main.jsp 107��° ��";
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
				tr3Clone.classList.add("tr3Clone" + tr3Num);
				tr3Clone.querySelector(".tr3CheckBox").value = tr3Num;
				tr3[tr3.length - 1].after(tr3Clone);
			}
			

			
		});
		

	
		/* ���̺� ���� */
		$j(".minusBtn").on("click", function() {
			if($j(this).val() == "tr1MinusBtn") {
				$j(".tr1CheckBox:checked").each(function() {
					const tr1El = document.getElementsByClassName("tr1Clone" + $j(this).val());
					
					/* eduSeq */
					console.log($j(this).prev().val());
					
					
					tr1El[0].remove();
					alert($j(this).val());
				});
			} else if($j(this).val() == "tr2MinusBtn") {
				$j(".tr2CheckBox:checked").each(function() {
					const tr2El = document.getElementsByClassName("tr2Clone" + $j(this).val());
					tr2El[0].remove();
					alert($j(this).val());
				});
			} else if($j(this).val() == "tr3MinusBtn") {
				$j(".tr3CheckBox:checked").each(function() {
					const tr3El = document.getElementsByClassName("tr3Clone" + $j(this).val());
					tr3El[0].remove();
					alert($j(this).val());
				});
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
			    	alert(data);
					alert("���� �Ϸ�");
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("Error");
			    }
			});
		}); /* ���� */
	
		
	}); /* $j(document).ready(function() */

	
</script>
<body>
	<form action="/recruit/submit.do" method="POST"><!-- ���� -->
		<input type="hidden" name="seq" value="${recruit.seq}"/>
		<input type="hidden" name="submit" id="submit" value="${recruit.submit}"/>
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
									<input type="text" maxlength="15" name="birth" id="birth" value="${recruit.birth}"/>
								</td>
							</tr>
							<tr>
								<td width="100" align="center">
									����
								</td>
								<td width="150" align="left">
									<select name="gender">
										<option value="����">����</option>
										<option value="����">����</option>
									</select>
									<input type="text" value="${recruit.gender}"/>
								</td>
								<td width="100" align="center">
									����ó
								</td>
								<td width="150" align="left">
									<input type="text"name="phone" id="phone" value="${recruit.phone}"/>
								</td>
							</tr>
							<tr>
								<td width="100" align="center">
									email
								</td>
								<td width="150" align="left">
									<input type="text" maxlength="12" name="email" id="email" value="${recruit.email}"/>
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
									 <select name="location" onChange="" >
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
									<input type="text" maxlength="12" value="${recruit.location}"/>
								</td>
								<td width="100" align="center">
									�ٹ�����
								</td>
								<td width="150" align="left">
									<select name="workType">
										<option value="������">������</option>
										<option value="�����">�����</option>
									</select>
									<input type="text" maxlength="12" value="${recruit.workType}"/>
								</td>
							</tr>
						</table> 
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
								<c:when test="${empty educationVoList}">
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
												<input type='checkBox' name='tr1CheckBox' class='tr1CheckBox' value='0'/>
											</td>
											<td>
												<input type='text' name='educationVoList[0].startPeriod'/><br/>
												~<br/>
												<input type='text' name='educationVoList[0].endPeriod'/>
											</td>
											<td>
												<select name='educationVoList[0].division'>
													<option value='����'>����</option>
													<option value='����'>����</option>
													<option value='����'>����</option>
												</select>
											</td>
											<td>
												<input type='text' name='educationVoList[0].schoolName'/><br/>
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
													<input type="hidden" name="educationVoList[${status.index}].eduSeq" value="${educationList.eduSeq}"/>
													<input type='checkBox' name='tr1CheckBox' class='tr1CheckBox' value='${status.index}'/>
												</td>
												<td>
													<input type='text' name="educationVoList[${status.index}].startPeriod" value='${educationList.startPeriod}'/><br/>
													~<br/>
													<input type='text' name="educationVoList[${status.index}].endPeriod" value='${educationList.endPeriod}'/>
												</td>
												<td>
													<select name='educationVoList[${status.index}].division' value='${educationList.division}'>
														<option value='����'>����</option>
														<option value='����'>����</option>
														<option value='����'>����</option>
													</select>
												</td>
												<td>
													<input type='text' name='educationVoList[${status.index}].schoolName' value='${educationList.schoolName}'/><br/>
													  <select name='educationVoList[${status.index}].location' value='${educationList.location}'>
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
													<input type='text' name='educationVoList[${status.index}].grade' value='${educationList.grade}'/>
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
								<tr class="tr2 tr2Clone0">
									<td><!-- üũ�ڽ� -->
										<input type="checkBox" name="tr2CheckBox" class="tr2CheckBox" value="0"/>
									</td>
									<td><!-- �ٹ��Ⱓ -->
										<input type="text"/>~<br/>
										<input type="text"/>
									</td>
									<td><!-- ȸ��� -->
										<input type="text" />
									</td>
									<td><!-- �μ�/����/��å -->
										<input type="text"/><br/>
									</td>
									<td><!-- ���� -->
										<input type="text"/>
									</td>
								</tr>
							</tbody>
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
							<thead>
								<tr>
									<th></th>
									<th>�ڰ�����</th>
									<th>�����</th>
									<th>����ó</th>
								</tr>
							</thead>
							<tbody>
								<tr class="tr3 tr3Clone0">
									<td><!-- üũ�ڽ� -->
										<input type="checkBox" name="tr3CheckBox" class="tr3CheckBox" value="0"/>
									</td>
									<td><!-- �ڰ����� -->
										<input type="text"/>
									</td>
									<td><!-- ����� -->
										<input type="text" />
									</td>
									<td><!-- ����ó -->
										<input type="text"/><br/>
									</td>
								</tr>
							</tbody>
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