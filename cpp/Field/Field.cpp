#include "../Define.h"
#include "Field.h"
#include "Load.h"

///�����o�ϐ��ɂ���ƃo�O��////////////////
static CTextBox TextBox1;
static CTextWrap TextWrap1;
static CBattle Battle;
///////////////////////////////////////////


CField::~CField(){
	DebugDx("Field_Destruct");
	
	Map.Init();
	EveManager.Init();
	Battle.Term();
}

bool CField::Init(playdata_tag* _playdata_p, const int _dnum){
	CHECK_TIME_START
	
		//���ϐ��̏�����
			NowMap=0;
			GodX = GodY = 0;

			X = Y = 0;		OldX=X; OldY=Y;
			Dir=DOWN; 
			Step=0;			Dx = Dy = 0; 
			Visible=true;
			Alpha = 255;		
			Effect=NONE;
			ImgBackGround = NULL;
			TextAutoPlaySpeed = 1000;

			Mode = MODE_PLAYING;

	//DebugDx("TextBox_Init_Start");

		//���C���̃e�L�X�g�{�b�N�X�ƃI�[�o�[���b�v�p�e�L�X�g�{�b�N�X�̏�����
			TextBox1.Init(60, 370, WINDOW_WIDTH-80*2, 100, 3, 25*2, 16, WHITE, BLACK, TextAutoPlaySpeed);
			TextWrap1.Init(100, 100, 400, 300, 30, 30*2, 14, WHITE, GRAY, TextAutoPlaySpeed);  
			TextBox = &TextBox1;

	//DebugDx("TextBox_Init_End");

		////WorldManager�̃|�C���^�ϐ��ɑ��
		//	EveManager_p = &EveManager;
		//	FlagSet_p = &FlagSet;
		//	CmdList_p = &CmdList;
		//	DebugDx("OK");
		//	

		//CBattle�̏�����
			if (!(Battle.Init())) return false;

	//DebugDx("Battle_Init_End");
			
		//�O���e�L�X�g�̃��[�h
			CLoad SystemLoad;
			CLoad ScenarioLoad;
			CFirstSetCmdManager FirstSetCmdManager;
			CCmdList SystemCmdList;
			
			if ((SystemLoad.LoadAddText("tenyu_data/system.rpg"))
				&&(ScenarioLoad.LoadAddText("tenyu_data/scenario.rpg"))
				&&(ScenarioLoad.LoadAddText("tenyu_data/event.rpg"))){
			
				SystemLoad.CommandCopy(&SystemCmdList);
				FirstSetCmdManager.Main(&SystemCmdList, this, &Map, &EveManager);

				ScenarioLoad.EventTextCopy(&EveManager);	//�����ɒ��ӁiCmdManager.Main�̌�j	
			
			}else{
				return false;
			}
	
	//DebugDx("Load_Init_End");
			
		//�Z�[�u�f�[�^�̓ǂݍ���
			if (PLAYDATA_NUM>0) PlayData_p = _playdata_p;
			if (!StartSet(_dnum)) return false;

	CHECK_TIME_END("Init_Field")
		
	return true;
}

