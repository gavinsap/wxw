<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<%
on error resume next
conn.BeginTrans
sBillCode = Request.QueryString("billcode")
sql = "delete from t_price where billcode = '"& sBillCode &"'"
conn.Execute(sql)
if err <> 0 then
	Response.Write("<script>alert('ɾ������ʱ���ִ���!');</script>")
	conn.rollbacktrans
else
	Response.Write("<script>alert('ɾ���ɹ���');</script>")
	conn.CommitTrans
end if
endconnection
%>
<script>
window.opener.location.reload();
window.close();
</script>