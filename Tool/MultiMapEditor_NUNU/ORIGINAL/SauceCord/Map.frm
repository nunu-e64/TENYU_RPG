VERSION 5.00
Begin VB.Form Map 
   Caption         =   "Map [Sample.map] X:00 Y:00"
   ClientHeight    =   2610
   ClientLeft      =   6180
   ClientTop       =   4365
   ClientWidth     =   2760
   Icon            =   "Map.frx":0000
   LinkTopic       =   "Form1"
   MDIChild        =   -1  'True
   ScaleHeight     =   174
   ScaleMode       =   3  'ﾋﾟｸｾﾙ
   ScaleWidth      =   184
   Begin VB.PictureBox SelectPic 
      AutoRedraw      =   -1  'True
      BackColor       =   &H00FF0000&
      BorderStyle     =   0  'なし
      Height          =   480
      Left            =   0
      ScaleHeight     =   35.31
      ScaleMode       =   0  'ﾕｰｻﾞｰ
      ScaleWidth      =   32
      TabIndex        =   4
      Top             =   960
      Visible         =   0   'False
      Width           =   480
   End
   Begin VB.HScrollBar X_Scroll 
      CausesValidation=   0   'False
      Height          =   240
      Left            =   0
      TabIndex        =   3
      Top             =   1740
      Width           =   795
   End
   Begin VB.VScrollBar Y_Scroll 
      CausesValidation=   0   'False
      Height          =   975
      Left            =   2340
      TabIndex        =   2
      Top             =   0
      Width           =   240
   End
   Begin VB.PictureBox Chip 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BackColor       =   &H80000007&
      BorderStyle     =   0  'なし
      Height          =   435
      Left            =   0
      ScaleHeight     =   29
      ScaleMode       =   3  'ﾋﾟｸｾﾙ
      ScaleWidth      =   29
      TabIndex        =   1
      Top             =   480
      Visible         =   0   'False
      Width           =   435
   End
   Begin VB.PictureBox Crt 
      AutoRedraw      =   -1  'True
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   0  'なし
      Height          =   435
      Left            =   0
      ScaleHeight     =   29
      ScaleMode       =   3  'ﾋﾟｸｾﾙ
      ScaleWidth      =   29
      TabIndex        =   0
      Top             =   0
      Width           =   435
   End
End
Attribute VB_Name = "Map"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'マルチマップエディター

Option Explicit

'編集中のマップファイル名をタイトルとして格納する
Private Title As String

'表示しているマップ座標
Public X As Long, Y As Long

'データ範囲選択時のマップ座標
Public Select_SX As Integer, Select_SY As Integer
Public Select_EX As Integer, Select_EY As Integer

'マップを格納する変数
Private Map() As Byte
Private RedoMap() As Byte
Private UndoMap() As Byte
Public MapSize As Long

'編集中のマップ名保存用変数
Public SaveFileName As String

'チップ選択番号
Public LeftNo As Long
Public RightNo As Long
Public LeftDraw As Long
Public RightDraw As Long

'ツールの選択状態
Public Tool As String

'編集中のデータの状態（True 変更：False 未変更）
Public DataChanged As Boolean

Private Sub Crt_MouseDown(Button As Integer, Shift As Integer, MX As Single, MY As Single)
'マップの置き換え
    
    Dim Ret As Integer
    
    Select Case Tool
    
        Case "Pen"
            'チップ配置処理
            
            UndoSet

            '左ボタンの処理
            If Button = 1 Then
                Map((X + (MX \ 32)) And MapSize, (Y + (MY \ 32)) And MapSize) = LeftNo
                LeftDraw = 1
                RightDraw = 0
            End If
            If Button = 2 Then
                Map((X + (MX \ 32)) And MapSize, (Y + (MY \ 32)) And MapSize) = RightNo
                LeftDraw = 0
                RightDraw = 1
            End If
            'マップを再描画
            MapShow
            'データの変更を記憶する
            DataChanged = True
            
        Case "Syringe"
            'スポイト処理
            
            '左ボタンの処理
            If Button = 1 Then
                LeftNo = Map((X + (MX \ 32)) And MapSize, (Y + (MY \ 32)) And MapSize)
            End If
            '右ボタンの処理
            If Button = 2 Then
                RightNo = Map((X + (MX \ 32)) And MapSize, (Y + (MY \ 32)) And MapSize)
            End If
            '吸い出した番号で表示の変更
            ChipBarShow
            
        Case "Cursor"
            'データの選択処理
            
            LeftDraw = 1
            Select_SX = X + MX \ 32
            Select_SY = Y + MY \ 32
            Select_EX = Select_SX
            Select_EY = Select_SY
            MapShow
            SelectShow Select_SX, Select_SY, Select_EX, Select_EY
            
        Case "Paint"
            '塗り潰し処理
            Ret = MsgBox("選択されているチップで塗り潰します", vbOKCancel + vbQuestion, "MapEditor")
            If Ret = vbOK And Button = 1 Then
                UndoSet
                DataChanged = True
                MapPaint LeftNo
            End If
            If Ret = vbOK And Button = 2 Then
                UndoSet
                DataChanged = True
                MapPaint RightNo
            End If
    
    End Select

