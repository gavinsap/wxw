<!-- #include file="../inc/conn.asp" -->
<!-- #include file="checkuser.asp" -->
<%
sql = "select billtype from t_bill where billcode='"&Request.QueryString("billcode")&"'"
Set rs = server.CreateObject("adodb.recordset")
rs.Open sql, conn, 1, 1
if rs("billtype") = "�ɹ�����" then
	call CheckAuthority("strDelCD")
end if
if rs("billtype") = "���۶���" then
	call CheckAuthority(str"DelXD")
end if
if rs("billtype") = "�ɹ����" then
	call CheckAuthority("strDelCG")
end if
if rs("billtype") = "���۳���" then
	call CheckAuthority("strDelXS")
end if
if rs("billtype") = "�ɹ��˻�" then
	call CheckAuthority("strDelCT")
end if
if rs("billtype") = "�����˻�" then
	call CheckAuthority("strDelXT")
end if
if rs("billtype") = "�������" then
	call CheckAuthority("strDelIn")
end if
if rs("billtype") = "��������" then
	call CheckAuthority("strDelOut")
end if
if rs("billtype") = "�ֿ����" then
	call CheckAuthority("strDelDB")
end if
if rs("billtype") = "����̵�" then
	call CheckAuthority("strDelPD")
end if
if rs("billtype") = "��װ����" then
	call CheckAuthority("strDelZZ")
end if
if rs("billtype") = "���ϳ���" then
	call CheckAuthority("strDelLL")
end if
if rs("billtype") = "�������" then
	call CheckAuthority("strDelTL")
end if

sql = "select [check] from t_bill where billcode = '" & Request.QueryString("billcode") & "'"
Set rs = conn.Execute(sql)


if rs("check") = True then
  Response.Write "<script>alert(""��˹��ĵ��ݲ���ɾ�������ȷ���!"");</script>"
  Response.Write "<script>window.history.go(-1);</script>"
  Response.End()
end if
sql = "delete from t_bill where billcode='"&Request.QueryString("billcode")&"'"
q="delete from t_cash where billcode='"&Request.QueryString("billcode")&"'"
conn.Execute(sql)
conn.execute(q)
close_rs(rs)
endconnection
%>
<script>
	window.history.go(-1);
</script>
pt>
