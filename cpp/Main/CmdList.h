////���d�C���N���[�h�h�~�i�C���N���[�h�K�[�h�j//
#ifndef CMDLIST_H							////
#define CMDLIST_H							////
////////////////////////////////////////////////
/*
##### Main/CmdList.h
���̃v���O�����̊̂ł��B  
�Ǝ���@�R�}���h�𕶎���Ƃ��Ċi�[���܂��B  
@�R�}���h�͊O���ǂ݂��݂Ŏ�Ɏg�p���܂����A�V�X�e�����ł��������X���[�Y�ɂ��邽�߂Ɏ��X�g���܂��B
*/


//���X�g�Ŏ��������L���[�\��

class CCmdList{
public:
	
	CCmdList(){
		front = NULL;
		tail = NULL;
	}
	~CCmdList(){
		Clear();
	}

	void Add(const char* _data);
	void Get(char* _cmd);
	bool Empty();
	void Clear();

private:
	struct node_tag{
		char command[256];
		node_tag* next;
	};
	
	node_tag* front;
	node_tag* tail;
};


////���d�C���N���[�h�h�~�i�C���N���[�h�K�[�h�j//
#endif										////
////////////////////////////////////////////////