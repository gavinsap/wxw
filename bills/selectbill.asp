<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<%
if Request.QueryString("type")="CG" then
	call CheckAuthority("strSelectCG")
Else
	call CheckAuthority("strSelectXS")
end if%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<title></title>
<SCRIPT   language="javascript">
function NewBill(str){
openwin('addbill.asp?type='+str,900,600)
}
function NewBackBill(Type){
var iCount = 0;
var index = "";
var billcode = "";
$("._del").each(
	function(i)
	{
		chk = $(this)
		if(chk.attr("checked") == true){
			iCount = iCount + 1;
			billcode = chk.val();
		}
	}
);
if(iCount != 1){
	alert("�����ѡ��ѡ���ݽ����˻���");
	return false;
}
openwin('backbill.asp?type='+Type+'&planbillcode='+billcode,900,600)
}
function EditBill(str){
openwin('editbill.asp?billcode='+str,900,600);
}
function delall(){
	var iCount = 0;
	var index = 0;
	var iSucceed = 0;
	var errMsg = "";
	$("._del").each(
		function(i)
		{
			chk = $(this)
			if(chk.attr("checked") == true){
				iCount = iCount + 1;
			}
		}
	);	
	if(iCount == 0){
		alert("��ѡ��Ҫ�����ĵ��ݣ�");
		return false;
	}
	if(confirm('ȷ��Ҫɾ��ѡ���'+iCount+'��������?')){
		$("._del").each( 
			function(i)
			{
				chk = $(this)
				if(chk.attr("checked") == true){
					$.post("../select/delallbill.asp",{billcode:escape(chk.val())},
					function(data)
					{ 
						index = index + 1;
						if(data == "True"){
							iSucceed = iSucceed + 1;
						}else{
							errMsg = errMsg + data + "\n";
						}
						if(index == iCount){
							alert("�ɹ�ɾ��"+iSucceed+"�ŵ���!");
							if(iCount != iSucceed){
								alert("δ�ɹ�ɾ�����ݣ�\n" + errMsg);
							}
							window.location.reload();
						}
					}
					);
				}
			}
		)//��������
	}
}
function checkall(){
	var iCount = 0;
	var index = 0;
	var iSucceed = 0;
	var errMsg = "";
	$("._del").each(
		function(i)
		{
			chk = $(this)
			if(chk.attr("checked") == true){
				iCount = iCount + 1;
			}
		}
	);	
	if(iCount == 0){
		alert("��ѡ��Ҫ�����ĵ��ݣ�");
		return false;
	}
	if(confirm('ȷ��Ҫ��˹�'+iCount+'�ŵ�����?')){
		$("._del").each( 
			function(i)
			{
				chk = $(this);
				if(chk.attr("checked") == true){
					code = chk.val();
					$.post("../select/checkbill.asp",{billcode:escape(chk.val())},
					function(data)
					{ 
						index = index + 1;
						if(data == "True"){
							iSucceed = iSucceed + 1;
						}else{
							errMsg = errMsg + data + "\n";
						}
						if(index == iCount){
							alert("�ɹ����"+iSucceed+"�ŵ���!");
							if(iCount != iSucceed){
								alert("δ�ɹ����ݣ�\n" + errMsg);
							}
							window.location.reload();
						}
					}
					);
				}
			}
		)//��������
	}
}
function uncheckall(){
	var iCount = 0;
	var index = 0;
	var iSucceed = 0;
	var errMsg = "";
	$("._del").each(
		function(i)
		{
			chk = $(this)
			if(chk.attr("checked") == true){
				iCount = iCount + 1;
			}
		}
	);	
	if(iCount == 0){
		alert("��ѡ��Ҫ�����ĵ��ݣ�");
		return false;
	}
	if(confirm('ȷ��Ҫ����'+iCount+'�ŵ�����?')){
		$("._del").each( 
			function(i)
			{
				chk = $(this)
				if(chk.attr("checked") == true){
					$.post("../select/uncheckbill.asp",{billcode:escape(chk.val())},
					function(data)
					{
						index = index + 1;
						if(data == "True"){
							iSucceed = iSucceed + 1;
						}else{
							errMsg = errMsg + data + "\n";
						}
						if(index == iCount){
							alert("�ɹ�����"+iSucceed+"�ŵ���!");
							if(iCount != iSucceed){
								alert("δ�ɹ����ݣ�\n" + errMsg);
							}
							window.location.reload();
						}
					}
					);
				}
			}
		)//��������
	}
}
</SCRIPT>
<script language="JavaScript" src="../js/ShowHideDiv.js"></script>
</head>

