<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<META http-equiv=Pragma content=no-cache>
<style type="text/css">
<!--
.STYLE1 {
	font-size: large;
	font-weight: bold;
}
#tblprint{
border-collapse:collapse;
table-layout:fixed;
border:solid 1px #000000;
}
#tblprint td{
border-collapse:collapse;
table-layout:fixed;
border:solid 1px #000000;
}
-->
</style>
<title>���ݴ�ӡ</title>
</head>

<body>
<!--startprint-->
<%
Function SetSmallInt(DataValue)
	if (DataValue<1) and (DataValue>0) then
	  if left(DataValue,1)<>"0" then
	    DataValue="0"&DataValue   
	  end if
	end if
	SetSmallInt = DataValue
End Function

sql_company = "select * from t_company"
Set rs_company = server.CreateObject("adodb.recordset")
rs_company.Open sql_company, conn, 1, 1
if request("billcode") <> "" then
sql = "select * from t_bill where billcode='"&request("billcode")&"'"
else
sql = "select * from t_bill where billcode='"&request.QueryString("billcode")&"'"
end if
Set rs_bill = server.CreateObject("adodb.recordset")
rs_bill.Open sql, conn, 1, 1
%>
<div align="center"><span class="style1"><%=rs_company("company")%></span></div>
<!--�ɹ�����-->
<%if rs_bill("billtype")="�ɹ�����" then%>
<br><div align="center"><span class="style1">�ɹ�����</span></div>
<br>
<table style="font-size:12px" width="100%" border="0" align="center">
<tbody>
 <tr>
   <td align="left">�Ƶ����ڣ�&nbsp;<%=rs_bill("adddate")%></td>
   <td align="left">���ݺ��룺&nbsp;<%=rs_bill("billcode")%></td>
   <td align="left">��&nbsp;Ӧ&nbsp;�̣�&nbsp;<%=rs_bill("custname")%></td>
 </tr>
 <tr>
   <td align="left">��&nbsp;&nbsp;&nbsp;&nbsp;�⣺&nbsp;<%=rs_bill("depotname")%></td>
   <td align="left">��&nbsp;��&nbsp;�ˣ�&nbsp;<%=rs_bill("maker")%></td>
   <td align="left">��&nbsp;��&nbsp;�ˣ�&nbsp;<%=rs_bill("username")%></td>
 </tr>
</tbody></table>
<table id="tblprint" width=100% align="center" cellspacing="0" border="1" border-collapse:collapse;>
<tr align="center"><td width=3% bgcolor="#FFFFFF" id="td">&nbsp;</td>
<td width=10% bgcolor="#FFFFFF" id="td">��Ʒ����</td>
<td width=15% bgcolor="#FFFFFF" id="td">��Ʒ����</td>
<td width=10% bgcolor="#FFFFFF" id="td">��Ʒ���</td>
<td width=7% bgcolor="#FFFFFF" id="td">��λ</td>
<td width=10% bgcolor="#FFFFFF" id="td">����</td>
<td width=10% bgcolor="#FFFFFF" id="td">����</td>
<td width=10% bgcolor="#FFFFFF" id="td">���</td>
<td width=20% bgcolor="#FFFFFF" id="td">��ע</td>
</tr>
<%
sql = "select * from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_detail = server.CreateObject("adodb.recordset")
rs_detail.Open sql, conn, 1, 1
For i = 1 To rs_detail.recordcount
%>
<tr align="center">
	<td width=3% bgcolor="#FFFFFF" id="td"><%=i%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodscode")%></td>
	<td width=15% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodsname")%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodsunit")%></td>
	<td width=7% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("units")%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("price"))%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("number"))%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("money"))%></td>
	<td width=20% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("detailnote")%></td>
</tr>
<%
rs_detail.movenext
Next
sql = "select sum(number) as num,sum(money) as mon from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_count = server.CreateObject("adodb.recordset")
rs_count.Open sql, conn, 1, 1
%>
<tr align="center" bgcolor="#FFFFFF">
	<td colspan="2" bgcolor="#FFFFFF" id="id">�ϼ�</td>
	<td colspan="4" bgcolor="#FFFFFF" id="td">&nbsp;</td>
	<td bgcolor="#FFFFFF" id="td"><%=rs_count("num")%></td>
	<td bgcolor="#FFFFFF" id="td"><%=rs_count("mon")%></td>
	<td bgcolor="#FFFFFF">&nbsp;</td>
