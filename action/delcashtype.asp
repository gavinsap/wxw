<!-- #include file="../inc/conn.asp" -->
<!-- #include file="checkuser.asp" -->
<%
sql = "delete from Dict_CashType where id=" & Request("id")
conn.Execute(sql)
endconnection
%>
<script language=javascript>
alert('ɾ���ɹ���');
window.history.go(-1);
</script>