int CField::MainLoop(){	//�Q�[�����͂��̃��[�v������o�Ȃ�


	while( BasicLoop() ){
	
		CHECK_TIME_START	

		if( !TextBox->Main(&CmdList, &FlagSet)){	//�e�L�X�g�\�����̓L�[���얳���i�e�L�X�g�����TextBox.Main�Ŕ���j
			
			if (OldX!=X||OldY!=Y) {		//�A�N�V�����R�}���h�ɂ��ړ�����p
				OldX=X; OldY=Y;
				if (CheckEvent(true)) {
					TextBox->NextPage(&CmdList, &FlagSet);		//�����Ƀe�L�X�g���ݒ肵�Ă���Ε\��
				}

			}else if (CheckHitKeyDown(KEY_INPUT_OK)){
				if (CheckEvent(false)) TextBox->NextPage(&CmdList, &FlagSet);		//�ڂ̑O�̃I�u�W�F�N�g�Ƀe�L�X�g���ݒ肵�Ă���Ε\��
				
			}else{
				//���s/////////////////////////////////////////////////////
				int walkspeed = ((CheckHitKey(KEY_INPUT_LSHIFT)||CheckHitKey(KEY_INPUT_RSHIFT))? 4:2);
				#ifndef PRODUCT_MODE
					walkspeed = ((CheckHitKey(KEY_INPUT_LCONTROL)||CheckHitKey(KEY_INPUT_RCONTROL))? MAP_CHIP_SIZE:walkspeed);
				#endif
				
				//PUSHBLOCK���������Ƃ�����Walk����true���Ԃ�
				if(CheckHitKey(KEY_INPUT_RIGHT)){		if(Walk(RIGHT, walkspeed))TextBox->NextPage(&CmdList, &FlagSet);
				}else if(CheckHitKey(KEY_INPUT_LEFT)){	if(Walk(LEFT, walkspeed))TextBox->NextPage(&CmdList, &FlagSet);
				}else if(CheckHitKey(KEY_INPUT_DOWN)){	if(Walk(DOWN, walkspeed))TextBox->NextPage(&CmdList, &FlagSet);
				}else if(CheckHitKey(KEY_INPUT_UP)){	if(Walk(UP, walkspeed))TextBox->NextPage(&CmdList, &FlagSet);
				}
				X = between(0, MAP_SIZE-1, (int)X);
				Y = between(0, MAP_SIZE-1, (int)Y);
				
				if (OldX!=X||OldY!=Y) {		//�ړ����Ȃ��������͑����`�F�b�N���Ȃ�
					OldX=X; OldY=Y;
					if (CheckEvent(true)){
						TextBox->NextPage(&CmdList, &FlagSet);		//�����Ƀe�L�X�g���ݒ肵�Ă���Ε\��
					}else{
						//�퓬�G���J�E���g����
						if (Battle.CheckEncount(NowMap, Map.GetMapData(NowMap, X, Y))){
							CmdList.Add("@BattleEncount");
						}
					}
				}
				///////////////////////////////////////////////////////////
				
			}

			////�e�X�g�p�F�Q�[���I�[�o�[���N���A���Z�[�u///////////$
				if (CheckHitKey(KEY_INPUT_S) && CheckHitKey(KEY_INPUT_LCONTROL)){
					SaveData(0);
					TextBox->AddStock("0�Ԃɏ㏑���ۑ����܂���");	TextBox->NextPage(&CmdList, &FlagSet);

				}else if (CheckHitKey(KEY_INPUT_LCONTROL)){
					int tmpdnum=-1;
					if (CheckHitKey(KEY_INPUT_0)){			tmpdnum = 0;
					}else if (CheckHitKey(KEY_INPUT_1)){	tmpdnum = 1;
					}else if (CheckHitKey(KEY_INPUT_2)){	tmpdnum = 2;
					}else if (CheckHitKey(KEY_INPUT_3)){	tmpdnum = 3;						
					}
					if (tmpdnum!=-1){
						while(1){
							//�Z�[�u�f�[�^���̎��R����
							char dataname[32];	dataname[0]='\0';
							char inputchar;		char inputmessage[64];
							ClearInputCharBuf() ;
							while(BasicLoop()){
								// �������̓o�b�t�@���當�����擾����
								inputchar = GetInputChar( TRUE ) ;
								// ����R�[�h�ȊO�̕������͂��������ꍇ�̂ݏ������s��
								if( inputchar == CTRL_CODE_CR && strlen(dataname)>0){		//Enter
									break;
								}else if( inputchar == CTRL_CODE_BS && strlen(dataname)>0){	//BackSpace
									dataname[strlen(dataname)-1]='\0';
								}else{
									switch(inputchar){
									case '.':	case '|':	case '\\':	case '/':	case ':':	case '>':	case '<':	case '?':	case '*':	case '"':	case ' ':	case '%':	//�Ȃ����m���%���g�p����Ɖ����Ȃ��G���[�ɂȂ�	//�t�H���_�Ɏg�p�ł��Ȃ��������̑��̔r��
										break;
									default:
										if( inputchar != 0 && inputchar >= CTRL_CODE_CMP && strlen(dataname)<ARRAY_SIZE(dataname)-1){
											dataname[strlen(dataname)+1]='\0';
											dataname[strlen(dataname)]=inputchar;
										}
									}
								}

								sprintf_s(inputmessage, "Input Save Data Name->%s%s", dataname, (strlen(dataname)<ARRAY_SIZE(dataname)-1?"_":""));
								DrawString(0, 0, inputmessage, WHITE);
							}

							//�Z�[�u���ʂɉ����ď�������i-1�F�G���[�A0�F���g���C�A1�F�����j
							int saveResult= SaveData(tmpdnum, dataname);
							if (saveResult == 1){
								char tmpmessage[32];			sprintf_s(tmpmessage, "%d�ԂɃZ�[�u���܂���", tmpdnum);
								TextBox->AddStock(tmpmessage);	TextBox->NextPage(&CmdList, &FlagSet);
								break;
							}else if(saveResult == 0){
								char tmpmessage[128];			sprintf_s(tmpmessage, "���ɓ����̃Z�[�u�f�[�^���ʃX���b�g�ɑ��݂��܂��B�ʂ̖��O����͂��Ă��Ă��������B�m%s�n", dataname);
								TextBox->AddStock(tmpmessage);	//TextBox->NextPage(&CmdList, &FlagSet);
								while(BasicLoop()){
									if( !TextBox->Main(&CmdList, &FlagSet)) {
										break;	//�e�L�X�g�{�b�N�X�������ꂽ��ē��͉�ʂ�
									}else{
										FieldCmdManager.Main(&CmdList, this, &Map, TextBox, &EveManager);
										Draw();
									}
								}
							}else{
								break;
							}
						}
					}

				}else if (CheckHitKey(KEY_INPUT_1)){
					return MODE_GAMECLEAR;
				}else if (CheckHitKey(KEY_INPUT_2)){
					return MODE_GAMEOVER;
				}else if (CheckHitKeyDown(KEY_INPUT_ESCAPE) || CheckHitKey(KEY_INPUT_3)){
					return MODE_BACKTOTITLE;
				}else if (CheckHitKeyDown(KEY_INPUT_P)){
					CmdList.Add("@AutoPlay_Set(true,1)");
				}else if (CheckHitKeyDown(KEY_INPUT_B)){;
					CmdList.Add("@Battle(bg_01, �G�l�~�[C, �G�l�~�[B, �G�l�~�[A)");
				}


			////////////////////////////////////////////////
		}

		CHECK_TIME_END("Main_Walk")	

		////�f�o�b�O�̎��ɂ̓v���C���[���W���^�C�g���o�[�ɕ\��////////////////////////////////////////
			#ifndef PRODUCT_MODE
				SetTitle("Map_%d Pos_%d:%d Data_%d:%d", NowMap, X, Y, Map.GetMapData(NowMap, X, Y, 0),Map.GetMapData(NowMap, X, Y, 1));
			#endif

		////TextBox�Ȃǂɂ����CmdList�ɒ~�ς��ꂽ�R�}���h������////////////////////////////////////////
			CHECK_TIME_START	FieldCmdManager.Main(&CmdList, this, &Map, TextBox, &EveManager);	CHECK_TIME_END("Command.Main")
			if (Mode != MODE_PLAYING)	return Mode;


		////�`��////////////////////////////////////////
			CHECK_TIME_START
			Draw();
			CHECK_TIME_END("Draw")

				
	}
	return MODE_GAMEEND;
}

