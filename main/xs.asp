<!-- #include file="../inc/conn.asp" -->
<%
sql = "select * from t_user where username = '"& request.cookies("username") &"'"
set rs = Server.CreateObject("adodb.recordset")
rs.open sql, conn, 1, 1
strPower = rs("authority")
'response.write strPower
strBrowseSK = instr(strPower,"BrowseSK")
strAddXD = instr(strPower,"AddXD")
strSelectXD = instr(strPower,"SelectXD")
strAddXS = instr(strPower,"AddXS")
strSelectXS = instr(strPower,"SelectXS")
strAddXT = instr(strPower,"AddXT")
strGoodsSaleDetail = instr(strPower,"GoodsSaleDetail")
strGoodsSaleCount = instr(strPower,"GoodsSaleCount")
strCustSaleCount = instr(strPower,"CustSaleCount")
strXSFinish = instr(strPower,"XSFinish")
strxslist = instr(strPower,"xslist")
intXS = cint(strAddXD) + cint(strSelectXD) + cint(strAddXS) + cint(strSelectXS) + cint(strAddXT) + cint(strGoodsSaleDetail) + cint(strGoodsSaleCount) + cint(strCustSaleCount) + cint(strXSFinish) + cint(strxslist)
%>

<html>
<head>
<title>���̽������������˰�</title>
<%mypath="../"%>
<meta http-equiv='Content-Type' content='text/html; charset=Gb2312;'>
<link rel="stylesheet" href="../skin.css"  type="text/css">

