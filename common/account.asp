<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<% call CheckAuthority("strBrowseAccount") %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<title>�ʻ���Ϣ</title>
<script>

function edit(i){
window.open ('add_account.asp?add=false&id='+i, 'add_account', 'height=400, width=600,top=100,left=150,toolbar=no,menubar=no, scrollbars=yes, resizable=no,location=no, status=no');
}
function check_add(){
if (document.getElementById("account").value == "")
{
alert("����д�ʻ���Ϣ��");
return false;
}
}

function add(){
window.open ('add_account.asp?add=true', 'add_account', 'height=400, width=600,top=100,left=150,toolbar=no,menubar=no, scrollbars=yes, resizable=no,location=no, status=no');
}
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
	if(confirm('ȷ��Ҫɾ��ѡ���'+iCount+'���˻���������?')){
		$("._del").each( 
			function(i)
			{
				chk = $(this)
				if(chk.attr("checked") == true){
					index = chk.attr("id");
					index = index.substring(2);
					$("#tr" + index).remove();
					$.post("../select/delallaccount.asp",{id:escape(chk.val())},
					function(data)
					{ 
					}
					);
				}
			}
		)//��������
	}
}
</script>
</head>

<body style="background:#FFFFFF">
<div style="background:url(../images/main-02.gif); width:100%; height:20; padding-left:0" ><img src="../images/main-01.gif"></div>
<div style="padding-left:10px">
<br>
<div align="center" class="STYLE1">�ʻ���Ϣ</div>
<form name="form1" action="account.asp" method="post">
<table width="760" border="0" align="center">
<tr>
  <input type="hidden" name="id" id="id">
  <td width="157" align="right">�ʻ�����:</td>
  <td width="124" align="left"><input type="text" name="account" id="account" size="16" value="<%=request.Form("account")%>"></td>
  <td valign="top">
  <input type="submit" value="��ѯ"  onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"class="button">
  <input type="button" value="����"  onMouseOver="this.className='button_over';" onMouseOut="this.className='button';" class="button" onClick="add()">
  <input type="button" value="ɾ��"  onMouseOver="this.className='button_over';" onMouseOut="this.className='button';" class="button" onClick="delall()">
  </td>
</tr>
</table>
</form>
<%
  if Request.Form("account") <> "" then
	  s_account = " and account = '" & Request.Form("account") & "'"
	else
	  s_account = ""
	end if 
sqlstr = "select CONCAT('<a href=# onClick=edit(''',id,''');>',account,'</a>') as aAccount,t_account.* from t_account where 1=1 " & s_account
call showpage(sqlstr,"account",1)
%>
</table>
</div>
</div>
</body>
</html>
