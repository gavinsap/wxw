<!--#include file="../inc/upload.inc.asp"-->
<%
dim upload,file,formName,formPath,filename,fileExt
dim ranNum
call UpFile()
'===========������ϴ�(upload_0)====================
sub UpFile()
set upload=new UpFile_Class '�����ϴ�����
upload.GetData (500*1024) 'ȡ���ϴ�����,�˴���Ϊ500 K
if upload.err > 0 then
select case upload.err
case 1
Response.Write "����ѡ����Ҫ�ϴ����ļ���[ <a href=# onclick=history.go(-1)>�����ϴ�</a> ]"
case 2
Response.Write "ͼƬ��С���������� 500 K��[ <a href=# onclick=history.go(-1)>�����ϴ�</a> ]"
end select
exit sub
else
formPath=upload.form("filepath") '�ļ�����Ŀ¼,��Ŀ¼����Ϊ����ɶ�д
formPath="../photo"
if formPath="" then
formPath="rwdata/"
end if
'��Ŀ¼���(/)
if right(formPath,1)<>"/" then 
formPath=formPath&"/"
end if 
for each formName in upload.file '�г������ϴ��˵��ļ�
set file=upload.file(formName) '����һ���ļ�����
if file.filesize<100 then
response.write "����ѡ����Ҫ�ϴ���ͼƬ��[ <a href=# onclick=history.go(-1)>�����ϴ�</a> ]"
response.end
end if

fileExt=lcase(file.FileExt)
if CheckFileExt(fileEXT)=false then
response.write "�ļ���ʽ����ȷ��[ <a href=# onclick=history.go(-1)>�����ϴ�</a> ]"
response.end
end if

'randomize
ranNum=int(90000*rnd)+10000
filename=formPath&year(now)&month(now)&day(now)&hour(now)&minute(now)&second(now)&ranNum&"."&fileExt
if file.FileSize>0 then '��� FileSize > 0 ˵�����ļ�����
result=file.SaveToFile(Server.mappath(filename)) '�����ļ�
if result="ok" then
response.write formName&" upload OK, had saved to "&filename&"<br>"
else
response.write formName&" upload Fail,"&result&"<br>"
end if
end if
set file=nothing
next
set upload=nothing
end if
end sub

'�ж��ļ������Ƿ�ϸ�
Private Function CheckFileExt (fileEXT)
dim Forumupload
Forumupload="gif,jpg,bmp,jpeg"
Forumupload=split(Forumupload,",")
for i=0 to ubound(Forumupload)
if lcase(fileEXT)=lcase(trim(Forumupload(i))) then
CheckFileExt=true
exit Function
else
CheckFileExt=false
end if
next
End Function
if Request.QueryString("goodsid") = "" then
response.Redirect "../common/addgoods.asp?add=true&filename=" & filename
else
response.Redirect "../common/addgoods.asp?temp=" & Request.QueryString("goodsid") & "&filename=" & filename
end if
%>


