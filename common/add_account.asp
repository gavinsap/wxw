<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<title>����/�޸��ʻ���Ϣ</title>
</head>

<body>
<%
if Request.QueryString("add") = "true" then
  s_tittle = "�����ʻ���Ϣ"
  s_url    = "../action/add_account.asp?add=true"
  s_account = ""
  s_bank    = ""
  s_accountNO = ""
  d_original = 0
  s_memo    = ""
  s_id      = ""
else
  s_tittle = "�޸��ʻ���Ϣ"
  s_url    = "../action/add_account.asp?add=false"
  sql = "select * from t_account where id = " & Request.QueryString("id")
  Set rs = server.CreateObject("adodb.recordset")
  rs.Open sql, conn, 1, 1
  s_account = rs("account")
  s_bank    = rs("bank")
  s_accountNO = rs("accountNO")
  d_original = rs("original")
  s_memo    = rs("memo")
  s_id      = rs("id")
end if
endconnection
%>
<br>
<div class="STYLE1" align="center"><%=s_tittle%></div>
<br>
<form name="form1" method="post" action="<%=s_url%>">
<input type="hidden" name="id" value="<%=s_id%>">
<table id="tbl" width="500" align="center">
  <tr>
    <td align="right" width="70">�ʻ�����:</td>
	<td><input type="text" name="account" size="16" value="<%=s_account%>"></td>
    <td align="right" width="70">��������:</td>
	<td><input type="text" name="bank" size="16" value="<%=s_bank%>"></td>
  </tr>
  <tr>
    <td align="right" width="70">��&nbsp;&nbsp;&nbsp;&nbsp;��:</td>
	<td><input type="text" name="accountNO" size="16" value="<%=s_accountNO%>"></td>
    <td align="right" width="70">��ʼ���:</td>
	<td><input type="text" name="original" size="16" value="<%=d_original%>"></td>
  </tr>
  <tr>
    <td align="right" width="70">��&nbsp;&nbsp;&nbsp;&nbsp;ע:</td>
	<td colspan="3"><input type="text" name="memo" size="50" value="<%=s_memo%>"></td>
  </tr>
</table>
<br>
<div align="center"><input class="button" type="submit"  onMouseOver="this.className='button_over';" onMouseOut="this.className='button';" value="��&nbsp;&nbsp;��">&nbsp;&nbsp;<input class="button"  onMouseOver="this.className='button_over';" onMouseOut="this.className='button';" type="reset" value="��&nbsp;&nbsp;��"></div>

</form>
</body>
</html>>
</html>