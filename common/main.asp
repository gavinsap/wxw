<!-- #include file="../inc/conn.asp" -->

<HTML><HEAD><TITLE></TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />

<link rel="stylesheet" href="../mainstyle.css" type="text/css">
<link rel="stylesheet" href="../skin.css" type="text/css">

<script>
function openwin(URL,x,y){
var URL;
var x1=window.screen.width;
var y1=window.screen.height;
x2=(x1-x)/2;
y2=(y1-y)/2;
window.open(URL,'','top='+y2+',left='+x2+',width='+x+',height='+y+',status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes')
}
function edit(str){
openwin('../bills/editbill.asp?billcode='+str,900,600)
}
function checkbill(str){
openwin('../action/checkbill.asp?billcode='+str,200,200);
}
function choose(str1,str2){
openwin('../bills/addbill.asp?type='+str1+'&billcode='+str2+'&chooseplan=true',900,600);
}
function cash(str,billcode){
openwin('../cash/addcash.asp?add=true&type='+str+'&billcode='+billcode,650,400);
}
</script>
</HEAD>
<BODY style=" margin-left:0px; background:#FFFFFF" >

 
	    <table border=0 width=100% height=100% style="margin-left:0px" cellpadding=0 cellspacing=0>
		  <tr >
		    <td height=29 width="100%" background="../images/main-02.gif "><img src="../images/main-01.gif"></td>
		  </tr>
		  <tr><td valign="top">

<%
on error resume next
conn.BeginTrans

Response.Write("<div class='tip'>")
sql = "select * from t_bill where t_bill.Check = 0 order by adddate"
set rs = Server.CreateObject("adodb.recordset")
rs.open sql, conn, 1, 1
Response.Write("<div class='update1'><h3>����������</h3></div>")
Response.Write("<div class='list-left'><ul>")
if rs.recordcount > 0 then
rs.movefirst
while not rs.eof
	Response.Write("<li><span class=new2>����:" & rs("billtype") & "&nbsp;����:" & rs("billcode") & "&nbsp;<a href=# onClick=edit('"& rs("billcode") &"')>�鿴</a>&nbsp;<a href=# onClick=checkbill('"& rs("billcode") &"')>���</a></span></li>")
	rs.movenext
wend
else
	Response.Write("û��δ��˵ĵ��ݣ�")
end if
Response.Write("</ul></div>")
Response.Write("</div>")

Response.Write("<div class='tip'>")
sql = "select * from t_bill where t_bill.Check = 1 and billtype = '�ɹ�����' and billcode not in (select planbillcode from t_bill)"
set rs = Server.CreateObject("adodb.recordset")
rs.open sql, conn, 1, 1
Response.Write("<div class='update1'><h3>δʹ�õĲɹ�����</h3></div>")
Response.Write("<div class='list-left'><ul>")
if rs.recordcount > 0 then
rs.movefirst
while not rs.eof
	Response.Write("<li><span class=new2>����:" & rs("billcode") & "&nbsp;<a href=# onClick=edit('"& rs("billcode") &"')>�鿴</a>&nbsp;<a href=# onClick=choose('CG','"& rs("billcode") &"')>�ɹ�</a></span></li>")
	rs.movenext
wend
else
	Response.Write("û��δʹ�õĲɹ�������")
end if
Response.Write("</ul></div>")
Response.Write("</div>")

Response.Write("<div class='tip'>")
sql = "select * from t_bill where t_bill.Check = 1 and billtype = '���۶���' and billcode not in (select planbillcode from t_bill)"
set rs = Server.CreateObject("adodb.recordset")
rs.open sql, conn, 1, 1
Response.Write("<div class='update1'><h3>δʹ�õ����۶���</h3></div>")
Response.Write("<div class='list-left'><ul>")
if rs.recordcount > 0 then
rs.movefirst
while not rs.eof
	Response.Write("<li><span class=new2>����:" & rs("billcode") & "&nbsp;<a href=# onClick=edit('"& rs("billcode") &"')>�鿴</a>&nbsp;<a href=# onClick=choose('XS','"& rs("billcode") &"')>����</a></span></li>")
	rs.movenext
