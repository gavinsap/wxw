<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<% call CheckAuthority("strBrowseGoods") %>
<html>
<head>
<title>��Ʒ����</title>
</head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<link rel="StyleSheet" href="dtree.css" type="text/css" />
<script language="JavaScript" src="../js/exportexcel.js"></script>
<script language="JavaScript" src="../js/dtree.js"></script>
<script language="JavaScript">
function clicknode(nodename,nodecode){
	if (document.getElementById("nodename")!=null){
		document.getElementById("nodename").value = String(nodename);	
	}
	if (document.getElementById("typecode")!=null){
		document.getElementById("typecode").value = String(nodecode);	
	}	
	closeProc();
}

function showProc(){
  message_box.style.visibility='visible';
  //������ɫ������
  procbg = document.createElement("div"); 
  procbg.setAttribute("id","mybg"); 
  procbg.style.background = "#f7f7f7"; 
  procbg.style.width = "100%"; 
  procbg.style.height = "100%"; 
  procbg.style.position = "absolute"; 
  procbg.style.top = "0"; 
  procbg.style.left = "0"; 
  procbg.style.zIndex = "500"; 
  procbg.style.opacity = "0.3"; 
  procbg.style.filter = "Alpha(opacity=30)"; 
  //���������ҳ��
  document.body.appendChild(procbg);
  //document.body.style.overflow = "hidden";
}
//�϶�
function drag(obj){  
     var s = obj.style;  
     var b = document.body;   
  var x = event.clientX + b.scrollLeft - s.pixelLeft;   
  var y = event.clientY + b.scrollTop - s.pixelTop; 
 
  var m = function(){  
   if(event.button == 1){  
    s.pixelLeft = event.clientX + b.scrollLeft - x;   
    s.pixelTop = event.clientY + b.scrollTop - y;   
   }else {
    document.detachEvent("onmousemove", m);
   }  
  }  
  document.attachEvent("onmousemove", m);
  if(!this.z) 
   this.z = 999;   
  s.zIndex = ++this.z;   
  event.cancelBubble = true;   
}
 
function closeProc(){
  message_box.style.visibility= "hidden";
  procbg.style.visibility = "hidden";
}

