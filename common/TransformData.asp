<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../inc/config.asp" -->
<%
state = Request.QueryString("state")
enddate = Request.Form("enddate")
if (state="true") and (enddate<>"") then
	on error resume next
	conn.BeginTrans	
		sql = "delete from t_temp_start"
		conn.execute sql
		set t = server.createobject("adodb.recordset")
		sql = "select depotname from t_depot"
		t.open sql, conn, 1, 1
		for i=0 to t.recordcount -1
			if t.bof or t.eof then exit for
			depot_f = ",depotname "
			depot_q = " depotname = '"&t("depotname")&"' and "	
			sql = "select a.goodscode,ifnull(b.avgprice,0) as startprice,ifnull(b.totalmoney,0) as startmoney,ifnull(b.t_num,0) as startdepot"&depot_f
			sql = sql&" as depot from t_goods a right join (select goodscode, "
			sql = sql&" case when Sum(flag]*number)=0 or Sum(flag*number) is null then 0 else round(Sum(flag*number*inprice)/Sum(flag*number),2) end AS avgprice, "
			sql = sql&" case when Sum(flag*number)=0 or Sum(flag*number) is null then 0 else Sum(flag*number*inprice) end AS totalmoney, " 
			sql = sql&" case when Sum(flag*number) is null then 0 else Sum(flag*number) end AS T_Num"&depot_f
			sql = sql&" from s_count where "&depot_q
			sql = sql&" adddate<='"&enddate&"'"
			sql = sql&" group by goodscode"&depot_f&") b on a.goodscode=b.goodscode "
			sql = "insert into t_temp_start(goodscode,depotname,price,number) select goodscode,depot,startprice,startdepot from ("&sql&") as vb where goodscode<>''"
		
			conn.execute sql
			t.movenext
		next
		
		sql = "delete from t_bill"
		conn.execute sql
		
		sql = "delete from t_billdetail"
		conn.execute sql
		
		sql = "delete from t_start"
		conn.execute sql
		
		sql = "insert into t_start(goodscode,depotname,number,price) select goodscode,depotname,number,price from t_temp_start"
		conn.execute sql		
	if err.number=0 then
		manageLog "���ս�ת��" & enddate
		conn.CommitTrans
		conn.close
		set conn=nothing
		Response.Write"<script>alert('��ת�ɹ���')</SCRIPT>"
	else
		conn.RollbackTrans
		response.write err.description
	end if	
end if
%>
<html>
<head>
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>���ݽ�ת</title>
</head>
<body>
<script language="javascript">
function check(){
	if(document.fm1.enddate.value==""){
		alert('��ѡ��������ڣ�');
		return false;
	}else{
		return true;
	}
}
</script>
<form name="fm1" method="post" action="TransformData.asp?state=true" onSubmit="return check()">
<font color="#FF0000">ע�⣺��ת����ѵ��ݽ�������֮ǰ�Ŀ������ת��Ϊ��ǰ���ڳ�����<br>
�����ĵ��ݿ������ݲ�ѯ�Ĺ������ݲ�ѯ�в�ѯ�������������޸�<br>
�˹����ʺ��ڵ����������������������������ٶ�<br>
�˲���Ϊ�������������������ǰ�����������ز���֮ǰ�������ݱ���</font><br>
���ݽ������ڣ�<input type="text" name="enddate" size="10" readonly value="<%=enddate%>"><%showdate("enddate")%>
<br>
<br>
<input type="submit" name="carry" class="button" value="��ʼ��ת">
</form>
</body>
</html>