</tr>
</table>
<%end if%>
<!--���۶���-->
<%if rs_bill("billtype")="���۶���" then%>
<br><div align="center"><span class="style1">���۶���</span></div><br>
<table style="font-size:12px" width="100%" border="0" align="center">
<tbody>
 <tr>
   <td align="left">�Ƶ����ڣ�&nbsp;<%=rs_bill("adddate")%></td>
   <td align="left">���ݺ��룺&nbsp;<%=rs_bill("billcode")%></td>
   <td align="left">��&nbsp;&nbsp;&nbsp;&nbsp;����&nbsp;<%=rs_bill("custname")%></td>
 </tr>
 <tr>
   <td align="left">��&nbsp;&nbsp;&nbsp;&nbsp;�⣺&nbsp;<%=rs_bill("depotname")%></td>
   <td align="left">��&nbsp;��&nbsp;�ˣ�&nbsp;<%=rs_bill("maker")%></td>
   <td align="left">��&nbsp;��&nbsp;�ˣ�&nbsp;<%=rs_bill("username")%></td>
 </tr>
</tbody></table>
<table id="tblprint" width=100% align="center" cellspacing="0" border="1" border-collapse:collapse;>
<tr align="center"><td width=3% bgcolor="#FFFFFF" id="td">&nbsp;</td>
<td width=10% bgcolor="#FFFFFF" >��Ʒ����</td>
<td width=15% bgcolor="#FFFFFF" >��Ʒ����</td>
<td width=10% bgcolor="#FFFFFF" >��Ʒ���</td>
<td width=7% bgcolor="#FFFFFF" >��λ</td>
<td width=10% bgcolor="#FFFFFF" >����</td>
<td width=10% bgcolor="#FFFFFF" >����</td>
<td width=10% bgcolor="#FFFFFF" >���</td>
<td width=20% bgcolor="#FFFFFF" >��ע</td>
</tr>
<%
sql = "select * from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_detail = server.CreateObject("adodb.recordset")
rs_detail.Open sql, conn, 1, 1
For i = 1 To rs_detail.recordcount
%>
<tr align="center">
	<td width=3% bgcolor="#FFFFFF" ><%=i%></td>
	<td width=10% bgcolor="#FFFFFF" >&nbsp;<%=rs_detail("goodscode")%></td>
	<td width=15% bgcolor="#FFFFFF" >&nbsp;<%=rs_detail("goodsname")%></td>
	<td width=10% bgcolor="#FFFFFF" >&nbsp;<%=rs_detail("goodsunit")%></td>
	<td width=7% bgcolor="#FFFFFF" >&nbsp;<%=rs_detail("units")%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("price"))%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("number"))%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("money"))%></td>
	<td width=20% bgcolor="#FFFFFF" >&nbsp;<%=rs_detail("detailnote")%></td>
</tr>
<%
rs_detail.movenext
Next
sql = "select sum(number) as num,sum(money) as mon from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_count = server.CreateObject("adodb.recordset")
rs_count.Open sql, conn, 1, 1
%>
<tr align="center" bgcolor="#FFFFFF"><td colspan="2" id="id">�ϼ�</td><td id="td" colspan="4">&nbsp;</td><td id="td"><%=rs_count("num")%></td><td id="td"><%=rs_count("mon")%></td><td>&nbsp;</td></tr>
</table>
<%end if%>
<!--�ɹ����-->
<%if rs_bill("billtype")="�ɹ����" then%>
<br><div align="center"><span class="style1">�ɹ���ⵥ</span></div>
<br>
<table style="font-size:12px" width="100%" border="0" align="center">
<tbody>
 <tr>
   <td align="left">�Ƶ����ڣ�&nbsp;<%=rs_bill("adddate")%></td>
   <td align="left">���ݺ��룺&nbsp;<%=rs_bill("billcode")%></td>
   <td align="left">��&nbsp;Ӧ&nbsp;�̣�&nbsp;<%=rs_bill("custname")%></td>
 </tr>
 <tr>
   <td align="left">��&nbsp;&nbsp;&nbsp;&nbsp;�⣺&nbsp;<%=rs_bill("depotname")%></td>
   <td align="left">��&nbsp;��&nbsp;�ˣ�&nbsp;<%=rs_bill("maker")%></td>
   <td align="left">��&nbsp;��&nbsp;�ˣ�&nbsp;<%=rs_bill("username")%></td>
 </tr>
