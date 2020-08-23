<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>������ ���� TOURSUM !</title>
</head>

<style>

#darken-background {
   position: fixed;
   top: 50%;
   left: 50%;
   transform:translate(-50%,-50%);
   width:100%;
   height: 100%;
   display: none;
   background: rgba(0, 0, 0, 0.5);
   z-index: 10000;
   overflow-y: scroll;
}


#lightbox {
   width: 600px;
   height: 750px;
   margin: auto;
   margin-top: 25px;
   margin-bottom: 25px;
   border: 1px solid #333333;
   border-radius: 5px;
   background: white;
   position: absolute;
   z-index: 15000;
   box-shadow: 0px 5px 5px rgba(34, 25, 25, 0.4);
   text-align: center;
   position: relative;
}
#page{
	margin:auto;
	
}
#tag img{
	width:80px;
	height:80px;
	cursor:pointer;
	margin-bottom:20px;
	border-radius:8px 8px 8px 8px;
	margin-left:10px;
	margin-right:10px;
}
</style>
<body>
<div id="darken-background">
      <div id="lightbox">
	      <form name="frm" action="updateKakao" method="post">
	      <div style="text-align:center; background:#efefef; padding:10px 0px 10px 0px; border-radius:3px 3px 3px 3px; margin:25px 5px 30px 5px; font-size:14.5px;">'${u_k_id}'���� ������ �Է��ϼ���.</div>
	      		<input type="hidden" name="u_k_id" value="${u_k_id}">
	      		<table id="kakaoUpdate">
	      			<tr class="line-name">
						<td><span>�̸�</span></td>
						<td colspan=2>
							<input type="text" id="txtName" size=30 name="u_name" placeholder="NAME">
						</td>
						<td style="text-align:center; padding-left:8px;">
							<input id="gender_radio1" type="radio" name="u_gender" value="male">
							<label for="gender_radio1">��</label>
							<input id="gender_radio2" type="radio" name="u_gender" value="female">
							<label for="gender_radio2">��</label>
						<td>
							<input type="hidden" value="0" id="passread">
							<input type="hidden" name="u_status" value=0>
						</td>
					</tr>
	      			<tr>
	      				<td><span>�޴�����ȣ</span></td>
							<td colspan=2>
								<input type="hidden" id="txtTel" size=50 style="height: 20px;" name="u_tel" placeholder="TEL">
								<select id="selectTel">
									<option style="padding-top:10px; padding-bottom:10px;">010</option>
									<option>011</option>
									<option>016</option>
									<option>017</option>
									<option>018</option>
									<option>019</option>
								</select> -
								<input type="text" id="telFirst" size="5"maxlength=4> -
								<input type="text" id="telSecond" size="5" maxlength=4>
							</td>
						<td></td>
	      			</tr>
	      			<tr class="line-address">
						<td><span>�ּ�</span></td>
						<td colspan=2>
							<input type="text" id="sample6_postcode" placeholder="POSTAL CODE" style="text-ailgn:center; width:32.5%;">
							<input type="button" onclick="sample6_execDaumPostcode()" value="�����ȣ ã��" style="width:32.5%; height:40px; border:none; outline:none; border-radius:3px 3px 3px 3px; cursor:pointer"><br> 
							<input type="text" id="sample6_address" placeholder="ADDRESS" size=25><br>
							<input type="text" id="sample6_detailAddress" placeholder="DETAILED ADDRESS" size=15>
							<input type="hidden" id="sample6_extraAddress" placeholder="�����׸�">
							<input type="hidden" id=allAddress name="u_address">
						</td>
						<td></td>
					</tr>
	      			<tr class="line-email">
						<td><span>�̸���</span></td>
						<td colspan=2>
							<input type="text" id="txtEmail" size="10" placeholder="E-MAIL" value=""> @ 
							<input type="text" id="txtEmailType" size="10"> 
						</td>
						<td style="text-align:center;">
							<select id="email">
								<option id="direct" value="direct">�����Է�</option>
								<option id="gmail" value="gmail.com">@gmail.com</option>
								<option id="naver" value="naver.com">@naver.com</option>
								<option id="daum" value="daum.net">@daum.net</option>
								<option id="nate" value="nate.com">@nate.com</option>
							</select> 
							<input type="hidden" id="emailAll" name="u_email">
						</td>
					</tr>
	      		</table>
	      		<!-- ��ȣ �±� ���� -->
		<div style="text-align:center; background:#efefef; padding:10px 0px 10px 0px; border-radius:3px 3px 3px 3px; margin:25px 5px 30px 5px; font-size:14.5px;">��ȣ�ϴ� ���� ��Ÿ���� �������ּ���. (2��)</div>
		<div id="tag" style="text-align:center;">
			<span id="tag1">
				<input type="checkbox" id="t_tag1" name="t_tag" value="01">
					<label for="t_tag1" id="tag1"><img src="/resources/img/usertag/�������Բ�.png"></label>
					<label for="t_tag1" id="tag1-1" style="display:none;"><img src="/resources/img/usertag/�������Բ�.png" style="border:0.5px solid #0f4c81;"></label>
			</span>
			<span id="tag2">
				<input type="checkbox" id="t_tag2" name="t_tag" value="02">
					<label for="t_tag2" id="tag1"><img src="/resources/img/usertag/����.png"></label>
					<label for="t_tag2" id="tag1-1" style="display:none;"><img src="/resources/img/usertag/����.png" style="border:0.5px solid #0f4c81;"></label>
			</span>
			<span id="tag3">
				<input type="checkbox" id="t_tag3" name="t_tag" value="03">
					<label for="t_tag3" id="tag1"><img src="/resources/img/usertag/�����ƴ�.png"></label>
					<label for="t_tag3" id="tag1-1" style="display:none;"><img src="/resources/img/usertag/�����ƴ�.png" style="border:0.5px solid #0f4c81;"></label>
			</span>
			<span id="tag4">
				<input type="checkbox" id="t_tag4" name="t_tag" value="04">
					<label for="t_tag4" id="tag1"><img src="/resources/img/usertag/��ȥ�ڿ���.png"></label>
					<label for="t_tag4" id="tag1-1" style="display:none;"><img src="/resources/img/usertag/��ȥ�ڿ���.png" style="border:0.5px solid #0f4c81;"></label>
			</span>
			<span id="tag5">
				<input type="checkbox" id="t_tag5" name="t_tag" value="05">
					<label for="t_tag5" id="tag1"><img src="/resources/img/usertag/���ɼӿ���.png"></label>
					<label for="t_tag5" id="tag1-1" style="display:none;"><img src="/resources/img/usertag/���ɼӿ���.png" style="border:0.5px solid #0f4c81;"></label>
			</span>
			<span id="tag6">
				<input type="checkbox" id="t_tag6" name="t_tag" value="06">
					<label for="t_tag6" id="tag1"><img src="/resources/img/usertag/�Թ�.png"></label>
					<label for="t_tag6" id="tag1-1" style="display:none;"><img src="/resources/img/usertag/�Թ�.png" style="border:0.5px solid #0f4c81;"></label>
			</span>
			<span id="tag7">
				<input type="checkbox" id="t_tag7" name="t_tag" value="07">
					<label for="t_tag7" id="tag1"><img src="/resources/img/usertag/�߰�.png"></label>
					<label for="t_tag7" id="tag1-1" style="display:none;"><img src="/resources/img/usertag/�߰�.png" style="border:0.5px solid #0f4c81;"></label>
			</span>
			<span id="tag8">
				<input type="checkbox" id="t_tag8" name="t_tag" value="08">
					<label for="t_tag8" id="tag1"><img src="/resources/img/usertag/���ΰ��Բ�.png"></label>
					<label for="t_tag8" id="tag1-1" style="display:none;"><img src="/resources/img/usertag/���ΰ��Բ�.png" style="border:0.5px solid #0f4c81;"></label>
			</span>
			<span id="tag9">
				<input type="checkbox" id="t_tag9" name="t_tag" value="10">
					<label for="t_tag9" id="tag1"><img src="/resources/img/usertag/�ͻ�����.png"></label>
					<label for="t_tag9" id="tag1-1" style="display:none;"><img src="/resources/img/usertag/�ͻ�����.png" style="border:0.5px solid #0f4c81;"></label>
			</span>
			<span id="tag10">
				<input type="checkbox" id="t_tag10" name="t_tag" value="11">
					<label for="t_tag10" id="tag1"><img src="/resources/img/usertag/ģ�����Բ�.png"></label>
					<label for="t_tag10" id="tag1-1" style="display:none;"><img src="/resources/img/usertag/ģ�����Բ�.png" style="border:0.5px solid #0f4c81;"></label>
			</span>
			<span id="tag11">
				<input type="checkbox" id="t_tag11" name="t_tag" value="12">
					<label for="t_tag11" id="tag1"><img src="/resources/img/usertag/�ｺ�ɾ�.png"></label>
					<label for="t_tag11" id="tag1-1" style="display:none;"><img src="/resources/img/usertag/�ｺ�ɾ�.png" style="border:0.5px solid #0f4c81;"></label>
			</span>
			<span id="tag12">
				<input type="checkbox" id="t_tag12" name="t_tag" value="13">
					<label for="t_tag12" id="tag1"><img src="/resources/img/usertag/����.png"></label>
					<label for="t_tag12" id="tag1-1" style="display:none;"><img src="/resources/img/usertag/����.png" style="border:0.5px solid #0f4c81;"></label>
			</span>
		</div>
		 <br>
		 <input type="submit" value="Submit" id="btnUpdatekakao">
	      </form>
	      <input type="button" id="btnClose" value="close">
      </div>
 	</div>
