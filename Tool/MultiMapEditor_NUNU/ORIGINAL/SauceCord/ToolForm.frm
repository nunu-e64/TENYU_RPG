VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form ToolForm 
   BorderStyle     =   4  '固定ﾂｰﾙ ｳｨﾝﾄﾞｳ
   Caption         =   "ToolBox"
   ClientHeight    =   2910
   ClientLeft      =   2190
   ClientTop       =   2580
   ClientWidth     =   1560
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   194
   ScaleMode       =   3  'ﾋﾟｸｾﾙ
   ScaleWidth      =   104
   ShowInTaskbar   =   0   'False
   Begin VB.Frame Frame1 
      Height          =   1395
      Left            =   60
      TabIndex        =   0
      Top             =   1500
      Width           =   675
      Begin VB.PictureBox RightPic 
         AutoRedraw      =   -1  'True
         BackColor       =   &H80000007&
         Height          =   540
         Left            =   60
         ScaleHeight     =   32
         ScaleMode       =   3  'ﾋﾟｸｾﾙ
         ScaleWidth      =   32
         TabIndex        =   2
         Top             =   780
         Width           =   540
      End
      Begin VB.PictureBox LeftPic 
         AutoRedraw      =   -1  'True
         BackColor       =   &H80000007&
         Height          =   540
         Left            =   60
         ScaleHeight     =   32
         ScaleMode       =   3  'ﾋﾟｸｾﾙ
         ScaleWidth      =   32
         TabIndex        =   1
         Top             =   180
         Width           =   540
      End
   End
   Begin MSComctlLib.ImageList Image01 
      Left            =   900
      Top             =   2220
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   8
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "ToolForm.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "ToolForm.frx":0118
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "ToolForm.frx":0230
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "ToolForm.frx":0344
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "ToolForm.frx":0458
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "ToolForm.frx":0570
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "ToolForm.frx":0684
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "ToolForm.frx":0798
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Tool1 
      Height          =   2040
      Left            =   60
      TabIndex        =   3
      Top             =   0
      Width           =   735
      _ExtentX        =   1296
      _ExtentY        =   3598
      ButtonWidth     =   609
      ButtonHeight    =   582
      ImageList       =   "Image01"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   10
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Cursor"
            Object.ToolTipText     =   "データの選択を行います"
            ImageIndex      =   1
            Style           =   2
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Pen"
            Object.ToolTipText     =   "選択されたマップチップを配置します"
            ImageIndex      =   2
            Style           =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Paint"
            Object.ToolTipText     =   "選択されたマップチップで塗り潰します"
            ImageIndex      =   3
            Style           =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Syringe"
            Object.ToolTipText     =   "マップ上のチップを抽出します"
            ImageIndex      =   4
            Style           =   2
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Copy"
            Object.ToolTipText     =   "選択されたデータをコピーします"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Past"
            Object.ToolTipText     =   "コピーしたデータを貼り付けます"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button9 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Undo"
            Object.ToolTipText     =   "編集を一つ前の状態にします"
            ImageIndex      =   7
         EndProperty
         BeginProperty Button10 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Redo"
            Object.ToolTipText     =   "アンドゥでやり直した作業を再度実行します"
            ImageIndex      =   8
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "ToolForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'マルチマップエディター

Option Explicit

Private Sub Form_Load()
    
    Me.Left = MainForm.Left
    Me.Top = MainForm.Top + Screen.TwipsPerPixelY * 100
    Me.Width = 59 * Screen.TwipsPerPixelX

End Sub

Private Sub Tool1_ButtonClick(ByVal Button As MSComctlLib.Button)

    '選択されたツール情報を編集中のフォームへ伝える
    Select Case Button.Key
        Case "Cursor"
            MainForm.ActiveForm.Tool = Button.Key
            Tool1.Buttons("Copy").Enabled = True
            MainForm.ActiveForm.Select_SX = MainForm.ActiveForm.X
            MainForm.ActiveForm.Select_SY = MainForm.ActiveForm.Y
            MainForm.ActiveForm.Select_EX = MainForm.ActiveForm.Select_SX
            MainForm.ActiveForm.Select_EY = MainForm.ActiveForm.Select_SY
        Case "Pen"
            MainForm.ActiveForm.Tool = Button.Key
            Tool1.Buttons("Past").Enabled = False
            Tool1.Buttons("Copy").Enabled = False
        Case "Paint"
            MainForm.ActiveForm.Tool = Button.Key
            Tool1.Buttons("Past").Enabled = False
            Tool1.Buttons("Copy").Enabled = False
        Case "Syringe"
            MainForm.ActiveForm.Tool = Button.Key
            Tool1.Buttons("Past").Enabled = False
            Tool1.Buttons("Copy").Enabled = False
        Case "Copy"
            MainForm.ActiveForm.MapCopy
            MainForm.ActiveForm.Select_EX = MainForm.ActiveForm.Select_SX
            MainForm.ActiveForm.Select_EY = MainForm.ActiveForm.Select_SY
            MainForm.ActiveForm.MapShow
            Tool1.Buttons("Past").Enabled = True
            Exit Sub
        Case "Past"
            MainForm.ActiveForm.UndoSet
            MainForm.ActiveForm.MapPast
            MainForm.ActiveForm.DataChanged = True
            Exit Sub
        Case "Undo"
            MainForm.ActiveForm.Undo
            Exit Sub
        Case "Redo"
            MainForm.ActiveForm.Redo
            Exit Sub
    End Select
    
    'ツールに依存する変数をクリアする
    MainForm.ActiveForm.LeftDraw = 0
    MainForm.ActiveForm.RightDraw = 0
    MainForm.ActiveForm.MapShow

End Sub
