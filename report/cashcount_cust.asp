<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<%
if Request.QueryString("type") = "fk" then
call CheckAuthority("strCustFKCount")
end if
if Request.QueryString("type") = "sk" then
call CheckAuthority("strCustSKCount")
end if
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<title></title>
</head>

<body style="background:#FFFFFF">
<%
s_date1 = Year(Date()) & "-" & Month(Date()) & "-1"
s_date2 = formatdate(date)
%>
<div style="padding-left:10px">
<br>
<%if Request.QueryString("type") = "FK" then%>
<br><div align="left"><span class="STYLE1">Ӧ���˿��-������λ</span></div><br>
<%else%>
<br><div align="left"><span class="STYLE1">Ӧ���˿��-������λ</span></div><br>
<%end if%>
<form id="form1" name="sample" method="post" action="cashcount_cust.asp?type=<%=request.QueryString("type")%>">
<table border="0">
<tr>
<td align="center">�����ڣ�</td>
      <td><input type="text" name="date1" size="16"  value=<%
			If Request("date1") = "" Then
				Response.Write s_date1
			Else
				Response.Write Request("date1")
			End If%>><%showdate("date1")%></td>
      <td align="center">�����ڣ�</td>
      <td><input type="text" name="date2" size="16"  value=<%
If Request("date2") = "" Then
    Response.Write Date()
Else
    Response.Write Request("date2")
End If

%>><%showdate("date2")%></td>
<td align="center">
������λ��<input type="text" name="cust" value="<%=request.Form("cust")%>"></td>
<td align="center" align="left" valign="top" width="120">
<input type="submit" value=" �� �� " onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  class="button">
</td>
</tr></table>
<hr>
<%
if Request.QueryString("type") = "FK" then
	sql = "select cust.custname, startmoneyf + isnull(beginamt,0) - isnull(begincash1,0) - isnull(begincash2,0) as beginyf, isnull(nowamt,0) as nowamt, isnull(nowcash1,0) + isnull(nowcash2,0) as nowcash, startmoneyf + isnull(beginamt,0) - isnull(begincash1,0) - isnull(begincash2,0) + isnull(nowamt,0) - isnull(nowcash1,0) - isnull(nowcash2,0) as endyf from ("
	sql = sql + "(select startmoneyf,custname from t_custom where custname like '%"& Request.Form("cust") &"%') as cust "
	sql = sql + "left join (select custname, sum(yfprice * flag) as beginamt from t_bill where [check] = 1 and billtype like '�ɹ�%' and adddate < '"&s_date1&"' group by custname) as b1 on b1.custname = cust.custname "
	sql = sql + "left join (select custname, sum(money) as begincash1 from t_cash where cashtype = '����' and adddate < '"&s_date1&"' group by custname) as b2 on b2.custname = cust.custname "
	sql = sql + "left join (select custname, sum(pay * flag) as begincash2 from t_bill where [check] = 1 and billtype like '�ɹ�%' and adddate < '"&s_date1&"' group by custname) as b3 on b3.custname = cust.custname "
	sql = sql + "left join (select custname, sum(yfprice * flag) as nowamt from t_bill where [check] = 1 and billtype like '�ɹ�%' and adddate between '"&s_date1&"' and '"&s_date2&"' group by custname) as n1 on n1.custname = cust.custname "
	sql = sql + "left join (select custname, sum(money) as nowcash1 from t_cash where cashtype = '����' and adddate between '"&s_date1&"' and '"&s_date2&"' group by custname) as n2 on n2.custname = cust.custname "
	sql = sql + "left join (select custname, sum(pay * flag) as nowcash2 from t_bill where [check] = 1 and billtype like '�ɹ�%' and adddate between '"&s_date1&"' and '"&s_date2&"' group by custname) as n3 on n3.custname = cust.custname)"
	call showpage(sql,"r_fkcountcust",1)
else
	sql = "select cust.custname, startmoneys + isnull(beginamt,0) - isnull(begincash1,0) - isnull(begincash2,0) as beginys, isnull(nowamt,0) as nowamt, isnull(nowcash1,0) + isnull(nowcash2,0) as nowcash, startmoneys + isnull(beginamt,0) - isnull(begincash1,0) - isnull(begincash2,0) + isnull(nowamt,0) - isnull(nowcash1,0) - isnull(nowcash2,0) as endys from ("
	sql = sql + "(select startmoneys,custname from t_custom where custname like '%"& Request.Form("cust") &"%') as cust "
	sql = sql + "left join (select custname, sum(yfprice * flag * -1) as beginamt from t_bill where [check] = 1 and billtype like '����%' and adddate < '"&s_date1&"' group by custname) as b1 on b1.custname = cust.custname "
	sql = sql + "left join (select custname, sum(money) as begincash1 from t_cash where cashtype = '�տ�' and adddate < '"&s_date1&"' group by custname) as b2 on b2.custname = cust.custname "
	sql = sql + "left join (select custname, sum(pay * flag * -1) as begincash2 from t_bill where [check] = 1 and billtype like '����%' and adddate < '"&s_date1&"' group by custname) as b3 on b3.custname = cust.custname "
	sql = sql + "left join (select custname, sum(yfprice * flag * -1) as nowamt from t_bill where [check] = 1 and billtype like '����%' and adddate between '"&s_date1&"' and '"&s_date2&"' group by custname) as n1 on n1.custname = cust.custname "
	sql = sql + "left join (select custname, sum(money) as nowcash1 from t_cash where cashtype = '�տ�' and adddate between '"&s_date1&"' and '"&s_date2&"' group by custname) as n2 on n2.custname = cust.custname "
	sql = sql + "left join (select custname, sum(pay * flag * -1) as nowcash2 from t_bill where [check] = 1 and billtype like '����%' and adddate between '"&s_date1&"' and '"&s_date2&"' group by custname) as n3 on n3.custname = cust.custname)"
	call showpage(sql,"r_skcountcust",1)
end if
endconnection
%>
</div>
</body>
</html>
