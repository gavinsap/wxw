<!-- #include file="../inc/conn.asp" -->
<!-- #include file="checkuser.asp" -->
<%
Response.ContentType = "text/html"
Response.Charset = "gb2312"
if instr(Request.QueryString("billcode"),"CD") <> 0 then
	CheckAuthority("strCheckCD")
end if
if instr(Request.QueryString("billcode"),"CG") <> 0 then
	CheckAuthority("strCheckCG")
end if
if instr(Request.QueryString("billcode"),"CT") <> 0 then
	CheckAuthority("strCheckCT")
end if
if instr(Request.QueryString("billcode"),"XD") <> 0 then
	CheckAuthority("strCheckXD")
end if
if instr(Request.QueryString("billcode"),"XS") <> 0 then
	CheckAuthority("strCheckXS")
end if
if instr(Request.QueryString("billcode"),"XT") <> 0 then
	CheckAuthority("strCheckXT")
end if
if instr(Request.QueryString("billcode"),"RK") <> 0 then
	CheckAuthority("strCheckIn")
end if
if instr(Request.QueryString("billcode"),"CK") <> 0 then
	CheckAuthority("strCheckOut")
end if
if instr(Request.QueryString("billcode"),"DB") <> 0 then
	CheckAuthority("strCheckDB")
end if
if instr(Request.QueryString("billcode"),"PD") <> 0 then
	CheckAuthority("strCheckPD")
end if
if instr(Request.QueryString("billcode"),"LL") <> 0 then
	CheckAuthority("strCheckLL")
end if
if instr(Request.QueryString("billcode"),"TL") <> 0 then
	CheckAuthority("strCheckTL")
end if
on error resume next
conn.BeginTrans
s_billcode = Request.QueryString("billcode")
sqlbill = "select billcode,depotname,flag,custname,billtype,[check] from t_bill where billcode = '"& s_billcode &"'"

set rsbill = server.CreateObject("adodb.recordset")

rsbill.open sqlbill, conn, 1, 1
if rsbill("check") = True then
	Response.Write s_billcode
	Response.Write("<script>alert('�õ�������ˣ������ظ����');</script>")
	Response.Write("<script>window.close();</script>")
	Response.End()
end if
sql = "update t_bill set [check]=1,checkman='"& Request.Cookies("username") &"',checkdate='"& date() &"' where billcode = '" & s_billcode & "'"

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
	if rsbill("flag") = -1 then
		'���ʱȡ���³ɱ���
		sql = "select price,qty from t_stock where goodscode = '"& rsdetail("goodscode") &"' and depotname = '"& rsbill("depotname") &"'"
		
		set rs_stock = server.CreateObject("adodb.recordset")
		rs_stock.open sql, conn, 1, 1		
		if rsbill("flag") * rsdetail("number") < 0 then
			if cdbl(rsdetail("number")) > cdbl(rs_stock("qty")) then
				Response.Write ("<script>alert('���ʧ��:�и���������("& rsdetail("goodscode") &"ʵ�ʿ��������"&rs_stock("qty")&",��Ҫ��ĳ�������Ϊ"&rsdetail("number")&"');</script>")
				Response.Write("<script>window.close();</script>")
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
if err <> 0 then
	Response.Write("<script>alert('�õ���δ��˳ɹ�!');</script>")
	conn.rollbacktrans
else
	Response.Write("<script>alert('�õ�������ˣ�');</script>")
	conn.CommitTrans
end if
endconnection
%>
<script language=javascript>
window.opener.location.reload();
window.close();
</script>
</script>