<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<%
if request.QueryString("type")="in" then
  call CheckAuthority("strSelectIn")
else
  call CheckAuthority("strSelectOut")
end if
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<script language="JavaScript" src="../js/xmlHttp_selectplan.js"></script>
<script>
function del(str){
if(!confirm('ȷ��Ҫɾ��'+str+'���ŵ�����?')){
  return false
  }else{
window.open('../action/delbill.asp?billcode='+str,'main');
}
}
function edit(str){
openwin('editbill.asp?billcode='+str, 900,600)
}
function checkbill(type,billcode){
window.location.href="../action/checkorder.asp?type="+type+"&billcode="+billcode
}
function uncheckbill(type,billcode){
window.location.href="../action/uncheckorder.asp?type="+type+"&billcode="+billcode
}
function NewBill(str){
openwin(str, 900,600)
}
</script>
<title>�������</title>
</head>

<body>
<br>
<%
function showdate(fieldname)
Response.Write "<input type=""image"" src=""../img/date.gif"" height=""16"" width=""18"" style=""cursor:hand"" onClick=""setDay("&fieldname&");return false;"">"
end function
s_date1 = Year(Date()) & "-" & Month(Date()) & "-1"
s_date2 = formatdate(date)
%>
<div align="left" class="STYLE1">
<%

if request.QueryString("type")="in" then
  Response.Write("������ⵥ��ѯ")
  linkbill = "inbill.asp"
else
  Response.Write("�������ⵥ��ѯ")
  linkbill = "outbill.asp"
end if
%></div>
<div style="width:100%">
<form name="form1" method="post" action="select_in.asp?type=<%=request.QueryString("type")%>">
<table align="left">
<tr>
      <td width="50">�����ڣ�</td>
      <td width="150"><input type="text" name="date1" size="16" value=<%If Request("date1") = "" Then
                                                              Response.Write Year(Date()) & "-" & Month(Date()) & "-1"
                                                            Else
                                                              Response.Write Request("date1")
                                                            End If%>><%showdate("date1")%></label></td>
      <td width="50">�����ڣ�</td>
      <td width="150"><input type="text" name="date2" size="16" value=<%If Request("date2") = "" Then
                                                              Response.Write Date()
                                                            Else
                                                              Response.Write Request("date2")
                                                            End If%>><%showdate("date2")%></td>
      <td rowspan="2"><input type="submit" value=" �� �� "  class="button"></td>
</tr>
<tr>
      <td width="50"><%if request.QueryString("type")="in" then
	                     Response.Write("��Ӧ�̣�")
					   else
					     Response.Write("��&nbsp;&nbsp;����")
					   end if%></td>
      <td colspan="3"><input type="text" name="custname" id="cust" size="45" value=<%=Request.Form("custname")%> ><a href="#SelectDate" onClick="JavaScript:window.open ('../common/selectcust.asp', 'selectcust', 'height=600, width=800,top=100,left=150, toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no, status=no')"><img border="0" src="../img/choose.gif" width="21" height="17"></a></td>
</tr>
</table>
</form>
</div>
<hr>

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
if Request.Form("custname") <> "" then
  s_cust = " and custname = '" & Request.Form("custname") & "'"
else
  s_cust = ""
end if
if Request.QueryString("type")="in" then
  s_type="�������"
else
  s_type="��������"
end if

sql_depot = "select depotname,RDepot from t_user where username='"&request.cookies("username")&"'"
Set rs_depot = conn.Execute(sql_depot)
arr = split(rs_depot("depotname"),",")
  if ubound(arr) <> -1 then
    for i = lbound(arr) to ubound(arr)-1
	  s_depotpower = s_depotpower & "'" & arr(i) & "',"
	next
  end if
		if (request.cookies("username") <> "admin") and rs_depot("RDepot") then  '��admin�û�û�п���������λ����
		  sDepotname = " and depotname in (" & s_depotpower & "'a')" 
		else
		  sDepotname = ""
		end if
sql = "select billcode,custname,depotname,memo,username,adddate,[check],sum(number) as t_num,sum(money) as t_mon,checkman from s_billdetail where billtype='"&s_type &"'"& s_date1 & s_date2 & s_cust & sDepotname &" group by billcode,custname,depotname,memo,username,adddate,[check],checkman"

    Set rs = server.CreateObject("adodb.recordset")
    rs.Open sql, conn, 3
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
    Str = "select * from t_fieldshow where show=1 and tablename='select_in' order by showid"
    Set a = server.CreateObject("adodb.recordset")
    a.Open Str, conn, 1, 1
%>
<div style="width:100%">
<input type="button" class="button" value=" �� �� " onClick="NewBill('<%=linkbill%>');">
<input type="hidden" name="temp">
<input type="hidden" name="temp1" id="temp1" onPropertyChange="change_key()">
<table id="tbl" border="0" width="850px" cellpadding="3" cellspacing="0" align="left" empty-cells:show style="word-break : break-all;">
<tr bgcolor="#FFFFFF"  style="background-color:#999999;   border-bottom:2px   solid   black;   height:25px"   align="center">
<%for k=1 to a.recordcount%>
<th bgcolor="#c5cdd1" width="<%=a("width")%>" align="center"><%=a("name")%></th>
<%
a.movenext
Next
%>
</tr>
<%
For i = 0 To rs.pagesize -1
    If rs.bof Or rs.EOF Then Exit For
%>
<tr id="tr" align="center" onMouseMove="GetDIV('block',<%=i%>,'<%=rs("billcode")%>')"  onmouseout="GetDIV('none',<%=i%>,'<%=rs("billcode")%>')" onClick="change()"\">
<td onMouseMove="addtext(<%=i+1%>)"><%=rs("billcode")%></td>
<td onMouseMove="addtext(<%=i+1%>)"><%=rs("adddate")%></td>
<td onMouseMove="addtext(<%=i+1%>)"><%=rs("custname")%></td>
<td onMouseMove="addtext(<%=i+1%>)"><%=rs("username")%></td>
<td>
	<a href=# onClick="edit('<%=rs("billcode")%>');">�޸�</a>
    <a href=# onClick="del('<%=rs("billcode")%>');">ɾ��</a></td>
<%
response.Write "</tr>"
rs.movenext()
Next
%>
</table>
</div>
<%
 Set mypage=new xdownpage '�������� 
 mypage.getconn=conn '�õ����ݿ����� 
 mypage.getsql=sql
 mypage.pagesize=rs_sys("pagerecord") '����ÿһҳ�ļ�¼������Ϊ5�� 
 set rs=mypage.getrs() '����Recordset 
 
 Response.Write "<table align=""left"" width='850px' border=0>"
 Response.Write "<tr>"
 Response.Write "<th colspan=6 align=""left"">"
 mypage.showpage()  '��ʾ��ҳ��Ϣ������������ԣ���set rs=mypage.getrs()�Ժ�����λ�õ��ã����Ե��ö�� 
 'Response.Write "<label class=""button1""><input type=""submit"" value=""Excel""></label>"
 Response.Write "</th></tr></table>"
 Response.Write "</form>"
 close_rs(rs_depot)
 close_rs(rs)
 close_rs(rs_sys)
 close_rs(a)
 endconnection
%>
<div id="search_suggest" class="billdetail" style="display: none; position:absolute;"></div>
</body>
</html>
v>
</body>
</html>