void CField::Draw(bool _screenflip, bool _textshowingstop, int dx, int dy, bool _playeralsoshake){
	
	if (ImgBackGround!=NULL){	//�w�i�ꖇ�G���[�h�̂Ƃ�
		CVector picsize = GetGraphSize(ImgBackGround);
		DrawGraph(WINDOW_WIDTH/2-picsize.x/2, WINDOW_HEIGHT/2-picsize.y/2, ImgBackGround, true);
	}else{

		///�_�V�X�e����肩��////////////////////////////////////////////////////////////////
		GodX = 0; GodY = 0;
		dx+=GodX*MAP_CHIP_SIZE; dy+=GodY*MAP_CHIP_SIZE;
		/////////////////////////////////////////////////////////////////////////////


		//�}�b�v�`��////////////////////////////////////////////////////////////////////////////
		CHECK_TIME_START2	Map.Draw(NowMap, X, Y, dx, dy);			CHECK_TIME_END2("Map.Draw")
		CHECK_TIME_START2	EveManager.Draw(NowMap, X, Y, false, dx, dy);	CHECK_TIME_END2("EveManager.Draw_under")

		//�v���C���[////////////////////////////////////////////////////////////////////////////
			switch(Effect){
			case NONE:
				break;
			case BLINK:
				Alpha = between(0,255,Alpha+EffectNum[3]);
				if (Alpha<=(EffectNum[0]*255/100)) EffectNum[3] = -EffectNum[3];
				if (Alpha>=(EffectNum[1]*255/100)) EffectNum[3] = -EffectNum[3];
				Alpha = between(EffectNum[0]*255/100, EffectNum[1]*255/100, (int)Alpha);
				break;
			}

			SetDrawBlendMode( DX_BLENDMODE_ALPHA, Alpha);
			CVector playerD(Dx,Dy);
				if(!_playeralsoshake){playerD.Add(-GodX*MAP_CHIP_SIZE,-GodY*MAP_CHIP_SIZE);
				}else{				  playerD.Add(-dx,-dy);}
					if(Visible) DrawGraph(playerD.x+WINDOW_WIDTH/2-MAP_CHIP_SIZE/2, playerD.y+WINDOW_HEIGHT/2-MAP_CHIP_SIZE/2, ImgPlayer[Dir*4+mod(Step,4)], true);	//_a.png�œ��ߏ���ǂݍ��ݍς�
			SetDrawBlendMode( DX_BLENDMODE_NOBLEND , 0 );
		//////////////////////////////////////////////////////////////////////////////////////////
	
		CHECK_TIME_START2	EveManager.Draw(NowMap, X, Y, true, dx, dy);	CHECK_TIME_END2("EveManager.Draw_over")
	}

	////////////////////////////////////////////////////////////////////////////////////////
	//�e�L�X�g�{�b�N�X�`��//////////////////////////////////////////////////////////////////
	TextBox->Draw(!CmdList.Empty() || _textshowingstop);
	////////////////////////////////////////////////////////////////////////////////////////
	
	if (_screenflip)	{BasicLoop();}
}
	