<body  style=""padding:0px;margin:0px; bgcolor="#FFFFFF" "" onmousemove="movediv(event)" onmouseup="obj=0">
<div style="background:url(../images/main-02.gif); width:100%; height:20; padding-left:0" ><img src="../images/main-01.gif"></div>
<br>
<div style="padding-left:10">
<%
s_date1 = Year(Date()) & "-" & Month(Date()) & "-1"
s_date2 = formatdate(date)
%>
<%
if Request.QueryString("type")="CG" then
addbtn = "�����ɹ���ⵥ"
%>
<p align="left"><span class="STYLE1">�ɹ�����ѯ</span></p>
<%
ElseIf Request.QueryString("type") = "XS" Then
addbtn = "�������۳��ⵥ"
%>
<p align="left"><span class="STYLE1">���۵���ѯ</span></p>
<%end if%>
<table align="left"><tr><td>
<form name="form1" method="post" action="selectbill.asp?type=<%=request("type")%>">
<table border="0">
<tr>
<td align="center">�����ڣ�</td>
      <td><input type="text" name="date1" size="16"  value=<%
			If Request("date1") = "" Then
				Response.Write s_date1
			Else
				Response.Write Request("date1")
			End If%>><%showdate("date1")%></td>
      <td align="center">�����ڣ�</td>
      <td><input type="text" name="date2" size="16"  value=<%
If Request("date2") = "" Then
    Response.Write Date()
Else
    Response.Write Request("date2")
End If

%>><%showdate("date2")%></td>
<td align="center">
��Ӧ��/�ͻ���<input type="text" name="cust" id="cust" value="<%=request("cust")%>"><a href="#" onClick="JavaScript:window.open ('../common/selectcust.asp', 'newwindow', 'height=600, width=800,top=100,left=150, toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no, status=no')"><img border="0" src="../img/choose.gif" width="21" height="17"></a></td>
<td align="center" align="left" valign="top" width="120">
<input type="submit" value=" �� �� " onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  class="button">
</td>
<td width="95" valign="top" ><input type="button" value="��������" onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  class="button" onClick="show_hide_div()">
</td></tr></table>
<div id="mdiv"style="position:absolute; visibility:hidden;top:178px; left:260px;background:#E9F0F8; border:1px solid #AFB799; font-family:verdana; font-size:12px;color=#111;" >
<table width="220px" border="0" cellpadding="0" cellspacing="0" style="border:0 solid #e7e3e7;border-collapse:collapse;">
    <tr height="20" onMouseDown="finddiv(event,mdiv)" style="cursor:move;z-index:100">
        <td colspan="2" background="../img/listbar_bg.jpg" width="220px" class="bg">
            &nbsp;<font color="#FFFFFF">��������</font>
        </td>
	<tr>
		<td width="30%">&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;�ţ�</td>
		<td><input type="text" name="billcode" value="<%=request("billcode")%>" size="16"></td>
	</tr>
	<tr>
		<td>&nbsp;��Ʒ���룺</td>
		<td><input type="text" name="goodscode" value="<%=request("goodscode")%>" size="16"></td>
	</tr>
	<tr>
		<td>&nbsp;��Ʒ���ƣ�</td>
		<td><input type="text" name="goodsname" value="<%=request("goodsname")%>" size="16"></td>
	</tr>
	<tr>
		<td>&nbsp;��Ʒ���</td>
		<td><input type="text" name="goodsunit" value="<%=request("goodsunit")%>" size="16"></td>
	</tr>
	<tr>
		<td>&nbsp;���״̬��</td>
		<td><select name="check"><option value=""></option>
						<option value="1">���</option>
						<option value="0">δ���</option></select></td>
	</tr>
	<tr>
		<td colspan="2" align="left"><input type="submit" class="button" onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  value="&nbsp;��&nbsp;ѯ&nbsp;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			   <input type="button" id="_close" class="button" onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  value="&nbsp;��&nbsp;��&nbsp;" onClick="show_hide_div()"></td>
</tr>
</form>

</table>
</div>
<hr>

<table >
<tr>
<td valign="top">
	<input type="button" value="<%=addbtn%>" class="button" onClick="NewBill('<%=request.QueryString("type")%>');">
	<input type="button" class="button" value="ɾ��" onClick="delall();">
	<input type="button" class="button" value="���" onClick="checkall();">
	<input type="button" class="button" value="����" onClick="uncheckall();">
	<%if Request.QueryString("type") = "CG" then%>
		<input type="button" class="button" value="�˻�" onClick="NewBackBill('CT');">
	<%else%>
		<input type="button" class="button" value="�˻�" onClick="NewBackBill('XT');">
	<%end if%>
</td>
</tr>
<tr>
<td valign="top"  style="margin-top:10px">
<div>
<%
sql_depot = "select depotname,RDepot from t_user where username='"&request.cookies("username")&"'"
Set rs_depot = conn.Execute(sql_depot)