function changegoodstype(){
  if (document.getElementById('nodename').value == "") {
	 document.getElementById('typecode').value ="";
	  }	
}
function CreateReturnValue(){
���� var nodecode=document.getElementById("goodstype");
     nodecode.value=document.getElementById('nodename').value; 
}
function del(goodscode){
if(!confirm('ȷ��Ҫɾ���û�Ʒ��������?')){
return false
}else{
window.location.href='../action/deletegoods.asp?goodscode='+goodscode
}
}
function editgoods(goodscode){
	window.open ('addgoods.asp?add=false&goodscode='+goodscode, 'addgoods', 'height=500, width=860,top=100,left=150,toolbar=no,menubar=no, scrollbars=yes, resizable=no,location=no, status=yes')	
}
function detail(goodscode){
window.open ('../report/depotdetail.asp?goodscode='+goodscode, 'depotdetail', 'height=600, width=900,top=100,left=150,toolbar=no,menubar=no, scrollbars=yes, resizable=no,location=no, status=yes')
}
function depot(goodscode){
window.open ('../report/eachdepot.asp?goodscode='+goodscode, 'eachdepot', 'height=600, width=850,top=100,left=150,toolbar=no,menubar=no, scrollbars=yes, resizable=no,location=no, status=yes')
}
function newgoods(){
openwin('addgoods.asp?add=true',850,500);
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
	if(confirm('ȷ��Ҫɾ��ѡ���'+iCount+'����Ʒ��������?')){
		$("._del").each( 
			function(i)
			{
				chk = $(this)
				if(chk.attr("checked") == true){
					index = chk.attr("id");
					index = index.substring(2);
					$("#tr" + index).remove();
					$.post("../select/delallgoods.asp",{goodscode:escape(chk.val())},
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
<body style="background:#FFFFFF; ">
<div style="background:url(../images/main-02.gif); width:100%; height:20; padding-left:0" ><img src="../images/main-01.gif"></div>

<br>
<form name="form1" method="post" action="goods.asp">
<div align="left" style="margin-left:10px;" ><span class="style1">��Ʒ����</span></div>

<table  border="0" style="margin-left:10px;">
<tr>
	<td align="right">��Ʒ���룺</td>
    <td><input type="text" id="goodscode" name="goodscode" size="16" value="<%=request.Form("goodscode")%>"></td>
    <td align="right">��Ʒ���</td>
	<td><input type="text" id="nodename" name="nodename" size="16" value="<%=request.Form("nodename")%>" onpropertychange="changegoodstype();"><a href="javascript:showProc()"><img border="0" src="../img/choose.gif" width="21" height="17"></a><input type="hidden" name="typecode" id="typecode" value="<%=request.Form("typecode")%>"></td>
    <td rowspan="2">
		<input type="submit" class="button" value="��ѯ">
	</td>
</tr>
<tr>
	<td align="right">��Ʒ���ƣ�</td>
    <td><input type="text" name="goodsname" size="16" value="<%=request.Form("goodsname")%>"></td>
	<td align="right">��Ʒ���</td>
    <td><input type="text" name="goodsunit" size="16" value="<%=request.Form("goodsunit")%>"></td>
	<td></td>
</tr>
</table>
</form>

<hr>
<table style="margin-left:10px">
<tr><td>
		<input type="button" class="button" value="����" onClick="newgoods();"> 
		<input type="button" class="button" value="ɾ��" onClick="delall();">
</td></tr>
<tr>
</td>

<%
if Request.Form("goodscode") = "" then
	s_goodscode = ""
else
	s_goodscode = " and goodscode like '%"& Request.Form("goodscode") &"%'"
end if

if Request.Form("nodename") = "" then
	s_goodstype = ""
else
	s_goodstype = " and code like '"& Request.Form("typecode") &"%'"
end if

if Request.Form("goodsname") = "" then
	s_goodsname = ""
else
	s_goodsname = " and goodsname like '%"&request.Form("goodsname")&"%'"
end if

if Request.Form("goodsunit") = "" then
	s_goodsunit = ""
else
	s_goodsunit = " and goodsunit like '%"&request.Form("goodsunit")&"%'"
end if

sql = "select '<a href=# onClick=editgoods('''+goodscode+''')>'+goodsname+'</a>' as agoodsname,* from t_goods where 1=1 " & s_goodscode & s_goodstype & s_goodsname & s_goodsunit&"order by GoodsID desc"

sql_check = "select * from t_softinfo"
Set rs = conn.Execute(sql_check)
if rs("showphoto") = true then
	call showpage(sql,"goods",4)
else
	call showpage(sql,"goods",1)
end if

%>
</td>
</tr>
</table>
<div id="message_box" style="position:absolute;left:48%;top:3%;width:250px;height:400px;filter:dropshadow(color=#666666,offx=3,offy=3,positive=2);z-index:1000;visibility:hidden">
   <div id= "message" style="border:#036 solid; border-width:1 1 3 1;width:95%; height:95%; background:#fff; color:#036; font-size:12px; line-height:150%;">
    <!-- DIV����״̬�У����⡢�رհ�ť -->
    <div style="background:#7DC6F0;height:5%;font-family:����; font-size:13px; padding:3 5 0 5; color:#00385E" onMouseDown="drag(message_box);return false">
     <span style="display:inline;width:100%;position:absolute;font-weight:bold">����ѡ�����</span>
     <span onClick="closeProc();" style="float:right;display:inline;cursor:pointer;font-size:150%">��</span>
    </div>
<script language="JavaScript">
	d = new dTree('d');
	<%
    Response.Write "d.add(0,-1,'��Ʒ����','edittree.asp?type=goods&name="&s_name&"&id="&i_id&"&pid=0');"
		sql_gtype = "select * from t_tree where type='goods'"
		set rs_gtype = conn.Execute(sql_gtype)
		do while rs_gtype.eof=false
		  i_id=rs_gtype("id")
			i_pid=rs_gtype("pid")
			s_name=rs_gtype("name")
			s_url=rs_gtype("url")
			s_code=rs_gtype("code")
		  Response.Write "d.add("&i_id&","&i_pid&",'"&s_name&"',""javascript:clicknode('"&s_name&"','"&s_code&"')"",'','','','','','"&s_code&"');"
		  rs_gtype.movenext
		loop
		close_rs(rs_gtype)
		%>
	document.write(d);
</script>
</div><!-- message -->
</div><!-- message_box -->

<%endconnection%>

</body>
</html>
  
  <%endconnection%>
  
</p>
<p>&nbsp;</p>
</body>
</html>