bool CField::Walk(int _dir, int _walkspeed, bool _eventwalk, bool _walk, int _fade){	
	if(_walk){
		SetMyDir(_dir);
		if(_walkspeed<0) _dir=sys::TurnDir(_dir, 2);
		if (CheckHitKey(KEY_INPUT_A) && !_eventwalk)return false;	//A�������Ȃ���ŕ����]���̂�
	}

	if (Map.GetMapData(NowMap, (X+((_dir==RIGHT)? 1: ((_dir==LEFT)? -1: 0)))%MAP_SIZE, (Y+((_dir==DOWN)? 1: ((_dir==UP)? -1: 0)))%MAP_SIZE, 1)) return false;	//��Q���̗L�����m�F
	if (!_eventwalk) if (CheckEvent(false, true)) return true;	//������u���b�N�iPUSH_BLOCK�j�̃C�x���g�L�����`�F�b�N		//_eventwalk�̎��͒ʂ�Ȃ��悤�ɂ���������������
	if (!EveManager.CheckWalkable(NowMap, (X+((_dir==RIGHT)? 1: ((_dir==LEFT)? -1: 0)))%MAP_SIZE, (Y+((_dir==DOWN)? 1: ((_dir==UP)? -1: 0)))%MAP_SIZE)) return false;	//NPCorBLOCK�̗L�����m�F

	int d=0, oldd=0;	//delta;
	int dx=0, dy=0;
	if (_walkspeed==0) _walkspeed=2;
	if (_walkspeed<0) _walkspeed=-_walkspeed;

	if (_walk) (++Step)%=4;
	int alpha = Alpha;
	if (_fade==1) {Visible = true; Alpha = 0;}

	while(d!=MAP_CHIP_SIZE){
		oldd=d;
		d = between(-MAP_CHIP_SIZE, MAP_CHIP_SIZE, d+_walkspeed);
		if (oldd/(MAP_CHIP_SIZE/2)<1 && d/(MAP_CHIP_SIZE/2)>=1) {
			if(_walk)(++Step)%=4;
		}
		dx = ((_dir==RIGHT)? d: ((_dir==LEFT)? -d: 0));
		dy = ((_dir==DOWN)? d: ((_dir==UP)? -d: 0));
		
		//Draw(true, true, dx, dy);	//140904�ύX�@�����Ȃ�����e�L�X�g�\�����i�ނ悤�ɁB�����s����o���_eventewalk�ŏ�����ς���B
		Draw(true, false, dx, dy);

		if (_fade==1)  Alpha = between(0, 255, (int)(alpha*(double)abs(d)/MAP_CHIP_SIZE));
		if (_fade==-1) Alpha = between(0, 255, (int)(alpha*(1-(double)abs(d)/MAP_CHIP_SIZE)));

	};

	if (_fade==-1) {
		Visible = false;
		Alpha = alpha;
	}


	switch(_dir){
	case RIGHT:
		X++;	break;
	case LEFT:
		X--;	break;
	case UP:
		Y--;	break;
	case DOWN:
		Y++;	break;
	}
		
	return false;
}

