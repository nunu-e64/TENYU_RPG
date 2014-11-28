////���d�C���N���[�h�h�~�i�C���N���[�h�K�[�h�j//
#ifndef SCREENCHANGER_H					////
#define SCREENCHANGER_H					////
////////////////////////////////////////////////
/*
##### Main/ScreenChanger.h
�Q�[�����e���Ŏg���A�l�X�ȉ�ʂ̐؂�ւ����ʂ��g���₷�����邽�߂̃N���X�ł��B  
���݂͐퓬�J�n���Ɏg���Ă��܂��B
*/

class CScreenChanger{
public:
	enum screenchange_tag{
		SCREEN_FADE,
		SCREEN_BOKASHI,
		SCREEN_NUM
	};

	void ChangeScreen(const int _pGraph, const int _nGraph, const screenchange_tag _type, int _count);


private:
	static void Fade(const int _pGraph, const int _nGraph, int _count);
	static void Bokashi(const int _pGraph, const int _nGraph, int _count);
};


////���d�C���N���[�h�h�~�i�C���N���[�h�K�[�h�j//
#endif										////
////////////////////////////////////////////////