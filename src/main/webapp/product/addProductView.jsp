<%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>��ǰ���</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">



<script type="text/javascript" src="../javascript/calendar.js"></script>
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
<!--
function fncAddProduct(){
	//Form ��ȿ�� ����
 	var name = document.detailForm.prodName.value;
	var detail = document.detailForm.prodDetail.value;
	var manuDate = document.detailForm.manuDate.value;
	var price = document.detailForm.price.value;

	if(name == null || name.length<1){
		alert("��ǰ���� �ݵ�� �Է��Ͽ��� �մϴ�.");
		return;
	}
	if(detail == null || detail.length<1){
		alert("��ǰ�������� �ݵ�� �Է��Ͽ��� �մϴ�.");
		return;
	}
	if(manuDate == null || manuDate.length<1){
		alert("�������ڴ� �ݵ�� �Է��ϼž� �մϴ�.");
		return;
	}
	if(price == null || price.length<1){
		alert("������ �ݵ�� �Է��ϼž� �մϴ�.");
		return;
	}

	
	$('form').attr('method','post').attr('enctype','multipart/form-data').attr('action','addProduct?menu=manage').submit();
}

function resetData(){
	document.detailForm.reset();
}
-->

$(function () {
	$('.ct_btn01:nth-child(2)').on('click',function(){
		console.log($('.ct_btn01:nth-child(2)').html());
		fncAddProduct();	
	})
	
	$("ct_btn01:contains('���')").on('click',function(){
		resetData();
	})
	
	$("ct_btn01:contains('���')").on('click',function(){
		resetData();
	})
	
	//../product/addProductView.jsp
})

</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<form name="detailForm" method="post" enctype="multipart/form-data">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
							��ǰ���
					</td>
					<td width="20%" align="right">&nbsp;</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif"	width="12" height="37"/>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 13px;">
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			��ǰ�� <imgsrc="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle">
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="105">
						
						<c:choose>
							<c:when test = "${empty product }">
								<input type="text" name="prodName" class="ct_input_g" 
									   style="width: 100px; height: 19px" maxLength="20">
							</c:when>
							
							<c:when test = "${!empty product }">
							 ${product.prodName }
							</c:when>							
							
						</c:choose>
						
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			��ǰ������ <img	src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			
			<c:choose>
				<c:when test = "${empty product }">
					<input type="text" name="prodDetail" class="ct_input_g" 
					       style="width: 100px; height: 19px" maxLength="10" minLength="6"/>
				</c:when>
				
				<c:when test = "${!empty product }">
					${product.prodDetail }
				</c:when>
			</c:choose>
			
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			�������� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<c:choose>
				<c:when test = "${empty product }">
					<input type="text" name="manuDate" readonly="readonly" class="ct_input_g"  
						style="width: 100px; height: 19px"	maxLength="10" minLength="6"/>
					&nbsp;
					<img src="../images/ct_icon_date.gif" width="15" height="15" 
					     onclick="show_calendar('document.detailForm.manuDate', document.detailForm.manuDate.value)"/>
				</c:when>
				
				<c:when test = "${!empty product }">
					${product.manuDate}
				</c:when>
			</c:choose>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			���� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<c:choose>
				<c:when test = "${empty product }">
					<input type="text" name="price" 	class="ct_input_g" 
					       style="width: 100px; height: 19px" maxLength="10">&nbsp;��
				</c:when>
				
				<c:when test = "${!empty product }">
					${product.price}
				</c:when>
			</c:choose>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
	<tr>
		<td width="104" class="ct_write">
			���� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<c:choose>
				<c:when test = "${empty product }">
					<input type="text" name="stock" 	class="ct_input_g" 
					       style="width: 100px; height: 19px" maxLength="10">&nbsp;EA
				</c:when>
				
				<c:when test = "${!empty product }">
					${product.stock}
				</c:when>
			</c:choose>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
	<tr>
		<td width="104" class="ct_write">��ǰ�̹���</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<c:choose>
				<c:when test = "${empty product }">
					<input	type="file" name="file" class="ct_input_g" 
							style="width: 200px; height: 19px" maxLength="13"/>
				</c:when>
				
				<c:when test = "${!empty product }">
					<img src="/images/uploadFiles/${fileName }" width="300" height="300" />
				</c:when>
			</c:choose>			
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td width="53%"></td>
		<td align="right">
		<table border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="17" height="23">
					<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
				</td>
				
				<td background="/images/ct_btnbg02.gif" class="ct_btn01"  style="padding-top: 3px;">
				<c:choose>
					<c:when test = "${empty product }">
						���
					</c:when>
					<c:when test = "${!empty product }">
					<a href="listProduct?menu=manage">Ȯ��</a>
					</c:when>
				</c:choose>				
				</td>
				
				<td width="14" height="23">
					<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
				</td>
				<td width="30"></td>
				<td width="17" height="23">
					<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
				</td>
				<td background="/images/ct_btnbg02.gif" class="ct_btn01"	 style="padding-top: 3px;">
				
				<c:choose>
					<c:when test = "${empty product }">
						���
					</c:when>
					
					<c:when test = "${!empty product }">
						�߰����
					</c:when>
				</c:choose>
				</td>
				<td width="14" height="23">
					<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

</form>
</body>
</html>