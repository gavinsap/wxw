<!-- #include file="../inc/conn.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<script language=javascript>
function doPrint(billcode) { 
window.open ('../action/print.asp?billcode='+billcode, 'newwindow', 'height=600, width=800,toolbar=no,menubar=yes, scrollbars=yes, resizable=no,location=no, status=yes,top=80,left=200')
}
</script>
<title>��������</title>
</head>

<body>
<%
if request("billcode") <> "" then
sql = "select * from t_bill where billcode='"&request("billcode")&"'"
else
sql = "select * from t_bill where billcode='"&request.QueryString("billcode")&"'"
end if
Set rs_bill = server.CreateObject("adodb.recordset")
rs_bill.Open sql, conn, 1, 1
%>
<!--�ɹ�����-->
<%if rs_bill("billtype")="�ɹ�����" then%>
<br><div align="center"><span class="style1">�ɹ�����</span></div>
<div align="center"><span class="style1"><%=request("billcode")%></span></div><br>
<table id="tbl" style="font-size:12px" width="780" border="0" align="center">
<tbody>
<tr>
	<td align="right" width="70">�Ƶ����ڣ�</td>
	<td width="320">&nbsp;<%=rs_bill("adddate")%></td>
	<td align="right" width="70">��&nbsp;Ӧ&nbsp;�̣�</td>
	<td width="320">&nbsp;<%=rs_bill("custname")%></td>
</tr>
<tr>
	<td align="right" width="70">��&nbsp;&nbsp;&nbsp;&nbsp;�⣺</td>
	<td width="320">&nbsp;<%=rs_bill("depotname")%></td>
	<td align="right" width="70">��&nbsp;��&nbsp;�ˣ�</td>
	<td width="320">&nbsp;<%=rs_bill("maker")%></td>
</tr>
<tr>
	<td align="right" width="70">��&nbsp;&nbsp;&nbsp;&nbsp;ע��</td>
	<td width="320">&nbsp;<%=rs_bill("memo")%></td>
	<td align="right" width="70">��&nbsp;��&nbsp;�ˣ�</td>
	<td width="320">&nbsp;<%=rs_bill("username")%></td>
</tr>
</tbody>
</table>
<table id="tbl" align="center" width="780">
<tr align="center">
	<th width=3%>&nbsp;</th>
	<th width=10%>��Ʒ����</th>
	<th width=15%>��Ʒ����</th>
	<th width=10%>��Ʒ���</th>
	<th width=7%>��λ</th>
	<th width=10%>����</th>
	<th width=10%>����</th>
	<th width=10%>���</th>
	<th width=20%>��ע</th>
</tr>
<%
sql = "select * from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_detail = server.CreateObject("adodb.recordset")
rs_detail.Open sql, conn, 1, 1
For i = 1 To rs_detail.recordcount
%>
<tr align="center">
	<td id="td" width=3%><%=i%></td>
	<td id="td" width=10%><%=rs_detail("goodscode")%></td>
	<td id="td" width=15%><%=rs_detail("goodsname")%></td>
	<td id="td" width=10%><%=rs_detail("goodsunit")%></td>
	<td id="td" width=7%><%=rs_detail("units")%></td>
	<td id="td" width=10%><%=rs_detail("price")%></td>
	<td id="td" width=10%><%=rs_detail("number")%></td>
	<td id="td" width=10%><%=rs_detail("money")%></td>
	<td id="td" width=20%><%=rs_detail("detailnote")%></td>
</tr>
<%
rs_detail.movenext
Next
sql = "select sum(number) as num,sum(money) as mon from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_count = server.CreateObject("adodb.recordset")
rs_count.Open sql, conn, 1, 1
%>
<tr align="center">
	<th colspan="2" id="id">�ϼ�</th>
	<th id="td" colspan="4"></th>
	<th id="td"><%=rs_count("num")%></th>
	<th id="td"><%=rs_count("mon")%></th>
	<th></th>