void CField::Jump(){
	Dy=-5;	
	for(int i=0; i<5; i++){
		Draw(true, true);
	}
	Dy=0;
	Draw(true, true);
}

void CField::SetPosition(int _mapnum, int _x, int _y, bool _d){
	if (_mapnum>=0){
		MAP_MAX_CHECK(_mapnum,);	
		NowMap = _mapnum;
	}
	X = (_d? X+_x:_x) % MAP_SIZE;
	Y = (_d? Y+_y:_y) % MAP_SIZE;
}
void CField::SetMyPic(const int _img[CHARA_PIC_NUM], const char* _pickey){
	for(int i=0; i<CHARA_PIC_NUM; i++){
		ImgPlayer[i] = _img[i];
	}
	strcpy_s(PlayerPicKey, _pickey);
}


void CField::ChangeTextMode(bool _box, const char* _eventtext){
	if (_box){
		TextBox = &TextBox1;
	}else{
		TextBox = &TextWrap1;

		if (_eventtext!=NULL){	//EveManager::CopyOriginalEvent��ėp�����グ�ĉ��P�B�����TextWrap1��@EventWrap�̓��e��n����
			std::vector<char256> tmptext;
			EveManager.CopyOriginalEvent(&tmptext, _eventtext);
			for (unsigned int i=0; i<tmptext.size(); i++){
				TextWrap1.AddStock(tmptext[i].text);
			}
			TextBox->NextPage(&CmdList, &FlagSet);
		}
	}
};

void CField::SetMyEffect(int _effectname, int _effectnum[]){
		
		if (_effectname==-1) {	//TextBox.Term����̌Ăяo��
			return;
		}

		Effect = (charaeffect_tag)_effectname;

		for (int i=0; i<ARRAY_SIZE(EffectNum); i++){
			EffectNum[i] = 0;
			EffectNumCmd[i] = 0;
			if (_effectnum[i]!=-1 && _effectname!=NONE)	EffectNumCmd[i] = _effectnum[i];
		}

		switch(Effect){
		case NONE:
			SetMyAlpha(255);
			break;
		case BLINK:
			if (EffectNumCmd[0]<0 || 
				EffectNumCmd[0]>100 || EffectNumCmd[1]<0 || EffectNumCmd[1]>100) {
				ErrorDx("Error->SetMyEffect-> 0<=BLINK_num<=100", __FILE__, __LINE__);
				goto reset;
			}else{
				EffectNum[0] = between(0, 100, EffectNumCmd[0]);
				EffectNum[1] = between(0, 100, EffectNumCmd[1]);
				EffectNum[2] = between(1, 10000, EffectNumCmd[2]);
				EffectNum[3] = between(1, 255, ((EffectNumCmd[1]-EffectNumCmd[0])*255*2*10) / (EffectNumCmd[2]*60));
			}
			break;
		case RND_DIR:
		case WALK:
			ErrorDx("Error->CField::SetMyEffect->You can't set [RND_DIR]or[WALK] for Player ....yet?",__FILE__,__LINE__);
			goto reset;
			break;
		default:
			break;
		}

		return;

reset:
		Effect = NONE;
		for (int i=0; i<ARRAY_SIZE(EffectNum); i++){
			EffectNum[i] = 0;
			EffectNumCmd[i] = 0;
		}
		return;
}

