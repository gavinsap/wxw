<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<% call CheckAuthority("strBrowseDepartment") %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<title>��������</title>
<script language="JavaScript" src="../js/exportexcel.js"></script>
<script>
function delall(){
	var iCount = 0;
	var index = "";
	$("._del").each(
		function(i)
		{
			chk = $(this)
			if(chk.attr("checked") == true){
				iCount = iCount + 1;
			}
		}
	);
	if(confirm('ȷ��Ҫɾ��ѡ���'+iCount+'�����ŵ�������?')){
		$("._del").each( 
			function(i)
			{
				chk = $(this)
				if(chk.attr("checked") == true){
					index = chk.attr("id");
					index = index.substring(2);
					$("#tr" + index).remove();
					$.post("../select/delalldepart.asp",{departname:escape(chk.val())},
					function(data)
					{ 
					}
					);
				}
			}
		)//��������
	}
}
function edit(name){
	window.location.href='adddepartment.asp?add=false&name=' + name
}
</script>
</head>
<body style="background:#FFFFFF">
<div style="background:url(../images/main-02.gif); width:100%; height:20; padding-left:0" ><img src="../images/main-01.gif"></div>
<div style="padding-left:10px;padding-top:10px">
<div align="left"><span class="style1">��������</span></div>
<form name="ss" method="post" action="department.asp">
<table border="0">
<tr>
	<td align="left">�������ƣ�</td>
    <td><input type="text" name="departname" size="16" value="<%=request.Form("departname")%>"></td>
    <td align="right">��&nbsp;��&nbsp;�ˣ�</td>
    <td><input type="text" name="contact" size="16" value="<%=request.Form("contact")%>"> </td>&nbsp;
    <td valign="top">
	<input type="submit" class="button" onMouseOver="this.className='button_over';" onMouseOut="this.className='button';" value="��ѯ">
	<input type="button" value="����" onMouseOver="this.className='button_over';" onMouseOut="this.className='button';" onClick="window.location.href='adddepartment.asp?add=true'" class="button">
	<input type="button" value="ɾ��" onMouseOver="this.className='button_over';" onMouseOut="this.className='button';" onClick="delall();" class="button"></td>
</tr>
</table>
</form>
<table align="left">
<tr valign="top">
<td>
<%
sql = "select CONCAT('<a href=# onClick=edit(''',name,''')>',name,'</a>') as aName,t_department.* from t_department where name like '"& Request.Form("department") &"%' and contact like '"& Request.Form("contact") &"%'"
call showpage(sql,"department",1)
endconnection
 %>
</td></tr></table>
</div>
</body>
</html>
