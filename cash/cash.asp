<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<%
if Request.QueryString("type") = "fk" then
  call CheckAuthority("strBrowseFK")
else
  call CheckAuthority("strBrowseSK")
end if
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<title>�ո��</title>
<%
If Request("type") = "FK" Then
    cashtype = "����"
	title="���"
Else
    cashtype = "�տ�"
	title="�տ"
End If
%>
<SCRIPT   language="javascript">
function del(str,str1){
if(!confirm('ȷ��Ҫɾ�����ŵ�����?')){
return false
}else{
window.location.href='../action/delcash.asp?cashcode='+str1+'&type='+str
}
}
function add(str){
window.location.href='addcash.asp?add=true&type='+str
}
function edit(str,str1){
window.open ('addcash.asp?add=false&type='+str+'&cashcode='+str1	, 'cashbill', 'height=400, width=800,top=100,left=150,toolbar=no,menubar=no, scrollbars=yes, resizable=no,location=no, status=no');
}
function showbill(str){
window.location.href='../bills/editbill.asp?billcode='+str
}
function detail(str,str1){
window.open ('cashdetail.asp?type='+str+'&id='+str1		, 'cashbill', 'height=400, width=800,top=100,left=150,toolbar=no,menubar=no, scrollbars=yes, resizable=no,location=no, status=no');
}
function NewBill(str){
window.open ('addcash.asp?add=true&type='+str, 'cashbill', 'height=400, width=650,top=100,left=150,toolbar=no,menubar=no, scrollbars=yes, resizable=no,location=no, status=no');
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
					$.post("../select/delallcash.asp",{cashcode:escape(chk.val())},
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
</script>
<script language="JavaScript" src="../js/ShowHideDiv.js"></script>
</head>

<body style=""padding:0px;margin:0px; bgcolor="#FFFFFF""" onmousemove="movediv(event)" onmouseup="obj=0">
<div style="background:url(../images/main-02.gif); width:100%; height:20; padding-left:0" ><img src="../images/main-01.gif"></div>
<div style="padding-left:10">
<br>
<%
sDate1 = Year(Date()) & "-" & Month(Date()) & "-1"
sDate2 = Date()
%>
<div align="left"><span class="STYLE1">
<%
If Request("type") = "FK" Then
    Response.Write "�����ѯ"
Else
    Response.Write "�տ��ѯ"
End If
%></span></div>
<table align="left">
<tr><td>
<form name="form1" method="post" action="cash.asp?type=<%=Request("type")%>">
<table border="0">
<tr>
    <td align="right">��&nbsp;��&nbsp;�ڣ�</td>
    <td><input type="text" name="date1" size="16" value=<%
    If Request("date1") = "" Then
        Response.Write Year(Date()) & "-" & Month(Date()) & "-1"
    Else
        Response.Write Request("date1")
    End If%>><%showdate("date1")%></td>
    <td align="right">��&nbsp;��&nbsp;�ڣ�</td>
    <td><input type="text" name="date2" size="16" value=<%
    If Request("date2") = "" Then
        Response.Write Date()
    Else
        Response.Write Request("date2")
    End If%>><%showdate("date2")%></td> 
  <td  width="80" ><input class="button" type="submit" onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  value="&nbsp;��&nbsp;&nbsp;��&nbsp;">
  </td>
  <td width="80">
    <input type="button" value="��������" onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  class="button" onClick="show_hide_div()">
                 </td>
</tr>
<tr>
  <td align="right">����ţ�</td>
  <td><input type="text" name="cashcode" value="<%=request.Form("cashcode")%>" size="16"></td>
  <td align="right">������λ��</td>
  <td><input type="text" name="custname" value="<%=request.Form("custname")%>" size="16"></td>
</tr>
</table>
<div id="mdiv"style="position:absolute; visibility:hidden;top:178px; left:260px;background:#E9F0F8; border:1px solid #AFB799; font-family:verdana; font-size:12px;color=#111;" >
<table width="220px" border="0" cellpadding="0" cellspacing="0" style="border:0 solid #e7e3e7;border-collapse:collapse;">
    <tr height="20" onMouseDown="finddiv(event,mdiv)" style="cursor:move;z-index:100">
        <td colspan="2" background="../img/listbar_bg.jpg" width="220px" class="bg">
            &nbsp;<font color="#FFFFFF">��������</font>
        </td>
	<tr>
		<td width="30%">&nbsp;����ⵥ��</td>
		<td><input type="text" name="billcode" value="<%=request("billcode")%>" size="16"></td>
	</tr>
	<tr>
		<td>&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;����</td>
		<td><input type="text" name="account" value="<%=request("account")%>" size="16"></td>
	</tr>
	<tr>
		<td>&nbsp;��&nbsp;��&nbsp;�ˣ�</td>
		<td><input type="text" name="user" value="<%=request("user")%>" size="16"></td>
	</tr>
	<tr>
		<td>&nbsp;��&nbsp;��&nbsp;�ˣ�</td>
		<td><input type="text" name="username" value="<%=request("username")%>" size="16"></td>
	</tr>
	<tr>
		<td colspan="2" align="center">
		<input type="submit" class="button" value="&nbsp;��&nbsp;ѯ&nbsp;">
		<input type="button" id="_close" class="button" value="&nbsp;��&nbsp;��&nbsp;" onClick="show_hide_div()">
</tr>
</table>
</div>
<hr>
<table>
<tr><td valign="top">
	<input type="button" value="����<%=title%>" class="button" onClick="NewBill('<%=Request("type")%>','')">
	
	<input type="button" class="button" value="ɾ��" onClick="delall();">
</td></tr>
</form>


<%
if Request.Form("date1") <> "" then
	sDate1 = Request.Form("date1")
end if

if Request.Form("date2") <> "" then
	sDate2 = Request.Form("date2")
end if

if Request.Form("cashcode") = "" then
	sCashcode = ""
else
	sCashcode = " and cashcode = '" & Request.Form("cashcode") & "'"
end if

sql_cust = "select custname from t_user where username='"&request.cookies("username")&"'"
Set rs_cust = conn.Execute(sql_cust)
arr = split(rs_cust("custname"),",")
temp_cust = ""
if ubound(arr) <> -1 then
  for i = lbound(arr) to ubound(arr)-1
    temp_cust = temp_cust & "'" & arr(i) & "',"
  next
end if
if Request.Form("custname") = "" then
	sCustname = " "
else
	sCustname = " and custname like '%" & Request.Form("custname") & "%'"
end if

if Request.Form("billcode") = "" then
	sBillcode = ""
else
	sBillcode = " and billcode = '" & Request.Form("billcode") & "'"
end if

if Request.Form("account") = "" then
	sAccount = ""
else
	sAccount = " and account = '" & Request.Form("account") & "'"
end if

if Request.Form("user") = "" then
	sUser = ""
else
	sUser = " and [user] = '" & Request.Form("user") & "'"
end if

if Request.Form("username") = "" then
	sUsername = ""
else
	sUsername = " and username = '" & Request.Form("username") & "'"
end if


sql = "select '<a href=# onClick=edit(''"&Request.QueryString("type")&"'','''+cashcode+''')>'+cashcode+'</a>' as aCashCode,cashcode,"
sql = sql & "adddate,custname,billcode,username,money,[user] from t_cash where AddDate<='"&sDate2&"' and AddDate>='"&sDate1&"' and cashtype='"&cashtype&"'"&sCashcode&sCustname&sBillcode&sAccount&sUser&sUsername
call showpage(sql,"showcash",1)
%>
</td></tr></table>
</div>
</body>
</html>
tml>
