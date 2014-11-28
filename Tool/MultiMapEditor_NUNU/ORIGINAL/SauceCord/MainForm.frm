VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.MDIForm MainForm 
   BackColor       =   &H8000000C&
   Caption         =   "MultiMapEditor"
   ClientHeight    =   5670
   ClientLeft      =   3825
   ClientTop       =   2910
   ClientWidth     =   8385
   Icon            =   "MainForm.frx":0000
   LinkTopic       =   "MDIForm1"
   Begin MSComctlLib.ImageList Image1 
      Left            =   840
      Top             =   900
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   3
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MainForm.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MainForm.frx":042A
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MainForm.frx":054A
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Timer Timer1 
      Interval        =   10
      Left            =   1500
      Top             =   1140
   End
   Begin MSComDlg.CommonDialog CommonDialog1 
      Left            =   1440
      Top             =   660
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin MSComctlLib.Toolbar Top_bar 
      Align           =   1  '上揃え
      Height          =   615
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   8385
      _ExtentX        =   14790
      _ExtentY        =   1085
      ButtonWidth     =   1482
      ButtonHeight    =   926
      Appearance      =   1
      ImageList       =   "Image1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   6
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "NewMap"
            Key             =   "New"
            Object.ToolTipText     =   "新しい編集データを作成する"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "ChipOpen"
            Key             =   "Chip"
            Object.ToolTipText     =   "編集中のマップのチップを選択する"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "MapOpen"
            Key             =   "Map"
            Object.ToolTipText     =   "編集中のマップを既存マップと交換する"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "MapSave"
            Key             =   "Save"
            Object.ToolTipText     =   "マップを上書き保存する"
            ImageIndex      =   3
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.StatusBar StatusBar 
      Align           =   2  '下揃え
      Height          =   315
      Left            =   0
      TabIndex        =   1
      Top             =   5355
      Width           =   8385
      _ExtentX        =   14790
      _ExtentY        =   556
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   3
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   9234
         EndProperty
         BeginProperty Panel2 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   6
            Alignment       =   1
            TextSave        =   "2011/05/21"
         EndProperty
         BeginProperty Panel3 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   5
            Alignment       =   1
            TextSave        =   "22:40"
         EndProperty
      EndProperty
   End
   Begin VB.PictureBox Left_Bar 
      Align           =   4  '右揃え
      Height          =   4740
      Left            =   6195
      ScaleHeight     =   312
      ScaleMode       =   3  'ﾋﾟｸｾﾙ
      ScaleWidth      =   142
      TabIndex        =   0
      Top             =   615
      Width           =   2190
      Begin VB.PictureBox ShowChip 
         AutoRedraw      =   -1  'True
         BackColor       =   &H80000007&
         BorderStyle     =   0  'なし
         Height          =   435
         Left            =   240
         ScaleHeight     =   29
         ScaleMode       =   3  'ﾋﾟｸｾﾙ
         ScaleWidth      =   29
         TabIndex        =   4
         Top             =   60
         Width           =   435
      End
      Begin VB.VScrollBar ChipBar 
         Height          =   615
         Left            =   0
         TabIndex        =   3
         Top             =   60
         Width           =   255
      End
   End
   Begin VB.Menu Menu000 
      Caption         =   "ﾌｧｲﾙ(&F)"
      Begin VB.Menu Menu001 
         Caption         =   "新しくマップを作成する"
      End
      Begin VB.Menu Menu002 
         Caption         =   "既存マップを開く"
      End
      Begin VB.Menu Menu003 
         Caption         =   "-"
      End
      Begin VB.Menu Menu004 
         Caption         =   "ﾏｯﾌﾟﾁｯﾌﾟの読込み"
      End
      Begin VB.Menu Menu005 
         Caption         =   "ﾏｯﾌﾟﾃﾞｰﾀの読込み"
      End
      Begin VB.Menu Menu006 
         Caption         =   "-"
      End
      Begin VB.Menu Menu007 
         Caption         =   "名前を付けて保存"
      End
   End
   Begin VB.Menu Menu100 
      Caption         =   "ﾏｯﾌﾟｻｲｽﾞ"
      Begin VB.Menu Menu101 
         Caption         =   "256×256"
         Index           =   1
      End
      Begin VB.Menu Menu101 
         Caption         =   "128×128"
         Index           =   2
      End
      Begin VB.Menu Menu101 
         Caption         =   "64×64"
         Index           =   3
      End
   End
   Begin VB.Menu Menu200 
      Caption         =   "ｳｨﾝﾄﾞｳ(&W)"
      WindowList      =   -1  'True
      Begin VB.Menu Menu201 
         Caption         =   "重ねて表示"
      End
      Begin VB.Menu Menu202 
         Caption         =   "並べて表示"
      End
   End
