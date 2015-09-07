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
   ScaleMode       =   3  '�߸��
   ScaleWidth      =   184
   Begin VB.PictureBox SelectPic 
      AutoRedraw      =   -1  'True
      BackColor       =   &H00FF0000&
      BorderStyle     =   0  '�Ȃ�
      Height          =   480
      Left            =   0
      ScaleHeight     =   35.31
      ScaleMode       =   0  'հ�ް
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
      BorderStyle     =   0  '�Ȃ�
      Height          =   435
      Left            =   0
      ScaleHeight     =   29
      ScaleMode       =   3  '�߸��
      ScaleWidth      =   29
      TabIndex        =   1
      Top             =   480
      Visible         =   0   'False
      Width           =   435
   End
   Begin VB.PictureBox Crt 
      AutoRedraw      =   -1  'True
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   0  '�Ȃ�
      Height          =   435
      Left            =   0
      ScaleHeight     =   29
      ScaleMode       =   3  '�߸��
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
'�}���`�}�b�v�G�f�B�^�[

Option Explicit

'�ҏW���̃}�b�v�t�@�C�������^�C�g���Ƃ��Ċi�[����
Private Title As String

'�\�����Ă���}�b�v���W
Public X As Long, Y As Long

'�f�[�^�͈͑I�����̃}�b�v���W
Public Select_SX As Integer, Select_SY As Integer
Public Select_EX As Integer, Select_EY As Integer

'�}�b�v���i�[����ϐ�
Private Map() As Byte
Private RedoMap() As Byte
Private UndoMap() As Byte
Public MapSize As Long

'�ҏW���̃}�b�v���ۑ��p�ϐ�
Public SaveFileName As String

'�`�b�v�I��ԍ�
Public LeftNo As Long
Public RightNo As Long
Public LeftDraw As Long
Public RightDraw As Long

'�c�[���̑I�����
Public Tool As String

'�ҏW���̃f�[�^�̏�ԁiTrue �ύX�FFalse ���ύX�j
Public DataChanged As Boolean

Private Sub Crt_MouseDown(Button As Integer, Shift As Integer, MX As Single, MY As Single)
'�}�b�v�̒u������
    
    Dim Ret As Integer
    
    Select Case Tool
    
        Case "Pen"
            '�`�b�v�z�u����
            
            UndoSet

            '���{�^���̏���
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
            '�}�b�v���ĕ`��
            MapShow
            '�f�[�^�̕ύX���L������
            DataChanged = True
            
        Case "Syringe"
            '�X�|�C�g����
            
            '���{�^���̏���
            If Button = 1 Then
                LeftNo = Map((X + (MX \ 32)) And MapSize, (Y + (MY \ 32)) And MapSize)
            End If
            '�E�{�^���̏���
            If Button = 2 Then
                RightNo = Map((X + (MX \ 32)) And MapSize, (Y + (MY \ 32)) And MapSize)
            End If
            '�z���o�����ԍ��ŕ\���̕ύX
            ChipBarShow
            
        Case "Cursor"
            '�f�[�^�̑I������
            
            LeftDraw = 1
            Select_SX = X + MX \ 32
            Select_SY = Y + MY \ 32
            Select_EX = Select_SX
            Select_EY = Select_SY
            MapShow
            SelectShow Select_SX, Select_SY, Select_EX, Select_EY
            
        Case "Paint"
            '�h��ׂ�����
            Ret = MsgBox("�I������Ă���`�b�v�œh��ׂ��܂�", vbOKCancel + vbQuestion, "MapEditor")
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
'�}�E�X�̈ړ����̏���

    Select Case Tool
    
        Case "Pen"
            '�A���f�[�^�z�u����
            If LeftDraw = 1 And (Crt.Width > MX And Crt.Height > MY) Then
                Map((X + (MX \ 32)) And MapSize, (Y + (MY \ 32)) And MapSize) = LeftNo
                MapShow
            End If
            If RightDraw = 1 And (Crt.Width > MX And Crt.Height > MY) Then
                Map((X + (MX \ 32)) And MapSize, (Y + (MY \ 32)) And MapSize) = RightNo
                MapShow
            End If
            
        Case "Cursor"
            '�I��͈͊g�又��
            If LeftDraw = 1 And (Crt.Width > MX And Crt.Height > MY) Then
                Select_EX = X + MX \ 32
                Select_EY = Y + MY \ 32
                MapShow
                SelectShow Select_SX, Select_SY, Select_EX, Select_EY
            End If

    End Select
    
End Sub