</tr>
</table>
<%end if%>
<!--���۶���-->
<%if rs_bill("billtype")="���۶���" then%>
<br><div align="center"><span class="style1">���۶���</span></div>
<div align="center"><span class="style1"><%=request("billcode")%></span></div><br>
<table id="tbl" style="font-size:12px" width="780" border="1" align="center" cellpadding="2" cellspacing="0" bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#FFFFEE">
<tbody>
<tr>
  <td align="right" width="70">�Ƶ����ڣ�</td>
  <td width="320">&nbsp;<%=rs_bill("adddate")%></td>
  <td align="right" width="70">��&nbsp;&nbsp;&nbsp;&nbsp;����</td>
  <td width="320">&nbsp;<%=rs_bill("custname")%></td>
</tr>
<tr>
	<td align="right" width="70">��&nbsp;&nbsp;&nbsp;&nbsp;�⣺</td>
	<td width="320">&nbsp;<%=rs_bill("depotname")%></td>
	<td align="right">��&nbsp;��&nbsp;�ˣ�</td>
	<td>&nbsp;<%=rs_bill("maker")%></td>
</tr>
<tr>
	<td align="right">��&nbsp;&nbsp;ע��</td>
	<td>&nbsp;<%=rs_bill("memo")%></td>
	<td align="right">��&nbsp;��&nbsp;�ˣ�</td>
	<td>&nbsp;<%=rs_bill("username")%></td>
</tr>
</tbody>
</table>
<table id="tbl" align="center" width="780">
<tr align="center">
	<td id="td" width=3%>&nbsp;</td>
	<td id="td" width=10%>��Ʒ����</td>
	<td id="td" width=15%>��Ʒ����</td>
	<td id="td" width=10%>��Ʒ���</td>
	<td id="td" width=7%>��λ</td>
	<td id="td" width=10%>����</td>
	<td id="td" width=10%>����</td>
	<td id="td" width=10%>���</td>
	<td id="td" width=20%>��ע</td>
</tr>
<%
sql = "select * from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_detail = server.CreateObject("adodb.recordset")
rs_detail.Open sql, conn, 1, 1
For i = 1 To rs_detail.recordcount
%>
<tr align="center">
	<td id="td" width=3%><%=i%></td>
	<td id="td" width=10%><%=rs_detail("goodscode")%></td>
	<td id="td" width=15%><%=rs_detail("goodsname")%></td>
	<td id="td" width=10%><%=rs_detail("goodsunit")%></td>
	<td id="td" width=7%><%=rs_detail("units")%></td>
	<td id="td" width=10%><%=rs_detail("price")%></td>
	<td id="td" width=10%><%=rs_detail("number")%></td>
	<td id="td" width=10%><%=rs_detail("money")%></td>
	<td id="td" width=20%><%=rs_detail("detailnote")%></td>
</tr>
<%
rs_detail.movenext
Next
sql = "select sum(number) as num,sum(money) as mon from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_count = server.CreateObject("adodb.recordset")
rs_count.Open sql, conn, 1, 1
%>
<tr align="center">
	<td colspan="2" id="id">�ϼ�</td>
	<td id="td" colspan="4"></td>
	<td id="td"><%=rs_count("num")%></td>
	<td id="td"><%=rs_count("mon")%></td>
	<td></td>
</tr>
</table>
<%end if%>
<!--�ɹ����-->
<%if rs_bill("billtype")="�ɹ����" then%>
<br><div align="center"><span class="style1">�ɹ���ⵥ</span></div>
<div align="center"><span class="style1"><%=request("billcode")%></span></div><br>
<table id="tbl" style="font-size:12px" width="780" border="0" align="center">
<tbody>
<tr>
	<td align="right" width="70">�Ƶ����ڣ�</td>
	<td width="320">&nbsp;<%=rs_bill("adddate")%></td>
	<td align="right" width="70">��&nbsp;Ӧ&nbsp;�̣�</td>
	<td width="320">&nbsp;<%=rs_bill("custname")%></td>
</tr>
<tr>
	<td align="right">��&nbsp;&nbsp;&nbsp;&nbsp;�⣺</td>
	<td>&nbsp;<%=rs_bill("depotname")%></td>
	<td align="right">��&nbsp;��&nbsp;�ˣ�</td>
	<td>&nbsp;<%=rs_bill("maker")%></td>
</tr>
<tr>
	<td align="right">��&nbsp;&nbsp;&nbsp;&nbsp;ע��</td>
	<td>&nbsp;<%=rs_bill("memo")%></td>
	<td align="right">��&nbsp;��&nbsp;�ˣ�</td>
	<td>&nbsp;<%=rs_bill("username")%></td>
