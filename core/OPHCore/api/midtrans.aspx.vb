Imports System.IO
Imports System.Net
Imports Newtonsoft.Json
Imports Newtonsoft.Json.Linq
Imports System.Xml


Partial Class OPHCore_API_midtrans

    Inherits cl_base_view

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        loadAccount()

        Dim curODBC = contentOfdbODBC
        Dim DBCore = contentOfsqDB
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
            Case "checkdata"
                Dim code = getQueryVar("code")
                Dim GUID = getQueryVar("GUID")
                sqlstr = "exec api.checkdata '" & curHostGUID & "','" & code & "', '" & GUID & "'"
                xmlstr = runSQLwithResult(sqlstr)

                Dim cli = New WebClient()
                cli.Headers(HttpRequestHeader.ContentType) = "application/json"
                cli.Headers(HttpRequestHeader.Accept) = "application/json"

                'Dim serverkey = "SB-Mid-server-Q8A5YgsHLF-DbCKaa9m9CHNA"
                Dim serverkey = "SB-Mid-server-hKaSAFBUgsTTshZxn8PK2g1Q"
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

                'Dim json = "{""transaction_details"":  {""order_id"": ""ORDER-103"",""gross_amount"": 490000}}" 'simple json
                'Dim json = "{""transaction_details"":  {""order_id"": ""ORDER-103"",""gross_amount"": 10000}, ""item_details"": [{""id"": ""ITEM1"",""price"": 10000,""quantity"": 1,""name"": ""Midtrans Bear"",""brand"": ""Midtrans"",""category"": ""Toys"",""merchant_name"": ""Midtrans""}],""item_details"": [{""id"": ""ITEM1"",""price"": 10000,""quantity"": 1,""name"": ""Midtrans Bear"",""brand"": ""Midtrans"",""category"": ""Toys"",""merchant_name"": ""Midtrans""}]}"
                'Di Response As String = cli.UploadString("https://app.sandbox.midtrans.com/snap/v1/transactions", "POST", json)

                Dim postarray As Byte() = Encoding.ASCII.GetBytes(json)
                Try
                    Dim responseArray As Byte() = cli.UploadData("https://app.sandbox.midtrans.com/snap/v1/transactions", postarray)
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
                                'output += "Comments:" + vbCrLf
                                'For Each comment As JObject In item.Values
                                '    Dim u As String = comment("user")
                                '    Dim d As String = comment("date")
                                '    Dim c As String = comment("comment")
                                '    output += u + vbTab + d + vbTab + c + vbCrLf
                                'Next



                        End Select
                    Next
                    xmlstr = "<sqroot><newurl>" + RedirectURL + "</newurl></sqroot>"
                    Response.Write(xmlstr)

                Catch exp As Exception
                    xmlstr = "<sqroot><message>Payment is Under Maintenance</message></sqroot>"
                    'Response.Write("Payment Error")


                End Try
            Case "verify"
                Response.Write("Continue")
            Case "unfinish"
                Response.Write("transaction Unfinished")
            Case "finish"
                'https://operahouse.systems/ophCore/api/midtrans.aspx?mode=finish&order_id=B052EEFC-B476-4C33-AE5A-1C86C6DD7590&status_code=200&transaction_status=capture
                Dim GUID = getQueryVar("order_id")
                Dim statuscode = getQueryVar("status_code")

                If statuscode = 200 Then 'success
                    Dim savexml = "<sqroot><field id=""PCSOGUID""><value>" & GUID & "</value></field></sqroot>"
                    sqlstr = "exec doc.after_midtrans '" & curHostGUID & "','" & GUID & "', '" & savexml & "'"

                    xmlstr = runSQLwithResult(sqlstr)

                    If xmlstr.Contains("success") Then
                        Response.Redirect("../../index.aspx?code=tapcs3")
                    Else
                        Response.Write("GAGAL")
                    End If
                ElseIf statuscode = 201 Then 'pending

                ElseIf statuscode >= 400 And statuscode <= 500 Then 'error
                    Dim urlx = "index.aspx?code=tapcs2&GUID=" & GUID
                    Response.Redirect(urlx)
                End If
                'Response.Write("transaction Finished")
            Case Else
                'Dim cli = New WebClient()
                'cli.Headers(HttpRequestHeader.ContentType) = "application/json"
                'cli.Headers(HttpRequestHeader.Accept) = "application/json"

                'Dim serverkey = "SB-Mid-server-Q8A5YgsHLF-DbCKaa9m9CHNA"
                'Dim username = serverkey
                'Dim password = ""

                'Dim base64Decoded As String = username + ":" + password
                'Dim base64Encoded As String

                'Dim data As Byte()
                'data = System.Text.ASCIIEncoding.ASCII.GetBytes(base64Decoded)
                'base64Encoded = System.Convert.ToBase64String(data)

                'cli.Headers(HttpRequestHeader.Authorization) = String.Format("Basic {0}", base64Encoded)
                'cli.Encoding = Encoding.UTF8

                ''Dim json = <JSON>{"transaction_details": {"order_id": "ORDER-101","gross_amount": 10000}</JSON>.ToString

                'Dim json = "{""transaction_details"":  {""order_id"": ""ORDER-103"",""gross_amount"": 490000}}" 'simple json
                ''Dim json = "{""transaction_details"":  {""order_id"": ""ORDER-103"",""gross_amount"": 10000}, ""item_details"": [{""id"": ""ITEM1"",""price"": 10000,""quantity"": 1,""name"": ""Midtrans Bear"",""brand"": ""Midtrans"",""category"": ""Toys"",""merchant_name"": ""Midtrans""}],""item_details"": [{""id"": ""ITEM1"",""price"": 10000,""quantity"": 1,""name"": ""Midtrans Bear"",""brand"": ""Midtrans"",""category"": ""Toys"",""merchant_name"": ""Midtrans""}]}"
                ''Di Response As String = cli.UploadString("https://app.sandbox.midtrans.com/snap/v1/transactions", "POST", json)

                'Dim postarray As Byte() = Encoding.ASCII.GetBytes(json)
                'Try
                '    Dim responseArray As Byte() = cli.UploadData("https://app.sandbox.midtrans.com/snap/v1/transactions", postarray)
                '    Dim jsonResp As String = Encoding.ASCII.GetString(responseArray)
                '    Dim ser As JObject = JObject.Parse(jsonResp)
                '    Dim jsonRespdata As List(Of JToken) = ser.Children().ToList
                '    Dim output As String = ""
                '    Dim Token As String = ""
                '    Dim RedirectURL As String = ""
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
                'Dim RedirectUrl = result(1).Replace("""redirect_url"":", "")
                'RedirectUrl = RedirectUrl.Replace("""", "")
                'RedirectUrl = RedirectUrl.Replace("}", "")

                'Response.Redirect(RedirectUrl)
                'Write(Response)
                'Dim baseAddress = "https://app.sandbox.midtrans.com/snap/v1/transactions"
                'Dim http As HttpWebRequest = WebRequest.Create((baseAddress))
                'http.Accept = "application/json"
                'http.ContentType = "application/json"
                'http.Method = "POST"

                ''Dim parsedContent = "{""transaction_details"" {""order_id"" ""ORDER-101"",""gross_amount"": 10000}}"
                'Dim parsedContent = "{'transaction_details': {" &
                '                     " 'order_id': 'ORDER-101'," &
                '                     " 'gross_amount' 10000" &
                '                     " } }"

                'Dim Encoding = New ASCIIEncoding()
                'Dim bytes = Encoding.GetBytes(parsedContent)

                'Dim serverkey = "SB-Mid-server-Q8A5YgsHLF-DbCKaa9m9CHNA"
                'Dim username = serverkey
                'Dim password = ""
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
