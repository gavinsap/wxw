<div align="left">
<% 
   Response.Write "����ĳ�����һ��ʹ���� " & Session.Contents.Count & _
             " ��Session����<P>"
   Dim strName, iLoop
   For Each strName in Session.Contents
     '�ж�һ��Session�����Ƿ�Ϊ����
     If IsArray(Session(strName)) then
       '��������飬��ô���г����е�����Ԫ������
       For iLoop = LBound(Session(strName)) to UBound(Session(strName))
          Response.Write strName & "(" & iLoop & ") - " & _
               Session(strName)(iLoop) & "<BR>"
       Next
     Else
       '����������飬��ôֱ����ʾ
       Response.Write strName & " - " & Session.Contents(strName) & "<BR>"
     End If
   Next
%> 
</div>