</tbody></table>
<table id="tblprint" width=100% align="center" cellspacing="0" border="1" border-collapse:collapse;>
<tr align="center"><td width=3% bgcolor="#FFFFFF" id="td">&nbsp;</td>
<td width=10% bgcolor="#FFFFFF" id="td">��Ʒ����</td>
<td width=15% bgcolor="#FFFFFF" id="td">��Ʒ����</td>
<td width=10% bgcolor="#FFFFFF" id="td">��Ʒ���</td>
<td width=7% bgcolor="#FFFFFF" id="td">��λ</td>
<td width=10% bgcolor="#FFFFFF" id="td">����</td>
<td width=10% bgcolor="#FFFFFF" id="td">����</td>
<td width=10% bgcolor="#FFFFFF" id="td">���</td>
<td width=20% bgcolor="#FFFFFF" id="td">��ע</td>
</tr>
<%
sql = "select * from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_detail = server.CreateObject("adodb.recordset")
rs_detail.Open sql, conn, 1, 1
For i = 1 To rs_detail.recordcount
%>
<tr align="center">
	<td width=3% bgcolor="#FFFFFF" id="td"><%=i%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodscode")%></td>
	<td width=15% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodsname")%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodsunit")%></td>
	<td width=7% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("units")%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("price"))%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("number"))%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("money"))%></td>
	<td width=20% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("detailnote")%></td>
</tr>
<%
rs_detail.movenext
Next
sql = "select sum(number) as num,sum(money) as mon from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_count = server.CreateObject("adodb.recordset")
rs_count.Open sql, conn, 1, 1
%>
<tr align="center" bgcolor="#FFFFFF">
	<td colspan="2" bgcolor="#FFFFFF" id="id">�ϼ�</td>
	<td colspan="4" bgcolor="#FFFFFF" id="td">&nbsp;</td>
	<td bgcolor="#FFFFFF" id="td"><%=rs_count("num")%></td>
	<td bgcolor="#FFFFFF" id="td"><%=rs_count("mon")%></td>
	<td bgcolor="#FFFFFF">&nbsp;</td>
</tr>
</table>
<table width=100%>
<tr>
  <td>��ˣ�</td>
  <td>�ջ��ˣ�</td>
</tr>
</table>
<%end if%>
<!--���۳���-->
<%if rs_bill("billtype")="���۳���" then%>
<br><div align="center"><span class="style1">���۳��ⵥ</span></div><br>
<table style="font-size:12px" width="100%" border="0" align="center">
<tbody>
 <tr>
   <td align="left">�Ƶ����ڣ�>&nbsp;<%=rs_bill("adddate")%></td>
   <td align="left">���ݺ��룺&nbsp;<%=rs_bill("billcode")%></td>
   <td align="left">��&nbsp;&nbsp;&nbsp;&nbsp;����&nbsp;<%=rs_bill("custname")%></td>
 </tr>
 <tr>
   <td align="left">��&nbsp;&nbsp;&nbsp;&nbsp;�⣺&nbsp;<%=rs_bill("depotname")%></td>
   <td align="left">��&nbsp;��&nbsp;�ˣ�&nbsp;<%=rs_bill("maker")%></td>
   <td align="left">��&nbsp;��&nbsp;�ˣ�&nbsp;<%=rs_bill("username")%></td>
 </tr>
