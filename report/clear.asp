<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<title>��ʼ����־</title>
</head>

<body>
<br>
<div class="STYLE1" align="center">���ݳ�ʼ����־</div>
<form name="form1" action="clear.asp" method="post">
</form>
<%
sql = "select * from t_clearmaker order by adddate desc"
call showpage(sql,"clear",1)
endconnection
%>
</body>
</html>