End Sub

Private Sub Crt_MouseMove(Button As Integer, Shift As Integer, MX As Single, MY As Single)
'マウスの移動時の処理

    Select Case Tool
    
        Case "Pen"
            '連続データ配置処理
            If LeftDraw = 1 And (Crt.Width > MX And Crt.Height > MY) Then
                Map((X + (MX \ 32)) And MapSize, (Y + (MY \ 32)) And MapSize) = LeftNo
                MapShow
            End If
            If RightDraw = 1 And (Crt.Width > MX And Crt.Height > MY) Then
                Map((X + (MX \ 32)) And MapSize, (Y + (MY \ 32)) And MapSize) = RightNo
                MapShow
            End If
            
        Case "Cursor"
            '選択範囲拡大処理
            If LeftDraw = 1 And (Crt.Width > MX And Crt.Height > MY) Then
                Select_EX = X + MX \ 32
                Select_EY = Y + MY \ 32
                MapShow
                SelectShow Select_SX, Select_SY, Select_EX, Select_EY
            End If

    End Select
    
End Sub

Private Sub Crt_MouseUp(Button As Integer, Shift As Integer, MX As Single, MY As Single)
'ボタンが離された場合の処理

    Select Case Tool
    
        Case "Pen", "Cursor"
            If Button = 1 Then
                LeftDraw = 0
            End If
            If Button = 2 Then
                RightDraw = 0
            End If
    End Select

End Sub


Private Sub Form_Activate()
'アクティブになった時にＭＤＩフォームのチップを切りかえる

    ChipBarShow
    ToolForm.Tool1.Buttons(Tool).Value = tbrPressed

End Sub

Private Sub Form_Load()
'マップ配置用フォームのロードイベント
        
    'マップサイズの設定
    MapSize = &HFF
    ReDim Map(0 To MapSize, 0 To MapSize) As Byte
    
    'マップ表示用のピクチャボックスの位置の初期化
    Crt.Top = 0
    Crt.Left = 0
    
    Chip.Width = 512
    Chip.Height = 512
    
    MapReSize
    
    X = 0: Y = 0
    Title = "NewMap(NoName)"

    'ツールバーの一部を有効にする
    With MainForm
        .Top_bar.Buttons("Chip").Enabled = True
        .Top_bar.Buttons("Map").Enabled = True
        .Top_bar.Buttons("Save").Enabled = True
    End With
    MainForm.MenuTrue
    
    X_Scroll.Max = MapSize
    Y_Scroll.Max = MapSize
    X_Scroll.Value = X
    Y_Scroll.Value = Y
    
    Tool = "Pen"
    
End Sub

Private Sub MapReSize()
'フォームサイズにピクチャボックスのサイズを合わせる

    On Error Resume Next    'このルーチン内のエラーを無効にする。

    'マップ表示用のピクチャボックスのサイズ調整
    Crt.Width = Me.ScaleWidth - 16
    Crt.Height = Me.ScaleHeight - 16
    
    'スクロールバーのサイズ調整
    Y_Scroll.Top = 0
    Y_Scroll.Left = Me.ScaleWidth - 16
    Y_Scroll.Height = Me.ScaleHeight - 16
    
    X_Scroll.Top = Me.ScaleHeight - 16
    X_Scroll.Left = 0
    X_Scroll.Width = Me.ScaleWidth - 16

    MapShow
    
    
End Sub

Private Sub Form_Resize()
'フォームの大きさを変更された場合の処理

    MapReSize
    
End Sub