</tbody></table>
<table id="tblprint" width=100% align="center" cellspacing="0" border="1" border-collapse:collapse;>
<tr align="center"><td width=3% bgcolor="#FFFFFF" id="td">&nbsp;</td>
<td width=10% bgcolor="#FFFFFF" id="td">��Ʒ����</td>
<td width=15% bgcolor="#FFFFFF" id="td">��Ʒ����</td>
<td width=10% bgcolor="#FFFFFF" id="td">��Ʒ���</td>
<td width=7% bgcolor="#FFFFFF" id="td">��λ</td>
<td width=10% bgcolor="#FFFFFF" id="td">����</td>
<td width=10% bgcolor="#FFFFFF" id="td">����</td>
<td width=10% bgcolor="#FFFFFF" id="td">���</td>
<td width=20% bgcolor="#FFFFFF" id="td">��ע</td>
</tr>
<%
sql = "select * from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_detail = server.CreateObject("adodb.recordset")
rs_detail.Open sql, conn, 1, 1
For i = 1 To rs_detail.recordcount
%>
<tr align="center">
	<td width=3% bgcolor="#FFFFFF" id="td"><%=i%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodscode")%></td>
	<td width=15% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodsname")%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodsunit")%></td>
	<td width=7% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("units")%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("price"))%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("number"))%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("money"))%></td>
	<td width=20% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("detailnote")%></td>
</tr>
<%
rs_detail.movenext
Next
sql = "select sum(number) as num,sum(money) as mon from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_count = server.CreateObject("adodb.recordset")
rs_count.Open sql, conn, 1, 1
%>
<tr align="center" bgcolor="#FFFFFF">
	<td colspan="2" id="id">�ϼ�</td>
	<td id="td" colspan="4">&nbsp;</td>
	<td id="td"><%=rs_count("num")%></td>
	<td id="td"><%=rs_count("mon")%></td>
	<td>&nbsp;</td>
</tr>
</table>
<table width=100%>
<tr>
  <td>��ˣ�</td>
  <td>�ͻ��ˣ�</td>
  <td>�ջ��ˣ�</td>
</tr>
</table>
<%end if%>
<!--�������-->
<%if rs_bill("billtype")="�������" then%>
<br><div align="center"><span class="style1">��ⵥ</span></div>
<br>
<table style="font-size:12px" width="100%" border="0" align="center">
<tbody>
 <tr>
   <td align="left">�Ƶ����ڣ�&nbsp;<%=rs_bill("adddate")%></td>
   <td align="left">���ݺ��룺&nbsp;<%=rs_bill("billcode")%></td>
   <td align="left">��&nbsp;Ӧ&nbsp;�̣�&nbsp;<%=rs_bill("custname")%></td>
 </tr>
 <tr>
   <td align="left">��&nbsp;&nbsp;&nbsp;&nbsp;�⣺&nbsp;<%=rs_bill("depotname")%></td>
   <td align="left">��&nbsp;��&nbsp;�ˣ�&nbsp;<%=rs_bill("maker")%></td>
   <td align="left">��&nbsp;��&nbsp;�ˣ�&nbsp;<%=rs_bill("username")%></td>
 </tr>
</tbody></table>
<table id="tblprint" width=100% align="center" cellspacing="0" border="1" border-collapse:collapse;>
<tr align="center"><td width=3% bgcolor="#FFFFFF" id="td">&nbsp;</td>
<td width=10% bgcolor="#FFFFFF" id="td">��Ʒ����</td>
<td width=15% bgcolor="#FFFFFF" id="td">��Ʒ����</td>
<td width=10% bgcolor="#FFFFFF" id="td">��Ʒ���</td>
<td width=7% bgcolor="#FFFFFF" id="td">��λ</td>
<td width=10% bgcolor="#FFFFFF" id="td">����</td>
<td width=10% bgcolor="#FFFFFF" id="td">����</td>
<td width=10% bgcolor="#FFFFFF" id="td">���</td>
<td width=20% bgcolor="#FFFFFF" id="td">��ע</td>
</tr>
<%
sql = "select * from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_detail = server.CreateObject("adodb.recordset")
rs_detail.Open sql, conn, 1, 1
For i = 1 To rs_detail.recordcount
%>
<tr align="center">
	<td width=3% bgcolor="#FFFFFF" id="td"><%=i%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodscode")%></td>
	<td width=15% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodsname")%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodsunit")%></td>
	<td width=7% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("units")%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("price"))%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("number"))%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("money"))%></td>
	<td width=20% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("detailnote")%></td>