void CField::BattleStart(const char* _pic_bg, std::vector<std::string> _enemyList){	
	//�C�x���g�o�g���p�i�w�i�摜�Əo���G���w�肵���퓬�j
	Battle.SetBackGround(_pic_bg);	//�����Ă�����܂邲��B_CmdList�ɓ�����
	Battle.SetEnemy(_enemyList);
	BattleStart();
}

void CField::BattleStart(){
	int result;
	CCmdList resultcmdlist;

	Battle.SetPlayer();
	Battle.BattleReady(&FlagSet, &Map, &EveManager);
	
	//��ʐ؂�ւ����ʁi�퓬�J�n�j
		int fieldGraph = MakeScreen(WINDOW_WIDTH, WINDOW_HEIGHT);
			SetDrawScreen(fieldGraph);
			Draw(false,true);
		int battleGraph = MakeScreen(WINDOW_WIDTH, WINDOW_HEIGHT);
			SetDrawScreen(battleGraph);
			Battle.Draw(false,true);
		SetDrawScreen(DX_SCREEN_BACK);
		int blankGraph =  MakeScreen(WINDOW_WIDTH,WINDOW_HEIGHT);
		ScreenChanger.ChangeScreen(fieldGraph, blankGraph, ScreenChanger.SCREEN_FADE, 10);
		ScreenChanger.ChangeScreen(blankGraph, fieldGraph, ScreenChanger.SCREEN_FADE, 10);
		ScreenChanger.ChangeScreen(fieldGraph, blankGraph, ScreenChanger.SCREEN_FADE, 10);
		ScreenChanger.ChangeScreen(blankGraph, fieldGraph, ScreenChanger.SCREEN_FADE, 10);
		ScreenChanger.ChangeScreen(fieldGraph, battleGraph, ScreenChanger.SCREEN_BOKASHI, 60);
	
	//�퓬�J�n
	Battle.BattleStart(&result, &resultcmdlist);
	
	//��ʐ؂�ւ����ʁi�퓬�I���j
		if (result!=LOSE_NOSCREENCHANGE){
			GetDrawScreenGraph(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT, battleGraph) ;
			SetDrawScreen(DX_SCREEN_BACK);
			ScreenChanger.ChangeScreen(battleGraph, blankGraph, ScreenChanger.SCREEN_FADE, 30);
			ScreenChanger.ChangeScreen(blankGraph, fieldGraph, ScreenChanger.SCREEN_FADE, 30);
		}
	//�퓬���ʃR�}���h�̏���
	FieldCmdManager.Main(&resultcmdlist, this, &Map, TextBox, &EveManager);
}

void CField::SetBattleResult(const char* _winmessage, const char* _losemessage){
	Battle.BattleSetting(_winmessage, _losemessage);
}


////////private/////////////////////////////////////////////////////////////////////////////////////////////
bool CField::CheckEvent(bool _foot, bool _push){
	char** addtext = NULL;
	bool event_happened=false;
	int count;		//EveManager����EveObj��Count���󂯎�邪�ύX�͂ł��Ȃ��iCount���Z��EveManager.GetText�ōs����j

	if (_push){
			if (EveManager.GetText(addtext, count, NowMap, (X+((Dir==RIGHT)?1:((Dir==LEFT)? -1:0)))%MAP_SIZE, (Y+((Dir==DOWN)? 1:((Dir==UP)?-1:0)))%MAP_SIZE, Dir, PUSHBLOCK)){
				event_happened = true;
			}
	}else if (!_foot){
		for (int k = WALKABLE_NUM+1; k < UNDERDRAW_NUM; k++){
			if (k==PUSHBLOCK) continue;
			if (EveManager.GetText(addtext, count, NowMap, (X+((Dir==RIGHT)?1:((Dir==LEFT)? -1:0)))%MAP_SIZE, (Y+((Dir==DOWN)? 1:((Dir==UP)?-1:0)))%MAP_SIZE, Dir, k)){
				event_happened = true;
				break;
			}
		}
	}else{
		for (int k = 0; k < WALKABLE_NUM; k++){
			if (EveManager.GetText(addtext, count, NowMap, X, Y, Dir, k)){
				event_happened = true;
				break;
			}
		}		
	}


	if (!event_happened) goto finish;	//�C�x���g�������Ȃ���΃���������������ďI��
	
	if (! TextBox->AddStock(addtext, Dir, count)) ErrorDx("Error->AddText", __FILE__, __LINE__);
	int i;
	for (i=0; !mystrcmp(addtext[i], EOP) ; i++){
		delete [] addtext[i];
		if (i > 10000) {ErrorDx("CriticalError->NotFound""EOP""", __FILE__, __LINE__); break;}
	}
	delete [] addtext[i];
	delete [] addtext;


finish:
	return event_happened;
}

