#include "nunuLib.h"

//using namespace nunuLib;

////////////////////////////////////////////////////////////////////////////////////
////������n///////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////
////������𐔒l�ɕϊ�///////////////////////////////////////
bool mystrtol(const char* str, long int* result, int radix){
	long int num;
	char* end;

	if( str == NULL || result == NULL )return false;
	errno=0;

	num = strtol( str, &end, radix );
	if( errno== ERANGE && (num== LONG_MAX || num== LONG_MIN) ){
		return false;    /* �ϊ����ʂ��\���ł��Ȃ� */
	}else if( str== end ){
		return false;    /* �P�������ϊ��ł��Ȃ� */
	}

	*result = num;
	return true;
}
bool mystrtol(const char* str, int* result, int radix){
	long int num;
	bool flag;
	if((flag = mystrtol(str, &num, radix)))	*result = (int)num;
	return flag;
}
bool mystrtod(const char* str, double* result){
	double num;
	char* end;

	if( str == NULL || result == NULL )return false;
	errno=0;

	num = strtod( str, &end);
	if( num== 0 && errno== ERANGE ){
		return false; /*�A���_�[�t���[*/
	}else if( (num== HUGE_VAL || num== -HUGE_VAL) && errno== ERANGE ){
		return false;	/*"���ʂ��\���ł��Ȃ�*/
	}

	*result = num;
	return true;
}
bool mystrtod(const char* str, float* result){
	double num;
	bool flag;
	if((flag = mystrtod(str, &num))) *result = (float)num;
	return flag;
}
/////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////
////strlen��signed��/////////////////////////////////////////
signed int mystrlen(const char* _str){
	return (signed int)strlen(_str);
}
/////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////
///�������r�p�֐�//////////////////////////////////////////
bool mystrcmp(const char *String, const char *Words, const char Option){	
	if (String==NULL) return false;
	if (Option=='p'){			//Perfect: ���S��v
		return ((strcmp(String, Words)==0)? true: false);

	}else if (Option=='l'){		//Left: String�̐擪��Words���܂܂�Ă���
		return ((strstr(String, Words)==String)? true: false);

	}else if (Option=='m'){		//Middle: String�̒���Words���܂܂�Ă���
		return ((strstr(String, Words)!=NULL)? true: false);

	}else{
		return mystrcmp(String, Words, 'p');
	}
}
//�����̃L�[���[�h��OR����
bool mystrcmp(const char *String, const char Option, const int arg_num, ...){
	va_list args;
	va_start( args, arg_num);	//arg_num���傫�������Ƃ��̏��u���@�͂Ȃ��̂��H
	
	for (int i=0; i<arg_num; i++){
		if (mystrcmp(String, va_arg(args, char*), Option)){
			return true;
		}
	}
	va_end(args);
	return false;
}
/////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////
///���p�������m�T���p�֐�////////////////////////////////////
char* mystrchr(char* string, char character){	//�T���������p�����ƁA����S�p������2Byte�ڂ������Ƃ��Ɍ�F���Ă��܂����������i�W���֐��łȂ��̂��E�E�E�H�j
	char* p = string;							//��string�̂ЂƂO���A�����܂��͔��p�����܂��͑S�p������2�o�C�g�ڂ̕����ɂȂ肦�镶���ł��邱�Ƃ��ۏ؂���Ă���Ƃ��̂ݐ���@�\	
	
	while ((p=strchr(p, character))!=NULL){

		if (p==string) return p;
		if (_ismbblead(*p)) {
			p++;
			continue;
		}
		
		for (int i=1; (p-i)>=string; i++){
			if (i%2){
				if (_ismbblead(*(p-i))) {
					continue;
				}else{
					return p;	//*p�����p�����Ɗm��
				}
			}else{
				if (_ismbblead(*(p-i))) {
					if ((p-i)==string) return p;	//*p�����p�����Ɗm��
					continue;
				}else{
					break;		//*p���S�p������2�o�C�g�ڂƊm��
				}			
			}
		}
		p++;
	}
	
	return NULL;
}
/////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////
///������R�s�[�p�֐�////////////////////////////////////////
bool mystrcpy(char *String, const char *Source){
	int i=0;
	while(1){
		String[i] = Source[i];
		if (Source[i++]=='\0') break;
	}
	return true;
}
bool mystrcpy(char **String, const char **Source, const int SourceLineSize){
	for (int i=0; i<SourceLineSize; i++){
		mystrcpy(String[i], Source[i]);
	}
	return true;
}
bool mystrcpy(char *String, const char *Source, int size_including_null){
	for (int i=0; i<size_including_null-1; i++){
		String[i] = Source[i];
		if (Source[i]=='\0') return true;
	}
	String[size_including_null-1]='\0';
	return true;
}
/////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////
///������̗��[����]�v�ȕ��������֐�//////////////////////
bool mystrsmt(char *string, const char* uselesswords){
	int i = 0; int j = 0;
	while(1){	//�O������
		i = 0;
		while (1){
			if (string[j]==uselesswords[i]){
				j++;
				break;
			}
			if (i==strlen(uselesswords)-1) goto endloop;
			i++;
		}
	}
endloop:
	mystrcpy(string, &string[j]);
	
	j = strlen(string)-1;
	while(1){	//��납����
		i = 0;
		while (1){
			if (string[j]==uselesswords[i]){
				j--;
				break;
			}
			if (i==strlen(uselesswords)-1) goto finish;
			i++;
		}
	}
finish:
	string[j+1]='\0';
	return true;
}
/////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////
///�����񌋍��p�֐�////////////////////////////////////////
bool mystrcat(char *string, const char* source){
	char* p;
	p = string+strlen(string);
	
	for (unsigned int i=0; i<strlen(source)+1; i++){
		*p = source[i];
		*p++;
	}
	
	return true;
}
/////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////
///������u���p�֐�//////////////////////////////////////////
void mystrrep(char* string, const char* from, const char* to){
	char* p;

	while((p=strstr(string, from))!=NULL){
		char* tmp = new char[strlen(string)];
		*p = '\0';
		p += strlen(from);
		mystrcpy(tmp, p);
		mystrcat(string, to);
		mystrcat(string, tmp);
		delete [] tmp;
	}
}
/////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////
bool mystrgrt(const char* string, const char* target, bool greater){
	int i=0;
	while (string[i]==target[i] && string[i]!='\0' && target[i]!='\0'){
		++i;
	}

	if (greater){
		return (string[i]>target[i]);
	}else{
		return (string[i]<target[i]);
	}
}
/////////////////////////////////////////////////////////////


