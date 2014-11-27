////���d�C���N���[�h�h�~�i�C���N���[�h�K�[�h�j//
#ifndef WORLDMANAGER_H						////
#define WORLDMANAGER_H						////
////////////////////////////////////////////////

#include "../Define.h"	//�C���N���[�h���Ȃ��Ă������i�Ԑ��͏o�邪�R���p�C�����ɉ������邽�߃G���[�͏o�Ȃ��j

#include "../Field/Map.h"
#include "TextBox.h"
#include "TextWrap.h"
#include "CmdManager.h"
#include "CmdList.h"
#include "../Field/EveManager.h"

class CWorldManager{
public:
	CWorldManager(){ImgBackGround = NULL;}
	~CWorldManager(){};

	virtual void Draw(bool _screenflip=false, bool _textshowingstop=false, int dx=0, int dy=0, bool _playeralsoshake=false)=0;
	void FadeDraw(int _time, int _img, bool _changeahead, bool _color);
	virtual void ChangeTextMode(bool _box, const char* _eventtext = NULL)=0;

protected:
	
	int ImgBackGround;	//�w�i�ꖇ�G�p
	/*
	CTextBox* TextBox;
	CTextBox TextBox1;
	CTextWrap TextWrap1;

	CEveManager* EveManager_p;
	CFlagSet* FlagSet_p;
	CCmdList* CmdList_p;*/
};

////���d�C���N���[�h�h�~�i�C���N���[�h�K�[�h�j//
#endif										////	
////////////////////////////////////////////////
