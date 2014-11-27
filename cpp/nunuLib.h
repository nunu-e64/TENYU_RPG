////���d�C���N���[�h�h�~�i�C���N���[�h�K�[�h�j//	//pragmaonce�Ɠ����Ӗ�����������̓R���p�C���Ɉˑ����Ȃ�
#ifndef NUNULIB_H							////
#define NUNULIB_H							////
////////////////////////////////////////////////

#include "DxLib.h"
#include "math.h"
#include <direct.h>

//#define WARNINGDX_DISABLE	//�}�N���̖�����
//#define DEBUGDX_DISABLE	//�}�N���̖�����
//#define FPS_DISABLE
#define CHECK_TIME_DISABLE	//���ԑ���}�N���̖�����
	#define CHECK_TIME2_DISABLE	//���ԑ���}�N���i�����j�̖�����
#define ARRAY_SIZE(array)    (sizeof(array)/sizeof(array[0]))


//namespace nunuLib{

const double PI = 3.1415926535897932384626433832795f;
const int WINDOW_WIDTH = 640;	//32px*20cell
const int WINDOW_HEIGHT = 480;	//32px*15cell

////////////////////////////////////////////////////////
//�F�萔////////////////////////////////////////////////
	const int RED = GetColor( 255 , 0 , 0 );
	const int GREEN = GetColor( 0 , 255 , 0 );
	const int BLUE = GetColor( 0 , 0 , 255 );
	const int YELLOW = GetColor( 255 , 255 , 0 );
	const int MAGENTA = GetColor(255, 0, 255);
	const int BLACK = GetColor( 0 , 0 , 0 );
	const int WHITE = GetColor( 255 , 255 , 255 );
	const int GRAY = GetColor( 120 , 120 , 120 );
////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////
///���ԑ���֐�//////////////////////////////////////////////
	#ifdef CHECK_TIME_DISABLE
	#define CHECK_TIME_START    /* �������Ȃ� */
	#else
	#define CHECK_TIME_START {							\
			int check_perform_start = GetNowCount();	
	#endif

	#ifdef CHECK_TIME_DISABLE
	#define CHECK_TIME_END(title)    /* �������Ȃ� */
	#else
	#define CHECK_TIME_END(title)					\
			int check_perform_end = GetNowCount();		\
			printfDx( "%s: %dms\n", title, (check_perform_end - check_perform_start)); \
			ScreenFlip();	\
			WaitKey();	\
		}	
	#endif

	#ifdef CHECK_TIME2_DISABLE
	#define CHECK_TIME_START2    /* �������Ȃ� */
	#else
	#define CHECK_TIME_START2 {							\
			int check_perform_start = GetNowCount();	
	#endif

	#ifdef CHECK_TIME2_DISABLE
	#define CHECK_TIME_END2(title)    /* �������Ȃ� */
	#else
	#define CHECK_TIME_END(title)					\
			int check_perform_end = GetNowCount();		\
			printfDx( "%s: %dms\n", title, (check_perform_end - check_perform_start)); \
			ScreenFlip();	\
			WaitKey();	\
		}	
	#endif
/////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////
///�񎟌����W�p�N���X////////////////////////////////////////
class CVector{	//�錾�Ɠ����ɒ�`�������Ă���̂̓C�����C����
public:
	CVector( double _x , double _y ){
		x = _x;
		y = _y;
	}

	CVector(){
		x = 0;
		y = 0;
	}

	double x;
	double y;

	void Set( double _x , double _y){
		x = _x;
		y = _y;
	}
	void Set(CVector _vec){
		x = _vec.x;
		y = _vec.y;
	}
	
	CVector Add( double _x , double _y){
		x += _x;
		y += _y;
		return *this;
	}
	CVector Add(CVector _vec){
		x += _vec.x;
		y += _vec.y;
		return *this;
	}