</tr>
<%
rs_detail.movenext
Next
sql = "select sum(number) as num,sum(money) as mon from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_count = server.CreateObject("adodb.recordset")
rs_count.Open sql, conn, 1, 1
%>
<tr align="center" bgcolor="#FFFFFF">
	<td colspan="2" id="id">�ϼ�</td>
	<td id="td" colspan="4">&nbsp;</td>
	<td id="td"><%=rs_count("num")%></td>
	<td id="td"><%=rs_count("mon")%></td>
	<td>&nbsp;</td>
</tr>
</table>
<table width=100%>
<tr>
  <td>��ˣ�</td>
  <td>�ջ��ˣ�</td>
</tr>
</table>
<%end if%>
<!--��������-->
<%if rs_bill("billtype")="��������" then%>
<br><div align="center"><span class="style1">���ⵥ</span></div>
<br>
<table style="font-size:12px" width="80%" border="0" align="center">
<tbody>
 <tr>
   <td align="left">�Ƶ����ڣ�&nbsp;<%=rs_bill("adddate")%></td>
   <td align="left">���ݺ��룺&nbsp;<%=rs_bill("billcode")%></td>
   <td align="left">��&nbsp;&nbsp;&nbsp;&nbsp;����&nbsp;<%=rs_bill("custname")%></td>
 </tr>
 <tr>
   <td align="left">��&nbsp;&nbsp;&nbsp;&nbsp;�⣺&nbsp;<%=rs_bill("depotname")%></td>
   <td align="left">��&nbsp;��&nbsp;�ˣ�&nbsp;<%=rs_bill("maker")%></td>
   <td align="left">��&nbsp;��&nbsp;�ˣ�&nbsp;<%=rs_bill("username")%></td>
 </tr>
</tbody></table>
<table id="tblprint" width=100% align="center" cellspacing="0" border="1" border-collapse:collapse;>
<tr align="center"><td width=3% bgcolor="#FFFFFF" id="td">&nbsp;</td>
<td width=10% bgcolor="#FFFFFF" id="td">��Ʒ����</td>
<td width=15% bgcolor="#FFFFFF" id="td">��Ʒ����</td>
<td width=10% bgcolor="#FFFFFF" id="td">��Ʒ���</td>
<td width=7% bgcolor="#FFFFFF" id="td">��λ</td>
<td width=10% bgcolor="#FFFFFF" id="td">����</td>
<td width=10% bgcolor="#FFFFFF" id="td">����</td>
<td width=10% bgcolor="#FFFFFF" id="td">���</td>
<td width=20% bgcolor="#FFFFFF" id="td">��ע</td>
</tr>
<%
sql = "select * from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_detail = server.CreateObject("adodb.recordset")
rs_detail.Open sql, conn, 1, 1
For i = 1 To rs_detail.recordcount
%>
<tr align="center">
	<td width=3% bgcolor="#FFFFFF" id="td"><%=i%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodscode")%></td>
	<td width=15% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodsname")%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodsunit")%></td>
	<td width=7% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("units")%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("price"))%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("number"))%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("money"))%></td>
	<td width=20% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("detailnote")%></td>
</tr>
<%
rs_detail.movenext
Next
sql = "select sum(number) as num,sum(money) as mon from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_count = server.CreateObject("adodb.recordset")
rs_count.Open sql, conn, 1, 1
%>
<tr align="center" bgcolor="#FFFFFF">
	<td colspan="2" id="id">�ϼ�</td>
	<td id="td" colspan="4">&nbsp;</td>
	<td id="td"><%=rs_count("num")%></td>
	<td id="td"><%=rs_count("mon")%></td>
	<td>&nbsp;</td>
</tr>
</table>
<table width=100%>
<tr>
  <td>��ˣ�</td>
  <td>�ջ��ˣ�</td>
