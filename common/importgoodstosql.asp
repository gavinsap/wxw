<!-- #include file="../inc/conn.asp" -->
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<html>
<head>
<title>Excel��Ʒ����</title>
</head>
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<body>
<script language="javascript">
function savegoodstosql(){
	var obj = document.getElementById("import"); 
	obj.action="../action/savegoodstosql.asp";
	obj.submit();
}
</script>
</form>
<div align="center"><span class="STYLE1">Excel��Ʒ����</span></div>
<hr>
<form id="import" name="import" action="" method="post">
<div id="inner-table-hpzl">
<table>
<tr>
	<th width="80px" align="center">��Ʒ���</th>
	<th width="80px" align="center">��Ʒ����</th>
	<th width="80px" align="center">��Ʒ����</th>
	<th width="80px" align="center">��Ʒ���</th>
	<th width="80px" align="center">��λ</th>
	<th width="80px" align="center">�����</th>
	<th width="80px" align="center">����</th>	
	<th width="80px" align="center">�������</th>	
	<th width="80px" align="center">�������</th>	
	<th width="80px" align="center">������</th>
	<th width="80px" align="center">��ע</th>	
</tr>
<%
connstr="DBQ="&Server.Mappath("../Database/JXC.mdb")&";DRIVER={Microsoft Access Driver (*.mdb)};" 
set conn1=Server.CreateObject("adodb.connection") 
conn1.Open connstr
sql = "select * from t_temp_goods"
Set rs = Server.CreateObject("adodb.recordset")
rs.open sql, conn1, 1, 1
response.write "<tr>"
for i=1 to 11
	response.write "<td align=center>"
	response.write "<select name=field_"&i&" >"
	response.write "<option value=></option>"
	for j=0 to rs.fields.count - 1
		response.write "<option value="&rs.fields(j).name&" >"&rs.fields(j).name&"</option>"
	next
	response.write "</select></td>"
next
response.write "</tr>"
%>
</table>
</div>
<hr>
<div id="inner-table-bill1">
<table>
	<tr>
		<th align="center" width="35px">���</th>
		<%
			for m=0 to rs.fields.count - 1
				response.write "<th width=90px>"&rs.fields(m).name&"</th>"
			next
		%>
	</tr>
	<%rs.movefirst
		for i=0 to rs.recordcount-1
			if rs.bof or rs.eof then exit for
	%>
	<tr>
		<td align="center"><%=i+1%></td>
			<%for j=0 to rs.fields.count -1
					response.write "<td>"&rs(rs.fields(j).name)&"</td>"
				next
			%>
	</tr>
	<%	rs.movenext
		next
		%>
</table>
</div>
<hr>
<input type="button" name="sub1" class="button" value="��ʼ����" onClick="savegoodstosql()">
</form>
</body>
</html>