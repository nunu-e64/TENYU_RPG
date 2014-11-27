////���d�C���N���[�h�h�~�i�C���N���[�h�K�[�h�j//
#ifndef DEFINE_H							////
#define DEFINE_H							////
////////////////////////////////////////////////

//#define PRODUCT_MODE  //���i��
	#ifdef PRODUCT_MODE
		#define WARNINGDX_DISABLE	//�}�N���̗L����/������
		#define DEBUGDX_DISABLE	//�}�N���̗L����/������
		#define CHECK_TIME_DISABLE	//�}�N���̗L����/������
		#define MEMORY_CHECK_DISABLE //�}�N���̗L����/������
		#define FPS_DISABLE
	#endif

//#define DEBUG_MODE	//�v���O���}�f�o�b�O�� �i���̃����o�[�ɓn�����ɂ̓R�����g�A�E�g�j
	#ifndef DEBUG_MODE
		#define DEBUGDX_DISABLE	//�}�N���̗L����/������
		#define WARNINGDX_DISABLE	//�}�N���̗L����/������
		#define CHECK_TIME_DISABLE	//�}�N���̗L����/������
		#define MEMORY_CHECK_DISABLE //�}�N���̗L����/������
	#endif

#include "Dxlib.h"
#include <vector>

//#define MEMORY_CHECK
	#if defined(MEMORY_CHECK) && !defined(MEMORY_CHECK_DISABLE)
		#include <crtdbg.h>
		#define new  ::new( _NORMAL_BLOCK, __FILE__, __LINE__ )  
	#endif

#include "nunuLib.h"
//using namespace nunuLib;

//"Mrt.h"��Define.h���C���N���[�h���Ă���̂�Mrt.h�͎g���Ƃ��ƂŔC�ӂɃC���N���[�h


////////////////////////////////////////////////
#define MAP_MAX_CHECK(_mapnum, _return) {	\
	if (!(_mapnum<MAP_MAX)){				\
		ErrorDx("Error overnum[MapMax]: %d",_mapnum);return _return;	\
	}else if(_mapnum<0){					\
		ErrorDx("Error mapnum<0: %d",_mapnum);return _return;	\
	}}

const int PLAYDATA_NUM = 0;	//�Z�[�u�f�[�^�̐�(0~3)
const int MAP_CHIP_SIZE = 32;
const int MAP_SIZE = 128;		//�����`��z��
const int MAP_DATA_SIZE = 256;	//�o�C�i���f�[�^�Ɋi�[����Ă���f�[�^�̍ő�l�i256=0~255=8bit=1byte�j

const char MAP_FILE_TYPE[] = ".Map2";
const char EMAP_FILE_TYPE[] = ".eMap";

const unsigned int MAP_MAX = 2;	//�ǂݍ��߂�}�b�v�̍ő吔	//MAP�f�[�^�z��̈ꎟ�̗v�f��
const int CHARA_PIC_NUM = 16;	//�L�����̊G���ꖇ���R�}�Ȃ̂�

//�퓬�֘A///////////////////////////////////////////////
const int MAX_PLAYER_NUM = 3;
const int MAX_ENEMY_NUM = 3;
const int MAX_MP = 10;
/////////////////////////////////////////////////////////
const char GAME_TITLE[] = "TENYU";
const char VERSION[] = "ver0.00";

////////////////////////////////////////////////////////
const char CMD_SEPARATOR[] = " ,	";
const char EOP[] = "EOP";	//EndOfParagraph

const char IFBEGIN[] = "IF_BEGIN";
const char IFEND[] = "IF_END";
const char IFCASE[] = "CASE";
const char _IFBEGIN[] = "_IF_BEGIN";
const char _IFEND[] = "_IF_END";
const char _IFCASE[] = "_CASE";
const char JOKER_NAME[] = "joker";
////////////////////////////////////////////////////