End
Attribute VB_Name = "MainForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'マルチマップエディター

Option Explicit

'現在開いているチャイルドウィンドウの数
Public FormCounter As Long

Private Sub ChipBar_Change()
    
    ShowChip.Top = ChipBar.Value * 32 * -1
    
End Sub

Private Sub Left_Bar_Resize()
    
    ChipReSize
    
End Sub

Private Sub MDIForm_Load()
'ＭＤＩフォームロードイベント

    '各コントロールの初期処理
    ChipReSize
    'コモンダイアログのキャンセル時にエラーとする
    CommonDialog1.CancelError = True
    
    '初期表示位置を画面上のセンターへ移動
    If WindowState = 0 Then
        Move (Screen.Width - Me.Width) / 2, (Screen.Height - Me.Height) / 2
    End If

    Me.Caption = Me.Caption & Space(2) & "Version1.0"

    'ツールバーを表示する
    Load ToolForm
    ToolForm.Show , Me
    
    'ツールバーの一部を無効にする
    With Top_bar
        .Buttons("Chip").Enabled = False
        .Buttons("Map").Enabled = False
        .Buttons("Save").Enabled = False
    End With
    MenuFalse
        
End Sub

Private Sub ChipReSize()
'フォーム上のコントロールのサイズ変更

    Left_Bar.Width = (20 + 32 * 4) * Screen.TwipsPerPixelX
    
    'チップ用のスクロールバーのサイズ変更
    With ChipBar
        .Top = 0
        .Left = 0
        .Height = Left_Bar.ScaleHeight
        .Width = 16
        .Max = ((32 * 64) - Left_Bar.ScaleHeight) \ 32
    End With
    
    'チップ用のピクチャボックスのサイズ変更
    With ShowChip
        .Top = 0
        .Left = ChipBar.Width
        .Width = 32 * 4
        .Height = 32 * 64
    End With
    
End Sub
Public Sub MenuTrue()
'編集中のフォームが無いと実効出来ないコントロールの有効化

    'メニュー部の有効化
    Menu004.Enabled = True
    Menu005.Enabled = True
    Menu007.Enabled = True
    Menu100.Enabled = True
    Menu200.Enabled = True
    
    'ツールボックスの有効化
    With ToolForm.Tool1
        .Buttons("Cursor").Enabled = True
        .Buttons("Pen").Enabled = True
        .Buttons("Syringe").Enabled = True
        .Buttons("Paint").Enabled = True
    End With
    
End Sub
Public Sub MenuFalse()
'編集中のフォームが無いと実効出来ないコントロールの無効
      
    'メニュー部の無効化
    Menu004.Enabled = False
    Menu005.Enabled = False
    Menu007.Enabled = False
    Menu100.Enabled = False
    Menu200.Enabled = False

    'ツールボックスの無効化
    With ToolForm.Tool1
        .Buttons("Cursor").Enabled = False
        .Buttons("Pen").Enabled = False
        .Buttons("Syringe").Enabled = False
        .Buttons("Paint").Enabled = False
    
        .Buttons("Copy").Enabled = False
        .Buttons("Past").Enabled = False
    
        .Buttons("Undo").Enabled = False
        .Buttons("Redo").Enabled = False
    
        '選択ツールの初期化
        .Buttons("Cursor").Value = 0
        .Buttons("Pen").Value = 0
        .Buttons("Syringe").Value = 0
        .Buttons("Paint").Value = 0
    End With

