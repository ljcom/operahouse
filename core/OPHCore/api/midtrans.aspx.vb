Imports System.IO
Imports System.Net
Imports System.Net.WebRequest
Imports Newtonsoft.Json
Imports Newtonsoft.Json.Linq
Imports System.Xml
Imports System.Collections.Generic

Partial Class OPHCore_API_midtrans

    Inherits cl_base

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        loadAccount()

        'Dim curODBC = Session("ODBC")
        'Dim DBCore = contentOfsqDB
        Dim curHostGUID = Session("hostGUID")
        Dim curUserGUID = Session("userGUID")

        Dim sqlstr = ""
        Dim noxml = False
        'Dim isValid = False
        Dim appSettings = ConfigurationManager.AppSettings

        Dim isSingle = True
        Dim xmlstr = ""
        Dim xmlstr1 = ""

        Dim mode = getQueryVar("mode")
        If mode = "" Then
            mode = Request.Form("mode")
        End If

        Select Case mode
            Case "payment"
                Dim code = getQueryVar("code")
                Dim GUID = getQueryVar("GUID")
                sqlstr = "exec api.function @hostguid='" & curHostGUID & "', @mode='payment', @code='" & code & "', @guid='" & GUID & "'"
                xmlstr = runSQLwithResult(sqlstr)
                xmlstr = "{""transaction_details"": {""order_id"": ""SO001"",""gross_amount"": 11000}, ""item_details"": [{""id"": ""00000"", ""price"": 10000, ""name"": ""Item 1"", ""quantity"": 1},{""id"": ""00001"", ""price"": 1000, ""name"": ""PPN 10%"", ""quantity"": 1}], ""enabled_payments"": [""credit_card""], ""credit_card"": {""secure"":true},""customer_details"": {""first_name"": ""Customer"", ""email"": ""customer@gmail.com""}}"
                ServicePointManager.Expect100Continue = True
                ServicePointManager.SecurityProtocol = 3072

                Dim cli = New WebClient()
                'cli.Proxy = New WebProxy("10.112.20.80", 8080)
                cli.Headers(HttpRequestHeader.ContentType) = "application/json"
                cli.Headers(HttpRequestHeader.Accept) = "application/json"

                'Dim serverkey = "SB-Mid-server-Q8A5YgsHLF-DbCKaa9m9CHNA" 'liberty
                'Dim serverkey = "SB-Mid-server-hKaSAFBUgsTTshZxn8PK2g1Q" 'sandbox
                Dim serverkey = "SB-Mid-server-XX_e6bZIOCwKrbwT_fFeWd-u" 'sandbox liberty
                'Dim serverkey = "Mid-server-Iyid57b2P0ckq2v60T8Dacf1"
                Dim username = serverkey
                Dim password = ""

                Dim base64Decoded As String = username + ":" + password
                Dim base64Encoded As String

                Dim data As Byte()
                data = System.Text.ASCIIEncoding.ASCII.GetBytes(base64Decoded)
                base64Encoded = System.Convert.ToBase64String(data)

                cli.Headers(HttpRequestHeader.Authorization) = String.Format("Basic {0}", base64Encoded)
                cli.Encoding = Encoding.UTF8

                Dim json = xmlstr

                If xmlstr.Contains("message") Then
                    Response.Write(xmlstr)
                Else

                    Dim postarray As Byte() = Encoding.ASCII.GetBytes(json)
                    Try
                        Dim responseArray As Byte() = cli.UploadData("https://app.sandbox.midtrans.com/snap/v1/transactions", postarray) 'sandbox

                        'Dim responseArray As Byte() = cli.UploadData("https://app.midtrans.com/snap/v1/transactions", postarray)
                        Dim jsonResp As String = Encoding.ASCII.GetString(responseArray)
                        Dim ser As JObject = JObject.Parse(jsonResp)
                        Dim jsonRespdata As List(Of JToken) = ser.Children().ToList
                        Dim output As String = ""
                        Dim Token As String = ""
                        Dim RedirectURL As String = ""
                        For Each item As JProperty In jsonRespdata
                            item.CreateReader()
                            Select Case item.Name
                                Case "Token"
                                    Token = item.Value
                                Case "redirect_url"
                                    RedirectURL = item.Value

                            End Select
                        Next
                        xmlstr = "<script>window.location='" & RedirectURL & "';</script>"
                        Response.Write(xmlstr)

                    Catch exp As Exception
                        xmlstr = "<sqroot><message>" & exp.Message & "</message></sqroot>"
                        Response.Write(xmlstr)
                    End Try
                End If
            Case "gettransaction"
                Dim code = getQueryVar("code")
                Dim GUID = getQueryVar("GUID")
                sqlstr = "exec api.checkdata '" & curHostGUID & "','" & code & "', '" & GUID & "'"
                xmlstr = runSQLwithResult(sqlstr)


                If xmlstr.Contains("message") Then
                    Response.Write(xmlstr)
                Else
                    xmlstr = "<sqroot><transaction>" + xmlstr + "</transaction></sqroot>"
                    Response.Write(xmlstr)
                End If

            Case "checkdatatest"
                Dim code = getQueryVar("code")
                Dim GUID = getQueryVar("GUID")
                sqlstr = "exec api.checkdata '" & curHostGUID & "','" & code & "', '" & GUID & "'"
                xmlstr = runSQLwithResult(sqlstr)

                Dim cli = New WebClient()
                cli.Proxy = New WebProxy("10.112.20.80", 8080)
                cli.Headers(HttpRequestHeader.ContentType) = "application/json"
                cli.Headers(HttpRequestHeader.Accept) = "application/json"

                'Dim serverkey = "SB-Mid-server-Q8A5YgsHLF-DbCKaa9m9CHNA" 'liberty
                Dim serverkey = "SB-Mid-server-hKaSAFBUgsTTshZxn8PK2g1Q" 'sandbox
                'Dim serverkey = "Mid-server-Iyid57b2P0ckq2v60T8Dacf1"
                Dim username = serverkey
                Dim password = ""

                Dim base64Decoded As String = username + ":" + password
                Dim base64Encoded As String

                Dim data As Byte()
                data = System.Text.ASCIIEncoding.ASCII.GetBytes(base64Decoded)
                base64Encoded = System.Convert.ToBase64String(data)

                cli.Headers(HttpRequestHeader.Authorization) = String.Format("Basic {0}", base64Encoded)
                cli.Encoding = Encoding.UTF8

                Dim json = xmlstr
                'System.Net.ServicePointManager.SecurityProtocol = SecurityProtocolType.Ssl3
                'json = "{'transaction_details':  {'order_id': '0000001','gross_amount': 490000}}" 'simple json
                If xmlstr.Contains("message") Then
                    Response.Write(xmlstr)
                Else

                    Dim postarray As Byte() = Encoding.ASCII.GetBytes(json)
                    Try
                        Dim responseArray As Byte() = cli.UploadData("https://app.sandbox.midtrans.com/snap/v1/transactions", postarray) 'sandbox
                        Dim jsonResp As String = Encoding.ASCII.GetString(responseArray)
                        Dim ser As JObject = JObject.Parse(jsonResp)
                        Dim jsonRespdata As List(Of JToken) = ser.Children().ToList
                        Dim output As String = ""
                        Dim Token As String = ""
                        Dim RedirectURL As String = ""
                        For Each item As JProperty In jsonRespdata
                            item.CreateReader()
                            Select Case item.Name
                                Case "token"
                                    Token = item.Value
                                Case "redirect_url"
                                    RedirectURL = item.Value
                                    'output += "Comments:" + vbCrLf
                                    'For Each comment As JObject In item.Values
                                    '    Dim u As String = comment("user")
                                    '    Dim d As String = comment("date")
                                    '    Dim c As String = comment("comment")
                                    '    output += u + vbTab + d + vbTab + c + vbCrLf
                                    'Next



                            End Select
                        Next
                        xmlstr = "<sqroot><newurl>" + RedirectURL + "</newurl><token>" + Token + "</token><transaction>" + xmlstr + "</transaction></sqroot>"
                        Response.Write(xmlstr)

                    Catch exp As Exception
                        xmlstr = "<sqroot><message>" & exp.Message & "</message></sqroot>"
                        Response.Write(xmlstr)
                    End Try
                End If
            Case "verify"
                Response.Write("Continue")
            Case "unfinish"
                Response.Write("transaction Unfinished")
            Case "finish"
                'https://operahouse.systems/ophCore/api/midtrans.aspx?mode=finish&order_id=B052EEFC-B476-4C33-AE5A-1C86C6DD7590&status_code=200&transaction_status=capture
                Dim GUID = getQueryVar("order_id")
                Dim statuscode = getQueryVar("status_code")

                If statuscode = 200 Then 'success
                    'Dim savexml = "<sqroot><field id='PCSOGUID'><value>" & GUID & "</value></field></sqroot>"
                    'sqlstr = "exec doc.after_midtrans '" & curHostGUID & "','" & GUID & "', '" & savexml & "'"
                    sqlstr = "exec doc.after_midtrans '" & curHostGUID & "','" & GUID & "'"


                    xmlstr = runSQLwithResult(sqlstr)
                    setCookie("cartID", "", 0)
                    If xmlstr.Contains("success") Then
                        Response.Redirect("../../index.aspx?code=tapcs3")
                    Else
                        Dim urlx = "../../index.aspx?code=tapcs2&GUID=" & GUID
                        Response.Redirect(urlx)
                    End If
                ElseIf statuscode = 201 Then 'pending
                    Dim urlx = "../../index.aspx?code=tapcs3"
                    Response.Redirect(urlx)
                ElseIf statuscode >= 400 And statuscode <= 500 Then 'error
                    Dim urlx = "../../index.aspx?code=tapcs2&GUID=" & GUID
                    Response.Redirect(urlx)
                End If
                'Response.Write("transaction Finished")
            Case Else
                'Dim cli = New WebClient()
                'cli.Headers(HttpRequestHeader.ContentType) = "application/json"
                'cli.Headers(HttpRequestHeader.Accept) = "application/json"

                'Dim serverkey = "SB-Mid-server-Q8A5YgsHLF-DbCKaa9m9CHNA"
                'Dim username = serverkey
                'Dim password = '

                'Dim base64Decoded As String = username + ":" + password
                'Dim base64Encoded As String

                'Dim data As Byte()
                'data = System.Text.ASCIIEncoding.ASCII.GetBytes(base64Decoded)
                'base64Encoded = System.Convert.ToBase64String(data)

                'cli.Headers(HttpRequestHeader.Authorization) = String.Format("Basic {0}", base64Encoded)
                'cli.Encoding = Encoding.UTF8

                ''Dim json = <JSON>{"transaction_details": {"order_id": "ORDER-101","gross_amount": 10000}</JSON>.ToString

                'Dim json = "{'transaction_details':  {'order_id': 'ORDER-103','gross_amount': 490000}}" 'simple json
                ''Dim json = "{'transaction_details':  {'order_id': 'ORDER-103','gross_amount': 10000}, 'item_details': [{'id': 'ITEM1','price': 10000,'quantity': 1,'name': 'Midtrans Bear','brand': 'Midtrans','category': 'Toys','merchant_name': 'Midtrans'}],'item_details': [{'id': 'ITEM1','price': 10000,'quantity': 1,'name': 'Midtrans Bear','brand': 'Midtrans','category': 'Toys','merchant_name': 'Midtrans'}]}"
                ''Di Response As String = cli.UploadString("https://app.sandbox.midtrans.com/snap/v1/transactions", "POST", json)

                'Dim postarray As Byte() = Encoding.ASCII.GetBytes(json)
                'Try
                '    Dim responseArray As Byte() = cli.UploadData("https://app.sandbox.midtrans.com/snap/v1/transactions", postarray)
                '    Dim jsonResp As String = Encoding.ASCII.GetString(responseArray)
                '    Dim ser As JObject = JObject.Parse(jsonResp)
                '    Dim jsonRespdata As List(Of JToken) = ser.Children().ToList
                '    Dim output As String = '
                '    Dim Token As String = '
                '    Dim RedirectURL As String = '
                '    For Each item As JProperty In jsonRespdata
                '        item.CreateReader()
                '        Select Case item.Name
                '            Case "Token"
                '                Token = item.Value
                '            Case "redirect_url"
                '                RedirectURL = item.Value
                '                'output += "Comments:" + vbCrLf
                '                'For Each comment As JObject In item.Values
                '                '    Dim u As String = comment("user")
                '                '    Dim d As String = comment("date")
                '                '    Dim c As String = comment("comment")
                '                '    output += u + vbTab + d + vbTab + c + vbCrLf
                '                'Next



                '        End Select
                '    Next
                '    Response.Write(RedirectURL)
                'Catch exp As Exception
                '    Response.Write("Payment Error")


                'End Try




                'Console.WriteLine(ControlChars.Cr + "Response received was :{0}", Encoding.ASCII.GetString(responseArray))

                'Dim result() As String = Split(Encoding.ASCII.GetString(responseArray), ",")
                'Dim RedirectUrl = result(1).Replace('"redirect_url':", ')
                'RedirectUrl = RedirectUrl.Replace('', ')
                'RedirectUrl = RedirectUrl.Replace("}", ')

                'Response.Redirect(RedirectUrl)
                'Write(Response)
                'Dim baseAddress = "https://app.sandbox.midtrans.com/snap/v1/transactions"
                'Dim http As HttpWebRequest = WebRequest.Create((baseAddress))
                'http.Accept = "application/json"
                'http.ContentType = "application/json"
                'http.Method = "POST"

                ''Dim parsedContent = "{'transaction_details' {'order_id' 'ORDER-101','gross_amount': 10000}}"
                'Dim parsedContent = "{'transaction_details': {" &
                '                     " 'order_id': 'ORDER-101'," &
                '                     " 'gross_amount' 10000" &
                '                     " } }"

                'Dim Encoding = New ASCIIEncoding()
                'Dim bytes = Encoding.GetBytes(parsedContent)

                'Dim serverkey = "SB-Mid-server-Q8A5YgsHLF-DbCKaa9m9CHNA"
                'Dim username = serverkey
                'Dim password = '
                'Dim client = New WebClient()

                'client.Credentials = New NetworkCredential(username, password)

                'Dim credentials = Convert.ToBase64String(Encoding.GetBytes(username + ":" + password))
                'client.Headers(HttpRequestHeader.Authorization) = String.Format("Basic {0}", credentials)

                'Dim newStream = http.GetRequestStream()
                'newStream.Write(bytes, 0, bytes.Length)
                'newStream.Close()

                'Try
                '    Dim Response = http.GetResponse()
                'Catch exp As webException
                '    Dim sResponse As String = New StreamReader(exp.Response.getResponseStream()).ReadToEnd
                'End Try

                'Dim Response = http.GetResponse()
                'http.GetResponse()

                'Dim Stream = Response.GetResponseStream()
                'Dim sr = New StreamReader(Stream)
                'Dim Content = sr.ReadToEnd()
        End Select

    End Sub

End Class
