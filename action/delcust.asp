<!-- #include file="../inc/conn.asp" -->
<!-- #include file="checkuser.asp" -->
<%
If Request.QueryString("id") = "" Then
%>
 <script language=javascript>
  alert('��ѡ��Ҫɾ����������λ��')
  window.history.go(-1)
 </script>
  <%
Else

sql = "delete from t_custom where custname='"&request.QueryString("id")&"'"
conn.Execute(sql)
endconnection
end if
%>
<script language=javascript>
window.location='../common/custom.asp'
</script>