</tr>
</tbody>
</table>
<table id="tbl" align="center" width="780">
<tr align="center">
	<td id="td" width=3%>&nbsp;</td>
	<td id="td" width=10%>��Ʒ����</td>
	<td id="td" width=15%>��Ʒ����</td>
	<td id="td" width=10%>��Ʒ���</td>
	<td id="td" width=7%>��λ</td>
	<td id="td" width=10%>����</td>
	<td id="td" width=10%>����</td>
	<td id="td" width=10%>���</td>
	<td id="td" width=20%>��ע</td>
</tr>
<%
sql = "select * from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_detail = server.CreateObject("adodb.recordset")
rs_detail.Open sql, conn, 1, 1
For i = 1 To rs_detail.recordcount
%>
<tr align="center">
	<td id="td" width=3%><%=i%></td>
	<td id="td" width=10%><%=rs_detail("goodscode")%></td>
	<td id="td" width=15%><%=rs_detail("goodsname")%></td>
	<td id="td" width=10%><%=rs_detail("goodsunit")%></td>
	<td id="td" width=7%><%=rs_detail("units")%></td>
	<td id="td" width=10%><%=rs_detail("price")%></td>
	<td id="td" width=10%><%=rs_detail("number")%></td>
	<td id="td" width=10%><%=rs_detail("money")%></td>
	<td id="td" width=20%><%=rs_detail("detailnote")%></td>
</tr>
<%
rs_detail.movenext
Next
sql = "select sum(number) as num,sum(money) as mon from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_count = server.CreateObject("adodb.recordset")
rs_count.Open sql, conn, 1, 1
%>
<tr align="center">
	<td colspan="2" id="id">�ϼ�</td>
	<td id="td" colspan="4"></td>
	<td id="td"><%=rs_count("num")%></td>
	<td id="td"><%=rs_count("mon")%></td>
	<td></td>
</tr>
</table>
<%end if%>
<!--���۳���-->
<%if rs_bill("billtype")="���۳���" then%>
<br><div align="center"><span class="style1">���۳��ⵥ</span></div>
<div align="center"><span class="style1"><%=request("billcode")%></span></div><br>
<table id="tbl" style="font-size:12px" width="780" border="1" align="center" cellpadding="2" cellspacing="0" bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#FFFFEE">
<tbody>
<tr>
	<td align="right" width="70">�Ƶ����ڣ�</td>
	<td width="320">&nbsp;<%=rs_bill("adddate")%></td>
	<td align="right" width="70">��&nbsp;&nbsp;&nbsp;&nbsp;����</td>
	<td width="320">&nbsp;<%=rs_bill("custname")%></td>
</tr>
<tr>
	<td align="right">��&nbsp;&nbsp;&nbsp;&nbsp;�⣺</td>
	<td>&nbsp;<%=rs_bill("depotname")%></td>
	<td align="right">��&nbsp;��&nbsp;�ˣ�</td>
	<td>&nbsp;<%=rs_bill("maker")%></td>
</tr>
<tr>
	<td align="right">��&nbsp;&nbsp;&nbsp;&nbsp;ע��</td>
	<td>&nbsp;<%=rs_bill("memo")%></td>
	<td align="right">��&nbsp;��&nbsp;�ˣ�</td>
	<td>&nbsp;<%=rs_bill("username")%></td>
</tr>
</tbody>
</table>
<table id="tbl" align="center" width="780">
<tr align="center">
	<td id="td" width=3%>&nbsp;</td>
	<td id="td" width=10%>��Ʒ����</td>
	<td id="td" width=15%>��Ʒ����</td>
	<td id="td" width=10%>��Ʒ���</td>
	<td id="td" width=7%>��λ</td>
	<td id="td" width=10%>����</td>
	<td id="td" width=10%>����</td>
	<td id="td" width=10%>���</td>
	<td id="td" width=20%>��ע</td>