bool CField::StartSet(const int _dnum){	//PlayData�Ɋi�[���ꂽ�ǂݍ��݃Z�[�u�f�[�^���e�ϐ��ɐU�蕪���đ��
	CCmdList PlayDataCmdList;
	char bufcmd[256];

	if (_dnum<-1 || _dnum>=PLAYDATA_NUM) {
		ErrorDx("GameStartError->dnum:%d", __FILE__, __LINE__, _dnum);
		return false;
	}

	if (_dnum!=-1 && PlayData_p[_dnum].Exist){
		
		sprintf_s(bufcmd, "@Position_Set(me, %d,%d,%d,%s)", PlayData_p[_dnum].NowMap, PlayData_p[_dnum].X, PlayData_p[_dnum].Y, PlayData_p[_dnum].PlayerPicKey);		PlayDataCmdList.Add(bufcmd);
		sprintf_s(bufcmd, "@Dir_Set(me,%d)", PlayData_p[_dnum].Dir);																						PlayDataCmdList.Add(bufcmd);
		FieldCmdManager.Main(&PlayDataCmdList, this, &Map, TextBox, &EveManager);
		
		for (unsigned int i = 0; i < PlayData_p[_dnum].EveObj.size(); i++){
			sprintf_s(bufcmd, "@Position_Set(%s,%d,%d)", PlayData_p[_dnum].EveObj[i].Name, PlayData_p[_dnum].EveObj[i].Dx/MAP_CHIP_SIZE, PlayData_p[_dnum].EveObj[i].Dy/MAP_CHIP_SIZE);	PlayDataCmdList.Add(bufcmd);
			if (PlayData_p[_dnum].EveObj[i].Kind==NPC){
				sprintf_s(bufcmd, "@Dir_Set(%s,%d)", PlayData_p[_dnum].EveObj[i].Name, PlayData_p[_dnum].EveObj[i].Dir);																PlayDataCmdList.Add(bufcmd);
			}
			sprintf_s(bufcmd, "@Count_Set(%s,%d)", PlayData_p[_dnum].EveObj[i].Name, PlayData_p[_dnum].EveObj[i].Count);																PlayDataCmdList.Add(bufcmd);
			sprintf_s(bufcmd, "@Pic_Set(%s,%s)", PlayData_p[_dnum].EveObj[i].Name, PlayData_p[_dnum].EveObj[i].PicKey);																PlayDataCmdList.Add(bufcmd);
			sprintf_s(bufcmd, "@Alpha_Set(%s,%d)", PlayData_p[_dnum].EveObj[i].Name, PlayData_p[_dnum].EveObj[i].Alpha*100/255);														PlayDataCmdList.Add(bufcmd);
			sprintf_s(bufcmd, "@Visible_Set(%s,%d)", PlayData_p[_dnum].EveObj[i].Name, PlayData_p[_dnum].EveObj[i].Visible);															PlayDataCmdList.Add(bufcmd);

			char tmp[256];
			sprintf_s(tmp, "%d",PlayData_p[_dnum].EveObj[i].EffectNumCmd[0]);
			for (int j=1; j<ARRAY_SIZE(PlayData_p[_dnum].EveObj[i].EffectNumCmd); j++){
				sprintf_s(tmp, "%s,%d", tmp, PlayData_p[_dnum].EveObj[i].EffectNumCmd[j]);
			}
			sprintf_s(bufcmd, "@Effect_Set(%s,%d,%s)", PlayData_p[_dnum].EveObj[i].Name, PlayData_p[_dnum].EveObj[i].Effect, tmp);													PlayDataCmdList.Add(bufcmd);

			FieldCmdManager.Main(&PlayDataCmdList, this, &Map, TextBox, &EveManager);
		}

		FlagSet = PlayData_p[_dnum].FlagSet;
		
		PlayData_p[_dnum].Exist = false;		//����̕K�v���悭�킩��Ȃ�14/05/07
	}
	
	if (!CheckHitKeyDown(KEY_INPUT_ESCAPE)){
		Map.CreateMapGraph(NowMap);
		return true;
	}else{
		return false;
	}
}

