Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data

Public Class cl_master_base
    Inherits System.Web.UI.MasterPage

    Protected wordofHeadTitle As String = "Main"
    Protected wordofHeadLinkHRef As String = "OPHCore/styles/default.css"
    Protected wordofBodyContextMenu As String = ""

#Region "Properties Section"

    Public Property headTitle() As String
        Get
            Return wordofHeadTitle
        End Get
        Set(ByVal value As String)
            wordofHeadTitle = value
        End Set
    End Property
    Public Property headLinkHRef() As String
        Get
            Return wordofHeadLinkHRef
        End Get
        Set(ByVal value As String)
            wordofHeadLinkHRef = value
        End Set
    End Property
    Public Property BodyContextMenu() As String
        Get
            Return wordofBodyContextMenu
        End Get
        Set(ByVal value As String)
            If wordofBodyContextMenu = "" And value <> "" Then
                wordofBodyContextMenu = "javascript:" & value
            Else
                wordofBodyContextMenu = wordofBodyContextMenu & value
            End If
        End Set
    End Property
#End Region

End Class