if rs_depot("RDepot")=false then
   sql = "select depotname from t_depot where 1=1"
   set rs=conn.execute(sql)
    Do While rs.eof=False
	  s_depotpower = s_depotpower & "'" & rs("depotname") & "',"
	  rs.movenext
     loop 
sDepotname = " and depotname in (" & s_depotpower & "'a')" 
else
	arr = split(rs_depot("depotname"),",")
	if ubound(arr) <> -1 then
	  for i = lbound(arr) to ubound(arr)-1
		s_depotpower = s_depotpower & "'" & arr(i) & "',"
	  next
	end if
	sDepotname = " and depotname in (" & s_depotpower & "'a')" 
end if

if Request.Form("cust") = "" then
  s_cust = " "
else
  s_cust = " and custname like '%"&request("cust")&"%'"
end if
if Request.Form("billcode") = "" then
	sBillcode = ""
else
	sBillcode = " and billcode = '" & Request.Form("billcode") & "'"
end if
if Request.Form("goodscode") = "" then
	sGoodscode = ""
else
	sGoodscode = " and billcode in (select billcode from t_billdetail where goodscode = '" & Request.Form("goodscode") & "')"
end if
if Request.Form("goodsname") = "" then
	sGoodsname = ""
else
	sGoodsname = " and billcode in (select billcode from t_billdetail where goodsname like '%" & Request.Form("goodsname") & "%')"
end if
if Request.Form("goodsunit") = "" then
	sGoodsunit = ""
else
	sGoodsunit = " and billcode in (select billcode from t_billdetail where goodsunit = '" & Request.Form("goodsunit") & "')"
end if
if Request.Form("check") = "" then
	s_check = ""
else
	s_check = " and [check] = " & Request.Form("check")
end if
If Request.Form("date1")<>"" Then
    s_date1 = Request.Form("date1")
End If
If Request.Form("date2")<>"" Then
    s_date2 = Request.Form("date2")
End If
if Request.QueryString("type") = "CG" then
	sql = "select top 100000 '<a href=# onClick=EditBill('''+billcode+''')>'+billcode+'</a>' as abillcode,"
	sql = sql + "billcode,adddate,custname,depotname,username,memo,zkprice,zdprice,maker,"
	sql = sql + "case when [check]=1 then '<font color=#0000FF>�����</font>' else '<font color=#FF0000>δ���</font>' end as state,checkman,"
	sql = sql + "case when billcode in (select planbillcode from t_bill where planbillcode = s.billcode) then '<font color=#0000FF>���˻�</font>' else '���˻�' end as back,"
	sql = sql + "isnull((select sum(yfprice) from t_bill where planbillcode = s.billcode),0) as backmoney,"
	sql = sql + "yfprice - isnull((select sum(yfprice) from t_bill where planbillcode = s.billcode),0) as yfmoney,"
	sql = sql + "isnull((select sum(money) from t_cash where billcode = s.billcode),0) + pay as cashmoney"
	sql = sql + " from t_bill as s where AddDate<='"&s_date2&"' and AddDate>='"&s_date1&"' and billtype = '�ɹ����'"&s_cust&s_check&sBillcode&sGoodscode&sGoodsname&sGoodsunit&sDepotname&" order by adddate desc,billcode desc"
	call showpage(sql,"selectcaigou",3)
ElseIf Request.QueryString("type") = "XS" Then
	sql = "select top 100000 '<a href=# onClick=EditBill('''+billcode+''')>'+billcode+'</a>' as abillcode,"
	sql = sql + "billcode,adddate,custname,depotname,username,memo,zkprice,zdprice,maker,"
	sql = sql + "case when [check]=1 then '<font color=#0000FF>�����</font>' else '<font color=#FF0000>δ���</font>' end as state,checkman,"
	sql = sql + "case when billcode in (select planbillcode from t_bill where planbillcode = s.billcode) then '<font color=#0000FF>���˻�</font>' else '���˻�' end as back,"
	sql = sql + "isnull((select sum(yfprice) from t_bill where planbillcode = s.billcode),0) as backmoney,"
	sql = sql + "yfprice - isnull((select sum(yfprice) from t_bill where planbillcode = s.billcode),0) as yfmoney,"
	sql = sql + "isnull((select sum(money) from t_cash where billcode = s.billcode),0) + pay as cashmoney"
	sql = sql + " from t_bill as s where AddDate<='"&s_date2&"' and AddDate>='"&s_date1&"' and billtype = '���۳���'"&s_cust&s_check&sBillcode&sGoodscode&sGoodsname&sGoodsunit&sDepotname&" order by adddate desc,billcode desc"
	call showpage(sql,"selectxiaoshou",3)
end if
%>
<div id="search_suggest" class="billdetail" style="display: none; position:absolute;"></div>
</div>
</td>
</tr>
</table>
</body>
</html>
html>
