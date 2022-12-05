#Game Night opimizáló 
set players;
set boardGames;
set categories;
set days;

#params
param playerPreferences {players, categories};
param gameCategories {boardGames, categories} binary;
param gameTime {boardGames};
param freeTime{days};

#vars
var chosenGames{days, boardGames} binary;


#korlátok
s.t. dayLimit {d in days}:  sum  {b in boardGames}chosenGames[d, b]*gameTime[b] <= freeTime[d];
s.t. gameLimits {b in boardGames}: sum {d in days}chosenGames[d,b]<= 3;
s.t. minimumSatisfaction {p in players}: sum {b in boardGames, c in categories, d in days} playerPreferences[p, c]*chosenGames[d,b]*gameCategories[b,c] >= 80;

#célfüggvény
maximize satisfaction: sum {p in players, b in boardGames, c in categories, d in days} chosenGames[d, b]*gameCategories[b,c]*playerPreferences[p,c];

solve;

printf "\n\n\n";

for {d in days}{
	for {b in boardGames} {
		printf (if (chosenGames[d, b] > 0) then "%s - %s\n" else ""),d, b;
	}
}
printf "A heti boldogság szint: %d\n\n", satisfaction;




#data 
data;
set players:= Akos Balint Jozsef Katalin Istvan Lajos Adam Maria;
set boardGames:= Risk Monopoly Catan Brittania Magic Gloomhaven Root Bang;
set categories:= workerplacement tradingcard strategy deckbuilding partygame roleplaying coop dungeoncrawler wargames citybuilding;
set days:= Hetfo Kedd Szerda Csutortok Pentek Szombat Vasarnap;

# játékosok kategoriak kedvelése
param playerPreferences: workerplacement tradingcard strategy deckbuilding partygame roleplaying coop dungeoncrawler wargames citybuilding:=
Akos	10	0	0	0	0	10	0	0	10	0
Balint	2	8	10	6	0	10	10	8	10	3
Jozsef	3	10	4	10	8	10	5	10	5	6
Katalin	2	6	9	1	4	10	5	4	5	4
Istvan 	10	2	0	7	5	10	10	8	0	9
Lajos 	2	6	9	1	4	10	5	4	5	4
Adam	3	10	4	10	8	10	5	10	5	6
Maria	6	9	1	4	5	10	4	5	4	4;
#melyik játék melyik kategóriába tartózik

param gameCategories: workerplacement tradingcard strategy deckbuilding partygame roleplaying coop dungeoncrawler wargames citybuilding:=
Risk 		0	0	0	0	0	0	1	0	0	1
Monopoly	0	0	1	1	1	0	0	0	0	1
Catan		0	0	0	1	0	0	1	0	0	0
Brittania	0	0	0	1	0	0	0	1	0	1
Magic		0	1	1	1	1	0	0	0	0	0
Gloomhaven	1	1	1	0	0	0	1	0	1	0
Root		0	0	1	0	0	1	0	1	0	0
Bang		0	1	1	0	0	0	1	0	0	0;

#játékidõ órában megadva
param gameTime := 
Risk		1
Monopoly	0.8
Catan 		0.5
Brittania 	2
Magic 		3
Gloomhaven 	5
Root 		1.5
Bang		0.5;

#szabadidõ egy napon
param freeTime :=
Hetfo	2.5
Kedd	3
Szerda	2.8
Csutortok	4.5
Pentek		6
Szombat		10
Vasarnap	7;
 
end;

 
 
