<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>��������</title>
</head>

<body>
<% 
function bl(path) 
set fso=server.createobject("scripting.filesystemobject") 
set fl=fso.getfolder(path) 
on error resume next 
response.write "��ǰ·��"&path&fl.files.count&"<br />���ļ����������ļ���" 
for each fn in fl.files 
response.write "<br />|--"&fn.name 
next 
set fso=nothing
end function 

bl(server.mappath("../backup"))
%>
</body>
</html>