Private Sub Form_Unload(Cancel As Integer)
'ウィンドウを閉じる時の処理

    Dim Ret As Integer
    
    If DataChanged = True Then
        
        Ret = MsgBox("編集中のデータは変更されています。" & vbCrLf & "データを保存しますか？", vbYesNoCancel + vbExclamation, "MapEditor")
        Select Case Ret
            'キャンセルボタンなら終了を取りやめる
            Case vbCancel
                Cancel = True
                Exit Sub
            'ＯＫならファイルセーブルーチンを実行、但しそこでキャンセルされたらやはり終了はしない
            Case vbOK
                If MainForm.MapSave = False Then
                    Cancel = True
                    Exit Sub
                End If
        End Select
    End If

    '開いているフォームの数を減らす
    MainForm.FormCounter = MainForm.FormCounter - 1

    'フォームに付随するチップの表示などをクリアする
    MainForm.ShowChip.Cls
    ToolForm.LeftPic.Cls
    ToolForm.RightPic.Cls
    
    '今閉じたフォームが最後かどうか調べる
    If MainForm.FormCounter = 0 Then
    
        'ツールバーの一部を無効にする
        With MainForm.Top_bar
            .Buttons("Chip").Enabled = False
            .Buttons("Map").Enabled = False
            .Buttons("Save").Enabled = False
        End With
        MainForm.MenuFalse
        
    End If
    
End Sub

Public Sub ChipLoad(FileName As String)
'指定されたファイル名でマップチップをロードする
        
    Chip.Picture = LoadPicture(FileName)
    ChipBarShow
    MapShow

End Sub
Public Sub MapLoad(FileName As String)
'指定されたファイル名でマップをロードする

    'ＦＩＬＥをバイナリ－モードでオープンしてそのまま変数に読み込む
    Open FileName For Binary Access Read As 1
        Get #1, , Map
    Close #1
    SaveFileName = FileName
    Title = FileName
    MapShow

End Sub
Public Sub MapSave(FileName As String)

    'ＦＩＬＥをバイナリ－モードでオープンして変数をそのまま書込む
    Open FileName For Binary Access Write As #1
        Put #1, , Map
    Close #1
    SaveFileName = FileName
    Title = FileName
    
    'マップの再描画
    MapShow
    'データ変更記憶をクリア
    DataChanged = False

End Sub
Public Sub ChangeMapSize(Index As Integer)
'マップサイズの変更
    
    Select Case Index
        Case 1
            ReDim Map(0 To &HFF, 0 To &HFF)
            MapSize = &HFF
        Case 2
            ReDim Map(0 To &H7F, 0 To &H7F)
            MapSize = &H7F
        Case 3
            ReDim Map(0 To &H3F, 0 To &H3F)
            MapSize = &H3F
    End Select
    
    X_Scroll.Max = MapSize
    Y_Scroll.Max = MapSize
    X_Scroll.Value = X
    Y_Scroll.Value = Y
    MapShow

End Sub
Public Sub MapShow()
'マップの表示を行う

    Dim I As Long, J As Long
    Dim HX As Long, HY As Long
    Dim ShowX As Long, ShowY As Long
    
    ShowX = Crt.Width \ 32
    ShowY = Crt.Height \ 32
    
    For I = 0 To ShowY
        For J = 0 To ShowX
            HX = (Map((X + J) And MapSize, (Y + I) And MapSize) And &HF) * 32
            HY = (Map((X + J) And MapSize, (Y + I) And MapSize) And &HF0) / &H10 * 32
            BitBlt Me.Crt.hdc, J * 32, I * 32, 32, 32, Me.Chip.hdc, HX, HY, SrcCopy
        Next J
    Next I
    
    'キャプションに現在の座標を表示する
    Me.Caption = Title & "[X:" & Hex(X) & " Y:" & Hex(Y) & "]"
    
    If Tool = "Cursor" Then SelectShow Select_SX, Select_SY, Select_EX, Select_EY
    Crt.Refresh
    
End Sub
Public Sub SelectShow(ByVal StartX As Integer, ByVal StartY As Integer, ByVal EndX As Integer, ByVal EndY As Integer)
    
    Dim I As Integer, J As Integer
    Dim D_X As Integer, D_Y As Integer
    
    '選択範囲がマイナス方向の場合開始地点と終了地点を入れ換える
    If StartX > EndX Then
        D_X = StartX
        StartX = EndX
        EndX = D_X
    End If
    If StartY > EndY Then
        D_Y = StartY
        StartY = EndY
        EndY = D_Y
    End If
    
    '選択範囲へ網掛けを描画する（実際はただのＯＲ転送）
    For I = 0 To EndY - StartY
        For J = 0 To EndX - StartX
            BitBlt Me.Crt.hdc, (J + (StartX - X)) * 32, (I + (StartY - Y)) * 32, 32, 32, SelectPic.hdc, 0, 0, SrcPaint
        Next J
    Next I
    
    '再描画を行う
    Crt.Refresh
    
