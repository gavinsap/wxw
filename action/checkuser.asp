<%
Response.Buffer = true
Response.ExpiresAbsolute=now()-1
Response.Expires=0
Response.CacheControl="no-cache"
%>
<%
If request.cookies("username") = "" Then
%>
<script language=javascript>
alert('����û��½��');
parent.location = '../login.asp';
</script>
<%
End If
%>