	// +���Z�q�I�[�o�[���[�h
	CVector operator+(const CVector &obj){
		CVector tmp;
		tmp.x = x + obj.x;
		tmp.y = y + obj.y;
		return tmp;
	}

	// +=���Z�q�I�[�o�[���[�h
	CVector& operator+=(const CVector &obj){
		x += obj.x;
		y += obj.y;
		return *this;
	}
	CVector& operator+=(const double _num){
		x += _num;
		y += _num;
		return *this;
	}
	
	// -���Z�q�I�[�o�[���[�h
	CVector operator-(const CVector &obj){
		CVector tmp;
		tmp.x = x - obj.x;
		tmp.y = y - obj.y;
		return tmp;
	}
	// -=���Z�q�I�[�o�[���[�h
	CVector& operator-=(const CVector &obj){
		x -= obj.x;
		y -= obj.y;
		return *this;
	}
	CVector& operator-=(const double _num){
		x -= _num;
		y -= _num;
		return *this;
	}
	//*���Z�q�I�[�o�[���[�h
	CVector operator*(const double _num){
		CVector tmp;
		tmp.x = x * _num;
		tmp.y = y * _num;
		return tmp;
	}
	//*=���Z�q�I�[�o�[���[�h
	CVector& operator*=(const double _num){
		x*=_num;
		y*=_num;
		return *this;
	}

	//operator*�̃I�[�o�[���[�h�ɂ����͂�s�v
	void Multiple(double _num){
		x = x*_num;
		y = y*_num;
	}

	double GetLength(){
		return sqrt((x*x)+(y*y));
	}
private:
};
/////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////
///�񎟌�BOX�N���X////////////////////////////////////////
class CRect{
public:
	int Top;
	int Left;
	int Bottom;
	int Right;
	CRect(){
		Top = Bottom = Left = Right = 0;
	}
	CRect(int _left, int _right, int _top, int _bottom){
		Left = _left;
		Right = _right;
		Top = _top;
		Bottom = _bottom;
	}
	CVector Center(){
		CVector vec(Left+(Right-Left)/2, Top+(Bottom-Top)/2);
		return vec;
	}
	int Width(){
		return (Right-Left);
	}
	int Height(){
		return (Bottom-Top);
	}
	void SetWidth(int _width){
		Left -= (_width-Width())/2;
		Right += (_width-Width())/2;		
		if (_width>Width()) Right++;
		if (_width<Width()) Right--;
	}
	void SetHeight(int _height){
		Top -= (_height-Height())/2;
		Bottom += (_height-Height())/2;
		if (_height>Height()) Bottom++;
		if (_height<Height()) Bottom--;
	}

};
/////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////////
////������n///////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////
////������𐔒l�ɕϊ�///////////////////////////////////////
bool mystrtol(const char* str, long int* result, int radix=10);
bool mystrtol(const char* str, int* result, int radix=10);
	//atoi�ɂ̓G���[���肪�Ȃ����߂��̊֐��𗘗p����
	//	str		�F	�ϊ��Ώۂ̕�����
	//	*result	�F	�ϊ�����Long�^�̐����󂯎��A�h���X ��int�^����
	//	radix	�F	��B���l�����i���Ƃ݂Ȃ�����ݒ�B�f�t�H���g��10�i��
bool mystrtod(const char* str, double* result);	
bool mystrtod(const char* str, float* result);
	//���������_���idouble��float���j
/////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////
////strlen��signed��/////////////////////////////////////////
signed int mystrlen(const char* _str);				   //�m��
/////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////
///�������r�p�֐�//////////////////////////////////////////
bool mystrcmp(const char *String, const char *Words, const char Option='p');
bool mystrcmp(const char *String, const char Option, const int arg_num, ...);		//�����L�[���[�h��OR����
	//	'p'	�F���S��v�F	Words��""�̎��AFalse
	//	'l'	�F������v�F	Words��""�̎��ATrue
	//	'm'	�F������v�F	Words��""�̎��ATrue
