<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<html>
<head>
<title>Excel��Ʒ����</title>
</head>
<body style="background:#FFFFFF">
<div style="background:url(../images/main-02.gif); width:100%; height:20; padding-left:0" ><img src="../images/main-01.gif"></div>
<div style="padding-left:10px">
<script language="javascript">
function uploaddata(){
	if (document.upload.pic1.value=""){
		alert('��ѡ��Ҫ�ϴ����ļ���');
		return;
	}
	var filename = document.upload.pic1.value;
	var kzName = filename.slice(filename.indexOf(".")).toLowerCase();
	if(kzName!=".xls"&&kzName!=".xlsx"){
		alert('ֻ���ϴ���׺Ϊxls|xlsx��Excel�����ļ���');
		return;
	}
	document.upload.submit();
}
</script>
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<font color="#FF0000">����������ģ�壬Ȼ����ģ����¼�����ݣ�<br>�벻Ҫ�޸�excel��sheet�����ƣ�Ȼ��ֱ���ϴ����ɣ�<br>���������ʾ������Ԥ��Ԥ�ڸ�ʽ����������excel���һ�£����ƶ����ģ�<br>Ȼ���ٴ��ϴ���������������������ǵĿͷ���ϵ.</font><br>
<table>
<tr>
<td colspan="2" valign="top">
<input type="button" class="button"  onMouseOver="this.className='button_over';" onMouseOut="this.className='button';" onClick="document.location='../Database/data.xls'" value="ģ������" >
</td>
</tr>
<tr>
<td width="350px" valign="top">
<form id="upload" name="upload" method="post"  action="importgoods_save.asp" enctype="multipart/form-data">
Excel�ϴ���<input type="file" name="pic1"  class="button" size=32 >

<td valign="top">
<input type="button" class="button" value=" �� �� "  onMouseOver="this.className='button_over';" onMouseOut="this.className='button';" onClick="uploaddata()">
</form>
</td>
</tr>
</table>
<p><b><font color="#ff0000">��Ѱ治�ṩ�˹��� ����ϵС���Ƽ�������ҵ�� http://www.hokilly.com/ ��ѯQQ��15916190</font></b></p>
</div>
</body>
</html>