End Sub
Public Sub MapCopy()
'編集中の選択部分をコピーする

    Dim I As Integer, J As Integer
    Dim StartX As Integer, StartY As Integer
    Dim EndX As Integer, EndY As Integer
    
    '選択範囲がマイナス方向の場合開始地点と終了地点を入れ換える
    If Select_SX > Select_EX Then
        StartX = Select_EX
        EndX = Select_SX
    Else
        StartX = Select_SX
        EndX = Select_EX
    End If
    If Select_SX > Select_EX Then
        StartY = Select_EY
        EndY = Select_SY
    Else
        StartY = Select_SY
        EndY = Select_EY
    End If

    ReDim CopyMap(0 To EndX - StartX, 0 To EndY - StartY)
    For I = 0 To EndY - StartY
        For J = 0 To EndX - StartX
            CopyMap(J, I) = Map((J + StartX) And MapSize, (I + StartY) And MapSize)
        Next J
    Next I
    
    CopyOn = True

End Sub

Public Sub MapPast()
'コピーしたマップデータを貼り付ける

    Dim I As Integer, J As Integer
    
    For I = 0 To UBound(CopyMap, 2)
        For J = 0 To UBound(CopyMap, 1)
            Map((J + Select_SX) And MapSize, (I + Select_SY) And MapSize) = CopyMap(J, I)
        Next J
    Next I

    MapShow

End Sub
Public Sub Undo()
'アンデゥを実行
    
    ReDim RedoMap(0 To MapSize, 0 To MapSize)
    RedoMap = Map
    Map = UndoMap
    ToolForm.Tool1.Buttons("Redo").Enabled = True
    ToolForm.Tool1.Buttons("Undo").Enabled = False
    MapShow
    
End Sub
Public Sub Redo()
'リドゥを実行

    Map = RedoMap
    ToolForm.Tool1.Buttons("Redo").Enabled = False
    ToolForm.Tool1.Buttons("Undo").Enabled = True
    MapShow
    
End Sub
Public Sub UndoSet()
'変更前のデータを保存する

    ReDim UndoMap(0 To MapSize, 0 To MapSize)
    UndoMap = Map
    ToolForm.Tool1.Buttons("Redo").Enabled = False
    ToolForm.Tool1.Buttons("Undo").Enabled = True

End Sub


Public Sub MapPaint(ByVal No As Integer)
'指定されたチップ番号でマップを塗り潰す

    Dim I As Integer, J As Integer

    For I = 0 To MapSize
        For J = 0 To MapSize
            Map(I, J) = No
        Next J
    Next I
    
    'マップの再描画
    MapShow

End Sub
Public Sub ChipBarShow()
'ＭＩＤフォームのチップ用ピクチャボックスにチップを再配置表示する

    Dim I As Long, J As Long
    Dim HX As Long, HY As Long
    Dim ShowX As Long, ShowY As Long
    
    For J = 0 To &HFF Step 4
        
        For I = 0 To 3
            HX = ((J + I) And &HF) * 32
            HY = ((J + I) And &HF0) / &H10 * 32
            BitBlt MainForm.ShowChip.hdc, I * 32, ShowY * 32, 32, 32, Me.Chip.hdc, HX, HY, SrcCopy
        Next I
        ShowY = ShowY + 1
    Next J

    'ツールバーの選択チップを変更する
    BitBlt ToolForm.LeftPic.hdc, 0, 0, 32, 32, Me.Chip.hdc, (LeftNo And &HF) * 32, (LeftNo And &HF0) / &H10 * 32, SrcCopy
    ToolForm.LeftPic.Refresh
    BitBlt ToolForm.RightPic.hdc, 0, 0, 32, 32, Me.Chip.hdc, (RightNo And &HF) * 32, (RightNo And &HF0) / &H10 * 32, SrcCopy
    ToolForm.RightPic.Refresh

    MainForm.ShowChip.Refresh

End Sub

Private Sub X_Scroll_Change()
'Ｘ方向のスクロールバーの処理

    X = X_Scroll.Value
    MapShow
    
End Sub

Private Sub Y_Scroll_Change()
'Ｙ方向のスクロールバーの処理

    Y = Y_Scroll.Value
    MapShow
    
End Sub