</tr>
<%
sql = "select * from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_detail = server.CreateObject("adodb.recordset")
rs_detail.Open sql, conn, 1, 1
For i = 1 To rs_detail.recordcount
%>
<tr align="center">
	<td id="td" width=3%><%=i%></td>
	<td id="td" width=10%><%=rs_detail("goodscode")%></td>
	<td id="td" width=15%><%=rs_detail("goodsname")%></td>
	<td id="td" width=10%><%=rs_detail("goodsunit")%></td>
	<td id="td" width=7%><%=rs_detail("units")%></td>
	<td id="td" width=10%><%=rs_detail("price")%></td>
	<td id="td" width=10%><%=rs_detail("number")%></td>
	<td id="td" width=10%><%=rs_detail("money")%></td>
	<td id="td" width=20%><%=rs_detail("detailnote")%></td>
</tr>
<%
rs_detail.movenext
Next
sql = "select sum(number) as num,sum(money) as mon from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_count = server.CreateObject("adodb.recordset")
rs_count.Open sql, conn, 1, 1
%>
<tr align="center">
	<td colspan="2" id="id">�ϼ�</td>
	<td id="td" colspan="4"></td>
	<td id="td"><%=rs_count("num")%></td>
	<td id="td"><%=rs_count("mon")%></td>
	<td></td>
</tr>
</table>
<%end if%>
<!--�������-->
<%if rs_bill("billtype")="�������" then%>
<br><div align="center"><span class="style1">��ⵥ</span></div>
<div align="center"><span class="style1"><%=request("billcode")%></span></div><br>
<table id="tbl" style="font-size:12px" width="780" border="1" align="center" cellpadding="2" cellspacing="0" bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#FFFFEE">
<tbody>
<tr>
	<td align="right" width="70">�Ƶ����ڣ�</td>
	<td width="320">&nbsp;<%=rs_bill("adddate")%></td>
	<td align="right" width="70">��&nbsp;Ӧ&nbsp;�̣�</td>
	<td width="320">&nbsp;<%=rs_bill("custname")%></td>
</tr>
<tr>
	<td align="right">��&nbsp;&nbsp;&nbsp;&nbsp;�⣺</td>
	<td>&nbsp;<%=rs_bill("depotname")%></td>
	<td align="right">��&nbsp;��&nbsp;�ˣ�</td>
	<td>&nbsp;<%=rs_bill("maker")%></td>
</tr>
<tr>
	<td align="right">��&nbsp;&nbsp;&nbsp;&nbsp;ע��</td>
	<td>&nbsp;<%=rs_bill("memo")%></td>
	<td align="right">��&nbsp;��&nbsp;�ˣ�</td>
	<td>&nbsp;<%=rs_bill("username")%></td>
</tr>
</tbody>
</table>
<table id="tbl" align="center" width="780">
<tr align="center">
	<td id="td" width=3%>&nbsp;</td>
	<td id="td" width=10%>��Ʒ����</td>
	<td id="td" width=15%>��Ʒ����</td>
	<td id="td" width=10%>��Ʒ���</td>
	<td id="td" width=7%>��λ</td>
	<td id="td" width=10%>����</td>
	<td id="td" width=10%>����</td>
	<td id="td" width=10%>���</td>
	<td id="td" width=20%>��ע</td>
</tr>
<%
sql = "select * from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_detail = server.CreateObject("adodb.recordset")
rs_detail.Open sql, conn, 1, 1
For i = 1 To rs_detail.recordcount
%>
<tr align="center">
	<td id="td" width=3%><%=i%></td>
	<td id="td" width=10%><%=rs_detail("goodscode")%></td>
	<td id="td" width=15%><%=rs_detail("goodsname")%></td>
	<td id="td" width=10%><%=rs_detail("goodsunit")%></td>
	<td id="td" width=7%><%=rs_detail("units")%></td>
	<td id="td" width=10%><%=rs_detail("price")%></td>
	<td id="td" width=10%><%=rs_detail("number")%></td>
	<td id="td" width=10%><%=rs_detail("money")%></td>
	<td id="td" width=20%><%=rs_detail("detailnote")%></td>
</tr>
<%
rs_detail.movenext
Next
sql = "select sum(number) as num,sum(money) as mon from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_count = server.CreateObject("adodb.recordset")
rs_count.Open sql, conn, 1, 1
%>
<tr align="center">
	<td colspan="2" id="id">�ϼ�</td>
	<td id="td" colspan="4"></td>
	<td id="td"><%=rs_count("num")%></td>
	<td id="td"><%=rs_count("mon")%></td>
	<td></td>
