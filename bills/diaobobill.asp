<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<% call CheckAuthority("strAddDB") %>
<HTML><HEAD><TITLE></TITLE>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<link rel="stylesheet" href="../style.css" type="text/css">
<META http-equiv=Pragma content=no-cache>
<script language="JavaScript" src="../js/addrow.js"></script>
<script language="JavaScript" src="../js/jquery.js"></script>
<script>
function checkbill(){
var temp = "";
var temp1 = "";
$.post("checkbillcode_ajax.asp",{billcode:escape($("#billcode").val())},
function(data)
{ 
   if (data == "False"){
	   alert("���ظ����ţ����ٴε������");
		temp = $("#tittle_lable").html();
		temp1 = "000"+String(Number(temp.substring(14))+1);
	   $('#tittle_lable').html(temp.substring(0,14)+temp1.substring(temp1.length-4)); 
	   $('#billcode_input').attr("value",$('#tittle_lable').html());
	   return false;
   }
}
);		
	}
function bar(){
  if ((event.keyCode == 13) && ($("#barcode").val()!="")){
	addrow_bar();
    $.post("barcode.asp",{date:escape($("#date").val()),barcode:escape($("#barcode").val()),depot:escape($("#depot").val())},
	function(data)
	{ 
	   i=$("#rowcount").val();
	   str=data.split("|");
	   $("#goodscode"+i).val(str[0]);
	   $("#goodsname"+i).val(str[1]);
	   $("#goodsunit"+i).val(str[2]);
	   $("#units"+i).val(str[3]);
	   $("#number"+i).val("1");
	   $("#aveprice"+i).val(str[8]);
	   $("#fact_num"+i).val(str[7]);
	   $("#remark"+i).val(str[6]);
	   $("#price"+i).val(str[8]);
	}
	);
	$("#barcode").val("");
  }
}
function check(){
if ($("#depot").val() == "")
{
alert("��ѡ������֣�");
document.sample.depot.focus();
return false;
}
if (document.sample.cust.value=="")
{
alert("��ѡ�����֣�");
document.sample.cust.focus();
return false;
}
if (document.getElementById("sqd").rows.length == 1)
{
alert("����ӻ�Ʒ��");
return false;
}
for (i=1;i<=Number(document.getElementById("rowcount").value);i++){
  need_number = Number(document.getElementById("number"+i).value);
  fact_number = Number(document.getElementById("fact_num"+i).value);
  <%
  sqlFCK = "select fuchuku from t_softinfo"
  set rsFCK = Server.CreateObject("adodb.recordset")
  rsFCK.open sqlFCK,conn,1,1
  if rsFCK("fuchuku") = false then
  %>
  if (need_number>fact_number){
  alert(document.getElementById("goodsname"+i).value+"����������㣡");
  return false;
  }
  <%end if%>
}
}
function edit_row(i)
{
	window.open ('../common/selectgoods.asp?depot='+document.getElementById("depot").value+'&type=<%=request.QueryString("type")%>&adddate='+document.all.date.value+'&id='+i, 'newwindow', 'top=100,left=150,height=600, width=800,toolbar=no,menubar=no, scrollbars=yes, resizable=no,location=no, status=no')
}
function count(i){
if (i!= 0){
r_price=Number(document.getElementById("price"+i).value);
r_number=Number(document.getElementById("number"+i).value);
document.getElementById("money"+i).value=(r_price*r_number).toFixed(2);
}
document.getElementById('total_money').value=0;
document.getElementById('total_number').value=0;
  for (j=1;j<document.all.sqd.rows.length;j++)
	{	
		document.getElementById('total_money').value=(Number(document.getElementById('total_money').value)+Number(document.getElementById("money"+j).value)).toFixed(2);
		document.getElementById('total_number').value=Number(document.getElementById('total_number').value)+Number(document.getElementById("number"+j).value);
	}
}
var j=0
function add_row(){
	if ($("#depot").val() == "")
	{
	alert("��ѡ��ֿ⣡");
	document.sample.depot.focus();
	return false;
	}
	if ($("#depot").val() == "")
	{
	alert("��ѡ��ֿ⣡");
	document.sample.depot.focus();
	return false;
	}
	window.open ('../common/selectgoods.asp?depot='+document.getElementById("depot").value+'&type=<%=request.QueryString("type")%>&adddate='+document.all.date.value+'&id='+j, 'newwindow', 'top=100,left=150,height=600, width=800,toolbar=no,menubar=no, scrollbars=yes, resizable=no,location=no, status=no')
}
function del_row() {
    if(sqd.rows.length==1) return;
    var checkit = false
    for (var i=0;i<document.all.delNumber.length;i++) {
            if (document.all.delNumber[i].checked) {
            checkit=true;
            document.getElementById("goodscode"+(i+1)).value="";
           	document.getElementById("goodsname"+(i+1)).value="";
           	document.getElementById("goodsunit"+(i+1)).value="";
           	document.getElementById("units"+(i+1)).value="";
           	document.getElementById("price"+(i+1)).value="";
           	document.getElementById("number"+(i+1)).value="";
           	document.getElementById("money"+(i+1)).value="";
           	document.getElementById("remark"+(i+1)).value="";
						count(i);
            break;
            }
    }
    if (checkit) {
        for(i=1;i<sqd.rows.length;i++){
        sqd.rows[i].cells[0].innerText=i
		document.getElementById("rowcount").value=sqd.rows.length-1
        }

    } else
    {
    alert("��ѡ��һ��Ҫɾ���Ķ���");
    return false}
}
</script>
</HEAD>
<BODY>
<table align="center" border="0"><tr><td>
<form method="POST" onKeyPress="if(event.keyCode==13){return false;}" action="../action/savediaobo.asp" name="sample">
<BR><div align="center"><span class="style1">������</span></div>
<input type="hidden" id="rowcount" name="rowcount">
<BR>
<table id="tbl" style="font-size:12px" width="780" border="1" align="center" cellpadding="2" cellspacing="0" bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#FFFFEE">
  <tr>
    <td width="70" height="27" align="right">�Ƶ����ڣ�</td>
		<td width="320"><input type="text" name="date" id="date" size="16" value="<%=formatdate(date)%>"><%showdate("date")%><font color="red">*</font></td>
		<td width="70" align="right">��&nbsp;��&nbsp;�֣�</td>
		<td width="320"><%call showdepot("cust","")%><font color="red">*</font></td>
  </tr>
  <tr>
    <td align="right">��&nbsp;��&nbsp;�֣�</td>
		<td><%call showdepot("depot","")%><font color="red">*</font></td>
		<td align="right">��&nbsp;��&nbsp;�ˣ�</td>
		<td><input type="text" size="16" name="maker" readonly value="<%=request.cookies("username")%>"><font color="red">*</font></td>
  </tr>
  <tr>
    <td align="right">��&nbsp;&nbsp;&nbsp;&nbsp;ע��</td>
	<td><input onKeyDown="" type="text" name="memo" size="30"></td>
	<td align="right">��&nbsp;��&nbsp;�ˣ�</td><td><select name="user">
    <%
    sql = "select * from t_Employee"
    Set a = conn.Execute(sql)
    Do While a.EOF = False
    s_name = a("name")
    Response.Write "<option value="&s_name&">"&s_name&"</option>"
    a.movenext
    Loop
	close_rs(a)
   %></select><font color="red">*</font></td>
  </tr>