<style>
body {background: #ffffff;	color: #444;}
a{	color: #09d;	text-decoration: none;	border: 0;	background-color: transparent;}
body,div,q,iframe,form,h5{	margin: 0;	padding: 0;}
img,fieldset { border: none 0; }
body,td,textarea {	word-break: break-all;	word-wrap: break-word;	line-height:1.5;}
body,input,textarea,select,button {	margin: 0;	font-size: 12px;	font-family: Tahoma, SimSun, sans-serif;}
div,p,table,th,td {	font-size:1em;	font-family:inherit;	line-height:inherit;}
h5{ font-size:12px;}
</style>
<script type="text/javascript" src="../js/Dialog.js"></script>
<script>
function zOpen(url,name,x,y){
	var diag = new Dialog("Diag2");
	diag.Width = x;
	diag.Height = y;
	diag.Title = name;
	diag.URL = url;
	diag.OKEvent = zAlert;//���ȷ������õķ���
	diag.show();
}
function zAlert(){
	
}

</script>

</head>
<body topmargin=0 leftmargin=0 style="background:#FFFFFF">

 
<table border=0 width=100% height=100% cellpadding=0 cellspacing=0>
  <tr>
	
	<td valign=top align="left">
 
	    <table border=0 width=100% height=100% cellpadding=0 cellspacing=0>
		  <tr>
		    <td height=29 background="../images/main-02.gif"><img src="../images/main-01.gif"></td>
		  </tr>
	      <tr>
		    <td>
 
			  <table border=0 width=100% height=100% cellpadding=0 cellspacing=0 align=center>
			    <tr>
				  <td>
				  
					<table border=0 width=100% cellpadding=0 cellspacing=0 align=center>
					  <tr>
						<td>
 
						  <table border=0 width=100% align=center>
							<tr height=80>
						<%if strSelectXD > 0 then%>
					 <td align=center><a href="#" onclick=window.parent.main.location.href='../Bills/selectplan.asp?type=XD'
					 ><img src="../images/sell_front.gif" border=0><BR>���۶���</a></td>   
					 
					<td align=center width=50><img src="../images/base_right.gif" border=0></td>
					<%end if%>
					<%if strSelectXS > 0 then%>
							  <td align=center><a href="#" onclick=window.parent.main.location.href='../Bills/selectbill.asp?type=XS'><img src="../images/sell_comeS.gif" border=0><BR>���۳���</a></td>
							  <td align=center width=50><img src="../images/base_right.gif" border=0></td>
					<%end if%>
					
					<%if strBrowseSK > 0 then%>	 		  
					<td align=center><a href="#" onclick=window.parent.main.location.href='../cash/cash.asp?type=SK'><img src="../images/fund_spay.gif" border=0><BR>�տ</a></td>
					<%end if%>
							</tr>
							<tr height=80>
							  <td align=center></td>
							  <td align=center></td>
							  <td align=center><img src="../images/base_down.gif" border=0></td>
							  <td align=center></td>
							  <td align=center><img src="../images/base_up.gif" border=0></td>
							</tr>
							
							<tr height=80>
							  <td align=center></td>
							  <td align=center></td>
							  <%if strGoodsSaleDetail > 0 then%>
							  <td align=center><a href="#"  onclick=window.parent.main.location.href='../report/goodssaledetail.asp' ><img src="../images/depot_number.gif" border=0><BR>������ϸ��</a></td>
							  <td align=center width=50><img src="../images/base_right.gif" border=0></td>
							  <%end if%>
							  <%if strSelectXS > 0 then%>
							  <td align=center><a href="#" 
							   onclick=window.parent.main.location.href='../Bills/selectbackbill.asp?type=XT' ><img src="../images/sell_comeT.gif" border=0><BR>�����˻�</a></td>                         <%end if%>
							</tr> 
						  </table>
 
						</td>
					  </tr>
					</table>
 
				  </td>
				  <td width=1 background="../images/main-03.gif"></td>
				  <td width="200" valign="top">
 
					<table border=0 width=85% align=center cellpadding=2 cellspacing=2>
					  <tr height=10>
						<td align=left></td>
					  </tr>
					  <tr height=20>
					  <%if strGoodsSaleCount > 0 then%>
						<td><img src="../images/icon.gif" border=0 align="absmiddle">&nbsp;&nbsp;
						<a href="#"  onclick=window.parent.main.location.href='../report/goodssalecount.asp'>��Ʒ���ۻ��ܱ�</a></td>
					<%end if%>
					  </tr>
					  <tr height=20>
					  <%if strCustSaleCount > 0 then%>
						<td><img src="../images/icon.gif" border=0 align="absmiddle">&nbsp;&nbsp;
						<a href="#"   onclick=window.parent.main.location.href='../report/custsalecount.asp'>�ͻ����ۻ��ܱ�</a></td>
					<%end if%>
					  </tr>
					  <tr height=20>
					  <%if strCustSaleCount > 0 then%>
						<td><img src="../images/icon.gif" border=0 align="absmiddle">&nbsp;&nbsp;
						<a href="#"   onclick=window.parent.main.location.href='../report/employeesalecount.asp'>ҵ��Ա���ۻ��ܱ�</a></td>
					<%end if%>
					  </tr>					  <tr height=20>
					  <%if strCustSaleCount > 0 then%>
						<td><img src="../images/icon.gif" border=0 align="absmiddle">&nbsp;&nbsp;
						<a href="#"   onclick=window.parent.main.location.href='../report/depotsalecount.asp'>�ֿ����ۻ��ܱ�</a></td>
					<%end if%>
					  </tr>
					  <tr height=20>
					  <%if strXSFinish > 0 then%>
						<td><img src="../images/icon.gif" border=0 align="absmiddle">&nbsp;&nbsp;
						<a href="#" onclick=window.parent.main.location.href='../report/orderdetail.asp?type=XD'>���۶���������</a></td>
						<%end if%>
					  </tr>
					  <tr height=20>
					  <%if strxslist > 0 then%>
						<td><img src="../images/icon.gif" border=0 align="absmiddle">&nbsp;&nbsp;
						<a href="#" onclick=window.parent.main.location.href='../report/pricelist.asp?type=XS' >���۵���һ��</a></td>
					<%end if%>
					  </tr>
					   <tr height=20>
					  <%if strxslist > 0 then%>
						<td><img src="../images/icon.gif" border=0 align="absmiddle">&nbsp;&nbsp;
						<a href="#" onclick=window.parent.main.location.href='../report/goodssaledetail.asp' >������ϸ��</a></td>
					<%end if%>
					  </tr>
					  
					</table>
 
				  </td>
				</tr>
			  </table>
 
			</td>
		  </tr>
	      <tr>
		    <td height=1 background="../images/main-04.gif"></td>
		  </tr>
	      <tr>
		    <td height=50></td>
		  </tr>
		</table>
 
	</td>
  </tr>
</table>

</body>
</html>
