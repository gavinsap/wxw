<!-- #include file="../inc/conn.asp" -->
<!-- #include file="checkuser.asp" -->
<%
If Request("add") = "false" Then
    if request("type") = "�ɹ�����" then
	    s_billtype = "�ɹ�����"
		elseif request("type") = "���۶���" then
	    s_billtype = "���۶���"
    End If
    s_adddate = Trim(Request.Form("date"))
    s_cust = Trim(Request.Form("cust"))
    s_depot = Trim(Request.Form("depot"))
		s_maker = trim(Request.Form("maker"))
    s_user = Trim(Request.Form("user"))
    s_memo = Trim(Request.Form("memo"))
	
		s_pay = Trim(Request.Form("pay"))
	
		s_account = Trim(Request.Form("account"))
    s_billcode = Trim(Request.Form("billcode"))
    i_rowcount = Trim(Request.Form("rowcount"))
		sql = "select t_bill.check from t_bill where billcode = '" & s_billcode & "'"
		Set rs = conn.Execute(sql)
		if rs("check") = true then
		  Response.Write "<script>alert(""��˹��ĵ��ݲ����޸ģ����ȷ���!"");</script>"
		  Response.Write "<script>window.history.go(-2);</script>"
		  Response.End()
		else
	    sql = "update t_bill set adddate='"&s_adddate&"',custname='"&s_cust&"',depotname='"&s_depot&"',username='"&s_user&"',memo='"&s_memo&"',pay="&s_pay&",account='"&s_account&"' where billcode='"&s_billcode&"'"
	    conn.Execute(sql)
	    sql = "delete from t_billdetail where billcode='"&s_billcode&"'"
	    conn.Execute(sql)
    	For i = 1 To i_rowcount
        s_goodscode = Trim(Request.Form("goodscode"&i))
        s_goodsname = Trim(Request.Form("goodsname"&i))
        s_goodsunit = Trim(Request.Form("goodsunit"&i))
        s_units = Trim(Request.Form("units"&i))
        s_price = Trim(Request.Form("price"&i))
        s_number = Trim(Request.Form("number"&i))
        s_money = Trim(Request.Form("money"&i))
        s_remark = Trim(Request.Form("remark"&i))
        s_aveprice = Trim(Request.Form("aveprice"&i))
        If (Request("type") = "�ɹ�����") Then
            sql = "insert into t_billdetail (billcode,goodscode,goodsname,goodsunit,units,price,number,money,DetailNote,inprice) values ('"&s_billcode&"','"&s_goodscode&"','"&s_goodsname&"','"&s_goodsunit&"','"&s_units&"','"&s_price&"','"&s_number&"','"&s_money&"','"&s_remark&"','"&s_price&"')"
       
	    End If
        If (Request("type") = "���۶���") Then
            sql = "insert into t_billdetail (billcode,goodscode,goodsname,goodsunit,units,price,number,money,DetailNote,inprice) values ('"&s_billcode&"','"&s_goodscode&"','"&s_goodsname&"','"&s_goodsunit&"','"&s_units&"','"&s_price&"','"&s_number&"','"&s_money&"','"&s_remark&"','"&s_aveprice&"')"
        End If
				if s_goodscode<>"" then
        	conn.Execute(sql)
        end if
    Next
	end if
Else
    If Request("type") = "CD" Then
        s_billtype = "�ɹ�����"
    ElseIf Request("type") = "XD" Then
        s_billtype = "���۶���"
    End If
    s_adddate = Trim(Request.Form("date"))
    s_cust = Trim(Request.Form("cust"))
    s_depot = Trim(Request.Form("depot"))
		s_maker = trim(Request.Form("maker"))
    s_user = Trim(Request.Form("user"))
    s_memo = Trim(Request.Form("memo"))
		s_pay = Trim(Request.Form("pay"))
		s_account = Trim(Request.Form("account"))
    s_billcode = Trim(Request.Form("billcode"))
    i_rowcount = Trim(Request.Form("rowcount"))
		f_check = Request.Form("_check")
		'�ж��ظ����ݺ�
		sql_check = "select count(*) as c from t_bill where billcode='"&s_billcode&"'"
		set rs_check = server.CreateObject("adodb.recordset")
		rs_check.Open sql_check, conn, 1, 1
		if CInt(rs_check("c")) > 0 then
      Response.Write("<script language=javascript>alert('�������ظ�!');history.go(-1);</script>")
	  	Response.End()
		end if
		close_rs(rs_check)
		'�жϽ���
    If (Request("type") = "CD") Then
        sql = "insert into t_bill (billcode,adddate,custname,depotname,UserName,Memo,billtype,inorout,maker,flag,t_bill.check,pay,account,planbillcode) values ('"&s_billcode&"','"&s_adddate&"','"&s_cust&"','"&s_depot&"','"&s_user&"','"&s_memo&"','"&s_billtype&"','����','"&s_maker&"',0,'"&f_check&"','"&s_pay&"','"&s_account&"','')"
		
    End If
    If (Request("type") = "XD") Then
        sql = "insert into t_bill (billcode,adddate,custname,depotname,UserName,Memo,billtype,inorout,maker,flag,t_bill.check,pay,account,planbillcode) values ('"&s_billcode&"','"&s_adddate&"','"&s_cust&"','"&s_depot&"','"&s_user&"','"&s_memo&"','"&s_billtype&"','����','"&s_maker&"',0,'"&f_check&"','"&s_pay&"','"&s_account&"','')"
    End If
    conn.Execute(sql)
    For i = 1 To i_rowcount
        s_goodscode = Trim(Request.Form("goodscode"&i))
        s_goodsname = Trim(Request.Form("goodsname"&i))
        s_goodsunit = Trim(Request.Form("goodsunit"&i))
        s_units = Trim(Request.Form("units"&i))
        s_price = Trim(Request.Form("price"&i))
        s_number = Trim(Request.Form("number"&i))
        s_money = Trim(Request.Form("money"&i))
        s_remark = Trim(Request.Form("remark"&i))
        s_aveprice = Trim(Request.Form("aveprice"&i))
        If (Request("type") = "CD") Then
            sql = "insert into t_billdetail (billcode,goodscode,goodsname,goodsunit,units,price,number,money,DetailNote,inprice) values ('"&s_billcode&"','"&s_goodscode&"','"&s_goodsname&"','"&s_goodsunit&"','"&s_units&"','"&s_price&"','"&s_number&"','"&s_money&"','"&s_remark&"','"&s_price&"')"
        End If
        If (Request("type") = "XD") Then
            sql = "insert into t_billdetail (billcode,goodscode,goodsname,goodsunit,units,price,number,money,DetailNote,inprice) values ('"&s_billcode&"','"&s_goodscode&"','"&s_goodsname&"','"&s_goodsunit&"','"&s_units&"','"&s_price&"','"&s_number&"','"&s_money&"','"&s_remark&"','"&s_aveprice&"')"
        End If
        if s_goodscode<>"" then
        	conn.Execute(sql)
        end if
    Next
End If
endconnection


		    response.write "<script>alert('����ɹ���');window.close();</script>"
		  
%>