</tr>
</table>
<%end if%>
<!--������-->
<%if rs_bill("billtype")="�ֿ����" then%>
<br><div align="center"><span class="style1">������</span></div>
<br>
<table style="font-size:12px" width="80%" border="0" align="center">
<tbody>
 <tr>
   <td align="left">�Ƶ����ڣ�&nbsp;<%=rs_bill("adddate")%></td>
   <td align="left">���ݺ��룺&nbsp;<%=rs_bill("billcode")%></td>
   <td align="left">��&nbsp;��&nbsp;�֣�&nbsp;<%=rs_bill("custname")%></td>
 </tr>
 <tr>
   <td align="left">��&nbsp;��&nbsp;�֣�&nbsp;<%=rs_bill("depotname")%></td>
   <td align="left">��&nbsp;��&nbsp;�ˣ�&nbsp;<%=rs_bill("maker")%></td>
   <td align="left">��&nbsp;��&nbsp;�ˣ�&nbsp;<%=rs_bill("username")%></td>
 </tr>
</tbody></table>
<table id="tblprint" width=100% align="center" cellspacing="0" border="1" border-collapse:collapse;>
<tr align="center"><td width=3% bgcolor="#FFFFFF" id="td">&nbsp;</td>
<td width=10% bgcolor="#FFFFFF" id="td">��Ʒ����</td>
<td width=15% bgcolor="#FFFFFF" id="td">��Ʒ����</td>
<td width=10% bgcolor="#FFFFFF" id="td">��Ʒ���</td>
<td width=7% bgcolor="#FFFFFF" id="td">��λ</td>
<td width=10% bgcolor="#FFFFFF" id="td">����</td>
<td width=10% bgcolor="#FFFFFF" id="td">����</td>
<td width=10% bgcolor="#FFFFFF" id="td">���</td>
<td width=20% bgcolor="#FFFFFF" id="td">��ע</td>
</tr>
<%
sql = "select * from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_detail = server.CreateObject("adodb.recordset")
rs_detail.Open sql, conn, 1, 1
For i = 1 To rs_detail.recordcount
%>
<tr align="center">
	<td width=3% bgcolor="#FFFFFF" id="td"><%=i%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodscode")%></td>
	<td width=15% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodsname")%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodsunit")%></td>
	<td width=7% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("units")%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("price"))%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("number"))%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("money"))%></td>
	<td width=20% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("detailnote")%></td>
</tr>
<%
rs_detail.movenext
Next
sql = "select sum(number) as num,sum(money) as mon from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_count = server.CreateObject("adodb.recordset")
rs_count.Open sql, conn, 1, 1
%>
<tr align="center" bgcolor="#FFFFFF">
	<td colspan="2" id="id">�ϼ�</td>
	<td id="td" colspan="4">&nbsp;</td>
	<td id="td"><%=rs_count("num")%></td>
	<td id="td"><%=rs_count("mon")%></td>
	<td>&nbsp;</td>
</tr>
</table>
<%end if%>
<!--�̵㵥-->
<%if rs_bill("billtype")="����̵�" then%>
<br><div align="center"><span class="style1">�̵㵥</span></div>
<br>
<table style="font-size:12px" width="100%" border="0" align="center">
<tbody>
 <tr>
   <td align="left">�Ƶ����ڣ�&nbsp;<%=rs_bill("adddate")%></td>
   <td align="left">���ݺ��룺&nbsp;<%=rs_bill("billcode")%></td>
   <td align="left">&nbsp;&nbsp;</td>
 </tr>
 <tr>
   <td align="left">��&nbsp;&nbsp;&nbsp;&nbsp;�⣺&nbsp;<%=rs_bill("depotname")%></td>
   <td align="left">��&nbsp;��&nbsp;�ˣ�&nbsp;<%=rs_bill("maker")%></td>
   <td align="left">��&nbsp;��&nbsp;�ˣ�&nbsp;<%=rs_bill("username")%></td>
 </tr>
