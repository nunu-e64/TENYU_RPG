Attribute VB_Name = "General"
'�}���`�}�b�v�G�f�B�^�[

Option Explicit

'�}�b�v�f�[�^�̕����R�s�[�p�ϐ�
Public CopyMap() As Byte
Public CopyOn As Boolean

Sub Wait(Wait_Time As Long)
'�`�o�h�ŃE�F�C�g�֐�
    
    '�g�p����ϐ��̒�`
    Dim Start_Time As Long
    
    '�v�������J�n���̎��Ԃ��擾
    Start_Time = timeGetTime()
    Do
        DoEvents    '���̏��������s
        
        '�ݒ莞�ԓ��B�̃`�F�b�N
        If timeGetTime() - Start_Time > Wait_Time Then
            '���B�����烋�[�v�𔲂���
            Exit Do
        End If
    Loop

End Sub
