<%
backup_path = server.mappath("../backup/"&request.QueryString("filename"))
Dim objFSO '����һ������Ϊ objFSO �ı����Դ�Ŷ���ʵ��    
Set objFSO = Server.CreateObject("Scripting.FileSystemObject")    
If objFSO.FileExists(backup_path) Then    
    objFSO.DeleteFile backup_path,True  %>  
    <script>alert("�Ѿ��ɹ��ض��ļ�"+"<%response.Write request.QueryString("filename")%>"+"������ɾ��");
    		window.location='../common/backup.asp'</script>    
<%Else%>    
	<script>alert("<%=request.QueryString("filename")%>"+"�����ڣ��޷�����ɾ��");
    		window.location='../common/backup.asp'</script> 
<%End If    
Set objFSO = Nothing '�ͷ� FileSystemObject ����ʵ���ڴ�ռ� 
%>