End Sub
Public Function MapSave() As Boolean
'マップファイルの保存
    
    Dim OpenFile As String
    
    On Error Resume Next    'このルーチン内のエラーを無効にする。
    
    If ActiveForm.SaveFileName = "" Then
        CommonDialog1.FileName = ""
    Else
        CommonDialog1.FileName = ActiveForm.SaveFileName
    End If
    
    With CommonDialog1
        .DialogTitle = "名前を付けてファイルの保存"
        .Filter = "Pictures(*.Map)|*.Map"
        .Flags = &H2
        .ShowSave   '名前を付けて保存用のﾀﾞｲｱﾛｸﾞを開く
    End With
    
    DoEvents
        
    If Err <> cdlCancel Then    ' ﾕｰｻﾞｰが[ｷｬﾝｾﾙ]を選択しました。 32755=ｷｬﾝｾﾙｺｰﾄﾞ
        ActiveForm.MapSave CommonDialog1.FileName
        MapSave = True
    Else
        MapSave = False
    End If

End Function
Private Sub Menu001_Click()
'新しいチャイルドウィンドウを開く

    FormCounter = FormCounter + 1
    Dim MapForm As New Map
    MapForm.Tag = FormCounter
    MapForm.Show

End Sub

Private Sub Menu002_Click()
'新しいフォームを開いてマップを読込む
    
    Dim OpenFile As String

    On Error Resume Next    'このルーチン内のエラーを無効にする。
    With CommonDialog1
        .DialogTitle = "マップデータの読み込み"
        .FileName = ""
        .Filter = "Pictures(*.map)|*.MAP"
        .ShowOpen     'ﾌｧｲﾙｵｰﾌﾟﾝ用のﾀﾞｲｱﾛｸﾞを開く
    End With
    
    DoEvents
        
    If Err <> cdlCancel Then    ' ﾕｰｻﾞｰが[ｷｬﾝｾﾙ]を選択しました。 32755=ｷｬﾝｾﾙｺｰﾄﾞ

        FormCounter = FormCounter + 1
        Dim MapForm As New Map
        MapForm.Tag = FormCounter
        MapForm.Show
        ActiveForm.MapLoad CommonDialog1.FileName
                
    End If

    '既存のマップを開いた場合、引き続きマップチップの選択も行う
    Menu004_Click
    ActiveForm.ChipBarShow

End Sub

Public Sub Menu004_Click()
'マップチップの読み込み

    Dim OpenFile As String
    On Error Resume Next    'このルーチン内のエラーを無効にする。

    With CommonDialog1
        .DialogTitle = "パターングラフィックの選択"
        .FileName = ""
        .Filter = "Pictures(*.bmp;*.gif)|*.bmp;*.gif"
        .ShowOpen   'ﾌｧｲﾙｵｰﾌﾟﾝ用のﾀﾞｲｱﾛｸﾞを開く
    End With
    
    DoEvents
        
    If Err <> cdlCancel Then    ' ﾕｰｻﾞｰが[ｷｬﾝｾﾙ]を選択しました。 32755=ｷｬﾝｾﾙｺｰﾄﾞ
        ActiveForm.ChipLoad CommonDialog1.FileName
    End If

End Sub
Public Sub Menu005_Click()
'マップファイルを選択して読込む
    
    Dim OpenFile As String

    On Error Resume Next    'このルーチン内のエラーを無効にする。
    With CommonDialog1
        .DialogTitle = "マップデータの読み込み"
        .FileName = ""
        .Filter = "Pictures(*.map)|*.MAP"
        .ShowOpen   'ﾌｧｲﾙｵｰﾌﾟﾝ用のﾀﾞｲｱﾛｸﾞを開く
    End With
    
    DoEvents
        
    If Err <> cdlCancel Then    ' ﾕｰｻﾞｰが[ｷｬﾝｾﾙ]を選択しました。 32755=ｷｬﾝｾﾙｺｰﾄﾞ
        ActiveForm.MapLoad CommonDialog1.FileName
        'マップを読み直したので変更記憶をクリアする
        ActiveForm.DataChanged = False
    End If

End Sub
Public Sub Menu007_Click()
'マップファイルの保存
    
    Dim Ret As Boolean
    Ret = MapSave

End Sub

