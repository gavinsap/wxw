<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>   
<!-- #include file="../inc/conn.asp" -->
<%
Response.ContentType = "text/html"
Response.Charset = "gb2312"

on error resume next
conn.BeginTrans
s_billcode = Request("billcode")
sqlbill = "select billcode,depotname,flag,custname,billtype,[check] from t_bill where billcode = '"& s_billcode &"'"
set rsbill = server.CreateObject("adodb.recordset")
rsbill.open sqlbill, conn, 1, 1
if rsbill("billtype") = "�ɹ�����" then
	power = Authority("strCheckCD")
end if
if rsbill("billtype") = "���۶���" then
	power = Authority("strCheckXD")
end if
if rsbill("billtype") = "�ɹ����" then
	power = Authority("strCheckCG")
end if
if rsbill("billtype") = "���۳���" then
	power = Authority("strCheckXS")
end if
if rsbill("billtype") = "�ɹ��˻�" then
	power = Authority("strCheckCT")
end if
if rsbill("billtype") = "�����˻�" then
	power = Authority("strCheckXT")
end if
if rsbill("billtype") = "�������" then
	power = Authority("strCheckIn")
end if
if rsbill("billtype") = "��������" then
	power = Authority("strCheckOut")
end if
if rsbill("billtype") = "�ֿ����" then
	power = Authority("strCheckDB")
end if
if rsbill("billtype") = "����̵�" then
	power = Authority("strCheckPD")
end if
if rsbill("billtype") = "��װ����" then
	power = Authority("strCheckZZ")
end if
if rsbill("billtype") = "���ϳ���" then
	power = Authority("strCheckLL")
end if
if rsbill("billtype") = "�������" then
	power = Authority("strCheckTL")
end if

if power = "False" then
	Response.Write s_billcode & ":�����Ȩ��"
	Response.End()
end if

if rsbill("check") = True then
	Response.Write s_billcode & ":�����ظ����"
	Response.End()
end if
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
	if rsbill("flag") = -1 then
		'���ʱȡ���³ɱ���
		sql = "select price,qty from t_stock where goodscode = '"& rsdetail("goodscode") &"' and depotname = '"& rsbill("depotname") &"'"
		set rs_stock = server.CreateObject("adodb.recordset")
		rs_stock.open sql, conn, 1, 1
		'�жϸ�����
		if rsbill("flag") * rsdetail("number") < 0 then
			if cdbl(rsdetail("number")) > cdbl(rs_stock("qty")) then
				Response.Write s_billcode & ":�и���������("& rsdetail("goodscode") &"ʵ�ʿ��������"&rs_stock("qty")&",��Ҫ��ĳ�������Ϊ"&rsdetail("number")&")"
				Response.End()
			end if
		end if
		if rs_stock.recordcount = 0 then
			rs_inout("inprice") = 0
			rsdetail("inprice") = 0
		else
			rs_inout("inprice") = rs_stock("price")
			rsdetail("inprice") = rs_stock("price")
		end if
		rsdetail.update
	else
		rs_inout("inprice") = rsdetail("price")
	end if
	rs_inout("depotname") = rsbill("depotname")
	rs_inout("flag") = rsbill("flag")
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
	rs_inout("flag") = -1*rsbill("flag")
	rs_inout.update
	rsdetail.movenext
wend
end if
end if
sql = "update t_bill set [check]=1,checkman='"& Request.Cookies("username") &"',checkdate='"& date() &"' where billcode = '" & s_billcode & "'"
Set rs = conn.Execute(sql)
if err <> 0 then
	Response.Write "False2"
	conn.rollbacktrans
else
	Response.Write "True"
	conn.CommitTrans
end if
Response.End()
endconnection
%>