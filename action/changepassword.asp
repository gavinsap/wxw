<!-- #include file="../inc/conn.asp" -->
<!-- #include file="checkuser.asp" -->
<%
s_username = Request.QueryString("username")
str = "select * from t_user where username='"&s_username&"' and password='"&request("oldpassword")&"'"
Set a = server.CreateObject("adodb.recordset")
a.Open str, conn, 1, 1
if a.recordcount=0 then
%>
<script language=javascript>
alert("�����벻��ȷ");
window.location='../common/changepassword.asp'
</script>
<%else
sql = "update t_user set password='"&request("newpassword1")&"' where username='"&s_username&"'"
conn.execute(sql)
end if
close_rs(a)
endconnection
%>
<script language=javascript>
alert('�޸ĳɹ���');
window.location='../common/changepassword.asp';
</script>