Private Sub Menu101_Click(Index As Integer)
'マップサイズの変更メニュー

    Dim I As Long
    
    '状態の変更があるかどうかをチェック
    If Menu101(Index).Checked = True Then Exit Sub
    
    'メッセージボックスにて確認を表示
    If MsgBox("マップサイズの変更を行いますか？", vbOKCancel, "マップサイズの変更") <> 1 Then
        Exit Sub
    End If
    
    'すべてのチェックを非表示にする
    For I = 1 To 3
        Menu101(I).Checked = False
    Next I
    '選択されたメニューのチェックを表示にする
    Menu101(Index).Checked = True
    
    '選択されたメニューに従ってマップサイズの変更を行う
    ActiveForm.ChangeMapSize Index
    
End Sub
Private Sub Menu201_Click()
'現在のウィンドウを重ねて整理

    Arrange vbCascade

End Sub

Private Sub Menu202_Click()
'現在のウィンドウを並べて整理
    
    Arrange vbTileVertical

End Sub


Private Sub ShowChip_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
'マップチップの選択

    '編集中のフォームがあるかどうかをチェック
    If FormCounter <> 0 Then
    
        '左ボタンが押された場合の処理
        If Button = 1 Then
            Me.ActiveForm.LeftNo = (X \ 32) + ((Y \ 32) * 4)
        End If
        '右ボタンが押された場合の処理
        If Button = 2 Then
            Me.ActiveForm.RightNo = (X \ 32) + ((Y \ 32) * 4)
        End If
        Me.ActiveForm.ChipBarShow
        
        If ToolForm.Tool1.Buttons("Pen").Value = tbrUnpressed And ToolForm.Tool1.Buttons("Paint").Value = tbrUnpressed Then
            ToolForm.Tool1.Buttons("Pen").Value = tbrPressed
            MainForm.ActiveForm.Tool = "Pen"
            ToolForm.Tool1.Buttons("Past").Enabled = False
            ToolForm.Tool1.Buttons("Copy").Enabled = False
            MainForm.ActiveForm.LeftDraw = 0
            MainForm.ActiveForm.RightDraw = 0
            MainForm.ActiveForm.MapShow
        End If
    
    End If

End Sub

Private Sub Timer1_Timer()
'タイマー割り込みにてマップのスクロールを行う

    If FormCounter <> 0 Then
        
        'Me.ActiveForm.Crt.SetFocus
        '右キーの処理
        If GetAsyncKeyState(vbKeyRight) Then
            Me.ActiveForm.X = (Me.ActiveForm.X + 1) And Me.ActiveForm.MapSize
            Me.ActiveForm.MapShow
            Me.ActiveForm.X_Scroll.Value = Me.ActiveForm.X
            Me.ActiveForm.Y_Scroll.Value = Me.ActiveForm.Y
        End If
        
        '左キーの処理
        If GetAsyncKeyState(vbKeyLeft) Then
            Me.ActiveForm.X = (Me.ActiveForm.X - 1) And Me.ActiveForm.MapSize
            Me.ActiveForm.MapShow
            Me.ActiveForm.X_Scroll.Value = Me.ActiveForm.X
            Me.ActiveForm.Y_Scroll.Value = Me.ActiveForm.Y
        End If
        
        '上キーの処理
        If GetAsyncKeyState(vbKeyUp) Then
            Me.ActiveForm.Y = (Me.ActiveForm.Y - 1) And Me.ActiveForm.MapSize
            Me.ActiveForm.MapShow
            Me.ActiveForm.X_Scroll.Value = Me.ActiveForm.X
            Me.ActiveForm.Y_Scroll.Value = Me.ActiveForm.Y
        End If
        
        '下キーの処理
        If GetAsyncKeyState(vbKeyDown) Then
            Me.ActiveForm.Y = (Me.ActiveForm.Y + 1) And Me.ActiveForm.MapSize
            Me.ActiveForm.MapShow
            Me.ActiveForm.X_Scroll.Value = Me.ActiveForm.X
            Me.ActiveForm.Y_Scroll.Value = Me.ActiveForm.Y
        End If

    End If

End Sub

Private Sub Top_bar_ButtonClick(ByVal Button As MSComctlLib.Button)
'ツールバーの処理

    Select Case Button.Key
    
        Case "New"
            Menu001_Click
        Case "Chip"
            Menu004_Click
        Case "Map"
            Menu005_Click
        Case "Save"
            Menu007_Click
    
    End Select

End Sub
