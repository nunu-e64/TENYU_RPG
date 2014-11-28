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
      Align           =   1  '�㑵��
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
            Object.ToolTipText     =   "�V�����ҏW�f�[�^���쐬����"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "ChipOpen"
            Key             =   "Chip"
            Object.ToolTipText     =   "�ҏW���̃}�b�v�̃`�b�v��I������"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "MapOpen"
            Key             =   "Map"
            Object.ToolTipText     =   "�ҏW���̃}�b�v�������}�b�v�ƌ�������"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "MapSave"
            Key             =   "Save"
            Object.ToolTipText     =   "�}�b�v���㏑���ۑ�����"
            ImageIndex      =   3
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.StatusBar StatusBar 
      Align           =   2  '������
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
      Align           =   4  '�E����
      Height          =   4740
      Left            =   6195
      ScaleHeight     =   312
      ScaleMode       =   3  '�߸��
      ScaleWidth      =   142
      TabIndex        =   0
      Top             =   615
      Width           =   2190
      Begin VB.PictureBox ShowChip 
         AutoRedraw      =   -1  'True
         BackColor       =   &H80000007&
         BorderStyle     =   0  '�Ȃ�
         Height          =   435
         Left            =   240
         ScaleHeight     =   29
         ScaleMode       =   3  '�߸��
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
      Caption         =   "̧��(&F)"
      Begin VB.Menu Menu001 
         Caption         =   "�V�����}�b�v���쐬����"
      End
      Begin VB.Menu Menu002 
         Caption         =   "�����}�b�v���J��"
      End
      Begin VB.Menu Menu003 
         Caption         =   "-"
      End
      Begin VB.Menu Menu004 
         Caption         =   "ϯ�����߂̓Ǎ���"
      End
      Begin VB.Menu Menu005 
         Caption         =   "ϯ���ް��̓Ǎ���"
      End
      Begin VB.Menu Menu006 
         Caption         =   "-"
      End
      Begin VB.Menu Menu007 
         Caption         =   "���O��t���ĕۑ�"
      End
   End
   Begin VB.Menu Menu100 
      Caption         =   "ϯ�߻���"
      Begin VB.Menu Menu101 
         Caption         =   "256�~256"
         Index           =   1
      End
      Begin VB.Menu Menu101 
         Caption         =   "128�~128"
         Index           =   2
      End
      Begin VB.Menu Menu101 
         Caption         =   "64�~64"
         Index           =   3
      End
   End
   Begin VB.Menu Menu200 
      Caption         =   "����޳(&W)"
      WindowList      =   -1  'True
      Begin VB.Menu Menu201 
         Caption         =   "�d�˂ĕ\��"
      End
      Begin VB.Menu Menu202 
         Caption         =   "���ׂĕ\��"
      End
   End
End
Attribute VB_Name = "MainForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'�}���`�}�b�v�G�f�B�^�[

Option Explicit

'���݊J���Ă���`���C���h�E�B���h�E�̐�
Public FormCounter As Long

Private Sub ChipBar_Change()
    
    ShowChip.Top = ChipBar.Value * 32 * -1
    
End Sub

Private Sub Left_Bar_Resize()
    
    ChipReSize
    
End Sub

Private Sub MDIForm_Load()
'�l�c�h�t�H�[�����[�h�C�x���g

    '�e�R���g���[���̏�������
    ChipReSize
    '�R�����_�C�A���O�̃L�����Z�����ɃG���[�Ƃ���
    CommonDialog1.CancelError = True
    
    '�����\���ʒu����ʏ�̃Z���^�[�ֈړ�
    If WindowState = 0 Then
        Move (Screen.Width - Me.Width) / 2, (Screen.Height - Me.Height) / 2
    End If

    Me.Caption = Me.Caption & Space(2) & "Version1.0"

    '�c�[���o�[��\������
    Load ToolForm
    ToolForm.Show , Me
    
    '�c�[���o�[�̈ꕔ�𖳌��ɂ���
    With Top_bar
        .Buttons("Chip").Enabled = False
        .Buttons("Map").Enabled = False
        .Buttons("Save").Enabled = False
    End With
    MenuFalse
        
End Sub

Private Sub ChipReSize()
'�t�H�[����̃R���g���[���̃T�C�Y�ύX

    Left_Bar.Width = (20 + 32 * 4) * Screen.TwipsPerPixelX
    
    '�`�b�v�p�̃X�N���[���o�[�̃T�C�Y�ύX
    With ChipBar
        .Top = 0
        .Left = 0
        .Height = Left_Bar.ScaleHeight
        .Width = 16
        .Max = ((32 * 64) - Left_Bar.ScaleHeight) \ 32
    End With
    
    '�`�b�v�p�̃s�N�`���{�b�N�X�̃T�C�Y�ύX
    With ShowChip
        .Top = 0
        .Left = ChipBar.Width
        .Width = 32 * 4
        .Height = 32 * 64
    End With
    
