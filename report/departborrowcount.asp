<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<% call CheckAuthority("strDepartBorrowCount") %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<title>�������û���</title>

</head>

<body style="background:#FFFFFF">
<div style="background:url(../images/main-02.gif); width:100%; height:20; padding-left:0" ><img src="../images/main-01.gif"></div>
<div style="padding-left:10px">
<%
s_date1 = Year(Date()) & "-" & Month(Date()) & "-1"
s_date2 = formatdate(date)
%>
<br>
<div align="left"><span class="style1">�������û��ܱ�</span></div>
<div align="left" style="width:100%">
<form id="form1" name="sample" method="post" action="departborrowcount.asp">
  <table align="left" border="0" id="tbl_tittle">
    <tr>
      <td width="70" height="24" align="right">�ֿ����ƣ�</td>
      <td width="150">
      <%call showdepot("depot",Request.Form("depot"))%>	   
	  </td>
      <td width="70" align="right">���ò��ţ�</td>
      <td width="150"><%call ShowCombo("t_department","name","custname",request.Form("custname"))%></td>
      <td rowspan="3"><input type="submit" name="Submit" value=" �� ѯ " onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  class="button"/></td>
    </tr>
    <tr>
      <td height="26" align="right">��&nbsp;��&nbsp;�ڣ�</td>
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
    Response.Write formatdate(date)
Else
    Response.Write Request("date2")
End If

%>><%showdate("date2")%></td>
    </tr>
	<tr><td align="right">��Ʒ���ƣ�</td><td><input type="text" name="goodsname" id="goodsname" size="16"></td>
	<td align="right">��&nbsp;��&nbsp;�ˣ�</td><td><select name="user" id="user">
	<option value=""></option>
    <%
sql = "select * from t_Employee"
Set a = conn.Execute(sql)
Do While a.EOF = False
    s_name = a("name")
    If Request.Form("user") = a("name") Then
        Response.Write "<option value="&s_name&" selected>"&s_name&"</option>"
    Else
        Response.Write "<option value="&s_name&">"&s_name&"</option>"
    End If
    a.movenext
Loop
close_rs(a)
%></select></td></tr></table></form></div>

<div align="left" style="width:100%; float:right; margin-left:10px;">
<hr>
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
    s_custname = " and custname='"&Request.Form("custname")&"'"
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

sql = "select s1.custname,isnull(innum,0) as innum,isnull(inmoney,0) as inmoney,isnull(outnum,0) as outnum,isnull(outmoney,0) as outmoney,isnull(innum-outnum,0) as totalnum,isnull(inmoney-outmoney,0) as totalmoney from (select custname,sum(number) as innum,sum(money) as inmoney from s_billdetail where billtype = '���ϳ��� 'and AddDate<='"&s_date2&"' and AddDate>='"&s_date1&"'"&s_depotname&s_custname&s_goodsname&s_user&" group by custname) as s1 left join (select custname,sum(number) as outnum,sum(money) as outmoney from s_billdetail where billtype = '������� 'and AddDate<='"&s_date2&"' and AddDate>='"&s_date1&"'"&s_depotname&s_custname&s_goodsname&s_user&" group by custname) as s2 on s2.custname = s1.custname"
'response.write(sql)
call showpage(sql,"R_DepartborrowCount",1)
endconnection
%>
</div>
</div>
</body>
</html>
