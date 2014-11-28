////多重インクルード防止（インクルードガード）//
#ifndef CMDLIST_H							////
#define CMDLIST_H							////
////////////////////////////////////////////////
/*
##### Main/CmdList.h
このプログラムの肝です。  
独自の@コマンドを文字列として格納します。  
@コマンドは外部読みこみで主に使用しますが、システム内でも処理をスムーズにするために時々使われます。
*/


//リストで実装したキュー構造

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


////多重インクルード防止（インクルードガード）//
#endif										////
////////////////////////////////////////////////