/////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////
///���p�������m�T���p�֐�//////////////////////////////////////
char* mystrchr(char* string, char character);
/////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////
///������R�s�[�p�֐�////////////////////////////////////////
bool mystrcpy(char *String, const char *Source);
bool mystrcpy(char **String, const char **Source, const int SourceLineSize);
bool mystrcpy(char *String, const char *Source, int size_including_null);
/////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////
///������̗��[����]�v�ȕ��������֐�//////////////////////
bool mystrsmt(char *string, const char* uselesswords);
/////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////
///�����񌋍��p�֐�////////////////////////////////////////
bool mystrcat(char *string, const char* source);
/////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////
///������u���p�֐�////////////////////////////////////////
void mystrrep(char* string, const char* from, const char* to);
/////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////
///������召��r�p�֐�(greater)//////////////////////////////
bool mystrgrt(const char* string, const char* target, bool greater=true);
/////////////////////////////////////////////////////////////

////������n�����܂�/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////////
////�`��n//////////////////////////////////////////////////////////////////////////
CVector GetGraphSize(int GrHandle);		//�摜�̃T�C�Y��CVector�^�ŕԂ�
int LoadGraph(const TCHAR *filename, bool errorcheck);		//Dx���C�u������LoadGraph�̃t�@�C���G���[�o�͕t���ŁB�R�[�h�ߖ񂪖ړI�B

inline int DrawGraph(double x, double y, int GrHandle, int TransFlag){		//Dx���C�u������DrawGraph��double��int�Ɏ����L���X�g���Ă���邾��
	return DrawGraph((int)x, (int)y, GrHandle, TransFlag);
}
inline int DrawExtendGraph(double x1, double y1, double x2, double y2, int GrHandle, int TransFlag){		//Dx���C�u������DrawExtendGraph��double��int�Ɏ����L���X�g���Ă���邾��
	return DrawExtendGraph((int)x1, (int)y1, (int)x2, (int)y2, GrHandle, TransFlag);
}
inline int DrawTurnGraph(double x, double y, int GrHandle, int TransFlag){		//Dx���C�u������DrawTurnGraph��double��int�Ɏ����L���X�g���Ă���邾��
	return DrawTurnGraph((int)x, (int)y, GrHandle, TransFlag);
}
template<class T> int DrawCenterGraph(T cx, T cy, int GrHandle, int TransFlag);

int DrawString(int x, int y, int color, const TCHAR* format, ...);	//�t�H�[�}�b�g�Ή�
inline int DrawCenterString(int cx, int y, const TCHAR *String, int color, bool centerY=false){	//x�����E�̒��S�ɂ���DrawString�ŕ����`��i��y�͏㉺���S�ł͂Ȃ���Ӂj
	if (centerY){
		return DxLib::DrawString(cx-GetDrawStringWidth(String, strlen(String))/2, y-GetFontSize()/2, String, color);	//�����܂Ŗڈ� 
	}else{
		return DxLib::DrawString(cx-GetDrawStringWidth(String, strlen(String))/2, y, String, color); 
	}
}
int DrawCenterString(int cx, int y, int color, const TCHAR* format, ...);
int DrawCenterString(int cx, int y, int color, bool centerY, const TCHAR* format, ...);

inline int DrawBox(CRect _rect, int _color, bool _fillflag){
	return DxLib::DrawBox(_rect.Left, _rect.Top, _rect.Right, _rect.Bottom, _color, _fillflag);
}
////�`��n�����܂�//////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////
///�G���[&�f�o�b�O�o�͗p�֐�/////////////////////////////////
inline void myprintfDx(const char* format, va_list args, char* filename=NULL, int line=0){
	char string[1024];
	vsprintf_s(string, format, args);
	if (filename!=NULL) sprintf_s(string, "\n->%s(%d)\n", filename, line);

	printfDx(string);
	ScreenFlip();
	WaitKey();
	clsDx();
	ClearDrawScreen();
}
inline void ErrorDx(const char* format, char* filename, int line, ...){
	va_list args;
	va_start(args, format);
	myprintfDx(format, args, filename, line);
	va_end(args);
}
inline void ErrorDx(const char* format, ...){
	va_list args;
	va_start(args, format);
	myprintfDx(format, args);
	va_end(args);
}

