<!-- #include file="../inc/conn.asp" -->
<!-- #include file="checkuser.asp" -->
<%
If Request("type") = "�ɹ����" Then
	s_billtype = "�ɹ����"
elseif Request("type") = "���۳���" Then
	s_billtype = "���۳���"
elseif request("type") = "�������" then
	s_billtype = "�������"
elseif request("type") = "��������" then
	s_billtype = "��������"
End If
s_billcode = Trim(Request.Form("billcode"))
set rs = Server.CreateObject("adodb.recordset")
sql = "select * from dict_bill where name = '"& s_billtype &"'"
rs.open sql, conn, 1, 1

set rsDetail = Server.CreateObject("adodb.recordset")
sql = "select * from t_billdetail where billcode = '" & s_billcode & "'"
rsDetail.Open sql, conn, 1, 3
arrGoodscode = split(Trim(Request.Form("goodscode")), ",")
arrGoodsname = split(Trim(Request.Form("goodsname")), ",")
arrGoodsunit = split(Trim(Request.Form("goodsunit")), ",")
arrUnits     = split(Trim(Request.Form("units")), ",")
arrPrice     = split(Trim(Request.Form("price")), ",")
arrNumber    = split(Trim(Request.Form("number")), ",")
arrMoney     = split(Trim(Request.Form("money")), ",")
arrRemark    = split(Trim(Request.Form("remark")), ",")
arrAvgprice  = split(Trim(Request.Form("aveprice")), ",")
For i = LBound(arrGoodscode) To UBound(arrGoodscode)
	on error resume next
	rsDetail.addnew
	rsDetail("billcode") = s_billcode
	rsDetail("goodscode") = Trim(arrGoodscode(i))
	rsDetail("goodsname") = Trim(arrGoodsname(i))
	rsDetail("goodsunit") = Trim(arrGoodsunit(i))
	rsDetail("units") = Trim(arrUnits(i))
	rsDetail("price") = cdbl(Trim(arrPrice(i)))
	rsDetail("number") = cdbl(Trim(arrNumber(i)))
	rsDetail("money") = cdbl(Trim(arrMoney(i)))
	rsDetail("detailnote") = Trim(arrRemark(i))
	if rs("inorout") = "���" then
		rsDetail("inprice") = cdbl(Trim(arrPrice(i)))
	else
		rsDetail("inprice") = cdbl(Trim(arrAvgprice(i)))
	end if
	rsDetail.update
	Response.Write i
	Response.Write s_billcode + ","
	Response.Write Trim(arrGoodscode(i)) + ","
	Response.Write Trim(arrGoodsname(i)) + ","
	Response.Write Trim(arrGoodsunit(i)) + ","
	Response.Write Trim(arrUnits(i)) + ","
	Response.Write Trim(arrPrice(i)) + ","
	Response.Write Trim(arrNumber(i)) + ","
	Response.Write Trim(arrMoney(i)) + ","
	Response.Write Trim(arrRemark(i)) + ","
	if rs("inorout") = "���" then
		Response.Write Trim(arrPrice(i)) + "<br>"
	else
		Response.Write Trim(arrAvgprice(i)) + "<br>"
	end if	
	Response.Write err.number
	if err.number = 0 then
		response.write "<script>alert('����ɹ���');</script>"
	else
		Response.Write err.description	
		response.write "<script>alert('����ʧ�ܣ�');</script>"
	end if
Next
rsDetail.close
set rsDetail = nothing
rs.close
set rs = nothing
%>
