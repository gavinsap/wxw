<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<% call CheckAuthority("strBorrowDetail") %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<title>������ϸ��</title>
</head>
<body  style="background:#FFFFFF">
<div style="background:url(../images/main-02.gif); width:100%; height:20; padding-left:0" ><img src="../images/main-01.gif"></div>
<div style="padding-left:10px">
<%
s_date1 = Year(Date()) & "-" & Month(Date()) & "-1"
s_date2 = formatdate(date)
%>
<br>
<div align="left"><span class="style1">������ϸ��</span></div>
<div align="left" style="width:100%">
<form id="form1" name="sample" method="post" action="goodsborrowdetail.asp">
  <table width="100%" border="0" id="tbl_tittle">
    <tr>
      <td width="70" height="24" align="right">�ֿ����ƣ�</td>
      <td width="150">
      <%call showdepot("depot",Request.Form("depot"))%>	   
	  </td>
      <td width="70" align="right">���ò��ţ�</td>
      <td width="150"><%call ShowCombo("t_department","name","custname",request.Form("custname"))%></td>
      <td rowspan="3"><input type="submit" onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  name="Submit" value=" �� ѯ "  class="button"/></td>
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
%></select></td>
</tr>
</table>
</form>
</div>
<hr>
<div align="left" style="width:100%">
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
    s_depotname = " and depotname in ("&s_depotpower&"'')"
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

sql = "select distinct goodscode,goodsname,billtype,adddate,custname,price,case when number is null then 0 else number*flag*-1 end as t_num,case when money is null then 0 else money*flag*-1 end as t_mon,goodsunit,username,units,billcode,depotname,memo from s_billdetail where flag<>0 and billtype like '����%' and (AddDate)<='"&s_date2&"' and (AddDate)>='"&s_date1&"'"&s_depotname&s_custname&s_goodsname&s_user&" order by adddate desc"

set rs = server.createobject("adodb.recordset")
rs.open sql,conn,1,1

sql_sys = "select * from T_SoftInfo"
	Set rs_sys = conn.Execute(sql_sys) 
    rs.pagesize = rs_sys("pagerecord")
    If request("page")<>"" Then
        epage = CInt(request("page"))
        If epage<1 Then epage = 1
        If epage>rs.pagecount Then epage = rs.pagecount
    Else
        epage = 1
    End If
    If Not rs.EOF Then rs.absolutepage = epage
%>
<form id="form2" name="exel" method="post" action="../inc/goodsborrowexcel.asp">
<input type="hidden" name="sql" value="<%=sql%>">
<table style="font-size:12px;" width="100%" id="sqd" align="center" border="1" cellpadding="2" cellspacing="0" bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#FFFFEE">
<tr align="center">
	<th width=3%></th>
	<th width=8%>��Ʒ����</th>
  <th width=8%>��Ʒ����</th>
  <th width=8%>��Ʒ���</th>
  <th width=5%>��λ</th>
  <th width=8%>���ϲ�</th>
  <th width=8%>��������</th>
  <th width=9%>���ʱ��</th>
  <th width=5%>����</th>
  <th width=8%>����</th>
  <th width=8%>���</th>
  <th width=10%>����</th>
  <th width=6%>��ע</th>
  <th width=6%>������</th>
</tr>
<%
totalnum = 0
totalmon = 0
if rs.eof=false then
For i = 0 To rs.pagesize -1
  If rs.bof Or rs.EOF Then Exit For
  totalnum = totalnum + rs("t_num")
	totalmon = totalmon + rs("t_mon")
%>
<tr align="center">
	<th><%=i+1%></th>
  <td><%=rs("goodscode")%></td>
  <td><%=rs("goodsname")%></td>
  <td><%=rs("goodsunit")%></td>
  <td><%=rs("units")%></td>
  <td><%=rs("depotname")%></td>
  <td><%=rs("custname")%></td>
  <td><%=rs("adddate")%></td>
  <td><%=rs("t_num")%></td>
  <td><%=rs("price")%></td>
  <td><%=rs("t_mon")%></td>
  <td><%=rs("billcode")%></td>
  <td><%=rs("memo")%></td>
  <td><%=rs("username")%></td>
</tr>
<%rs.movenext
next
end if
%>
<tr align="center">
<th colspan=8 >�ϼ�</th>
<th ><%=totalnum%></th>
<th ></th>
<th ><%=totalmon%></th>
<th ></th>
<th ></th>
<th ></th>
</tr>
</table>
<%
 Set mypage=new xdownpage '�������� 
 mypage.getconn=conn '�õ����ݿ����� 
 mypage.getsql=sql
 mypage.pagesize=rs_sys("pagerecord") '����ÿһҳ�ļ�¼������Ϊ5�� 
 set rs=mypage.getrs() '����Recordset 
 
 Response.Write "<table align=""center"" width='100%' border=0>"
 Response.Write "<tr>"
 Response.Write "<th colspan=6 align=""left"">"
 mypage.showpage()  '��ʾ��ҳ��Ϣ������������ԣ���set rs=mypage.getrs()�Ժ�����λ�õ��ã����Ե��ö�� 
 Response.Write "<label class=""button1""><input type=""submit"" value=""Excel""></label>"
 Response.Write "</th></tr></table>"
 Response.Write "</form>"

endconnection
%>
</form>
</div>
</body>
</html>
