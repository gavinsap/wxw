<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<% call CheckAuthority("strCustBuyCount") %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<title>�ɹ����ܱ�</title>
</head>

<body style="background:#FFFFFF">
<div style="background:url(../images/main-02.gif); width:100%; height:20; padding-left:0" ><img src="../images/main-01.gif"></div>
<div style="padding-left:10px">
<%
s_date1 = Year(Date()) & "-" & Month(Date()) & "-1"
s_date2 = formatdate(date)
%>
<br>
<form id="form1" name="sample" method="post" action="custbuycount.asp">
<div align="left" class="style1">��Ӧ�̲ɹ����ܱ�</div>
<table align="left" border="0"><tr><td>
  <table border="0" id="tbl_tittle">
    <tr>
      <td width="70" align="right" height="24">�ֿ����ƣ�</td>
      <td width="150">
      <%call showdepot("depot",Request.Form("depot"))%>
	 
	  </td>
      <td width="70" align="right">��&nbsp;Ӧ&nbsp;�̣�</td>
      <td width="150"><label>
      <input type="text" name="custname" id="cust" size="16" value=<%=Request.Form("custname")%> ><a href="#" onClick="JavaScript:window.open ('../common/selectcust.asp', 'newwindow', 'height=600, width=800,top=100,left=150, toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no, status=no')"><img border="0" src="../img/choose.gif" width="21" height="17"></a></label></td>
      <td rowspan="3"><input type="submit" name="Submit" value=" �� ѯ " onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  class="button" /></td>
    </tr>
    <tr>
      <td align="right" height="26">��&nbsp;��&nbsp;�ڣ�</td>
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
    </tr>
	<tr>
    <td align="right">��Ʒ���ƣ�</td>
    <td><input type="text" name="goodsname" size="16" value=<%=request.Form("goodsname")%>></td>
	<td align="right">��&nbsp;��&nbsp;�ˣ�</td>
    <td><% call showcombo("t_Employee","name","user",Request.Form("user")) %></td>
    </tr>
  </table><hr>
</form>

<%
  sql_depot = "select depotname,RDepot from t_user where username='"&request.cookies("username")&"'"
Set rs_depot = conn.Execute(sql_depot)

if rs_depot("RDepot")=false then
   sql = "select depotname from t_depot where 1=1"
   set rs=conn.execute(sql)
    Do While rs.eof=False
	  s_depotpower = s_depotpower & "'" & rs("depotname") & "',"
	  rs.movenext
     loop 
sDepotname = " and depotname in (" & s_depotpower & "'a')" 
else
arr = split(rs_depot("depotname"),",")
if ubound(arr) <> -1 then
  for i = lbound(arr) to ubound(arr)-1
	s_depotpower = s_depotpower & "'" & arr(i) & "',"
  next
end if

  sDepotname = " and depotname in (" & s_depotpower & "'a')" 

end if

If Request.Form("date1")<>"" Then
    s_date1 = Request.Form("date1")

End If
If Request.Form("date2")<>"" Then
    s_date2 = Request.Form("date2")
End If
If Request.Form("depot") = "" Then
    s_depotname = " and depotname in ("&s_depotpower&"'a')"
Else
    s_depotname = " and depotname='"&Request.Form("depot")&"'"
End If
If Request.Form("custname") = "" Then
    s_custname = ""
Else
    s_custname = " and custname like '%"&Request.Form("custname")&"%'"
End If
If Request.Form("goodsname") = "" Then
    s_goodsname = ""
Else
    s_goodsname = " and goodsname='"&Request.Form("goodsname")&"'"
End If
If Request.Form("user") = "" Then
    s_user = ""
Else
    s_user = " and username='"&Request.Form("user")&"'"
End If

sql = " select s1.custname,isnull(innum,0) as t_innum,isnull(inmoney,0) as t_inmoney,isnull(outnum,0) as t_outnum,isnull(outmoney,0) as t_outmoney,isnull(innum-outnum,0) as t_totalnum,isnull(inmoney-outmoney,0) as t_totalmoney from(select custname,sum(number) as innum,sum(money) as inmoney from s_billdetail where billtype='�ɹ����' and AddDate>='"&s_date1&"' and AddDate<='"&s_date2&"'"&s_depotname&s_username&s_goodsname&s_custname&"  group by custname) as s1 left join (select custname,sum(number) as outnum,sum(money) as outmoney from s_billdetail where billtype='�ɹ��˻�' and AddDate>='"&s_date1&"' and AddDate<='"&s_date2&"'"&s_depotname&s_username&s_goodsname&s_custname&" group by custname) as s2 on s1.custname=s2.custname"
'response.write(sql)
call showpage(sql,"R_ProviderCount",1)
endconnection
%>
</td></tr></table>
</div>
</body>
</html>
