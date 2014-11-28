Attribute VB_Name = "Api"
'�}���`�}�b�v�G�f�B�^�[

Option Explicit

'�摜�]���p�`�o�h�̒�`
    
    Public Declare Function BitBlt Lib "gdi32" ( _
    ByVal hdc As Long, _
    ByVal X As Long, ByVal Y As Long, _
    ByVal nWidth As Long, _
    ByVal nHeight As Long, _
    ByVal hSrcDC As Long, _
    ByVal XSrc As Long, ByVal YSrc As Long, _
    ByVal dwRop As Long _
    ) As Long

    '���X�^�I�y���[�V�����̒�`
    Public Const SrcCopy = &HCC0020
    Public Const SrcAnd = &H8800C6
    Public Const SrcPaint = &HEE0086
    Public Const SrcInvert = &H660046

'�c�h�a�p�]������

    Public Declare Function StretchDIBits Lib "gdi32" ( _
    ByVal hdc As Long, _
    ByVal X As Long, _
    ByVal Y As Long, _
    ByVal dx As Long, _
    ByVal dy As Long, _
    ByVal SrcX As Long, _
    ByVal SrcY As Long, _
    ByVal wSrcWidth As Long, _
    ByVal wSrcHeight As Long, _
    lpBits As Any, _
    lpBitsInfo As BITMAPINFO, _
    ByVal wUsage As Long, _
    ByVal dwRop As Long) As Long

'�摜�����擾����`�o�h

    '�����i�[����\���̂̒�`
    Public Type BITMAP
        bmType As Long
        bmWidth As Long
        bmHeight As Long
        bmWidthbytes As Long
        bmPlanes As Integer
        bmBitsPixel As Integer
        bmBits As Long
    End Type

    Public Declare Function GetObject Lib "gdi32" Alias "GetObjectA" ( _
    ByVal hObject As Long, _
    ByVal nCount As Long, _
    lpObject As Any) As Long

'�c�h�a�ɂĉ摜���擾����`�o�h

    '  �r�b�g�}�b�v���w�b�_�[�\����
    Public Type BITMAPINFOHEADER
        biSize          As Long
        biWidth         As Long
        biHeight        As Long
        biPlanes        As Integer
        biBitCount      As Integer
        biCompression   As Long
        biSizeImage     As Long
        biXPelsPerMeter As Long
        biYPelsPerMeter As Long
        biClrUsed       As Long
        biClrImportant  As Long
    End Type
    '  �p���b�g�G���g���\����
    Public Type RGBQUAD
        rgbBlue         As Byte
        rgbGreen        As Byte
        rgbRed          As Byte
        rgbReserved     As Byte
    End Type
    '  �r�b�g�}�b�v���
    Public Type BITMAPINFO
        bmiHeader As BITMAPINFOHEADER
        bmiColors(0 To 255)  As RGBQUAD
    End Type
    
    Public Declare Function CreateDIBSection Lib "gdi32" ( _
    ByVal hdc As Long, _
    pBitmapInfo As BITMAPINFO, _
    ByVal un As Long, _
    lplpVoid As Long, _
    ByVal handle As Long, _
    ByVal dw As Long) As Long

'��������Ƀr�b�g�}�b�v���쐬����`�o�h

    Public Declare Function CreateBitmap Lib "gdi32" ( _
    ByVal nWidth As Long, _
    ByVal nHeight As Long, _
    ByVal nPlanes As Long, _
    ByVal nBitCount As Long, _
    lpBits As Any) As Long
    
'���������u���b�N�]���p�̂`�o�h

    Public Declare Sub MoveMemory Lib "kernel32" Alias "RtlMoveMemory" ( _
    dest As Any, _
    ByVal Source As Long, _
    ByVal Length As Long)
    
'�f�o�C�X�R���e�L�X�g�̍쐬�p�`�o�h
    
    Public Declare Function CreateCompatibleDC Lib "gdi32" ( _
    ByVal hdc As Long) As Long
    