enum gamemode_tag{
	MODE_PLAYING,
	MODE_GAMEOVER,
	MODE_GAMECLEAR,
	MODE_BACKTOTITLE,
	MODE_GAMEEND,
};
enum title_tag{
	TITLE_FIRSTSTART,
	TITLE_LOADSTART,
	TITLE_SETTING,
	TITLE_GAMEEND,
	TITLE_NUM,
};
enum direction_tag{		//���ԕύX�֎~�iSystem.cpp�Ŏg�p�j
	RIGHT,
	LEFT,
	DOWN,
	UP,
	DIRECTION_NUM
};
enum objkind_tag{
	PANEL,				//���ނ��ƂŃC�x���g�J�n
	WALKABLE_NUM,	//����������Kind�̓v���C���[�����������Ƃ��ł���i�����蔻�肪�Ȃ����ނ��ƂŃC�x���g�j
	BLOCK,				//BLOCK,NPC�͒��ׂ邱�ƂŃC�x���g�J�n
	NPC,
	PUSHBLOCK,			//�������ƂŃC�x���g�J�n�i���ׂȂ��j
	UNDERDRAW_NUM,	//���������i�����Ƃ��Ă͏������j��Kind�̓v���C���[�L�����̉��ɕ`��
	COVER,				//�C�x���g�J�n���@���Ȃ��A������s�\
	KIND_NUM
};
enum charaeffect_tag{
	NONE,
	BLINK,
	KEEP_NUM,		//�������艺�i�����Ƃ��Ă͑傫���j�Ƃ��̓C�x���g�������ɁA�ꎞ�I��Effect��NONE�ɂȂ�
	RND_DIR,
	WALK,
	EFFECT_NUM
};
enum btlresult_tag{
	WIN,
	LOSE,
	LOSE_NOSCREENCHANGE
};
struct char256{
	char text[256];
	bool operator<(const char256& obj)const{
		return mystrgrt(text, obj.text, false);
	}
	bool operator>(const char256& obj)const{
		return mystrgrt(text, obj.text, true);
	}
};

//���p�֐���N���X/////////////////////////////////
namespace sys{
	direction_tag TurnDir(int _dir, signed int _rightspin);
	direction_tag StrtoDir(const char* _str, int _originaldir=DOWN);
	bool PlayerName(const char* _str);
	bool TrueOrFalse(const char* _str, bool _torf);
	int rank3(const char* _str, int _exception=2);
}
struct sideeffect_tag{
	enum{
		ATK_UP,
		ATK_DOWN,
		HEAL_ME,
		HEAL_FRIEND,
		HEAL_PARTY,
		TRICKEFFECT_NUM,
	}; int TrickEffect;
	int Power;		//���ʗ�
	int Incidence;	//�����m��
};
struct trick_tag{
	char Name[32];
	int Power;
	int Cost;
	std::vector <sideeffect_tag> SideEffect;

	enum targetType_tag{
		SINGLE,
		ALL,
		SINGLE_FRIEND,
		ALL_FRIEND,
		TARGETTYPE_NUM,
	}TargetType;

};

struct flag_tag{
	char Key[32];
	int Num;
};

class CFlagSet{
public:
	CFlagSet(){}

	bool CreateNewFlag(const char* _key){
		for(unsigned int i=0; i<Flag.size(); i++){
			if (mystrcmp(Flag[i].Key, _key)) return false;
		}
		CreateFlag(_key, 0);
		return true;
	}

	void SetFlag(const char* _key, int _num=0, bool _add=false, bool _create=false){
		for(unsigned int i=0; i<Flag.size(); i++){
			if (mystrcmp(Flag[i].Key, _key)) {
				int num = (_add? Flag[i].Num+_num: _num);

				if (num<0) ErrorDx("Error->You can't set [num<0] for FLAG (changed to 0):%s", _key);
				Flag[i].Num=max(0,num);
				return;
			}
		}

		if (_create){
			CreateFlag(_key, _num);
		}else{
			ErrorDx("Error->Not Found Flag[%s]", _key);
		}
	};

	int GetFlagNum(const char* _key){
		for(unsigned int i=0; i<Flag.size(); i++){
			if (mystrcmp(Flag[i].Key, _key)) return Flag[i].Num;
		}
		ErrorDx("Error->Not Found Flag[%s] (return -2)", _key);
		return -2;	//����`
	};
	
	std::vector <flag_tag> Flag;

private:
	
	bool CreateFlag(const char* _key, int _num=0){
		flag_tag newflag;
		mystrcpy(newflag.Key, _key, 32);

		if (_num<0){
			ErrorDx("Error->You can't use [num<0] for FLAG (changed to 0) :%s", _num);
			newflag.Num = 0;
		}else{
			newflag.Num = _num;
		}
		
		Flag.push_back(newflag);
		return true;
	};
};

////////////////////////////////////////////////


//�Z�[�u�f�[�^�p�̍\����/////////////////////////////////
class CEveObj;
struct playdata_tag{
	bool Exist;		//�Z�[�u�f�[�^�����݂��邩�ۂ�

	int NowMap;
	unsigned int X, Y;
	unsigned int OldX, OldY;
	char PlayerPicKey[32];
	enum direction_tag Dir;
	int Step;	//0~3
	int Dx, Dy;
	bool Visible;

	CFlagSet FlagSet;
	std::vector<CEveObj> EveObj;

	char DataName[32];

};
///////////////////////////////////////////////////


////���d�C���N���[�h�h�~�i�C���N���[�h�K�[�h�j//
#endif										////	
////////////////////////////////////////////////