</tr>
</table>
<%end if%>
<!--��������-->
<%if rs_bill("billtype")="��������" then%>
<br><div align="center"><span class="style1">���ⵥ</span></div>
<div align="center"><span class="style1"><%=request("billcode")%></span></div><br>
<table id="tbl" style="font-size:12px" width="780" border="1" align="center" cellpadding="2" cellspacing="0" bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#FFFFEE">
<tbody>
<tr>
	<td align="right" width="70">�Ƶ����ڣ�</td>
	<td width="320">&nbsp;<%=rs_bill("adddate")%></td>
	<td align="right" width="70">��&nbsp;&nbsp;&nbsp;&nbsp;����</td>
	<td width="320">&nbsp;<%=rs_bill("custname")%></td>
</tr>
<tr>
	<td align="right" width="70">��&nbsp;&nbsp;&nbsp;&nbsp;�⣺</td>
	<td width="320">&nbsp;<%=rs_bill("depotname")%></td>
	<td align="right">��&nbsp;��&nbsp;�ˣ�</td>
	<td>&nbsp;<%=rs_bill("maker")%></td>
</tr>
<tr>
	<td align="right">��&nbsp;&nbsp;&nbsp;&nbsp;ע��</td>
	<td>&nbsp;<%=rs_bill("memo")%></td>
	<td align="right">��&nbsp;��&nbsp;�ˣ�</td>
	<td>&nbsp;<%=rs_bill("username")%></td>
</tr>
</tbody>
</table>
<table id="tbl" align="center" width="780">
<tr align="center">
	<td id="td" width=3%>&nbsp;</td>
	<td id="td" width=10%>��Ʒ����</td>
	<td id="td" width=15%>��Ʒ����</td>
	<td id="td" width=10%>��Ʒ���</td>
	<td id="td" width=7%>��λ</td>
	<td id="td" width=10%>����</td>
	<td id="td" width=10%>����</td>
	<td id="td" width=10%>���</td>
	<td id="td" width=20%>��ע</td>
</tr>
<%
sql = "select * from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_detail = server.CreateObject("adodb.recordset")
rs_detail.Open sql, conn, 1, 1
For i = 1 To rs_detail.recordcount
%>
<tr align="center">
	<td id="td" width=3%><%=i%></td>
	<td id="td" width=10%><%=rs_detail("goodscode")%></td>
	<td id="td" width=15%><%=rs_detail("goodsname")%></td>
	<td id="td" width=10%><%=rs_detail("goodsunit")%></td>
	<td id="td" width=7%><%=rs_detail("units")%></td>
	<td id="td" width=10%><%=rs_detail("price")%></td>
	<td id="td" width=10%><%=rs_detail("number")%></td>
	<td id="td" width=10%><%=rs_detail("money")%></td>
	<td id="td" width=20%><%=rs_detail("detailnote")%></td>
</tr>
<%
rs_detail.movenext
Next
sql = "select sum(number) as num,sum(money) as mon from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_count = server.CreateObject("adodb.recordset")
rs_count.Open sql, conn, 1, 1
%>
<tr align="center">
	<td colspan="2" id="id">�ϼ�</td>
	<td id="td" colspan="4"></td>
	<td id="td"><%=rs_count("num")%></td>
	<td id="td"><%=rs_count("mon")%></td>
	<td></td>
</tr>
</table>
<%end if%>
<!--������-->
<%if rs_bill("billtype")="�ֿ����" then%>
<br><div align="center"><span class="style1">������</span></div>
<div align="center"><span class="style1"><%=request("billcode")%></span></div><br>
<table id="tbl" style="font-size:12px" width="780" border="1" align="center" cellpadding="2" cellspacing="0" bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#FFFFEE">
<tbody>
<tr>
	<td align="right" width="70">�Ƶ����ڣ�</td>
	<td width="320">&nbsp;<%=rs_bill("adddate")%></td>
	<td align="right" width="70">��&nbsp;��&nbsp;�֣�</td>
	<td width="320">&nbsp;<%=rs_bill("custname")%></td>