////������n�����܂�////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////////
////�`��n//////////////////////////////////////////////////////////////////////////
CVector GetGraphSize(int GrHandle){
	CVector vec;	
	int w, h;
	GetGraphSize(GrHandle, &w, &h);
	vec.Set(w, h);
	return vec;
}

int LoadGraph(const TCHAR *filename, bool errorcheck)		//Dx���C�u������LoadGraph�̃t�@�C���G���[�o�͕t���ŁB�R�[�h�ߖ񂪖ړI�B
{	int img = LoadGraph(filename);
	if (errorcheck){
		if(img == -1){ErrorDx("Error->Not Found Image:%s", filename);}
	}
	return img;
}

//DrawGraph
//DrawExtendGraph
//DrawTurnGraph
template<class T> int DrawCenterGraph(T cx, T cy, int GrHandle, int TransFlag){
	CVector imgsize = GetGraphSize(GrHandle);
	DrawGraph(cx-imgsize.x/2, cy-imgsize.y/2, GrHandle, TransFlag);
}


int DrawString(int x, int y, int color, const TCHAR* format, ...){
	va_list args;
	char string[1024];
	int for_return;

	va_start( args, format );
	vsprintf_s( string, format, args );

	if(strlen(string)<1024){
		for_return = DrawString(x,y,string,color);	
	}else{
		ErrorDx("Error->nunuLib:DrawString->too long string:%s", __FILE__, __LINE__, string);
		for_return=-1;
	}
	va_end( args );

	return for_return;	
}
//DrawCenterString Not�t�H�[�}�b�g��
int DrawCenterString(int cx, int y, int color, const TCHAR* format, ...){
	va_list args;
	char string[1024];
	int for_return;

	va_start( args, format );
	vsprintf_s( string, format, args );
	va_end( args );

	if(strlen(string)<1024){
		for_return = DrawCenterString((int)cx,(int)y,string,color);	
	}else{
		ErrorDx("Error->nunuLib:DrawCenterString->too long string:%s", __FILE__, __LINE__, string);
		for_return=-1;
	}

	return for_return;	
}
int DrawCenterString(int cx, int y, int color, bool centerY, const TCHAR* format, ...){	//�t�H�[�}�b�g��
	va_list args;
	char string[1024];
	int for_return;

	va_start( args, format );
	vsprintf_s( string, format, args );
	va_end( args );

	if(strlen(string)<1024){
		for_return = DrawCenterString((int)cx,(int)y,string,color,centerY);	
	}else{
		ErrorDx("Error->nunuLib:DrawCenterString->too long string:%s", __FILE__, __LINE__, string);
		for_return=-1;
	}

	return for_return;	
}
////�`��n�����܂�//////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////
///�G���[�o�͗p�֐�//////////////////////////////////////////
//
//ErrorDx�̓C�����C���֐��Ȃ̂ŁA��`�̓w�b�_�ɋL��
//
/////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////
///����Choose�֐�////////////////////////////////////////////
int choose(const int target, ...){
	int choice;
	va_list args;
	va_start( args, target);	//target���傫�������Ƃ��̏��u���@�͂Ȃ��̂��H
	
	if (target<=0){
		ErrorDx("Error->arg[target] should >=1: target=%d", __FILE__, __LINE__, target);
		return va_arg(args, int);
	}

	for (int i=1; i<=target; i++){
		choice = va_arg(args, int);		//target=1�̎��A��ڂ�Ԃ��iNot target=0�j
	}
	va_end(args);
	return choice;
}
/////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////
///KeyDown����p�֐�/////////////////////////////////////////
static nunuLibKey::CKeyManager KeyManager;
bool CheckHitKeyDown(const int KEY_CODE){
	return KeyManager.CheckDown(KEY_CODE);
}
nunuLibKey::CKeyManager::CKeyManager(){
	for (int i=0; i<ARRAY_SIZE(Pressed); i++){
		Pressed[i]=false;
	}
}
bool nunuLibKey::CKeyManager::CheckDown(const int KEY_CODE){		//�������u�Ԃ���true��Ԃ�
	//����L�[���Z,Enter  �L�����Z���L�[���X,BackSpace  ���ꂼ��ǂ���ł���
	switch (KEY_CODE){
		case KEY_INPUT_OK:
			return (CheckDown(KEY_INPUT_RETURN) || CheckDown(KEY_INPUT_Z));			
			break;
		case KEY_INPUT_CANCEL:
			return (CheckDown(KEY_INPUT_BACK) || CheckDown(KEY_INPUT_X));
			break;
		default:
			break;
	}

	//����̃��C��
	if (CheckHitKey(KEY_CODE)){
		if (!Pressed[KEY_CODE]) {
			Pressed[KEY_CODE] = true;
			return true;
		}
		return false;
	}else{
		Pressed[KEY_CODE]= false;
		return false;
	}

	return false;
}
/////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////
//////�t�H�[�}�b�g�Ή��E�B���h�E�^�C�g���ύX�֐�/////////////
int SetTitle(const char* format, ...){
	va_list args;
	char title[256];
	int for_return;

	va_start( args, format );
	vsprintf_s( title, format, args );

	if(strlen(title)<256){
		for_return = SetMainWindowText(title);	
	}else{
		ErrorDx("Error->SetTitle->too long title (title should<256):%s", __FILE__, __LINE__, title);
		for_return=-1;
	}
	va_end( args );

	return for_return;	
}
/////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////
////���̑�///////////////////////////////////////////////////
//between			������
//mod				������	
/////////////////////////////////////////////////////////////