</body>
<script>
	$(":checkbox").css("display","none");	
	
	$("input[name=t_tag]").on("click",function(){
		
		$(this).length	
		var count=$("input:checked[type='checkbox']").length;	
		if(count<3){
			var tag1=$(this).parent().find("#tag1");
			var tag2=$(this).parent().find("#tag1-1");
			
			if($(this).is(":checked")==true){
				tag1.css("display","none");
				tag2.css("display","inline-block");
			}else{
				tag1.css("display","inline-block");
				tag2.css("display","none");
			}
		}else{
			$(this).prop("checked",false);
			alert("2�������� ������ �� �ֽ��ϴ�.");
		}
	});
	
	$("#email").change(function() {
		var email = $("#email option:selected").val();
		if (email != "direct") {
			$("#txtEmailType").attr("readonly", true);
		}
	})
	
	//email Ÿ��
	$("#email").change(function() {
		var email = $("#email option:selected").val();
		if (email == $("#direct").val()) {
			$("#txtEmailType").attr("readonly", false);
			$("#txtEmailType").val("");
			$("#txtEmailType").focus();
		} else {
			$("#txtEmailType").val(email);
		}
	});
	
	// �ּ� �˻� API
	function sample6_execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// �˾����� �˻���� �׸��� Ŭ�������� ������ �ڵ带 �ۼ��ϴ� �κ�
						var addr = '';//�ּ� ����
						var extraAddr = '';//���� �׸� ����
	
						//����ڰ� ������ �ּ� Ÿ�Կ� ���� �ش� �ּ� ���� �����´�.
						if (data.userSelectedType === 'R') { // ����ڰ� ���θ� �ּҸ� �������� ���
							addr = data.roadAddress;
						} else { // ����ڰ� ���� �ּҸ� �������� ���(J)
							addr = data.jibunAddress;
						}
						// ����ڰ� ������ �ּҰ� ���θ� Ÿ���϶� �����׸��� �����Ѵ�.
						if (data.userSelectedType === 'R') {
							// ���������� ���� ��� �߰��Ѵ�. (�������� ����)
							// �������� ��� ������ ���ڰ� "��/��/��"�� ������.
							if (data.bname !== ''
									&& /[��|��|��]$/g.test(data.bname)) {
								extraAddr += data.bname;
							}
							// �ǹ����� �ְ�, ���������� ��� �߰��Ѵ�.
							if (data.buildingName !== ''
									&& data.apartment === 'Y') {
								extraAddr += (extraAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							// ǥ���� �����׸��� ���� ���, ��ȣ���� �߰��� ���� ���ڿ��� �����.
							if (extraAddr !== '') {
								extraAddr = ' (' + extraAddr + ')';
							}
							// ���յ� �����׸��� �ش� �ʵ忡 �ִ´�.
							document.getElementById("sample6_extraAddress").value = extraAddr;
						} else {
							document.getElementById("sample6_extraAddress").value = '';
						}
	
						// �����ȣ�� �ּ� ������ �ش� �ʵ忡 �ִ´�.
						document.getElementById('sample6_postcode').value = data.zonecode;
						document.getElementById("sample6_address").value = addr;
						// Ŀ���� ���ּ� �ʵ�� �̵��Ѵ�.
						document.getElementById("sample6_detailAddress")
								.focus();
	
					}
				}).open();
	}


	//ȸ�� ���� ���
	$(frm).submit(function(e) {
		e.preventDefault();
		if (!confirm("ȸ�� ������ �����Ͻðڽ��ϱ�?")) return;
		var gender = $(":input:radio[name=u_gender]:checked").val();
		var year = $("#year").val();
		var MM = $("#MM").val();
		var dd = $("#dd").val();
		
		//�ּ� ��ġ��
		var address = $("#sample6_address").val();
		var addressDetail = $("#sample6_detailAddress").val();
		var allAddress = address + "," + addressDetail;
		//�̸��� ��ġ��
		var txtEmail = $("#txtEmail").val();
		var txtEmailType = $("#txtEmailType").val();
		var emailAll = txtEmail + "@" + txtEmailType;
		$("#emailAll").val(emailAll);
		$("#allAddress").val(allAddress);
	
		//��ȭ��ȣ ��ġ��
		var tel1 = $("#selectTel option:selected").val();
		var tel2 = $("#telFirst").val();
		var tel3 = $("#telSecond").val();
		$("#txtTel").val(tel1 + "-" + tel2 + "-" + tel3);
		frm.submit();
	});
	

		$("#darken-background").css("display", "block"); //�˾� �޹�� display block
		$("#lightbox").css("display", "inline-block;"); //�˾�â display block
	
		$("body").css("overflow", "hidden");//body ��ũ�ѹ� ���ֱ�
		
		
	$("#btnClose").on("click", function(event) {
		$("#darken-background").css("display", "none"); //�˾�â �޹�� display none
		$("#lightbox").css("display", "none"); //�˾�â display none
		$("body").css("overflow", "auto");//body ��ũ�ѹ� ����
	});
	//�ּ� �˻� api
	new daum.Postcode({
		oncomplete : function(data) {
			// �˾����� �˻���� �׸��� Ŭ�������� ������ �ڵ带 �ۼ��ϴ� �κ��Դϴ�.
			// ������ �����Ͽ� �پ��� Ȱ����� Ȯ���� ������.
		}
	}).open();
</script>
<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js?autoload=false"></script>
</html>