Private Sub Crt_MouseUp(Button As Integer, Shift As Integer, MX As Single, MY As Single)
'�{�^���������ꂽ�ꍇ�̏���

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
'�A�N�e�B�u�ɂȂ������ɂl�c�h�t�H�[���̃`�b�v��؂肩����

    ChipBarShow
    ToolForm.Tool1.Buttons(Tool).Value = tbrPressed

End Sub

Private Sub Form_Load()
'�}�b�v�z�u�p�t�H�[���̃��[�h�C�x���g
        
    '�}�b�v�T�C�Y�̐ݒ�
    MapSize = &HFF
    ReDim Map(0 To MapSize, 0 To MapSize) As Byte
    
    '�}�b�v�\���p�̃s�N�`���{�b�N�X�̈ʒu�̏�����
    Crt.Top = 0
    Crt.Left = 0
    
    Chip.Width = 512
    Chip.Height = 512
    
    MapReSize
    
    X = 0: Y = 0
    Title = "NewMap(NoName)"

    '�c�[���o�[�̈ꕔ��L���ɂ���
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
'�t�H�[���T�C�Y�Ƀs�N�`���{�b�N�X�̃T�C�Y�����킹��

    On Error Resume Next    '���̃��[�`�����̃G���[�𖳌��ɂ���B

    '�}�b�v�\���p�̃s�N�`���{�b�N�X�̃T�C�Y����
    Crt.Width = Me.ScaleWidth - 16
    Crt.Height = Me.ScaleHeight - 16
    
    '�X�N���[���o�[�̃T�C�Y����
    Y_Scroll.Top = 0
    Y_Scroll.Left = Me.ScaleWidth - 16
    Y_Scroll.Height = Me.ScaleHeight - 16
    
    X_Scroll.Top = Me.ScaleHeight - 16
    X_Scroll.Left = 0
    X_Scroll.Width = Me.ScaleWidth - 16

    MapShow
    
    
End Sub

Private Sub Form_Resize()
'�t�H�[���̑傫����ύX���ꂽ�ꍇ�̏���

    MapReSize
    
End Sub

Private Sub Form_Unload(Cancel As Integer)
'�E�B���h�E����鎞�̏���

    Dim Ret As Integer
    
    If DataChanged = True Then
        
        Ret = MsgBox("�ҏW���̃f�[�^�͕ύX����Ă��܂��B" & vbCrLf & "�f�[�^��ۑ����܂����H", vbYesNoCancel + vbExclamation, "MapEditor")
        Select Case Ret
            '�L�����Z���{�^���Ȃ�I��������߂�
            Case vbCancel
                Cancel = True
                Exit Sub
            '�n�j�Ȃ�t�@�C���Z�[�u���[�`�������s�A�A�������ŃL�����Z�����ꂽ���͂�I���͂��Ȃ�
            Case vbOK
                If MainForm.MapSave = False Then
                    Cancel = True
                    Exit Sub
                End If
        End Select
    End If

    '�J���Ă���t�H�[���̐������炷
    MainForm.FormCounter = MainForm.FormCounter - 1

    '�t�H�[���ɕt������`�b�v�̕\���Ȃǂ��N���A����
    MainForm.ShowChip.Cls
    ToolForm.LeftPic.Cls
    ToolForm.RightPic.Cls
    
    '�������t�H�[�����Ōォ�ǂ������ׂ�
    If MainForm.FormCounter = 0 Then
    
        '�c�[���o�[�̈ꕔ�𖳌��ɂ���
        With MainForm.Top_bar
            .Buttons("Chip").Enabled = False
            .Buttons("Map").Enabled = False
            .Buttons("Save").Enabled = False
        End With
        MainForm.MenuFalse
        
    End If
    
End Sub

Public Sub ChipLoad(FileName As String)
'�w�肳�ꂽ�t�@�C�����Ń}�b�v�`�b�v�����[�h����
        
    Chip.Picture = LoadPicture(FileName)
    ChipBarShow
    MapShow

End Sub
Public Sub MapLoad(FileName As String)
'�w�肳�ꂽ�t�@�C�����Ń}�b�v�����[�h����

    '�e�h�k�d���o�C�i���|���[�h�ŃI�[�v�����Ă��̂܂ܕϐ��ɓǂݍ���
    Open FileName For Binary Access Read As 1
        Get #1, , Map
    Close #1
    SaveFileName = FileName
    Title = FileName
    MapShow

End Sub
Public Sub MapSave(FileName As String)

    '�e�h�k�d���o�C�i���|���[�h�ŃI�[�v�����ĕϐ������̂܂܏�����
    Open FileName For Binary Access Write As #1
        Put #1, , Map
    Close #1
    SaveFileName = FileName
    Title = FileName
    
    '�}�b�v�̍ĕ`��
    MapShow
    '�f�[�^�ύX�L�����N���A
    DataChanged = False

