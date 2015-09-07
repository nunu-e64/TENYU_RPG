Attribute VB_Name = "General"
'マルチマップエディター

Option Explicit

'マップデータの部分コピー用変数
Public CopyMap() As Byte
Public CopyOn As Boolean

Sub Wait(Wait_Time As Long)
'ＡＰＩ版ウェイト関数
    
    '使用する変数の定義
    Dim Start_Time As Long
    
    'Ｗａｉｔ開始時の時間を取得
    Start_Time = timeGetTime()
    Do
        DoEvents    '他の処理を実行
        
        '設定時間到達のチェック
        If timeGetTime() - Start_Time > Wait_Time Then
            '到達したらループを抜ける
            Exit Do
        End If
    Loop

End Sub