wend
else
	Response.Write("û��δʹ�õ����۶�����")
end if
Response.Write("</ul></div>")
Response.Write("</div>")

Response("<div class='tip'>")
sql = "select billcode, "
sql = sql + "yfprice - IFNULL((select sum(yfprice) from t_bill where t_bill.Check = 1 and planbillcode = bill.billcode), 0) as mon, "
sql = sql + "yfprice - IFNULL((select sum(yfprice) from t_bill where t_bill.Check = 1 and planbillcode = bill.billcode), 0) - IFNULL((select sum(money) from t_cash where billcode = bill.billcode),0) - pay as nopay "
sql = sql + "from t_bill as bill where bill.Check = 1 and billtype = '�ɹ����'"
sql = sql + " and yfprice - IFNULL((select sum(yfprice) from t_bill where t_bill.Check = 1 and planbillcode = bill.billcode), 0) - IFNULL((select sum(money) from t_cash where billcode = bill.billcode),0) - pay > 0"
set rs = Server.CreateObject("adodb.recordset")
rs.open sql, conn, 1, 1
Response.Write("<div class='update1'><h3>�ɹ��������</h3></div>")
Response.Write("<div class='list-left'><ul>")
if rs.recordcount > 0 then
rs.movefirst
while not rs.eof
	Response.Write("<li><span class=new2>����:" & rs("billcode") & "&nbsp;δ�����:" & round(rs("nopay"),2) & "&nbsp;<a href=# onClick=edit('"& rs("billcode") &"')>�鿴</a>&nbsp;<a href=# onClick=cash('FK','"& rs("billcode") &"')>����</a></span></li>")
	rs.movenext
wend
else
	Response.Write("û��δ����ĵ��ݣ�")
end if
Response.Write("</ul></div>")
Response.Write("</div>")

Response.Write("<div class='tip'>")
sql = "select billcode, "
sql = sql + "yfprice - IFNULL((select sum(yfprice) from t_bill where t_bill.Check = 1 and planbillcode = bill.billcode), 0) as mon, "
sql = sql + "yfprice - IFNULL((select sum(yfprice) from t_bill where t_bill.Check = 1 and planbillcode = bill.billcode), 0) - IFNULL((select sum(money) from t_cash where billcode = bill.billcode),0) - pay as nopay "
sql = sql + "from t_bill as bill where bill.Check = 1 and billtype = '���۳���'"
sql = sql + " and yfprice - IFNULL((select sum(yfprice) from t_bill where t_bill.Check = 1 and planbillcode = bill.billcode), 0) - IFNULL((select sum(money) from t_cash where billcode = bill.billcode),0) - pay > 0"
set rs = Server.CreateObject("adodb.recordset")
rs.open sql, conn, 1, 1
Response.Write("<div class='update1'><h3>�����տ����</h3></div>")
Response.Write("<div class='list-left'><ul>")
if rs.recordcount > 0 then
rs.movefirst
while not rs.eof
	Response.Write("<li><span class=new2>����:" & rs("billcode") & "&nbsp;δ�ս��:" & round(rs("nopay"),2) & "&nbsp;<a href=# onClick=edit('"& rs("billcode") &"')>�鿴</a>&nbsp;<a href=# onClick=cash('SK','"& rs("billcode") &"')>�տ�</a></span></li>")
	rs.movenext
wend
else
	Response.Write("û��δ�տ�ĵ��ݣ�")
end if
Response.Write("</ul></div>")
Response.Write("</div>")


if err <> 0 then
	Response.Write(err.source&":"&err.description) 
	conn.rollbacktrans
else
	conn.CommitTrans
end if
%>

</td>

</tr>
<tr>
		    <td height=1 background="../images/main-04.gif"></td>
		  </tr>
	      <tr>
		    <td height=50></td>
		  </tr>
</table>

</BODY>
</HTML>
r>
		    <td height=50></td>
		  </tr>
</table>

</BODY>
</HTML>
