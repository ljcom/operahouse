Imports System.IO

Partial Class OPHCore_api_loadTheme
    Inherits cl_base

    Private Sub OPH_welcome_default_xml_tableview_Load(sender As Object, e As EventArgs) Handles Me.Load

        Dim doc = ""

        Dim theme = getQueryVar("theme")
        Dim page = getQueryVar("page")
        Dim code = getQueryVar("code")
        Dim guid = getQueryVar("guid")


        'If Session(code.ToLower()) = "" Then
        'loadAccount()
        'End If

        Dim curHostGUID = getSession() 'Session("hostGUID")
        If curHostGUID = "" Then loadAccount()

        'contentOfdbODBC = Session("odbc")
        'contentOfsqDB = Session("sqDB")

        Dim quick = False
        'System.Web.HttpRuntime.CodegenDir' //asp.net temp folder
        Dim time = Now().ToString("yyMMddHH")
        Dim themetemp As String = Server.MapPath("~/OPHContent/documents/") & "\temp\" & theme & "_" & page & "_" & time & ".xslt"
        If File.Exists(themetemp) Then

            Try
                Dim document As XDocument = XDocument.Load(themetemp)
                doc = document.ToString()
                quick = True
            Catch ex As Exception

            End Try


        End If

        If Not quick Then
            Dim themeFile As String = Server.MapPath("~/OPHContent/themes/") & theme & "\xslt\" & page & ".xslt"

            If File.Exists(themeFile) Then
                Dim document As XDocument = XDocument.Load(themeFile)
                doc = document.ToString()

                'If Not quick Then
                doc = doc.Replace("<xsl:variable name=""queryGuid""/>", "<xsl:variable name='queryGuid'>" & guid & "</xsl:variable>")
                doc = doc.Replace("<xsl:variable name=""queryCode""/>", "<xsl:variable name='queryCode'>" & code & "</xsl:variable>")
                doc = doc.Replace("<xsl:variable name=""queryPage""/>", "<xsl:variable name='queryPage'>" & page & "</xsl:variable>")
                doc = doc.Replace("<xsl:variable name=""queryTheme""/>", "<xsl:variable name='queryTheme'>" & theme & "</xsl:variable>")

                While doc.Contains("<xsl:include href=""")
                    Dim n = doc.IndexOf("<xsl:include href=")
                    Dim includestr = doc.Substring(n + 19, doc.Length - n - 19)
                    Dim m = includestr.IndexOf(""" />")
                    includestr = includestr.Substring(0, m)

                    Dim themeFile1 As String = Server.MapPath("~/OPHContent/themes/") & theme & "\xslt\" & includestr

                    Dim doc1 = ""
                    If File.Exists(themeFile1) Then
                        Dim document1 As XDocument = XDocument.Load(themeFile1)
                        doc1 = removeElement(document1.ToString, "stylesheet")
                    End If
                    doc = doc.Replace("<xsl:include href=""" & includestr & """ />", doc1)

                End While
                'End If

            End If
        End If
        'If Not quick Then
        'scripts
        Dim js = ""

        Dim sqlstr = "select infovalue from modlinfo i inner join modl m on m.moduleguid=i.moduleguid where m.moduleid='" & code & "' and i.infokey='js_savebefore'"
        js = runSQLwithResult(sqlstr).Replace("js_", code.ToLower() & "_")

        If js <> "" Then doc = doc.Replace("function <xsl:value-of select=""$lowerCode"" />_savebefore(d) {}", js)
        'writeLog(doc.indexOf("function <xsl:value-of select=""$lowerCode"" />_savebefore(d) {}"))
        'writeLog(js)

        sqlstr = "select infovalue from modlinfo i inner join modl m on m.moduleguid=i.moduleguid where m.moduleid='" & code & "' and i.infokey='js_saveafter'"
        js = runSQLwithResult(sqlstr).Replace("js_", code.ToLower() & "_")

        If js <> "" Then doc = doc.Replace("function <xsl:value-of select=""$lowerCode"" />_saveafter(d) {}", js)
        'writeLog(doc.indexOf("function <xsl:value-of select=""$lowerCode"" />_saveafter(d) {}"))
        'writeLog(js)

        sqlstr = "select infovalue from modlinfo i inner join modl m on m.moduleguid=i.moduleguid where m.moduleid='" & code & "' and i.infokey='js_custom'"
        js = runSQLwithResult(sqlstr).Replace("js_", code.ToLower() & "_")

        If js <> "" Then doc = doc.Replace("function <xsl:value-of select=""$lowerCode"" />_custom(d) {}", js)
        'writeLog(doc.indexOf("function <xsl:value-of select=""$lowerCode"" />_saveafter(d) {}"))
        'writeLog(js)
        'End If

        'insert gpskey
        '##gpskey##
        Dim gpskey = runSQLwithResult("select infovalue from acctinfo where infokey='gpskey'")
        If gpskey <> "" Then doc = doc.Replace("##gpskey##", gpskey)


		'insert recaptchakey
		'##recaptchakey##
		Dim recaptchakey=runSQLwithResult("select infovalue from acctinfo where infokey='recaptchakey'")
		If recaptchakey <> "" Then doc = doc.Replace("##recaptchakey##", recaptchakey)

		'insert gsigninclientid
		'##gsigninclientid##
		Dim gsigninclientid=runSQLwithResult("select infovalue from acctinfo where infokey='gsigninclientid'")
		If gsigninclientid <> "" Then doc = doc.Replace("##gsigninclientid##", gsigninclientid)

        'save
        If Not System.IO.File.Exists(themetemp) = True Then
            Dim file As System.IO.FileStream
            Try 
				file = System.IO.File.Create(themetemp)
				file.Close()
				My.Computer.FileSystem.WriteAllText(themetemp, doc, False)															 
            Catch ex As Exception

            End Try
        End If





        'flush the result

        Response.ContentType = "text/xml"
        Response.Write("<?xml version=""1.0"" encoding=""utf-8""?>")
        If doc <> "" Then Response.Write(doc)

    End Sub

    Function removeElement(doc As String, el As String) As String
        If doc.Contains("<xsl:" & el) Then
            Dim n = doc.IndexOf("<xsl:" & el)
            Dim doc1 = doc.Substring(n, doc.Length - n)
            Dim m = doc1.IndexOf(">")
            doc = doc.Substring(m + 2, doc.Length - m - 2)
        End If
        If doc.Contains("</xsl:" & el & ">") Then
            Dim n2 = doc.IndexOf("</xsl:" & el & ">")
            doc = doc.Substring(0, n2)
        End If
        Return doc
    End Function
End Class
