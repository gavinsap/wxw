<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<% call CheckAuthority("strBrowseDepot") %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<title>�ֿ����</title>

<SCRIPT language="javascript">
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
	if(confirm('ȷ��Ҫɾ��ѡ���'+iCount+'���ֿ��������?')){
		$("._del").each( 
			function(i)
			{
				chk = $(this)
				if(chk.attr("checked") == true){
					index = chk.attr("id");
					index = index.substring(2);
					$("#tr" + index).remove();
					$.post("../select/delalldepot.asp",{depotname:escape(chk.val())},
					function(data)
					{ 
					}
					);
				}
			}
		)//��������
	}
}
function edit(depotname){
	window.location='adddepot.asp?type=edit&depotname=' + depotname
}

function add(){
	window.location="adddepot.asp?type=add";
}
</SCRIPT>
</head>
<body style="background:#FFFFFF">
<div style="background:url(../images/main-02.gif); width:100%; height:20; padding-left:0" ><img src="../images/main-01.gif"></div>
<div style="padding-left:10px">
<form name="depot" method="post" action="depot.asp">
<input type="hidden" name="temp" id="temp" value="">
	<table align="center" width="620">
		<tr>
			<td align="left">�ֿ����ƣ�
			<input type="text" name="depotname" id="depotname" value="<%=Request.Form("depotname")%>">&nbsp;
			<input type="submit" name="btSearch" class="button" onMouseOver="this.className='button_over';" onMouseOut="this.className='button';" id="btSearch" value="����">		 
			<input type="button" class="button"  onMouseOver="this.className='button_over';" onMouseOut="this.className='button';" value="����" onClick="add()">
		  <input type="button" class="button"  onMouseOver="this.className='button_over';" onMouseOut="this.className='button';" value="ɾ��" onClick="delall()"></td>
		  <input type="hidden" name="depotid" id="depotid" value="">
			</td>
		</tr>
	</table>
</form>
<div align="center"><span class="style1">�ֿ����</span></div>
<br>
<table border="0" align="center" width="620px">
<tr valign="top">
<td>
<%
sql = "select '<a href=# onClick=edit('''+depotname+''')>'+depotname+'</a>' as aDepotname, * from t_depot where depotname like '"& Request.Form("depotname") &"%'"
call showpage(sql,"depotname",1)
endconnection
%>
</td></tr>
</table>
</div>
</body>
</html>
body>
</html>