</tr>
<tr>
	<td align="right">��&nbsp;&nbsp;&nbsp;&nbsp;�⣺</td>
	<td>&nbsp;<%=rs_bill("depotname")%></td>
	<td align="right">��&nbsp;��&nbsp;�ˣ�</td>
	<td>&nbsp;<%=rs_bill("maker")%></td>
</tr>
<tr>
	<td align="right">��&nbsp;&nbsp;&nbsp;&nbsp;ע��</td>
	<td>&nbsp;<%=rs_bill("memo")%></td>
	<td align="right">��&nbsp;��&nbsp;�ˣ�</td>
	<td>&nbsp;<%=rs_bill("username")%></td>
</tr>
</tbody>
</table>
<table id="tbl" align="center" width="780">
<tr align="center">
	<td id="td" width=3%>&nbsp;</td>
	<td id="td" width=10%>��Ʒ����</td>
	<td id="td" width=15%>��Ʒ����</td>
	<td id="td" width=10%>��Ʒ���</td>
	<td id="td" width=7%>��λ</td>
	<td id="td" width=10%>����</td>
	<td id="td" width=10%>����</td>
	<td id="td" width=10%>���</td>
	<td id="td" width=20%>��ע</td>
</tr>
<%
sql = "select * from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_detail = server.CreateObject("adodb.recordset")
rs_detail.Open sql, conn, 1, 1
For i = 1 To rs_detail.recordcount
%>
<tr align="center">
	<td id="td" width=3%><%=i%></td>
	<td id="td" width=10%><%=rs_detail("goodscode")%></td>
	<td id="td" width=15%><%=rs_detail("goodsname")%></td>
	<td id="td" width=10%><%=rs_detail("goodsunit")%></td>
	<td id="td" width=7%><%=rs_detail("units")%></td>
	<td id="td" width=10%><%=rs_detail("price")%></td>
	<td id="td" width=10%><%=rs_detail("number")%></td>
	<td id="td" width=10%><%=rs_detail("money")%></td>
	<td id="td" width=20%><%=rs_detail("detailnote")%></td>
</tr>
<%
rs_detail.movenext
Next
sql = "select sum(number) as num,sum(money) as mon from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_count = server.CreateObject("adodb.recordset")
rs_count.Open sql, conn, 1, 1
%>
<tr align="center">
	<td colspan="2" id="id">�ϼ�</td>
	<td id="td" colspan="4"></td>
	<td id="td"><%=rs_count("num")%></td>
	<td id="td"><%=rs_count("mon")%></td>
	<td></td>
</tr>
</table>
<%end if%>
<!--�̵㵥-->
<%if rs_bill("billtype")="����̵�" then%>
<br><div align="center"><span class="style1">�̵㵥</span></div>
<div align="center"><span class="style1"><%=request("billcode")%></span></div><br>
<table id="tbl" style="font-size:12px" width="780" border="1" align="center" cellpadding="2" cellspacing="0" bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#FFFFEE">
<tbody>
<tr>
	<td align="right" width="70">�Ƶ����ڣ�</td>
	<td width="320">&nbsp;<%=rs_bill("adddate")%></td>
	<td align="right" width="70">&nbsp;</td>
	<td width="320">&nbsp;</td>
</tr>
<tr>
	<td align="right">��&nbsp;&nbsp;&nbsp;&nbsp;�⣺</td>
	<td>&nbsp;<%=rs_bill("depotname")%></td>
	<td align="right">��&nbsp;��&nbsp;�ˣ�</td>
	<td>&nbsp;<%=rs_bill("maker")%></td>
</tr>
<tr>
	<td align="right">��&nbsp;&nbsp;&nbsp;&nbsp;ע��</td>
	<td>&nbsp;<%=rs_bill("memo")%></td>
	<td align="right">��&nbsp;��&nbsp;�ˣ�</td>
	<td>&nbsp;<%=rs_bill("username")%></td>
</tr>
</tbody>
</table>
<table id="tbl" align="center" width="780">
<tr align="center">
	<td id="td" width=3%>&nbsp;</td>
	<td id="td" width=10%>��Ʒ����</td>
	<td id="td" width=15%>��Ʒ����</td>
	<td id="td" width=10%>��Ʒ���</td>
	<td id="td" width=7%>��λ</td>
	<td id="td" width=10%>����</td>
	<td id="td" width=10%>����</td>
	<td id="td" width=10%>���</td>
	<td id="td" width=20%>��ע</td>
