<!-- #include file="../inc/conn.asp" -->
<%
connstr="DBQ="&Server.Mappath("../Database/JXC.mdb")&";DRIVER={Microsoft Access Driver (*.mdb)};" 
set conn1=Server.CreateObject("adodb.connection") 
conn1.Open connstr
sql = "select * from t_temp_goods  "
Set rs = Server.CreateObject("adodb.recordset")
rs.open sql, conn1, 1, 1


sql = "select * from t_goods where goodsid=0"
set rs_sql = server.createobject("adodb.recordset")
rs_sql.open sql, conn, 1, 3
Response.Write rs_sql.recordcount

s_num = rs.recordcount
for i=0 to rs.recordcount - 1
	if rs.bof or rs.eof then exit for
	rs_sql.addnew
	Response.Write i
	rs_sql("goodscode")=rs("��Ʒ����")
	rs_sql("goodsunit")=rs("��Ʒ���")
	rs_sql("goodsname")=rs("��Ʒ����")
	rs_sql("units")=rs("��λ")
	rs_sql("goodstype")=rs("��Ʒ���")
	rs_sql("inprice")=rs("����")
	rs_sql("outprice")=rs("�����")
	rs_sql("barcode")=rs("������")
	rs_sql("depotup")=rs("�������")
	rs_sql("depotdown")=rs("�������")
	rs_sql("remark")=rs("��ע")
	rs.movenext
next
Response.End()
rs_sql.update
rs_sql.close
rs.close
conn1.close : set conn1=nothing
sql = "update v_goodstype set code=treecode"
conn.execute(sql)
endconnection
response.write "<script language=javascript>alert('�ɹ�����"&s_number&"�л�Ʒ���ϣ�');</script>"
'response.Redirect "../common/importgoods.asp"
%>