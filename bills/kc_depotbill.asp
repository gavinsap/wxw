<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<% 
if request.QueryString("type")="RK" then
savebill="../action/savebill.asp?type=RK"
call CheckAuthority("strAddIn")
title="��ⵥ"
billtype="RK"
end if
if request.QueryString("type")="CK" then
savebill="../action/savebill.asp?type=CK"
call CheckAuthority("strAddOut") 
title="���ⵥ"
billtype="CK"
end if
if request.QueryString("type")="db" then

call CheckAuthority("strAddDB") 
savebill="../action/savebill.asp?type=DB"
title="������"
billtype="DB"
end if
if request.QueryString("type")="PD" then
call CheckAuthority("strAddPD")
savebill="../action/savebill.asp?type=PD"
title="�̵㵥"
billtype="PD"
end if
if request.QueryString("type")="LL" then
 call CheckAuthority("strAddLL")
savebill="../action/savebill.asp?type=LL"
title="���ϵ�"
billtype="LL"
end if
if request.QueryString("type")="TL" then
savebill="../action/savebill.asp?type=TL"
title="���ϵ�"
billtype="TL"
end if
%>
<HTML><HEAD><TITLE></TITLE>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<link rel="stylesheet" href="../style.css" type="text/css">
<META http-equiv=Pragma content=no-cache>
<script language="JavaScript" src="../js/addrow.js"></script>
<script language="JavaScript" src="../js/jquery.js"></script>
<script>
function checkbill(){
var temp = "";
var temp1 = "";
$.post("checkbillcode_ajax.asp",{billcode:escape($("#billcode").val())},
function(data)
{ 
   if (data == "False"){
	   alert("���ظ����ţ����ٴε������");
		temp = $("#tittle_lable").html();
		temp1 = "000"+String(Number(temp.substring(14))+1);
	   $('#tittle_lable').html(temp.substring(0,14)+temp1.substring(temp1.length-4)); 
	   $('#billcode_input').attr("value",$('#tittle_lable').html());
	   return false;
   }
}
);		
	}
function bar(){
  if ((event.keyCode == 13) && ($("#barcode").val()!="")){
	
    $.post("barcode.asp",{date:escape($("#date").val()),barcode:escape($("#barcode").val()),depot:escape($("#depot").val())},
	function(data)
	{ if(data!="")
	{
	addrow_bar();
	   i=$("#rowcount").val();
	   str=data.split("|");
	   $("#goodscode"+i).val(str[0]);
	   $("#goodsname"+i).val(str[1]);
	   $("#goodsunit"+i).val(str[2]);
	   $("#units"+i).val(str[3]);
	   $("#number"+i).val("1");
	   $("#aveprice"+i).val(str[8]);
	   $("#fact_num"+i).val(str[7]);
	   $("#remark"+i).val(str[6]);
	   $("#price"+i).val(str[4]);
	   }
	   else
	   {
	   alert('û����ص�����!!');
	   }
	}
	);
	$("#barcode").val("");
  }
}
function check(){
if (document.sample.cust.value=="")
{
alert("��ѡ��������λ��");
document.sample.cust.focus();
return false;
}
if ($("#depot").val() == "")
{
alert("��ѡ��ֿ⣡");
document.sample.depot.focus();
return false;
}
if (document.getElementById("sqd").rows.length == 1)
{
alert("����ӻ�Ʒ��");
return false;
}
}
function edit_row(i)
{
	openwin('../common/selectgoods.asp?depot='+document.getElementById("depot").value+'&type=<%=request.QueryString("type")%>&adddate='+document.all.date.value+'&id='+i, 800,600)
}
function counttotal(){

var vTotalNumber=0;
var vTotalMoney=0;//�ܽ��ĳ�ʼֵΪ0;
$(".money").each( 
	function(i)
	{
	var vTempValue=$(this).val();
		if(vTempValue=="")
		{
			vTempValue=0;
		}
	vTotalMoney=vTotalMoney+parseFloat(vTempValue);//�����ܷ���
	}
)//��������
$("#total_money").val(vTotalMoney); //���ܷ�����ʾ����Ӧ�ı��������
$(".number").each( 
	function(i)
	{
	var vTempValue=$(this).val();
		if(vTempValue=="")
		{
			vTempValue=0;
		}
	vTotalNumber=vTotalNumber+parseFloat(vTempValue);//�����ܷ���
	}
)//��������
$("#total_number").val(vTotalNumber); //���ܷ�����ʾ����Ӧ�ı��������
}
function count(i){
r_price=Number(document.getElementById("price"+i).value);

r_number=Number(document.getElementById("number"+i).value);
document.getElementById("money"+i).value=(r_price*r_number).toFixed(2);
document.getElementById('total_money').value=0;
document.getElementById('total_number').value=0;
counttotal();
}

var j=0
function add_row(){
	if ($("#depot").val() == "")
	{
	alert("��ѡ��ֿ⣡");
	document.sample.depot.focus();
	return false;
	}
	openwin('../common/selectgoods.asp?depot='+document.getElementById("depot").value+'&type=<%=request.QueryString("type")%>&adddate='+document.all.date.value+'&id='+j,800,600)
}

