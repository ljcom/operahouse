Imports System.IO

Partial Class OPHCore_api_loadTheme
    Inherits cl_base

    Private Sub OPH_welcome_default_xml_tableview_Load(sender As Object, e As EventArgs) Handles Me.Load
        loadAccount()
        Dim doc = ""
        Dim theme = getQueryVar("theme")
        Dim page = getQueryVar("page")

        Dim themeFile As String = Server.MapPath("~/OPHContent/themes/") & theme & "\xslt\" & page & ".xslt"

        If File.Exists(themeFile) Then
            Dim document As XDocument = XDocument.Load(themeFile)
            doc = document.ToString()

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

        End If

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