int CField::SaveData(int _dnum, const char _dataname[32]){	//-1�F�G���[�A0�F���g���C�A1�F����
	char filename[256];
	FILE *fp;
	
	//�Z�[�u�f�[�^�ԍ����K�����`�F�b�N
		if (_dnum<0 || _dnum>=PLAYDATA_NUM) {
			ErrorDx("Error->SaveDataNumber too small or big:%d", __FILE__, __LINE__, _dnum);
			return -1;
		}
	
	//�Z�[�u�t�H���_�����l�[�����͐V�K�쐬�i_dataname���󕶎���̂Ƃ��̓Z�[�u�ԍ������𗊂�ɏ㏑���ۑ�����j
		char olddirname[256];
		char newdirname[256];
		if (strlen(_dataname) > 0){
			sprintf_s(olddirname, "tenyu_data/save/%s", PlayData_p[_dnum].DataName);
			sprintf_s(newdirname, "tenyu_data/save/%s", _dataname); 

			//�Z�[�u�t�H���_�����l�[��
			if (rename(olddirname, newdirname) != 0){
				//���l�[���Ɏ��s�����̂ŁA�����t�H���_���Ȃ��Ɣ��f���V�K�쐬
				if (_mkdir(newdirname) !=0 ){
					//�t�H���_�쐬�Ɏ��s�������̃t�H���_�����݂��Ă���
					return 0;
				}
			}
			strcpy_s(PlayData_p[_dnum].DataName, _dataname);
		}else{
			sprintf_s(newdirname, "tenyu_data/save/%s", PlayData_p[_dnum].DataName);
			_mkdir(newdirname);
		}
		
	//�Z�[�u�f�[�^���ꗗ�̕ۑ��i�����̂��̂����ׂď㏑���j
		fopen_s(&fp, "tenyu_data/save/dataname.rpg", "w" );
		for (int i = 0; i < PLAYDATA_NUM; i++){
			fputs(PlayData_p[i].DataName, fp);		
			fputs("\n", fp);
		}
		fclose(fp);

		
	///�Z�[�u�f�[�^�ԍ��Ɋ�Â��ăZ�[�u�t�@�C�����J��/////////////////////////////////////////////////////////////////////////////////////
		for (int i=0; i<3; i++){
			switch(i){
			case 0:
				sprintf_s(filename, "tenyu_data/save/%s/pos.dat", PlayData_p[_dnum].DataName);
				break;
			case 1:
				sprintf_s(filename, "tenyu_data/save/%s/flg.dat", PlayData_p[_dnum].DataName);
				break;
			case 2:
				sprintf_s(filename, "tenyu_data/save/%s/eve.dat", PlayData_p[_dnum].DataName);
				break;
			default:
				//���Ƃ̓A�C�e���A�L�����X�e�[�^�X�A���A�ƁH $
				break;
			}

			//�t�@�C�����J��
			fopen_s(&fp, filename, "wb" );

			////�t�@�C���ɏ�������ŕۑ�/////////////////////////////////////////////////////////////////////////////
			switch(i){
			case 0:
				fwrite(&NowMap, sizeof(NowMap), 1, fp);
				fwrite(&X, sizeof(char), 1, fp);
				fwrite(&Y, sizeof(char), 1, fp);
				fwrite(&Dir, sizeof(char), 1, fp);
				fwrite(&PlayerPicKey, sizeof(char), sizeof(PlayerPicKey), fp);
				break;
			case 1:
				for(unsigned int i=0; i<FlagSet.Flag.size(); i++){
					fwrite(&FlagSet.Flag[i].Key, sizeof(char), sizeof(FlagSet.Flag[i].Key), fp);
					fwrite(&FlagSet.Flag[i].Num, sizeof(FlagSet.Flag[i].Num), 1, fp);
				}
				break;
			case 2:
				EveManager.Save(fp);
				break;
			}
			/////////////////////////////////////////////////////////////////////////////////
			fclose(fp);
		}
	///////////////////////////////////////////////////////////////////////////////////////////
	
	return 1;
}
