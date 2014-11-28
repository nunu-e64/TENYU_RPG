////多重インクルード防止（インクルードガード）//
#ifndef SCREENCHANGER_H					////
#define SCREENCHANGER_H					////
////////////////////////////////////////////////
/*
##### Main/ScreenChanger.h
ゲーム内各所で使う、様々な画面の切り替え効果を使いやすくするためのクラスです。  
現在は戦闘開始時に使われています。
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


////多重インクルード防止（インクルードガード）//
#endif										////
////////////////////////////////////////////////