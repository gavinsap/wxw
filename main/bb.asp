<!-- #include file="../inc/conn.asp" -->
<%
sql = "select * from t_user where username = '"& request.cookies("username") &"'"
set rs = Server.CreateObject("adodb.recordset")
rs.open sql, conn, 1, 1
strPower = rs("authority")
'response.write strPower
strGain = instr(strPower,"Gain")
strSaleTop = instr(strPower,"SaleTop")
strJXC = instr(strPower,"JXC")
strOtherDetail = instr(strPower,"OtherDetail")
strMonthSale = instr(strPower,"MonthSale")
strAnalysis = instr(strPower,"Analysis")
intReport = cint(strGain) + cint(strSaleTop) + cint(strJXC) + cint(strOtherDetail) + cint(strMonthSale) + cint(strAnalysis)
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
				<%if strOtherDetail > 0 then%>
 <td align=center><a href="#" onclick=window.parent.main.location.href='../report/otherdetail.asp'
 ><img src="../images/depot_check1.gif" border=0><BR>������ϸ����</a></td>
                <%end if%>
							 
			    <%if strGain > 0 then%>
<td align=center><a href="#" onclick=window.parent.main.location.href='../report/gain.asp'
><img src="../images/pay_pmoney.gif" border=0><BR>�������</a></td>
                <%end if%>
							
			    <%if strSaleTop > 0 then%>				 
 <td align=center><a href="#"  onclick=window.parent.main.location.href='../report/saletop.asp'><img src="../images/depot_check2.gif" border=0><BR>��������</a></td>
			    <%end if%>
							</tr>
							
						<tr height="50"><td></td></tr>							
							<tr height=80>
			    <%if strMonthSale > 0 then%>
<td align=center><a href="#"  onclick=window.parent.main.location.href='../report/sale_month.asp'><img src="../images/join_comeT.gif" border=0><BR>����ͳ��</a></td>
                <%end if%>
			    <%if strAnalysis > 0 then%>
<td align=center><a href="#"  onclick=window.parent.main.location.href='../chart/Analysis.asp' ><img src="../images/join_comeS.gif" border=0><BR>ͼ�����</a></td>             <%end if%>
							
				<%if strJXC > 0 then%>			  
<td align=center><a href="#" onclick=window.parent.main.location.href='../Report/jxc.asp'><img src="../images/pay_proce.gif" border=0><BR>�����汨��</a></td>
                <%end if%>
							</tr> 
						  </table>
 
						</td>
					  </tr>
					</table>
 
				  </td>
				  <td width=1 background="../images/main-03.gif"></td>
				  <td width="200" valign="top">
 
			
				  </td>
				</tr>
			  </table>
 
			</td>
		  </tr>
	      <tr>
		    <td height=1 background="../images/main-04.gif"></td>
		  </tr>
	      <tr>
		    <td  height="50"  align=center>
			  
 
	</td>
  </tr>
</table>

</body>
</html>
