<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<% call CheckAuthority("strSYS") %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<title>ϵͳ����</title>
<script>
function goods()
{
	window.open ('../common/edittree.asp?type=goods', 'newwindow', 'height=500, width=650,left=100,top=100,toolbar=no,menubar=no, scrollbars=yes, resizable=no,location=no, status=no')
}


function depot()
{
	window.open ('../common/depot.asp', 'newwindow', 'height=400, width=700,left=120,top=180,toolbar=no,menubar=no, scrollbars=yes, resizable=no,location=no, status=no')
}

function units()
{
	window.open ('../common/units.asp', 'newwindow', 'height=400, width=300,left=300,top=180,toolbar=no,menubar=no, scrollbars=yes, resizable=no,location=no, status=no')
}

function cashtype()
{
	window.open ('../common/cashtype.asp', 'newwindow', 'height=400, width=300,left=300,top=180,toolbar=no,menubar=no, scrollbars=yes, resizable=no,location=no, status=no')
}

function record()
{
	window.open ('../common/record.asp', 'newwindow', 'top=200,left=150,height=400, width=700,toolbar=no,menubar=no, scrollbars=yes, resizable=no,location=no, status=no')
}
</script>
</head>

<body bgcolor="#f7f7f7">
<div style="background:url(../images/main-02.gif); width:100%; height:20; padding-left:0" ><img src="../images/main-01.gif"></div>
<div style="padding-left:10px">
<br>
<div align="center"><span class="style1">ϵͳ����</span><br>
<table width="760" border="0" >
<tr valign="top"><td><fieldset style="padding-bottom:5px"><legend>��ʾ����</legend>
  <form name="form1" method="post" action="../action/editsys.asp">
    <table width="200" border="0" align="center">
      <tr>
        <td width="100" align="left" colspan="3">��ʾ��¼����</td>
		<%
		sql = "select * from T_SoftInfo"
		Set rs = conn.Execute(sql)
		%>
        <td colspan="3"><input type="text" name="pagerecord" size="2" value="<%=rs("pagerecord")%>"></td>
      </tr>
      <tr>
        <td colspan="6">��ʾС����λ��</td>
      </tr>
      <tr>
        <td align="right">����</td>
        <td><input type="text" name="dotnum" size="2" value="<%=rs("dotnum")%>"></td>
        <td align="right">����</td>
        <td><input type="text" name="dotprice" size="2" value="<%=rs("dotprice")%>"></td>
        <td align="right">���</td>
        <td><input type="text" name="dotmon" size="2" value="<%=rs("dotmon")%>"></td>
      </tr>
	  <tr>
	    <td colspan="4">��Ʒ�����б�����ʾͼƬ</td>
	    <td colspan="2">
		  <%
		  if rs("showphoto")=false then
		    s_false = "selected"
		  else
		    s_true = "selected"
		  end if
		  %>
		  <select name="showphoto"><option value="true" <%=s_true%>>��</option>
		                           <option value="false" <%=s_false%>>��</option></select>
		</td>
	  </tr>
	  <tr>
	    <td colspan="4">�Ƿ���������</td>
	    <td colspan="2">
		  <%
		  if rs("fuchuku")=false then
		    ss_false = "selected"
		  else
		    ss_true = "selected"
		  end if
		  %>
		  <select name="fuchuku"><option value="true" <%=ss_true%>>��</option>
		                           <option value="false" <%=ss_false%>>��</option></select>
		</td>
	  </tr>
	  <tr>
	    <td colspan="4">�Ƿ���ü����</td>
	    <td colspan="2">
		  <%
		  if rs("memoryprice")=false then
		    sss_false = "selected"
		  else
		    sss_true = "selected"
		  end if
		  %>
		  <select name="memoryprice"><option value="true" <%=sss_true%>>��</option>
		                           <option value="false" <%=sss_false%>>��</option></select>
		</td>
	  </tr>
	  <tr>
	    <td colspan="4">�Ƿ�����Զ�����</td>
	    <td colspan="2">
		  <%
		  if rs("autogoodscode")=false then
		    ssss_false = "selected"
		  else
		    ssss_true = "selected"
		  end if
		  %>
		  <select name="autogoodscode"><option value="true" <%=ssss_true%>>��</option>
		                           <option value="false" <%=ssss_false%>>��</option></select>
		</td>
	  </tr>
      <tr>
      	<td colspan="4">��Ʒ����</td>
        <td colspan="2"><input type="text" name="goodscode" value="<%=rs("goodscode")%>" size="4"></td>
       </tr>
    </table>
      <div align="center"><input type="submit" name="Submit"  onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  value=" �� �� " class="button"></div>
  </form>
</fieldset>
</td>
<td><fieldset style="padding-bottom:5px"><legend>��Ϣ����</legend>
<table align="center" border="0" height="135" width="100%">
<tr>
  <td align="center"><input type="button" onClick="goods();"  onMouseOver="this.className='button_over';" onMouseOut="this.className='button';" value="�������"  class="button"></td>
  <td></td>
</tr>
<tr>
  <td align="center"><input type="button" onClick="depot();"  onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  value="�ֿ����"  class="button"></td>
  <td align="center"><input type="button" onClick="units();"  onMouseOver="this.className='button_over';" onMouseOut="this.className='button';" value="������λ����"  class="button"></td>
</tr>
<tr>
  <td align="center"><input type="button" onClick="cashtype();"   onMouseOver="this.className='button_over';" onMouseOut="this.className='button';" value="֧����ʽ"  class="button"></td>
  <td align="center"><input type="button" onClick="record();"  onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  value="�鿴��½��־"  class="button"></td>
</tr>
</table>
</fieldset></td>
</tr>
</div>
<%
close_rs(rs)
endconnection
%>
</div>
</body>
</html>
