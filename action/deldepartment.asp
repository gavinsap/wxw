<!-- #include file="../inc/conn.asp" -->
<!-- #include file="checkuser.asp" -->
<%
If Request.QueryString("departname") = "" Then
%>
 <script language=javascript>
  alert('��ѡ��Ҫɾ���Ĳ��ţ�')
  window.history.go(-1)
 </script>
  <%
Else

sql = "delete from t_department where name='"& Request.QueryString("departname") &"'"
conn.Execute(sql)
endconnection
end if
%>
<script language=javascript>
window.location='../common/department.asp'
</script>
