#include "../Define.h"
#include "Main.h"

#include "../Mrt.h"
#include "../Field/Field.h"
#include "../Field/Load.h"


bool CMain::Init(){
	srand((unsigned int)GetNowCount());
	//ChangeFont("�l�r �o�S�V�b�N") ;	$
	
	if (_mkdir("tenyu_data")==0){
		_rmdir("tenyu_data");
		ErrorDx("Error->NotFound dir\"tenyu_data\" (exit)");
		return false;
	}

	return true;
	//�G���[���ɂ�return false
}

bool CMain::GameLoop(){
	int dnum;

	StartDemo();

	if (PLAYDATA_NUM>0){
		CLoad PlayDataLoad;
			char path[256]; strcpy_s(path, "tenyu_data/save");
			PlayDataLoad.LoadPlayData(path, PlayData);
	}

	while(1){
		switch(Title()){
		case TITLE_FIRSTSTART:
			Opening();
			return Playing();

		case TITLE_LOADSTART:
			if (PLAYDATA_NUM>0 && (dnum = ChooseData()) != -1){
				return Playing(dnum);
			}
			break;

		case TITLE_SETTING:
			Setting();
			break;
		
		case TITLE_GAMEEND:
			return false;

		default:
			WarningDx("Warning->Unexpected matter happend [back to title]->GameLoop()", __FILE__, __LINE__);
		}
	}

	return true;
}

bool CMain::Playing(const int _dnum){
	//DebugDx("PlayingStart");
	CField Field;
	//DebugDx("Playing_CFieldCreate");
	if (!Field.Init((PLAYDATA_NUM>0?PlayData:NULL), _dnum)) return true;
	//DebugDx("Playing_FieldInit_finish");

	switch (Field.MainLoop()){
	case MODE_GAMEOVER:
		return GameOver();
	case MODE_GAMECLEAR:
		return GameClear();
	case MODE_BACKTOTITLE:
		return true;
	case MODE_GAMEEND:
		return false;
	default:
		WarningDx("Warning->Unexpected matter happend [back to title]->Playing(int_dnum)", __FILE__, __LINE__);
		return true;
	}
}

int CMain::Title(){
	return mrt::Title();
}

int CMain::ChooseData(){		//�Z�[�u�f�[�^�̑I�����
	return mrt::ChooseData(PlayData);
}

void CMain::StartDemo(){
	int timecount = 0;
	int scene = 0;
	
	CheckHitKeyDown(KEY_INPUT_OK);	//�L�[��Ԃ����Z�b�g
	while( BasicLoop() && !CheckHitKeyDown(KEY_INPUT_ESCAPE) && !CheckHitKeyDown(KEY_INPUT_OK)  && !CheckHitKeyDown(KEY_INPUT_CANCEL) && scene != -1){
		
		switch(scene){
		case 0:
			if (timecount<255) {
				SetDrawBlendMode(DX_BLENDMODE_ALPHA, timecount);
			}else if(timecount<255*2){
				SetDrawBlendMode(DX_BLENDMODE_ALPHA, 255-(timecount-255));
			}else if(timecount==255*2){
				scene = -1;
				break;
			}
			DrawCenterString(WINDOW_WIDTH/2, (int)(WINDOW_HEIGHT*2/5), "Opening Demo", WHITE);
			DrawCenterString(WINDOW_WIDTH/2, (int)(WINDOW_HEIGHT*4/5), "Presented by MathLabo OBOG in IH", WHITE);
			break;
		}
		
		timecount++;
	}

	SetDrawBlendMode(DX_BLENDMODE_NOBLEND, 0);
};


void CMain::Opening(){
	int oldfontsize = GetFontSize();
	
	mrt::Opening();

	SetFontSize(oldfontsize);
	SetDrawBlendMode(DX_BLENDMODE_NOBLEND, 0);
};


bool CMain::GameOver(){
	int timecount=0;

	while( BasicLoop()){
		if (timecount<255) {
			SetDrawBlendMode(DX_BLENDMODE_ALPHA, timecount);
		}else{	
			SetDrawBlendMode(DX_BLENDMODE_NOBLEND, 0);		
			if (int(timecount/40)%2) DrawCenterString(WINDOW_WIDTH/2, (int)(WINDOW_HEIGHT*4/5), "Z���^�C�g���֖߂�, X���Q�[���I��", GRAY);
		}
		
		DrawCenterString(WINDOW_WIDTH/2, (int)(WINDOW_HEIGHT*2/5), "GAME OVER", WHITE);
		timecount++;

		if (CheckHitKeyDown(KEY_INPUT_OK)){
			SetDrawBlendMode(DX_BLENDMODE_NOBLEND, 0);	
			return true;
		}else if (CheckHitKeyDown(KEY_INPUT_CANCEL) || CheckHitKeyDown(KEY_INPUT_ESCAPE)){
			SetDrawBlendMode(DX_BLENDMODE_NOBLEND, 0);	
			return false;
		}
	}
	WarningDx("Warning->Unexpected error happend[program_end]: GameOver()", __FILE__, __LINE__);
	return false;
};

bool CMain::GameClear(){
	int timecount=0;

	while( BasicLoop() ){
		if (timecount<255) {
			SetDrawBlendMode(DX_BLENDMODE_ALPHA, timecount);
		}else{	
			SetDrawBlendMode(DX_BLENDMODE_NOBLEND, 0);		
			if (int(timecount/40)%2) DrawCenterString(WINDOW_WIDTH/2, (int)(WINDOW_HEIGHT*4/5), "Z���^�C�g���֖߂�, X���Q�[���I��", GRAY);
		}
		
		DrawCenterString(WINDOW_WIDTH/2, (int)(WINDOW_HEIGHT*2/5), "GAME CLEAR!", WHITE);
		timecount++;

		if (CheckHitKeyDown(KEY_INPUT_OK)){
			SetDrawBlendMode(DX_BLENDMODE_NOBLEND, 0);	
			return true;
		}else if (CheckHitKeyDown(KEY_INPUT_CANCEL) || CheckHitKeyDown(KEY_INPUT_ESCAPE)){
			SetDrawBlendMode(DX_BLENDMODE_NOBLEND, 0);	
			return false;
		}
	}

	WarningDx("Error->Unexpected matter happend[program_end]: GameClear()", __FILE__, __LINE__);
	return false;
}

void CMain::Setting(){
	int oldfontsize = GetFontSize();
	
	while(mrt::Setting()){
		//�ݒ菈��
	}

	SetFontSize(oldfontsize);
}