inline void WarningDx(const char* format, char* filename, int line, ...){
	#ifndef	WARNINGDX_DISABLE 
		va_list args;
		va_start(args, format);
		myprintfDx(format, args, filename, line);
		va_end(args);
	#endif
}
inline void WarningDx(const char* format, ...){
	#ifndef	WARNINGDX_DISABLE 
		va_list args;
		va_start(args, format);
		myprintfDx(format, args);
		va_end(args);
	#endif
}

inline void DebugDx(const char* format, char* filename, int line, ...){
	#ifndef	DEBUGDX_DISABLE 
		va_list args;
		va_start(args, format);
		myprintfDx(format, args, filename, line);
		va_end(args);
	#endif
}
inline void DebugDx(const char* format, ...){
	#ifndef	DEBUGDX_DISABLE 
		va_list args;
		va_start(args, format);
		myprintfDx(format, args);
		va_end(args);
	#endif
}
/////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////
//////����Choose�֐�/////////////////////////////////////////
int choose(const int target, ...);	//int����	//VB6�d�l�i��ڂ��w�肵������target=1�j
/////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////
///KeyDown����p�֐�/////////////////////////////////////////
const int KEY_INPUT_OK = -1;
const int KEY_INPUT_CANCEL = -2;

namespace nunuLibKey{			//�N���X���Փ˂�����邽�ߖ��O��Ԃɕ��
	class CKeyManager{		//�\���̕ϐ��ɂ��Ă��������ǂȂ�ׂ�static���g�������Ȃ�����
	public:
		CKeyManager();
		bool CheckDown(const int KEY_CODE);
	private:
		bool Pressed[256];
	};
}
bool CheckHitKeyDown(const int KEY_CODE); //������L�[���Z,Enter  �L�����Z���L�[���X,BackSpace  ���ꂼ��ǂ���ł���
/////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////
//////�t�H�[�}�b�g�Ή��E�B���h�E�^�C�g���ύX�֐�/////////////
int SetTitle(const char* format, ...);		//Dxlib�֐�SetMainWindowText�̏�ʌ݊�
/////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////
////���̑�///////////////////////////////////////////////////
template<class T>inline T between(const T& min_border, const T& max_border, const T& num)	//num��min_border�ȏ�max_border�ȉ��ɂȂ�悤�`�F�b�N	�������͂��ׂČ^�������łȂ��Ă͂Ȃ�Ȃ�
{	return max((min_border), min((max_border), (num)));
}
inline int mod(int a, int b){	//VB6�̂悤�ɕK���񕉂̂��܂��Ԃ��֐��B%���Z�q�͕��̐�����肤��̂ŕs�ցB
	return ((b)+((a)%(b)))%(b);
}
inline bool BasicLoop(){
	#ifndef FPS_DISABLE
		static int start = GetNowCount();
		static int counter = 0;
		static int fps = 0;
		++counter;
		if (counter==30){
			fps = counter*1000/(GetNowCount()-start);
			start = GetNowCount();
			counter = 0;
		}
		DrawFormatString(WINDOW_WIDTH-20, WINDOW_HEIGHT-20, GRAY, "%d", fps); 
	#endif

	if(ScreenFlip()==0 && ProcessMessage()==0 && ClearDrawScreen()==0){
		return true;
	}else{ return false;}
}
/////////////////////////////////////////////////////////////

//}

////���d�C���N���[�h�h�~�i�C���N���[�h�K�[�h�j//
#endif										////
////////////////////////////////////////////////