<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<%
If Request("type") = "fk" Then
    call CheckAuthority("strBrowseFK")
Else
    call CheckAuthority("strBrowseSK")
End If
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<title>�ޱ����ĵ�</title>
</head>

<body><br><br><br>
<div align="center"><span class="STYLE1">
<%
If Request("type") = "fk" Then
    Response.Write("����Ǽ�")
Else
    Response.Write("�տ�Ǽ�")
End If
%>
</span></div>
<div align="center"><span class="STYLE1">
<%
sql = "select * from t_cash where id="&Request("id")
Set rs = server.CreateObject("adodb.recordset")
rs.Open sql, conn, 1, 1
Response.Write rs("cashcode")
Response.Write "<INPUT type=hidden name=""billcode"" value="&rs("cashcode")&">"
%></span></div><br>
<table align="center" id="tbl" border-collapse:collapse width="600" border="1" cellpadding="2" cellspacing="0" bordercolorlight="#000000" bordercolordark="#FFFFFF">
          <tr>
            <td width="70" align="right"><%
If Request("type") = "fk" Then
    Response.Write("��������:")
Else
    Response.Write("�տ�����:")
End If
%></td>
            <td width="230"><%=rs("adddate")%></td>
            <td width="70" align="right">
			<%If Request("type") = "fk" Then
    Response.Write("�ɹ�����:")
Else
    Response.Write("���۵���:")
End If

%></td>
            <td width="230"><%=rs("billcode")%></td>
          </tr>
          <tr>
            <td align="right"><%If Request("type") = "fk" Then
    Response.Write("��&nbsp;Ӧ&nbsp;��:")
Else
    Response.Write("��&nbsp;&nbsp;&nbsp;&nbsp;��:")
End If

%></td>
            <td><%=rs("custname")%>&nbsp;</td>
			<td align="right">��&nbsp;&nbsp;&nbsp;&nbsp;��:</td>
			<td><%=rs("account")%>&nbsp;</td>
          </tr>
   
          <tr>
            <td align="right">֧����ʽ:</td>
            <td><%=rs("type")%>&nbsp;</td>
            <td align="right">ʵ�����:</td>
            <td><%=rs("money")%>&nbsp;</td>
          </tr>
         
          <tr>
            <td align="right">ҵ&nbsp;��&nbsp;Ա:</td>
            <td><%=rs("user")%>&nbsp;</td>
            <td align="right">���첿��:</td>
            <td><%=rs("depart")%>&nbsp;</td>
          </tr>
		   <tr>
            <td align="right">��&nbsp;&nbsp;&nbsp;&nbsp;ע:</td>
            <td><%=rs("memo")%>&nbsp;</td>
			<td align="right">�Ƶ���:</td>
            <td><%=rs("username")%>&nbsp;</td>
          </tr>
      </table>
      <%
	  close_rs(rs)
	  endconnection
	  %>
</body>
</html>
