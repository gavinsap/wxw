<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<% call CheckAuthority("strAllBill") %>
<html>
<head>
<script language="JavaScript" src="../js/jquery.js"></script>
<script>
function EditBill(str){
openwin('../bills/editbill.asp?billcode='+str,900,600);
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
</script>
<meta http-equiv="Content-Type" content="text/html; charset=GB2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<script language="JavaScript" src="../js/xmlHttp.js"></script>
<title>�ɹ����ܱ�</title>
</head>

<body style="background:#FFFFFF">
<div style="background:url(../images/main-02.gif); width:100%; height:20; padding-left:0" ><img src="../images/main-01.gif"></div>
<div style="padding-left:10px">
<%
s_date1 = Year(Date()) & "-" & Month(Date()) & "-1"
s_date2 = formatdate(date)
%>
<br>
<div align="left"><span class="style1">���ݲ�ѯ</span></div>
<table align="left"><tr><td>
<form id="form1" name="sample" method="post" action="allbill.asp">
  <table width="100%" border="0" id="tbl_tittle">
    <tr>
      <td width="70" height="24" align="right">�ֿ����ƣ�</td>
      <td width="150">
      <%call showdepot("depot",Request.Form("depot"))%>	  
	  </td>
      <td width="80" align="right">��Ӧ��/�ͻ���</td>
      <td width="150"><label>
      <input type="text" name="custname" id="cust" size="16" value=<%=Request.Form("custname")%> ><a href="#" onClick="JavaScript:window.open ('../common/selectcust.asp', 'newwindow', 'height=600, width=800,top=100,left=150, toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no, status=no')"><img border="0" src="../img/choose.gif" width="21" height="17"></a></label></td>
      <td rowspan="2" colspan="3"><input type="submit" onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  name="Submit" value=" �� ѯ " class="button" /></td>
    </tr>
    <tr>
      <td height="26" align="right">��&nbsp;��&nbsp;�ڣ�</td>
      <td><label>
      <input type="text" name="date1" size="16" value=<%
If Request("date1") = "" Then
    Response.Write Year(Date()) & "-" & Month(Date()) & "-1"
Else
    Response.Write Request("date1")
End If

%>><%showdate("date1")%></label></td>
      <td align="right">��&nbsp;��&nbsp;�ڣ�</td>
      <td><input type="text" name="date2" size="16" value=<%
If Request("date2") = "" Then
    Response.Write Date()
Else
    Response.Write Request("date2")
End If

%>><%showdate("date2")%></td>
    </tr>
	<tr><td align="right">��Ʒ���ƣ�</td><td><input type="text" name="goodsname" id="goodsname" size="16" value="<%=Request.Form("goodsname")%>"></td>
	<td align="right">��&nbsp;��&nbsp;�ˣ�</td><td><select name="user" id="user">
	                     <option value=""></option>
    <%
sql = "select * from t_employee"
Set a = conn.Execute(sql)
Do While a.EOF = False
    s_name = a("name")
	if Request("user") = s_name then
	Response.Write "<option value="&s_name&" selected>"&s_name&"</option>"
	else
    Response.Write "<option value="&s_name&">"&s_name&"</option>"
	end if
    a.movenext
Loop
close_rs(a)
%>
	</select></td>
	</tr>
	<tr>
	  <td align="right">���ݺ��룺</td>
	  <td><input type="text" size="16" name="billcode" value="<%=request.Form("billcode")%>"></td>
	  <td align="right">�������ͣ�</td>
	  <td><select name="billtype">
	                     <option value=""></option>
						 <%if request.Form("billtype")="�ɹ�����" then%>
	                     <option value="�ɹ�����" selected="selected">�ɹ�����</option>
						 <%else%>
						 <option value="�ɹ�����">�ɹ�����</option>
						 <%end if%>
						 
						 <%if request.Form("billtype")="�ɹ����" then%>
	                     <option value="�ɹ����" selected="selected">�ɹ����</option>
						 <%else%>
						 <option value="�ɹ����">�ɹ����</option>
						 <%end if%>
						 
						 <%if request.Form("billtype")="�ɹ��˻�" then%>
						 <option value="�ɹ��˻�" selected="selected">�ɹ��˻�</option>
						 <%else%>
						 <option value="�ɹ��˻�">�ɹ��˻�</option>
						 <%end if%>
						 
						 <%if request.Form("billtype")="���۶���" then%>
	                     <option value="���۶���" selected="selected">���۶���</option>
						 <%else%>
						 <option value="���۶���">���۶���</option>
						 <%end if%>
						 
						 <%if request.Form("billtype")="���۳���" then%>
						 <option value="���۳���" selected="selected">���۳���</option>
						 <%else%>
						 <option value="���۳���">���۳���</option>
						 <%end if%>
						 
						 <%if request.Form("billtype")="�����˻�" then%>
						 <option value="�����˻�" selected="selected">�����˻�</option>
						 <%else%>
						 <option value="�����˻�">�����˻�</option>
						 <%end if%>
						 
						 <%if request.Form("billtype")="�������" then%>
						 <option value="�������" selected="selected">�������</option>
						 <%else%>
						 <option value="�������">�������</option>
						 <%end if%>
						 
						 <%if request.Form("billtype")="��������" then%>
						 <option value="��������" selected="selected">��������</option>
						 <%else%>
						 <option value="��������">��������</option>
						 <%end if%>
						 
						 <%if request.Form("billtype")="�ֿ����" then%>
						 <option value="�ֿ����" selected="selected">�ֿ����</option>
						 <%else%>
						 <option value="�ֿ����">�ֿ����</option>
						 <%end if%>
						 
						 <%if request.Form("billtype")="�ֿ��̵�" then%>
						 <option value="����̵�" selected="selected">����̵�</option>
						 <%else%>
						 <option value="����̵�">����̵�</option>
						 <%end if%>
						 </select></td>
    </tr>
	<tr><td align="right">��Ʒ���룺</td><td><input type="text" name="goodscode" id="goodscode" size="16" value="<%=Request.Form("goodscode")%>"></td>
	<td align="right">���״̬��</td><td><select name="checked" id="checked">
	                     <option value=""></option>
						 <%
						 if Request.Form("checked") = "�����" then
						 	selected1 = "selected"
						elseif Request.Form("checked") = "δ���" then
							selected2 = "selected"
						end if
						 %>
	                     <option value="�����" <% =selected1%>>�����</option>
	                     <option value="δ���" <% =selected2%>>δ���</option>
	</select></td>
	</form>
  </table>
  <hr>
<table border="0">
<tr><td>
<input type="button" class="button" value="ɾ��" onClick="delall();">
<input type="button" class="button" value="���" onClick="checkall();">
<input type="button" class="button" value="����" onClick="uncheckall();">
</td></tr>
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
If Request.Form("date1")<>"" Then
    s_date1 = Request.Form("date1")
End If
If Request.Form("date2")<>"" Then
    s_date2 = Request.Form("date2")
End If
If Request.Form("depot") = "" Then
    s_depotname = " and (depotname in ("&s_depotpower&"'a') or custname in ("&s_depotpower&"'a'))"
Else
    s_depotname = " and (depotname='"&Request.Form("depot")&"' or custname='"&Request.Form("depot")&"')"
End If
If Request.Form("custname") = "" Then
    s_custname = ""
Else
    s_custname = " and custname='"&Request.Form("custname")&"'"
End If
If Request.Form("goodsname") = "" Then
    s_goodsname = ""
Else
    s_goodsname = " and billcode in (select billcode from t_billdetail where goodsname like '%"&Request.Form("goodsname")&"%')"
End If
if Request.Form("goodscode") = "" then
	s_goodscode = ""
else
	s_goodscode = " and billcode in (select billcode from t_billdetail where goodscode = '"& Request.Form("goodscode") &"')"
end if
If Request.Form("user") = "" Then
    s_user = ""
Else
    s_user = " and username='"&Request.Form("user")&"'"
End If
If Request.Form("billcode") = "" Then
    s_billcode = ""
Else
    s_billcode = " and billcode='"&request.Form("billcode")&"'"
End If
If Request.Form("billtype") = "" Then
    s_billtype = ""
Else
    s_billtype = " and billtype='"&request.Form("billtype")&"'"
End If
if Request.Form("checked") = "" then
	s_check = ""
elseif Request.Form("checked") = "�����" then
	s_check = " and [check] = 1"
elseif Request.Form("checked") = "δ���" then
	s_check = " and [check] = 0"
end if
sql = "select '<a href=# onClick=EditBill('''+billcode+''')>'+billcode+'</a>' as abillcode,billcode,custname,adddate,depotname,billtype,username,memo,case when [check]=1 then '<font color=#0000FF>�����</font>' else '<font color=#FF0000>δ���</font>' end as state,checkman from t_bill where (AddDate)<='"&s_date2&"' and (AddDate)>='"&s_date1&"'"&s_depotname&s_custname&s_goodsname&s_user&s_billcode&s_billtype&s_goodscode&s_check&" order by adddate desc"
'response.write(sql)
call showpage(sql,"allbill",3)
endconnection
%>
<div id="search_suggest" class="billdetail" style="display: none; position:absolute;"></div>
</td></tr></table>
</div>
</body></html>