</tbody></table>
<table id="tblprint" width=100% align="center" cellspacing="0" border="1" border-collapse:collapse;>
<tr align="center"><td width=3% bgcolor="#FFFFFF" id="td">&nbsp;</td>
<td width=10% bgcolor="#FFFFFF" id="td">��Ʒ����</td>
<td width=15% bgcolor="#FFFFFF" id="td">��Ʒ����</td>
<td width=10% bgcolor="#FFFFFF" id="td">��Ʒ���</td>
<td width=7% bgcolor="#FFFFFF" id="td">��λ</td>
<td width=10% bgcolor="#FFFFFF" id="td">����</td>
<td width=10% bgcolor="#FFFFFF" id="td">����</td>
<td width=10% bgcolor="#FFFFFF" id="td">���</td>
<td width=20% bgcolor="#FFFFFF" id="td">��ע</td>
</tr>
<%
sql = "select * from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_detail = server.CreateObject("adodb.recordset")
rs_detail.Open sql, conn, 1, 1
For i = 1 To rs_detail.recordcount
%>
<tr align="center">
	<td width=3% bgcolor="#FFFFFF" id="td"><%=i%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodscode")%></td>
	<td width=15% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodsname")%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodsunit")%></td>
	<td width=7% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("units")%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("price"))%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("number"))%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("money"))%></td>
	<td width=20% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("detailnote")%></td>
</tr>
<%
rs_detail.movenext
Next
sql = "select sum(number) as num,sum(money) as mon from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_count = server.CreateObject("adodb.recordset")
rs_count.Open sql, conn, 1, 1
%>
<tr align="center" bgcolor="#FFFFFF">
	<td colspan="2" id="id">�ϼ�</td>
	<td id="td" colspan="4">&nbsp;</td>
	<td id="td"><%=rs_count("num")%></td>
	<td id="td"><%=rs_count("mon")%></td>
	<td>&nbsp;</td>
</tr>
</table>
<%end if%>
<!--�ɹ��˻�-->
<%if rs_bill("billtype")="�ɹ��˻�" then%>
<br><div align="center"><span class="style1">�ɹ��˻���</span></div>
<br>
<table style="font-size:12px" width="100%" border="0" align="center">
<tbody>
 <tr>
   <td align="left">�Ƶ����ڣ�&nbsp;<%=rs_bill("adddate")%></td>
   <td align="left">���ݺ��룺&nbsp;<%=rs_bill("billcode")%></td>
   <td align="left">��&nbsp;Ӧ&nbsp;�̣�&nbsp;<%=rs_bill("custname")%></td>
 </tr>
 <tr>
   <td align="left">��&nbsp;&nbsp;&nbsp;&nbsp;�⣺&nbsp;<%=rs_bill("depotname")%></td>
   <td align="left">��&nbsp;��&nbsp;�ˣ�&nbsp;<%=rs_bill("maker")%></td>
   <td align="left">��&nbsp;��&nbsp;�ˣ�&nbsp;<%=rs_bill("username")%></td>
 </tr>
</tbody></table>
<table id="tblprint" width=100% align="center" cellspacing="0" border="1" border-collapse:collapse;>
<tr align="center"><td width=3% bgcolor="#FFFFFF" id="td">&nbsp;</td>
<td width=10% bgcolor="#FFFFFF" id="td">��Ʒ����</td>
<td width=15% bgcolor="#FFFFFF" id="td">��Ʒ����</td>
<td width=10% bgcolor="#FFFFFF" id="td">��Ʒ���</td>
<td width=7% bgcolor="#FFFFFF" id="td">��λ</td>
<td width=10% bgcolor="#FFFFFF" id="td">����</td>
<td width=10% bgcolor="#FFFFFF" id="td">����</td>
<td width=10% bgcolor="#FFFFFF" id="td">���</td>
<td width=20% bgcolor="#FFFFFF" id="td">��ע</td>
</tr>
<%
sql = "select * from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_detail = server.CreateObject("adodb.recordset")
rs_detail.Open sql, conn, 1, 1
For i = 1 To rs_detail.recordcount
%>
<tr align="center">
	<td width=3% bgcolor="#FFFFFF" id="td"><%=i%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodscode")%></td>
	<td width=15% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodsname")%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodsunit")%></td>
	<td width=7% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("units")%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("price"))%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("number"))%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("money"))%></td>
	<td width=20% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("detailnote")%></td>
