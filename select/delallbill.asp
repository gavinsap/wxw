<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>   
<!-- #include file="../inc/conn.asp" -->
<%
Response.ContentType = "text/html"
Response.Charset = "gb2312"
billcode=unescape(request("billcode"))
set rsDel = Server.CreateObject("adodb.recordset")
sql = "select * from t_bill where billcode = '" & billcode & "'"
rsDel.open sql, conn, 1, 3
if rsDel("billtype") = "�ɹ�����" then
	power = Authority("strDelCD")
end if
if rsDel("billtype") = "���۶���" then
	power = Authority("strDelXD")
end if
if rsDel("billtype") = "�ɹ����" then
	power = Authority("strDelCG")
end if
if rsDel("billtype") = "���۳���" then
	power = Authority("strDelXS")
end if
if rsDel("billtype") = "�ɹ��˻�" then
	power = Authority("strDelCT")
end if
if rsDel("billtype") = "�����˻�" then
	power = Authority("strDelXT")
end if
if rsDel("billtype") = "�������" then
	power = Authority("strDelIn")
end if
if rsDel("billtype") = "��������" then
	power = Authority("strDelOut")
end if
if rsDel("billtype") = "�ֿ����" then
	power = Authority("strDelDB")
end if
if rsDel("billtype") = "����̵�" then
	power = Authority("strDelPD")
end if
if rsDel("billtype") = "��װ����" then
	power = Authority("strDelZZ")
end if
if rsDel("billtype") = "���ϳ���" then
	power = Authority("strDelLL")
end if
if rsDel("billtype") = "�������" then
	power = Authority("strDelTL")
end if
if power = "False" then
	Response.Write billcode & ":��ɾ��Ȩ��"
else
	if rsDel("check") = false then
		rsDel.delete
		rsDel.update
		Response.Write "True"
	else
		Response.Write billcode & ":����ɾ������˵���"
	end if
end if
rsDel.close
set rsDel = nothing
Response.End
'Response.Write s_account
%>