End Sub
Public Sub MenuTrue()
'�ҏW���̃t�H�[���������Ǝ����o���Ȃ��R���g���[���̗L����

    '���j���[���̗L����
    Menu004.Enabled = True
    Menu005.Enabled = True
    Menu007.Enabled = True
    Menu100.Enabled = True
    Menu200.Enabled = True
    
    '�c�[���{�b�N�X�̗L����
    With ToolForm.Tool1
        .Buttons("Cursor").Enabled = True
        .Buttons("Pen").Enabled = True
        .Buttons("Syringe").Enabled = True
        .Buttons("Paint").Enabled = True
    End With
    
End Sub
Public Sub MenuFalse()
'�ҏW���̃t�H�[���������Ǝ����o���Ȃ��R���g���[���̖���
      
    '���j���[���̖�����
    Menu004.Enabled = False
    Menu005.Enabled = False
    Menu007.Enabled = False
    Menu100.Enabled = False
    Menu200.Enabled = False

    '�c�[���{�b�N�X�̖�����
    With ToolForm.Tool1
        .Buttons("Cursor").Enabled = False
        .Buttons("Pen").Enabled = False
        .Buttons("Syringe").Enabled = False
        .Buttons("Paint").Enabled = False
    
        .Buttons("Copy").Enabled = False
        .Buttons("Past").Enabled = False
    
        .Buttons("Undo").Enabled = False
        .Buttons("Redo").Enabled = False
    
        '�I���c�[���̏�����
        .Buttons("Cursor").Value = 0
        .Buttons("Pen").Value = 0
        .Buttons("Syringe").Value = 0
        .Buttons("Paint").Value = 0
    End With

End Sub
Public Function MapSave() As Boolean
'�}�b�v�t�@�C���̕ۑ�
    
    Dim OpenFile As String
    
    On Error Resume Next    '���̃��[�`�����̃G���[�𖳌��ɂ���B
    
    If ActiveForm.SaveFileName = "" Then
        CommonDialog1.FileName = ""
    Else
        CommonDialog1.FileName = ActiveForm.SaveFileName
    End If
    
    With CommonDialog1
        .DialogTitle = "���O��t���ăt�@�C���̕ۑ�"
        .Filter = "Pictures(*.Map)|*.Map"
        .Flags = &H2
        .ShowSave   '���O��t���ĕۑ��p���޲�۸ނ��J��
    End With
    
    DoEvents
        
    If Err <> cdlCancel Then    ' հ�ް��[��ݾ�]��I�����܂����B 32755=��ݾٺ���
        ActiveForm.MapSave CommonDialog1.FileName
        MapSave = True
    Else
        MapSave = False
    End If

End Function
Private Sub Menu001_Click()
'�V�����`���C���h�E�B���h�E���J��

    FormCounter = FormCounter + 1
    Dim MapForm As New Map
    MapForm.Tag = FormCounter
    MapForm.Show

End Sub

Private Sub Menu002_Click()
'�V�����t�H�[�����J���ă}�b�v��Ǎ���
    
    Dim OpenFile As String

    On Error Resume Next    '���̃��[�`�����̃G���[�𖳌��ɂ���B
    With CommonDialog1
        .DialogTitle = "�}�b�v�f�[�^�̓ǂݍ���"
        .FileName = ""
        .Filter = "Pictures(*.map)|*.MAP"
        .ShowOpen     '̧�ٵ���ݗp���޲�۸ނ��J��
    End With
    
    DoEvents
        
    If Err <> cdlCancel Then    ' հ�ް��[��ݾ�]��I�����܂����B 32755=��ݾٺ���

        FormCounter = FormCounter + 1
        Dim MapForm As New Map
        MapForm.Tag = FormCounter
        MapForm.Show
        ActiveForm.MapLoad CommonDialog1.FileName
                
    End If

    '�����̃}�b�v���J�����ꍇ�A���������}�b�v�`�b�v�̑I�����s��
    Menu004_Click
    ActiveForm.ChipBarShow

End Sub

Public Sub Menu004_Click()
'�}�b�v�`�b�v�̓ǂݍ���

    Dim OpenFile As String
    On Error Resume Next    '���̃��[�`�����̃G���[�𖳌��ɂ���B

    With CommonDialog1
        .DialogTitle = "�p�^�[���O���t�B�b�N�̑I��"
        .FileName = ""
        .Filter = "Pictures(*.bmp;*.gif)|*.bmp;*.gif"
        .ShowOpen   '̧�ٵ���ݗp���޲�۸ނ��J��
    End With
    
    DoEvents
        
    If Err <> cdlCancel Then    ' հ�ް��[��ݾ�]��I�����܂����B 32755=��ݾٺ���
        ActiveForm.ChipLoad CommonDialog1.FileName
    End If