</tr>
<%
sql = "select * from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_detail = server.CreateObject("adodb.recordset")
rs_detail.Open sql, conn, 1, 1
For i = 1 To rs_detail.recordcount
%>
<tr align="center">
	<td id="td" width=3%><%=i%></td>
	<td id="td" width=10%><%=rs_detail("goodscode")%></td>
	<td id="td" width=15%><%=rs_detail("goodsname")%></td>
	<td id="td" width=10%><%=rs_detail("goodsunit")%></td>
	<td id="td" width=7%><%=rs_detail("units")%></td>
	<td id="td" width=10%><%=rs_detail("price")%></td>
	<td id="td" width=10%><%=rs_detail("number")%></td>
	<td id="td" width=10%><%=rs_detail("money")%></td>
	<td id="td" width=20%><%=rs_detail("detailnote")%></td>
</tr>
<%
rs_detail.movenext
Next
sql = "select sum(number) as num,sum(money) as mon from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_count = server.CreateObject("adodb.recordset")
rs_count.Open sql, conn, 1, 1
%>
<tr align="center">
	<td colspan="2" id="id">�ϼ�</td>
	<td id="td" colspan="4"></td>
	<td id="td"><%=rs_count("num")%></td>
	<td id="td"><%=rs_count("mon")%></td>
	<td></td>
</tr>
</table>
<%end if%>
<!--�ɹ��˻�-->
<%if rs_bill("billtype")="�ɹ��˻�" then%>
<br><div align="center"><span class="style1">�ɹ��˻���</span></div>
<div align="center"><span class="style1"><%=request("billcode")%></span></div><br>
<table id="tbl" style="font-size:12px" width="780" border="1" align="center" cellpadding="2" cellspacing="0" bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#FFFFEE">
<tbody>
<tr>
	<td align="right" width="70">�Ƶ����ڣ�</td>
	<td width="320">&nbsp;<%=rs_bill("adddate")%></td>
	<td align="right" width="70">��&nbsp;Ӧ&nbsp;�̣�</td>
	<td width="320">&nbsp;<%=rs_bill("custname")%></td>
</tr>
<tr>
	<td align="right">��&nbsp;&nbsp;&nbsp;&nbsp;�⣺</td>
	<td>&nbsp;<%=rs_bill("depotname")%></td>
	<td align="right">��&nbsp;��&nbsp;�ˣ�</td>
	<td>&nbsp;<%=rs_bill("maker")%></td>
</tr>
<tr>
	<td align="right">��&nbsp;&nbsp;&nbsp;&nbsp;ע��</td>
	<td>&nbsp;<%=rs_bill("memo")%></td>
	<td align="right">��&nbsp;��&nbsp;�ˣ�</td>
	<td>&nbsp;<%=rs_bill("username")%></td>
</tr>
</tbody>
</table>
<table id="tbl" align="center" width="780">
<tr align="center">
	<td id="td" width=3%>&nbsp;</td>
	<td id="td" width=10%>��Ʒ����</td>
	<td id="td" width=15%>��Ʒ����</td>
	<td id="td" width=10%>��Ʒ���</td>
	<td id="td" width=7%>��λ</td>
	<td id="td" width=10%>����</td>
	<td id="td" width=10%>����</td>
	<td id="td" width=10%>���</td>
	<td id="td" width=20%>��ע</td>
</tr>
<%
sql = "select * from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_detail = server.CreateObject("adodb.recordset")
rs_detail.Open sql, conn, 1, 1
For i = 1 To rs_detail.recordcount
%>
<tr align="center">
	<td id="td" width=3%><%=i%></td>
	<td id="td" width=10%><%=rs_detail("goodscode")%></td>
	<td id="td" width=15%><%=rs_detail("goodsname")%></td>
	<td id="td" width=10%><%=rs_detail("goodsunit")%></td>
	<td id="td" width=7%><%=rs_detail("units")%></td>
	<td id="td" width=10%><%=rs_detail("price")%></td>
	<td id="td" width=10%><%=rs_detail("number")%></td>
	<td id="td" width=10%><%=rs_detail("money")%></td>
	<td id="td" width=20%><%=rs_detail("detailnote")%></td>