</table>
<div align="left" class="but_mar">
    <input name="add" type="button" onClick=add_row() onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  class="button" value=" �� �� ">
	<input name="del" onclick=del_row() type="button" onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  class="button" value=" ɾ �� ">
	&nbsp;&nbsp;����¼���<input name="barcode" id="barcode" size="16" onKeyUp="bar();"></div>
<table style="font-size:12px" width="780" id="sqd" align="center" border="1" cellpadding="2" cellspacing="0" bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#FFFFEE">
<tr align="center">

  <th width=3%>&nbsp;</th>
  <th width=5%>ɾ��</th>
  <th width=10%>��Ʒ����</th>
  <th width=15%>��Ʒ����</th>
  <th width=10%>��Ʒ���</th>
  <th width=7%>��λ</th>
  <th width=10%>����</th>
  <th width=10%>����</th>
  <th width=10%>���</th>
  <th width=20%>��ע</th>
</tr>
</table>
<table style="font-size:12px" width="780" id="sqd1" align="center" border="1" cellpadding="2" cellspacing="0" bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#FFFFEE">
<tr align="center">
  <th width=60%>�ϼ�</th>
  <th width=10%><input id="total_number" type="text" size="8"></th>
  <th width=10%><input id="total_money" type="text" size="8"></th>
  <th width=20%></th>
</tr>
</table>
<div align="center" class="but_mar"><input type="submit" onMouseDown="checkbill();" onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  onClick="return check();" class="button" value=" �� �� " name="B1"></div>
</form>
<%endconnection%>
</td></td></td>
</BODY>
</HTML>