End Sub
Public Sub Menu005_Click()
'�}�b�v�t�@�C����I�����ēǍ���
    
    Dim OpenFile As String

    On Error Resume Next    '���̃��[�`�����̃G���[�𖳌��ɂ���B
    With CommonDialog1
        .DialogTitle = "�}�b�v�f�[�^�̓ǂݍ���"
        .FileName = ""
        .Filter = "Pictures(*.map)|*.MAP"
        .ShowOpen   '̧�ٵ���ݗp���޲�۸ނ��J��
    End With
    
    DoEvents
        
    If Err <> cdlCancel Then    ' հ�ް��[��ݾ�]��I�����܂����B 32755=��ݾٺ���
        ActiveForm.MapLoad CommonDialog1.FileName
        '�}�b�v��ǂݒ������̂ŕύX�L�����N���A����
        ActiveForm.DataChanged = False
    End If

End Sub
Public Sub Menu007_Click()
'�}�b�v�t�@�C���̕ۑ�
    
    Dim Ret As Boolean
    Ret = MapSave

End Sub

Private Sub Menu101_Click(Index As Integer)
'�}�b�v�T�C�Y�̕ύX���j���[

    Dim I As Long
    
    '��Ԃ̕ύX�����邩�ǂ������`�F�b�N
    If Menu101(Index).Checked = True Then Exit Sub
    
    '���b�Z�[�W�{�b�N�X�ɂĊm�F��\��
    If MsgBox("�}�b�v�T�C�Y�̕ύX���s���܂����H", vbOKCancel, "�}�b�v�T�C�Y�̕ύX") <> 1 Then
        Exit Sub
    End If
    
    '���ׂẴ`�F�b�N���\���ɂ���
    For I = 1 To 3
        Menu101(I).Checked = False
    Next I
    '�I�����ꂽ���j���[�̃`�F�b�N��\���ɂ���
    Menu101(Index).Checked = True
    
    '�I�����ꂽ���j���[�ɏ]���ă}�b�v�T�C�Y�̕ύX���s��
    ActiveForm.ChangeMapSize Index
    
End Sub
Private Sub Menu201_Click()
'���݂̃E�B���h�E���d�˂Đ���

    Arrange vbCascade

End Sub

Private Sub Menu202_Click()
'���݂̃E�B���h�E����ׂĐ���
    
    Arrange vbTileVertical

End Sub


Private Sub ShowChip_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
'�}�b�v�`�b�v�̑I��

    '�ҏW���̃t�H�[�������邩�ǂ������`�F�b�N
    If FormCounter <> 0 Then
    
        '���{�^���������ꂽ�ꍇ�̏���
        If Button = 1 Then
            Me.ActiveForm.LeftNo = (X \ 32) + ((Y \ 32) * 4)
        End If
        '�E�{�^���������ꂽ�ꍇ�̏���
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
'�^�C�}�[���荞�݂ɂă}�b�v�̃X�N���[�����s��

    If FormCounter <> 0 Then
        
        'Me.ActiveForm.Crt.SetFocus
        '�E�L�[�̏���
        If GetAsyncKeyState(vbKeyRight) Then
            Me.ActiveForm.X = (Me.ActiveForm.X + 1) And Me.ActiveForm.MapSize
            Me.ActiveForm.MapShow
            Me.ActiveForm.X_Scroll.Value = Me.ActiveForm.X
            Me.ActiveForm.Y_Scroll.Value = Me.ActiveForm.Y
        End If
        
        '���L�[�̏���
        If GetAsyncKeyState(vbKeyLeft) Then
            Me.ActiveForm.X = (Me.ActiveForm.X - 1) And Me.ActiveForm.MapSize
            Me.ActiveForm.MapShow
            Me.ActiveForm.X_Scroll.Value = Me.ActiveForm.X
            Me.ActiveForm.Y_Scroll.Value = Me.ActiveForm.Y
        End If
        
        '��L�[�̏���
        If GetAsyncKeyState(vbKeyUp) Then
            Me.ActiveForm.Y = (Me.ActiveForm.Y - 1) And Me.ActiveForm.MapSize
            Me.ActiveForm.MapShow
            Me.ActiveForm.X_Scroll.Value = Me.ActiveForm.X
            Me.ActiveForm.Y_Scroll.Value = Me.ActiveForm.Y
        End If
        
        '���L�[�̏���
        If GetAsyncKeyState(vbKeyDown) Then
            Me.ActiveForm.Y = (Me.ActiveForm.Y + 1) And Me.ActiveForm.MapSize
            Me.ActiveForm.MapShow
            Me.ActiveForm.X_Scroll.Value = Me.ActiveForm.X
            Me.ActiveForm.Y_Scroll.Value = Me.ActiveForm.Y
        End If

    End If

End Sub

Private Sub Top_bar_ButtonClick(ByVal Button As MSComctlLib.Button)
'�c�[���o�[�̏���

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