</tr>
<%
rs_detail.movenext
Next
sql = "select sum(number) as num,sum(money) as mon from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_count = server.CreateObject("adodb.recordset")
rs_count.Open sql, conn, 1, 1
%>
<tr align="center">
	<td colspan="2" id="id">�ϼ�</td>
	<td id="td" colspan="4"></td>
	<td id="td"><%=rs_count("num")%></td>
	<td id="td"><%=rs_count("mon")%></td>
	<td></td>
</tr>
</table>
<%end if%>
<!--�����˻�-->
<%if rs_bill("billtype")="�����˻�" then%>
<br><div align="center"><span class="style1">�����˻���</span></div>
<div align="center"><span class="style1"><%=request("billcode")%></span></div><br>
<table style="font-size:12px" width="780" border="1" align="center" cellpadding="2" cellspacing="0" bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#FFFFEE">
<tbody>
<tr>
	<td align="right" width="70">�Ƶ����ڣ�</td>
	<td width="320">&nbsp;<%=rs_bill("adddate")%></td>
	<td align="right" width="70">��&nbsp;&nbsp;&nbsp;&nbsp;����</td>
	<td width="320">&nbsp;<%=rs_bill("custname")%></td>
</tr>
<tr>
	<td align="right">��&nbsp;&nbsp;&nbsp;&nbsp;�⣺</td>
	<td>&nbsp;<%=rs_bill("depotname")%></td>
	<td align="right">��&nbsp;��&nbsp;�ˣ�</td>
	<td>&nbsp;<%=rs_bill("maker")%></td>
</tr>
<tr>
	<td align="right">��&nbsp;&nbsp;&nbsp;&nbsp;ע��</td>
	<td>&nbsp;<%=rs_bill("memo")%></td>
	<td align="right">��&nbsp;��&nbsp;�ˣ�</td>
	<td>&nbsp;<%=rs_bill("username")%></td>
</tr>
</tbody>
</table>
<table id="tbl" align="center" width="780">
<tr align="center">
	<td id="td" width=3%>&nbsp;</td>
	<td id="td" width=10%>��Ʒ����</td>
	<td id="td" width=15%>��Ʒ����</td>
	<td id="td" width=10%>��Ʒ���</td>
	<td id="td" width=7%>��λ</td>
	<td id="td" width=10%>����</td>
	<td id="td" width=10%>����</td>
	<td id="td" width=10%>���</td>
	<td id="td" width=20%>��ע</td>
</tr>
<%
sql = "select * from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_detail = server.CreateObject("adodb.recordset")
rs_detail.Open sql, conn, 1, 1
For i = 1 To rs_detail.recordcount
%>
<tr align="center">
	<td id="td" width=3%><%=i%></td>
	<td id="td" width=10%><%=rs_detail("goodscode")%></td>
	<td id="td" width=15%><%=rs_detail("goodsname")%></td>
	<td id="td" width=10%><%=rs_detail("goodsunit")%></td>
	<td id="td" width=7%><%=rs_detail("units")%></td>
	<td id="td" width=10%><%=rs_detail("price")%></td>
	<td id="td" width=10%><%=rs_detail("number")%></td>
	<td id="td" width=10%><%=rs_detail("money")%></td>
	<td id="td" width=20%><%=rs_detail("detailnote")%></td>
</tr>
<%
rs_detail.movenext
Next
sql = "select sum(number) as num,sum(money) as mon from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_count = server.CreateObject("adodb.recordset")
rs_count.Open sql, conn, 1, 1
%>
<tr align="center">
	<td colspan="2" id="id">�ϼ�</td>
	<td id="td" colspan="4"></td>
	<td id="td"><%=rs_count("num")%></td>
	<td id="td"><%=rs_count("mon")%></td>
	<td></td>
</tr>
</table>
<%end if%>
<div align="center">
  <input name="button" type="button" class="button but_mar" onClick="doPrint('<%=rs_bill("billcode")%>')" value=" �� ӡ ">
</div>
<%
close_rs(rs_bill)
close_rs(rs_detail)
close_rs(rs_count)
endconnection
%>
</body>
</html>
