<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<% call CheckAuthority("strBrowseEmployee") %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<title>Ա����Ϣ</title>
<script language=javascript>
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
	if(confirm('ȷ��Ҫɾ��ѡ���'+iCount+'��Ա����������?')){
		$("._del").each( 
			function(i)
			{
				chk = $(this)
				if(chk.attr("checked") == true){
					index = chk.attr("id");
					index = index.substring(2);
					$("#tr" + index).remove();
					$.post("../select/delallemployee.asp",{employeename:escape(chk.val())},
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
	window.location.href='addemployee.asp?add=false&name='+name;
}
</script>
</head>

<body style="background:#FFFFFF">
<div style="background:url(../images/main-02.gif); width:100%; height:20; padding-left:0" ><img src="../images/main-01.gif"></div>

<br>
<form name="employee" method="post" action="employee.asp">
<table style="margin-left:10px;" border="0" >
<tr>
	<td colspan="3">Ա��������
		<input type="text" name="name" size="16" value="<%=request.Form("name")%>">&nbsp;&nbsp;
		<input type="submit" class="button" onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  value="����">
		<input type="button"  class="button"  onMouseOver="this.className='button_over';" onMouseOut="this.className='button';" value="����" onClick="window.location.href='addemployee.asp?add=true'">
		<input type="button" class="button"  onMouseOver="this.className='button_over';" onMouseOut="this.className='button';" value="ɾ��" onClick="delall()">
	</td>    
</tr>
</table>
    </form>
<table style="margin-left:10px">
<tr>
<td valign="top" style="margin-left:10px" colspan="3">
<%
If Request("name") = "" Then
    sql = "select name as aName,t_employee.* from t_employee order by id"
Else
    sql = "select CONCAT('<a href=# onClick=edit(''',name,''')>',name,'</a>') as aName,t_employee.* from t_employee where name='"&request("name")&"' order by id"
End If
call showpage(sql,"employee ",1)
%>

</td></tr></table>
</body>
</html>