'�쐬�����f�o�C�X�R���e�L�X�g���폜����`�o�h
    
    Public Declare Function DeleteDC Lib "gdi32" (ByVal hdc As Long) As Long
    
'�o�b�N�J���[��ύX����`�o�h
    
    Public Declare Function SetBkColor Lib "gdi32" ( _
    ByVal hdc As Long, _
    ByVal crColor As Long) As Long

'�I�u�W�F�N�g��I������`�o�h
    
    Public Declare Function SelectObject Lib "gdi32" ( _
    ByVal hdc As Long, _
    ByVal hObject As Long) As Long

'�I�������I�u�W�F�N�g���J������`�o�h
    
    Public Declare Function DeleteObject Lib "gdi32" ( _
    ByVal hObject As Long) As Long

'�摜��ϐ��Ɋi�[����`�o�h

    Public Declare Function GetBitmapBits Lib "gdi32" ( _
    ByVal hBitmap As Long, _
    ByVal dwCount As Long, _
    lpBits As Any) As Long

'�摜��ϐ�����߂��`�o�h

    Public Declare Function SetBitmapBits Lib "gdi32" ( _
    ByVal hBitmap As Long, _
    ByVal dwCount As Long, _
    lpBits As Any) As Long

'�`�o�h�ło�r�d�s����

    Public Declare Function SetPixelV Lib "gdi32" ( _
    ByVal hdc As Long, _
    ByVal X As Long, _
    ByVal Y As Long, _
    ByVal crColor As Long) As Long


'�L�[�{�[�h���m�̂`�o�h�̒�`

    Public Declare Function GetKeyState Lib "user32" ( _
    ByVal nVirtKey As Long _
    ) As Integer

    Public Declare Function GetAsyncKeyState Lib "user32" ( _
    ByVal vKey As Long _
    ) As Integer

'�l�h�c�h�y�тv�`�u�d�t�@�C���̍Đ��p�`�o�h�̒�`

    Public Declare Function mciSendString Lib "winmm.dll" Alias "mciSendStringA" ( _
    ByVal CMD$, ByVal Ret$, ByVal RLen&, ByVal hWnd&) As Long

'�E�F�C�g�ׂ̈̃^�C�}�[�`�o�h�̒�`

    Public Declare Function timeGetTime Lib "winmm.dll" () As Long

'���ʉ��T�E���h�p�`�o�h�̒�`
    
    Public Declare Function sndPlaySound Lib "winmm.dll" Alias "sndPlaySoundA" _
    (ByVal lpszSoundName As String, ByVal uFlags As Long) As Long

    Public Const Snd_Sync = &H0
    Public Const Snd_Async = &H1
    Public Const Snd_Nodefault = &H2
    Public Const Snd_Memory = &H4
    Public Const Snd_Loop = &H8
    Public Const Snd_Nostop = &H10

'�W���C�X�e�B�b�N�p�`�o�h�̒�`

    Type JOYINFOEX
            dwSize As Long
            dwFlags As Long
            dwXpos As Long
            dwYpos As Long
            dwZpos As Long
            dwRpos As Long
            dwUpos As Long
            dwVpos As Long
            dwButtons As Long
            dwButtonNumber As Long
            dwPOV As Long
            dwReserved1 As Long
            dwReserved2 As Long
    End Type
    
    Declare Function joyGetNumDevs Lib "winmm.dll" () As Long
    Declare Function joyGetPosEx Lib "winmm.dll" (ByVal uJoyID As Long, pji As JOYINFOEX) As Long

    Public Const JOY_RETURNX = &H1&
    Public Const JOY_RETURNY = &H2&
    Public Const JOY_RETURNBUTTONS = &H80&
    Public Const JOYERR_BASE = 160
    Public Const JOYERR_NOERROR = (0)
    Public Const JOYERR_UNPLUGGED = (JOYERR_BASE + 7)
    
    Public Const JOYSTICKID1 = 0
    Public Const JOYSTICKID2 = 1

    Public JoyPort As Long
    Public JoyStickState As Boolean
    Public Joy_Button(0 To 4)



