<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<html>
<head>
<script type="text/javascript" src="../js/dtree.js"></script>
<script>
function check(){
if (document.employee.name.value=="")
{
alert("����дԱ�����ƣ�");
document.employee.name.focus();
return false; 
}
if ($("#birthday").val() == "")
{
alert("Ա�����ղ���Ϊ�գ�");
$("#birthday").focus();
return false; 
}
}
function check_name(){
	if ($("#name").val() == "") {
		$("#div_check_name").attr("innerHTML","<li style='float:left;'><img src='../img/btn_false.gif'></li><li style='float:left;width:auto'><strong><font color=#FF0000>����Ϊ��</font></strong></li>");
	}else{
    $.post("../select/addemployee_ajax_name.asp",{name:escape($("#name").val())},
	function(data)
	{ 
       if (data == "True"){
		   $("#div_check_name").attr("innerHTML","<img src='../img/btn_true.gif'>"); 
		   }else{
		   $("#div_check_name").attr("innerHTML","<li style='float:left;'><img src='../img/btn_false.gif'></li><li style='float:left;width:auto'><strong><font color=#FF0000>Ա�������ظ�</font></strong></li>"); 
	   }
	}
	);	
	}
}
function check_date(){
    $.post("../select/addemployee_ajax_date.asp",{name:escape($("#birthday").val())},
	function(data)
	{ 
       if (data == "True"){
		   $("#div_check_date").attr("innerHTML","<img src='../img/btn_true.gif'>"); 
		   }else{
		   $("#div_check_date").attr("innerHTML","<li style='float:left;'><img src='../img/btn_false.gif'></li><li style='float:left;width:auto'><strong><font color=#FF0000>�����ʽ����ȷ</font></strong></li>"); 
	   }
	}
	);	
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<title>Ա����Ϣ</title>
</head>

<body bgcolor="#F3F1E9"><br>
<div align="center"><span class="STYLE1">Ա����Ϣ</span></div>
<p><br>
</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p><b><font color="#ff0000">��Ѱ治�ṩ�˹��� ����ϵС���Ƽ�������ҵ�� http://www.hokilly.com/ ��ѯQQ��15916190</font></b></p>
</body>
</html>