function del_row(i) {	
	document.getElementById("sqd").deleteRow(i);
	$("#rowcount").val($("#rowcount").val() - 1);
	counttotal();	
}

</script>
</HEAD>
<BODY>
<table align="center" border="0"><tr><td>
<form method="POST" onKeyPress="if(event.keyCode==13){return false;}" action="<%=savebill%>" name="sample">

<br><div align="center"><span class="style1"><%=title%></span></div>
<input type="hidden" id="rowcount" name="rowcount">
<br>
<table id="tbl" style="font-size:12px" width="860" border="1" align="center" cellpadding="2" cellspacing="0" bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#FFFFEE">
<tbody>
<tr>
<td align="right" width="70">�Ƶ����ڣ�</td>
<td width="320"><input type="text" name="date" id="date" size="16" readonly value=<%=formatdate(date)%>><%showdate("date")%><font color="red">*</font></td>
<% if request.QueryString("bill")="bill" then%>
         <td width="70" align="right">��&nbsp;��&nbsp;�֣�</td>
		 <td width="320"><%call showdepot("cust","")%><font color="red">*</font></td>
		 <%else if request.QueryString("bill")="pbill" then%>
		  <%else if request.QueryString("bill")="lbill" then%>
		  <td align="right" width="70">��&nbsp;&nbsp;&nbsp;&nbsp;�ţ�</td>
<td width="320"><%call ShowCombo("t_department","name","cust","")%></td>
		 <%else%>
<td align="right" width="70">��&nbsp;Ӧ&nbsp;�̣�</td>
<td width="320"><input type="text" name="Cust" id="cust" size="35"><a href="#" onClick="JavaScript:window.open ('../common/selectcust.asp', 'newwindow', 'left=150,top=100,height=600, width=800, toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no, status=no')"><img border="0" src="../img/choose.gif" width="21" height="17"></a><font color="red">*</font></td>
<%end if%>
 <%end if%>
  <%end if%>

</tr>
<tr>
<% if request.QueryString("bill")="bill" then%> 
<td align="right">��&nbsp;��&nbsp;�֣�</td>
<%else if request.QueryString("bill")="pbill" then %>
  <td align="right">��&nbsp;��&nbsp;�֣�</td>

<%else%>
<td align="right">��&nbsp;&nbsp;&nbsp;&nbsp;�⣺</td>
<%end if%>
  <%end if%>


    <td><%call showdepot("depot","")%><font color="red">*</font></td>
	<td align="right">��&nbsp;��&nbsp;�ˣ�</td>
	<td><input type="text" size="16" name="maker" readonly value="<%=request.cookies("username")%>"><font color="red">*</font></td></tr>
  <tr><td align="right">��&nbsp;&nbsp;&nbsp;&nbsp;ע��</td><td><input onKeyDown="" type="text" name="memo" size="30"></td>
  <td align="right">��&nbsp;��&nbsp;�ˣ�</td><td><select name="user">
    <%
    sql = "select * from t_Employee"
    Set a = conn.Execute(sql)
    Do While a.EOF = False
    s_name = a("name")
    Response.Write "<option value="&s_name&">"&s_name&"</option>"
    a.movenext
    Loop
	close_rs(a)
   %>
  </select><font color="red">*</font></td>
  </tr></tbody></table>
<div align="left" class="but_mar">
<table>
<tr>
<td width="80" valign="top">
  <input name="add" type="button" onClick=add_row() onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  class="button" value=" �����Ʒ"></td>

<td>
&nbsp;&nbsp;����¼���<input name="barcode" id="barcode" size="16" onKeyUp="bar();"></div>
</td>
	</tr>
<table>
<table style="font-size:12px" width="860" id="sqd" align="center" border="1" cellpadding="2" cellspacing="0" bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#FFFFEE">
<tr align="center">
  <th width=3%>&nbsp;</th>
  <th width=5%>ɾ��</th>
  <th width=15%>��Ʒ����</th>
  <th width=15%>��Ʒ����</th>
  <th width=12%>��Ʒ���</th>
  <th width=10%>��λ</th>
  <th width=10%>����</th>
  <th width=10%>����</th>
  <th width=10%>���</th>
  <th width=10%>��ע</th>
</tr>
</table>
<table style="font-size:12px" width="860" id="sqd1" align="center" border="1" cellpadding="2" cellspacing="0" bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#FFFFEE">
<tr align="center">
  <th width=70%>�ϼ�</th>
  <th width=10%><input id="total_number" type="text" size="8"></th>
  <th width=10%><input id="total_money" type="text" size="8"></th>
  <th width=10%></th>
</tr>
</table>
<div align="center" class="but_mar"><input type="submit" onMouseDown="checkbill();" onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"   onClick="return check();" class="button" value=" �� �� " name="B1"></div>
</form>
</td></tr></table>
<%endconnection%>
</BODY>
</HTML>