End Sub
Public Sub ChangeMapSize(Index As Integer)
'�}�b�v�T�C�Y�̕ύX
    
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
'�}�b�v�̕\�����s��

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
    
    '�L���v�V�����Ɍ��݂̍��W��\������
    Me.Caption = Title & "[X:" & Hex(X) & " Y:" & Hex(Y) & "]"
    
    If Tool = "Cursor" Then SelectShow Select_SX, Select_SY, Select_EX, Select_EY
    Crt.Refresh
    
End Sub
Public Sub SelectShow(ByVal StartX As Integer, ByVal StartY As Integer, ByVal EndX As Integer, ByVal EndY As Integer)
    
    Dim I As Integer, J As Integer
    Dim D_X As Integer, D_Y As Integer
    
    '�I��͈͂��}�C�i�X�����̏ꍇ�J�n�n�_�ƏI���n�_����ꊷ����
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
    
    '�I��͈֖͂Ԋ|����`�悷��i���ۂ͂����̂n�q�]���j
    For I = 0 To EndY - StartY
        For J = 0 To EndX - StartX
            BitBlt Me.Crt.hdc, (J + (StartX - X)) * 32, (I + (StartY - Y)) * 32, 32, 32, SelectPic.hdc, 0, 0, SrcPaint
        Next J
    Next I
    
    '�ĕ`����s��
    Crt.Refresh
    
End Sub
Public Sub MapCopy()
'�ҏW���̑I�𕔕����R�s�[����

    Dim I As Integer, J As Integer
    Dim StartX As Integer, StartY As Integer
    Dim EndX As Integer, EndY As Integer
    
    '�I��͈͂��}�C�i�X�����̏ꍇ�J�n�n�_�ƏI���n�_����ꊷ����
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
'�R�s�[�����}�b�v�f�[�^��\��t����

    Dim I As Integer, J As Integer
    
    For I = 0 To UBound(CopyMap, 2)
        For J = 0 To UBound(CopyMap, 1)
            Map((J + Select_SX) And MapSize, (I + Select_SY) And MapSize) = CopyMap(J, I)
        Next J
    Next I

    MapShow

End Sub
Public Sub Undo()
'�A���f�D�����s
    
    ReDim RedoMap(0 To MapSize, 0 To MapSize)
    RedoMap = Map
    Map = UndoMap
    ToolForm.Tool1.Buttons("Redo").Enabled = True
    ToolForm.Tool1.Buttons("Undo").Enabled = False
    MapShow
    
End Sub
Public Sub Redo()
'���h�D�����s

    Map = RedoMap
    ToolForm.Tool1.Buttons("Redo").Enabled = False
    ToolForm.Tool1.Buttons("Undo").Enabled = True
    MapShow
    
End Sub
Public Sub UndoSet()
'�ύX�O�̃f�[�^��ۑ�����

    ReDim UndoMap(0 To MapSize, 0 To MapSize)
    UndoMap = Map
    ToolForm.Tool1.Buttons("Redo").Enabled = False
    ToolForm.Tool1.Buttons("Undo").Enabled = True

End Sub


Public Sub MapPaint(ByVal No As Integer)
'�w�肳�ꂽ�`�b�v�ԍ��Ń}�b�v��h��ׂ�

    Dim I As Integer, J As Integer

    For I = 0 To MapSize
        For J = 0 To MapSize
            Map(I, J) = No
        Next J
    Next I
    
    '�}�b�v�̍ĕ`��
    MapShow

End Sub
Public Sub ChipBarShow()
'�l�h�c�t�H�[���̃`�b�v�p�s�N�`���{�b�N�X�Ƀ`�b�v���Ĕz�u�\������

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

    '�c�[���o�[�̑I���`�b�v��ύX����
    BitBlt ToolForm.LeftPic.hdc, 0, 0, 32, 32, Me.Chip.hdc, (LeftNo And &HF) * 32, (LeftNo And &HF0) / &H10 * 32, SrcCopy
    ToolForm.LeftPic.Refresh
    BitBlt ToolForm.RightPic.hdc, 0, 0, 32, 32, Me.Chip.hdc, (RightNo And &HF) * 32, (RightNo And &HF0) / &H10 * 32, SrcCopy
    ToolForm.RightPic.Refresh

    MainForm.ShowChip.Refresh

End Sub

Private Sub X_Scroll_Change()
'�w�����̃X�N���[���o�[�̏���

    X = X_Scroll.Value
    MapShow
    
End Sub

Private Sub Y_Scroll_Change()
'�x�����̃X�N���[���o�[�̏���

    Y = Y_Scroll.Value
    MapShow
    
End Sub
