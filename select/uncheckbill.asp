<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>   
<!-- #include file="../inc/conn.asp" -->
<%
Response.ContentType = "text/html"
Response.Charset = "gb2312"
s_billcode = Request("billcode")
'�����ص���
sqlcheck = "select count(billcode) as c from t_bill where planbillcode = '"& s_billcode &"'"
set rscheck = Server.CreateObject("adodb.recordset")
rscheck.open sqlcheck, conn, 1, 1
if CInt(rscheck("c")) > 0 then
	Response.Write s_billcode & ":������ص���"
	Response.End()
end if
rscheck.close()
set rscheck = nothing
'����ո����¼
sqlcheck = "select count(billcode) as c from t_cash where billcode = '"& s_billcode &"'"
set rscheck = Server.CreateObject("adodb.recordset")
rscheck.open sqlcheck, conn, 1, 1
if CInt(rscheck("c")) > 0 then
	Response.Write s_billcode & ":���ո����¼"
	Response.End()
end if
rscheck.close()
set rscheck = nothing
sqlbill = "select billcode,depotname,flag,custname,billtype,[check] from t_bill where billcode = '"& s_billcode &"'"
set rsbill = server.CreateObject("adodb.recordset")
rsbill.open sqlbill, conn, 1, 1
if rsbill("billtype") = "�ɹ�����" then
	power = Authority("strUnCheckCD")
end if
if rsbill("billtype") = "���۶���" then
	power = Authority("strUnCheckXD")
end if
if rsbill("billtype") = "�ɹ����" then
	power = Authority("strUnCheckCG")
end if
if rsbill("billtype") = "���۳���" then
	power = Authority("strUnCheckXS")
end if
if rsbill("billtype") = "�ɹ��˻�" then
	power = Authority("strUnCheckCT")
end if
if rsbill("billtype") = "�����˻�" then
	power = Authority("strUnCheckXT")
end if
if rsbill("billtype") = "�������" then
	power = Authority("strUnCheckIn")
end if
if rsbill("billtype") = "��������" then
	power = Authority("strUnCheckOut")
end if
if rsbill("billtype") = "�ֿ����" then
	power = Authority("strUnCheckDB")
end if
if rsbill("billtype") = "����̵�" then
	power = Authority("strUnCheckPD")
end if
if rsbill("billtype") = "��װ����" then
	power = Authority("strUnCheckZZ")
end if
if rsbill("billtype") = "���ϳ���" then
	power = Authority("strUnCheckLL")
end if
if rsbill("billtype") = "�������" then
	power = Authority("strUnCheckTL")
end if
if power = "False" then
	Response.Write s_billcode & ":�޷���Ȩ��"
	Response.End()
end if
if rsbill("check") = False then
	Response.Write s_billcode & ":�����ظ�����"
	Response.End()
end if
on error resume next
conn.BeginTrans
sql = "update t_bill set [check]=0,checkman='' where billcode = '" & s_billcode & "'"
Set rs = conn.Execute(sql)
if rsbill("flag") <> 0 then
sqldetail = "select goodscode,number,price,inprice from t_billdetail where billcode = '"& s_billcode &"'"
Set rsdetail = server.CreateObject("adodb.recordset")
rsdetail.Open sqldetail, conn, 1,3
rsdetail.movefirst
sql = "select * from t_inout where id < 0"
Set rs_inout = server.CreateObject("adodb.recordset")
rs_inout.Open sql, conn, 1, 3
while not rsdetail.eof
	rs_inout.addnew
	rs_inout("billcode") = rsbill("billcode")
	rs_inout("goodscode") = rsdetail("goodscode")
	rs_inout("qty") = rsdetail("number")
	rs_inout("price") = rsdetail("price")
	rs_inout("inprice") = rsdetail("inprice")
	rs_inout("depotname") = rsbill("depotname")
	rs_inout("flag") = -1 * rsbill("flag")
	rs_inout.update
	rsdetail.movenext
wend

rsdetail.movefirst
if rsbill("BillType") = "�ֿ����" then
while not rsdetail.eof
	rs_inout.addnew
	rs_inout("billcode") = rsbill("billcode")
	rs_inout("goodscode") = rsdetail("goodscode")
	rs_inout("qty") = rsdetail("number")
	rs_inout("price") = rsdetail("price")
	rs_inout("inprice") = rsdetail("inprice")
	rs_inout("depotname") = rsbill("custname")
	rs_inout("flag") = rsbill("flag")
	rs_inout.update
	rsdetail.movenext
wend
end if
end if
if err <> 0 then
	conn.rollbacktrans
	Response.Write "False4"
else
	conn.CommitTrans
	Response.Write "True"
end if
Response.End()
endconnection
%>