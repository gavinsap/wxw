<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<%
if Request.QueryString("type") = "CD" then
	CheckAuthority("strCGFinish")
else
	CheckAuthority("strXSFinish")
end if
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<title>��������</title>
</head>

<body style="background:#FFFFFF">

<div style="background:url(../images/main-02.gif); width:100%; height:20; padding-left:0" ><img src="../images/main-01.gif"></div>
<div style="padding-left:10px">
<%
s_date1 = Year(Date()) & "-" & Month(Date()) & "-1"
s_date2 = formatdate(date)
%>
<br>
<form name="form1" method="post" action="orderdetail.asp?type=<%=request.QueryString("type")%>">
<%
if Request.QueryString("type") = "CD" then
Response.Write "<div align=""left""><span class=""style1"">�ɹ�����������</span></div>"
else
Response.Write "<div align=""left""><span class=""style1"">���۶���������</span></div>"
end if
%>
<table align="left"><tr><td>
<table id="tbl_tittle">
<tr>
<td height="26" align="left">��&nbsp;��&nbsp;�ڣ�</td>
      <td><label>
      <input type="text" name="date1" size="16" value=<%
If Request("date1") = "" Then
    Response.Write Year(Date()) & "-" & Month(Date()) & "-1"
Else
    Response.Write Request("date1")
End If

%>><%showdate("date1")%></label></td>
      <td align="right">��&nbsp;��&nbsp;�ڣ�</td>
      <td><input type="text" name="date2" size="16" value=<%
If Request("date2") = "" Then
    Response.Write Date()
Else
    Response.Write Request("date2")
End If

%>><%showdate("date2")%></td>
<td rowspan="2"><input type="submit" value=" �� ѯ " onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  class="button"></td>
</tr>
<tr>
<td align="right">��&nbsp;��&nbsp;�ţ�</td>
<td><input type="text" name="billcode" value="<%=request("billcode")%>" size="16"></td>
<td align="right">��Ʒ���ƣ�</td>
<td><input type="text" name="goodsname" value="<%=request("goodsname")%>" size="16"></td>
</tr>
</table>
<hr>
</form>
<%

if Request.Form("date1") <> "" then
  s_date1 = " and adddate >= '" & Request.Form("date1") & "'"
else
  s_date1 = " and adddate >= '" & s_date1 & "'"
end if
if Request.Form("date2") <> "" then
  s_date2 = " and adddate <= '" & Request.Form("date2") & "'"
else
  s_date2 = " and adddate <= '" & s_date2 & "'"
end if
if Request.Form("billcode") <> "" then
  s_billcode = "and billcode = '" & Request.Form("billcode") & "'"
else
  s_billcode = ""
end if
if Request.Form("goodsname") <> "" then
	sGoodsname = " and goodsname like '%" & Request.Form("goodsname") & "%'"
else
	sGoodsname = ""
end if
sql = "select s1.billcode,s1.goodscode,goodsname,goodsunit,units,ordernumber,isnull(finishnumber,0) as f_number,(ordernumber-finishnumber) as n_number,remark,custname from ((select billcode+goodscode as bg,billcode,goodscode,goodsname,goodsunit,units,sum(number) as ordernumber,remark,custname from s_billdetail where [check]=1 and billcode like '"&Request.QueryString("type")&"%'"&s_date1&s_date2&s_billcode&sGoodsname&" group by billcode,goodscode,goodsname,goodsunit,units,remark,custname) as s1 left join (select goodscode,planbillcode,sum(number) as finishnumber,planbillcode+goodscode as pg from s_billdetail group by planbillcode,goodscode) as s2 on s1.bg = s2.pg)"

call showpage(sql,"orderdetail",1)
endconnection
%>
</td></tr></table>
</div>
</body>
</html>
