////多重インクルード防止（インクルードガード）//
#ifndef BATTLECALCULATOR_H					////
#define BATTLECALCULATOR_H					////
////////////////////////////////////////////////
/*
##### Battle/BattleCalculator.h
戦闘に関する各種計算を受け持ちます。  
将来的に戦闘計算は複雑化することが予想されるので、計算関数だけ分離していく予定です。
*/


class CBattleCalculator{
public:
	static int CalcGold(int _lv, int _goldgene);
	static int CalcExp(int _lv, int _expgene);
}typedef BattleCalc;


////多重インクルード防止（インクルードガード）//
#endif										////
////////////////////////////////////////////////