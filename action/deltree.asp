<!-- #include file="../inc/conn.asp" -->
<!-- #include file="checkuser.asp" -->
<%
Dim s_id
s_id = request("pid")
If  s_id ="" then
%>
<script language=javascript>
	alert('�ýڵ��Ǹ��ڵ㣬����ɾ����')
	window.history.go(-1)
</script>
<%
Else
Str = "select count(*) as nodecount from t_tree where pid="&s_id
Set a = server.CreateObject("adodb.recordset")

a.Open Str, conn, 1, 1
If Cint(a("nodecount"))>0 Then
%>
<script language=javascript>
	alert('�ýڵ����ӽڵ㣬����ɾ����')
	window.history.go(-1)
</script>
<%
Else
    sql = "delete from t_tree where id="&s_id
    conn.Execute(sql)
End If
close_rs(a)
endconnection
End If
%>
<script language=javascript>
  window.location='../common/edittree.asp?type=<%=Request.QueryString("type")%>'
</script>
