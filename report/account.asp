<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<% call CheckAuthority("strDailyAccount") %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<title>�ʻ���ѯ</title>
</head>

<body style="background:#FFFFFF">
<div style="background:url(../images/main-02.gif); width:100%; height:20; padding-left:0" ><img src="../images/main-01.gif"></div>
<div style="padding-left:10px">
<%
if Request.Form("date1") = "" then
  s_date1 = Year(Date()) & "-" & Month(Date()) & "-1"
else
  s_date1 = Request.Form("date1")
end if

if Request.Form("date2") = "" then
  s_date2 = formatdate(date)
else
  s_date2 = Request.Form("date2")
end if
%>
<br>
<div align="left" class="STYLE1">�ʻ���ѯ</div>
<table align="left" width="650" border="0">
<tr>
  <td>
    <form name="form1" action="account.asp" method="post">
	<table align="left">
	<tr>
	  <td width="60%">����:<input type="text" name="date1" id="date1" size="16" value="<%=s_date1%>"><%showdate("date1")%>
	               <input type="text" name="date2" id="date2" size="16" value="<%=s_date2%>"><%showdate("date2")%>
	  </td>
	  <td align="right" width="10%">��&nbsp;&nbsp;&nbsp;&nbsp;��:</td>
      <td align="left" width="20%"><select name="account"><option value=""></option>
               <%
	           sql_account = "select * from t_account"
	    	       Set rs_account = server.CreateObject("adodb.recordset")
				  rs_account.open sql_account,conn,1,1
				  Do While rs_account.EOF = False
				   if request.Form("account")=rs_account("account") then
	 			     Response.Write "<option value="&rs_account("account")&" selected>"&rs_account("account")&"</option>"
				   else
				     Response.Write "<option value="&rs_account("account")&">"&rs_account("account")&"</option>"
				   end if
				   rs_account.movenext
				  loop
				  close_rs(rs_account)
				  %></select>
	  </td>
	  <td valign="top"><input type="submit" value=" �� ѯ " onMouseOver="this.className='button_over';" onMouseOut="this.className='button';" class="button"></td>	 
	   
	</tr>
	</table>
	</form>
  </td>
</tr>
<tr>
  <td>
    <hr>
	<%
	if Request.Form("account") = "" then
	  s_account = ""
	else
	  s_account = " and account = '" & Request.Form("account") & "'"
	end if
	
	sql1 = "select account,adddate,cashcode,money as t_zcmon,0 as t_srmon,'����' as billtype from t_cash where (AddDate)<='"&s_date2&"' and (AddDate)>='"&s_date1&"' and sign=-1 " & s_account
	sql2 = "select account,adddate,cashcode,0 as t_zcmon,money as t_srmon,'�տ�' as billtype from t_cash where (AddDate)<='"&s_date2&"' and (AddDate)>='"&s_date1&"' and sign=1 " & s_account
	sql3 = "select account,adddate,billcode,money as t_zcmon,0 as t_srmon,'����֧��' as billtype from t_cashbank where (AddDate)<='"&s_date2&"' and (AddDate)>='"&s_date1&"' and sign=-1 " & s_account
	sql4 = "select account,adddate,billcode,0 as t_zcmon,money as t_srmon,'��������' as billtype from t_cashbank where (AddDate)<='"&s_date2&"' and (AddDate)>='"&s_date1&"' and sign=1 " & s_account
	sql5 = "select account,adddate,billcode,pay as t_zcmon,0 as t_srmon,'�ɹ�����' as billtype from t_bill where (AddDate)<='"&s_date2&"' and (AddDate)>='"&s_date1&"' and flag=1 " & s_account & " and account <> ''"
	sql6 = "select account,adddate,billcode,0 as t_zcmon,pay as t_srmon,'�����տ�' as billtype from t_bill where (AddDate)<='"&s_date2&"' and (AddDate)>='"&s_date1&"' and flag=-1 " & s_account & " and account <> ''"
	sql  = "select top 1000000 * from (" & sql1 & " union all " & sql2 & " union all " & sql3 & " union all " & sql4 & " union all " & sql5 & " union all " & sql6 & ") d order by adddate"
	
	sql1 = "select '' as account,'"& cdate(s_date1) - 1 &"' as adddate,'' as cashcode,'�ڳ�' as billtype,sum(t_zcmon) as t_zcmon,sum(t_srmon) as t_srmon from s_account where AddDate<'"&s_date1&"'"&s_account
	sql2 = "select account,adddate,cashcode,billtype,t_zcmon,t_srmon from s_account where AddDate<='"&s_date2&"' and addDate>='"&s_date1&"'"& s_account
	sql = "select * from ("& sql1 &" union all "& sql2 &") dd"
	'Response.Write(sql)
	Call showpage(sql,"r_account",1)
	endconnection
	%>
  </td>
</tr>
</table>
</div>
</body>
</html>