</tr>
<%
rs_detail.movenext
Next
sql = "select sum(number) as num,sum(money) as mon from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_count = server.CreateObject("adodb.recordset")
rs_count.Open sql, conn, 1, 1
%>
<tr align="center" bgcolor="#FFFFFF">
	<td colspan="2" id="id">�ϼ�</td>
	<td id="td" colspan="4">&nbsp;</td>
	<td id="td"><%=rs_count("num")%></td>
	<td id="td"><%=rs_count("mon")%></td>
	<td>&nbsp;</td>
</tr>
</table>
<table width=100%>
<tr>
  <td>��ˣ�</td>
  <td>�ջ��ˣ�</td>
</tr>
</table>
<%end if%>
<!--�����˻�-->
<%if rs_bill("billtype")="�����˻�" then%>
<br><div align="center"><span class="style1">�����˻���</span></div>
<br>
<table style="font-size:12px" width="100%" border="0" align="center">
<tbody>
 <tr>
   <td align="left">�Ƶ����ڣ�&nbsp;<%=rs_bill("adddate")%></td>
   <td align="left">���ݺ��룺>&nbsp;<%=rs_bill("billcode")%></td>
   <td align="left">��&nbsp;&nbsp;&nbsp;&nbsp;����&nbsp;<%=rs_bill("custname")%></td>
 </tr>
 <tr>
   <td align="left">��&nbsp;&nbsp;&nbsp;&nbsp;�⣺&nbsp;<%=rs_bill("depotname")%></td>
   <td align="left">��&nbsp;��&nbsp;�ˣ�&nbsp;<%=rs_bill("maker")%></td>
   <td align="left">��&nbsp;��&nbsp;�ˣ�&nbsp;<%=rs_bill("username")%></td>
 </tr>
</tbody></table>
<table id="tblprint" width=100% align="center" cellspacing="0" border="1" border-collapse:collapse;>
<tr align="center"><td width=3% bgcolor="#FFFFFF" id="td">&nbsp;</td>
<td width=10% bgcolor="#FFFFFF" id="td">��Ʒ����</td>
<td width=15% bgcolor="#FFFFFF" id="td">��Ʒ����</td>
<td width=10% bgcolor="#FFFFFF" id="td">��Ʒ���</td>
<td width=7% bgcolor="#FFFFFF" id="td">��λ</td>
<td width=10% bgcolor="#FFFFFF" id="td">����</td>
<td width=10% bgcolor="#FFFFFF" id="td">����</td>
<td width=10% bgcolor="#FFFFFF" id="td">���</td>
<td width=20% bgcolor="#FFFFFF" id="td">��ע</td>
</tr>
<%
sql = "select * from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_detail = server.CreateObject("adodb.recordset")
rs_detail.Open sql, conn, 1, 1
For i = 1 To rs_detail.recordcount
%>
<tr align="center">
	<td width=3% bgcolor="#FFFFFF" id="td"><%=i%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodscode")%></td>
	<td width=15% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodsname")%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodsunit")%></td>
	<td width=7% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("units")%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("price"))%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("number"))%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("money"))%></td>
	<td width=20% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("detailnote")%></td>
</tr>
<%
rs_detail.movenext
Next
sql = "select sum(number) as num,sum(money) as mon from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_count = server.CreateObject("adodb.recordset")
rs_count.Open sql, conn, 1, 1
%>
<tr align="center" bgcolor="#FFFFFF">
	<td colspan="2" id="id">�ϼ�</td>
	<td id="td" colspan="4">&nbsp;</td>
	<td id="td"><%=rs_count("num")%></td>
	<td id="td"><%=rs_count("mon")%></td>
	<td>&nbsp;</td>
</tr>
</table>
<table width=100%>
<tr>
  <td>��ˣ�</td>
  <td>�ͻ��ˣ�</td>
  <td>�ջ��ˣ�</td>
</tr>
</table>
<%end if%>
</body>
</html>
