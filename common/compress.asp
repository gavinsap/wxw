<%
Sub CompactDB(strDBFileName)
  Set fso = CreateObject("Scripting.FileSystemObject")
  dim strOldDB
  strOldDB = server.MapPath(strDBFileName)
  dim strNewDB
  strNewDB = server.MapPath("../data/tempjxc.mdb")
  if fso.FileExists(strOldDB) then
    'ѹ�����ݿ�
    Set Engine = Server.CreateObject("JRO.JetEngine")
    strPvd = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source="
    Engine.CompactDatabase strPvd & strOldDB , strPvd & strNewDB
    set Engine = nothing
    'ɾ���ɵ����ݿ��ļ�
    fso.DeleteFile strOldDB
    ' ��ѹ���õ����ݿ��ļ���������
    fso.MoveFile strNewDB, strOldDB
    response.write "���ݿ�ѹ�����!"
  else
    response.write "�Ҳ���ָ�������ݿ��ļ�!"
  end if
  set FSO = nothing
end sub

call CompactDB("../data/jxc.mdb")
%>
<script>
alert("ѹ���ɹ���");
window.close();
</script>