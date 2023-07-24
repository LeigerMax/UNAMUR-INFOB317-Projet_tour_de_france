

plateau([

    /* 
    
    Voici un set de tout les états possible (les différentes cases du jeu, 
    ainsi que leurs accesibilité et les cases chances), un état fonctionne comme ceci : 

    [case ligne, case colonne, case chance, case accessible],
    
    */

    %CASE DE BASE

    [0,0,false,true],[0,1,false,true],[0,2,false,true],[0,3,false,true],

    %CASE DE JEU

    [1,1,false,true],[1,2,false,true],[1,3,false,true],            
    [2,1,false,true], [2,2,false,true], [2,3,false,true],
    [3,1,false,true],[3,2,false,true],[3,3,false,true],
    [4,1,false,true],[4,2,false,true],[4,3,false,true],
    [5,1,false,true],[5,2,false,true],[5,3,false,true],
    [6,1,false,true],[6,2,false,true],[6,3,false,true],
    [7,1,false,true],[7,2,false,true],[7,3,false,true],
    [8,1,false,true],[8,2,false,true],[8,3,false,true],

    [9,1,true,true],[9,2,false,true],[9,3,false,false],
    [10,1,false,false],[10,2,false,true],[10,3,false,false],
    [11,1,true,true],[11,2,false,true],[11,3,false,false],
    [12,1,false,false],[12,2,false,true],[12,3,false,false],

    [13,1,true,true],[13,2,false,true],[13,3,false,false],
    [14,1,true,true],[14,2,false,true],[14,3,false,false],
    [15,1,false,true],[15,2,false,true],[15,3,false,false],
    [16,1,false,true],[16,2,false,true],[16,3,false,false],
    [17,1,false,true],[17,2,true,true],[17,3,false,false],
    [18,1,false,true],[18,2,true,true],[18,3,false,false],
    [19,1,false,true],[19,2,false,true],[19,3,false,false],
    [20,1,false,true],[20,2,false,true],[20,3,false,false],

    [21,1,false,true],[21,2,false,true],[21,3,true,true],
    [22,1,false,true],[22,2,false,true],[22,3,false,true],
    [23,1,false,true],[23,2,false,true],[23,3,true,true],

    [24,1,false,true],[24,2,false,true],[24,4,false,true],
    [25,1,false,true],[25,2,false,true],[25,4,false,true],
    [26,1,true,true],[26,2,false,true],[26,4,false,true],
    [27,1,false,true],[27,2,false,true],[27,4,false,true],
    [28,1,true,true],[28,2,false,true],[28,4,false,true],
    [29,1,false,true],[29,2,false,true],[29,4,false,true],
    [30,1,true,true],[30,2,false,true],[30,4,false,true],
    [31,1,false,true],[31,2,false,true],[31,4,false,true],
    [32,1,true,true],[32,2,false,true],[32,4,false,true],
    [33,1,false,true],[33,2,false,true],[33,4,false,true],
    [34,1,true,true],[34,2,false,true],[34,4,false,true],
    [35,1,false,true],[35,2,false,true],[35,4,false,true],
    [36,1,true,true],[36,2,false,true],[36,4,false,true],
    [37,1,false,true],[37,2,false,true],[37,4,false,true],

    [38,1,false,false],[38,2,false,false],[38,4,false,true],
    [39,1,false,false],[39,2,false,false],[39,4,false,true],

    [40,1,false,true],[40,2,false,true],[40,3,false,false],
    [41,1,false,true],[41,2,false,true],[41,3,false,false],
    [42,1,false,true],[42,2,false,true],[42,3,false,false],
    [43,1,false,true],[43,2,false,true],[43,3,false,false],
    [44,1,false,true],[44,2,false,true],[44,3,false,false],
    [45,1,false,true],[45,2,false,true],[45,3,false,false],
    [46,1,false,true],[46,2,false,true],[46,3,false,false],
    [47,1,false,true],[47,2,false,true],[47,3,false,false],
    [48,1,false,true],[48,2,false,true],[48,3,false,false],
    [49,1,false,true],[49,2,false,true],[49,3,false,false],
    [50,1,false,true],[50,2,false,true],[50,3,false,false],
    [51,1,false,true],[51,2,false,true],[51,3,false,false],
    [52,1,true,true],[52,2,false,true],[52,3,false,false],
    [53,1,false,true],[53,2,false,true],[53,3,false,false],
    [54,1,false,true],[54,2,false,true],[54,3,false,false],
    [55,1,false,true],[55,2,false,true],[55,3,false,false],
    [56,1,false,true],[56,2,false,true],[56,3,false,false],
    [57,1,false,true],[57,2,false,true],[57,3,false,false],
    [58,1,false,true],[58,2,false,true],[58,3,false,false],
    [59,1,false,true],[59,2,false,true],[59,3,false,false],
    [60,1,false,true],[60,2,false,true],[60,3,false,false],
    [61,1,false,true],[61,2,true,true],[61,3,false,false],
    [62,1,false,true],[62,2,false,true],[62,3,false,false],
    [63,1,false,true],[63,2,false,true],[63,3,false,false],
    [64,1,false,true],[64,2,false,true],[64,3,false,false],
    [65,1,false,true],[65,2,false,true],[65,3,false,false],
    [66,1,false,true],[66,2,false,true],[66,3,false,false],
    [67,1,false,true],[67,2,false,true],[67,3,false,false],
    [68,1,false,true],[68,2,false,true],[68,3,false,false],
    [69,1,false,false],[69,2,false,true],[69,3,false,false],
    [70,1,false,true],[70,2,false,true],[70,3,false,false],
    [71,1,true,true],[71,2,true,true],[71,3,false,false],
    [72,1,false,true],[72,2,false,true],[72,3,false,false],
    [73,1,false,true],[73,2,false,true],[73,3,false,false],
    [74,1,false,true],[74,2,false,true],[74,3,false,false],
    [75,1,false,true],[75,2,false,true],[75,3,false,false],
    [76,1,false,true],[76,2,false,true],[76,3,false,false],
    [77,1,false,true],[77,2,false,true],[77,3,false,false],

    [78,1,false,true],[78,2,false,false],[78,3,false,false],
    [79,1,true,true],[79,2,false,false],[79,3,false,false],
    [80,1,false,true],[80,2,false,false],[80,3,false,false],
    [81,1,false,true],[81,2,false,true],[81,3,false,false],
    [82,1,false,true],[82,2,false,true],[82,3,false,false],
    [83,1,false,true],[83,2,false,true],[83,3,false,false],

    [84,1,false,true],[84,2,false,true],[84,3,false,false],
    [85,1,false,true],[85,2,false,true],[85,3,false,false],
    [86,1,false,true],[86,2,false,true],[86,3,false,false],
    [87,1,false,true],[87,2,false,true],[87,3,false,false],
    [88,1,false,true],[88,2,false,true],[88,3,false,false],

    [89,1,false,true],[89,2,false,false],[89,3,false,true],
    [90,1,false,true],[90,2,false,false],[90,3,false,true],
    [91,1,false,true],[91,2,false,false],[91,3,false,true],
    [92,1,false,true],[92,2,false,false],[92,3,false,true],
    [93,1,false,true],[93,2,false,false],[93,3,false,true],
    [94,1,false,true],[94,2,false,false],[94,3,false,true],
    [95,1,false,true],[95,2,false,false],[95,3,false,true],
    [96,1,false,true],[96,2,false,false],[96,3,true,true],
    [97,1,false,true],[97,2,false,false],[97,3,false,true],
    [98,1,false,true],[98,2,false,false],[98,3,false,true],
    [99,1,false,true],[99,2,false,false],[99,3,false,true],
    [100,1,false,false],[100,2,false,false],[100,3,false,true],
    [101,1,false,false],[101,2,false,false],[101,3,false,true],
    [102,1,false,true],[102,2,false,true],[102,3,false,true],


    [103,1,false,true],[103,2,false,true],[103,3,false,true],
    [104,1,false,true],[104,2,false,true],[104,3,false,true],
    [105,1,false,true],[105,2,false,true],[105,3,false,true],
    [106,1,false,true],[106,2,false,true],[106,3,false,true],
    [107,1,false,true],[107,2,false,true],[107,3,false,true],
    [108,1,false,true],[108,2,false,true],[108,3,false,true],
    [109,1,false,true],[109,2,false,true],[109,3,false,true],
    [110,1,false,true],[110,2,false,true],[110,3,false,true],
    [111,1,false,true],[111,2,false,true],[111,3,false,true],
    [112,1,false,true],[112,2,false,true],[112,3,false,true]
]).

/* CASE BONUS TEMPS

    Si caseBonus((Case-_)) est vrai alors caseBonus([Case, _, _, _]) est vrai

    caseBonus([Case, _, _, _]) est vrai si et seulement si Case est plus grand ou égal à 103 (peu importe les autres arguments)

*/


caseBonus((Case-_)) :- caseBonus([Case, _, _, _]).
caseBonus([Case, _, _, _]):- Case >= 103.    



/* DANS LE CAS DE DOUBLE CASE

    testDoubleCase vérifie qu'une double case donnée est effectivement considérée comme une double case. Toutes les double case sont hard-codées.

*/

doubleCase([9,1,false,true],[10,1,false,false]).
doubleCase([11,1,false,true],[12,1,false,false]).
doubleCase([68,1,false,true],[69,1,false,false]).
doubleCase([37,0,false,true],[39,0,false,false]).
doubleCase([37,1,false,true],[39,1,false,false]).
doubleCase([99,1,false,true],[101,1,false,false]).

verifDoubleCase([LignPos, ColPos, _, _],[LigneDeux,ColDeux,ChanceDeux,AccesDeux]):-
    doubleCase([LignPos, ColPos, _, _],[LigneDeux,ColDeux,ChanceDeux,AccesDeux]).



/* 

DEPLACEMENT POSSIBLE

Si on est sur la case départ (la case 0), les cyclistes peuvent aller sur la première case peu importe sa colonne

Si pas dans la case départ, on check la case actuelle du cycliste (LignPos, ColPos), et on la compare a la case désirée (LignTarget, ColTarget). 
Afin de satisfaire le prédicat, il faut que la Ligne désirée soit plus grande de 1 unité (Case 10 -> Case 11).
Il faut aussi que la ligne soit plus grande de 1, moins grande de 1 ou égale à la case actuelle (Si nous sommes dans la 1 ère colonne, la seule colonne possible sera 2).
Il faut aussi que le booléen Accès soit sur true.

Enfin on regarde si la case désirée existe bien dans la setlist plateau.

Si la case adjacente nous rend false, alors on check si c'est une double case et on retente de check si un déplacement est possible.

*/

%Cas de base

deplacementPossible([0, _, _, _], [1, 1, _, _]).
deplacementPossible([0, _, _, _], [1, 2, _, _]).
deplacementPossible([0, _, _, _], [1, 3, _, _]).


%Cas pour le reste

deplacementPossible([LignPos, ColPos, _, _], [LignTarget, ColTarget, Chance, Acces]):-
    Acces = true,
    LignTarget is LignPos + 1,
    (ColTarget is ColPos + 1; ColTarget is ColPos -1; ColTarget = ColPos),
    plateau(Verif),
    member([LignTarget, ColTarget, Chance, Acces], Verif).

deplacementPossible([LignPos, ColPos, _, _], [LignTarget, ColTarget, Chance, Acces]):-
    verifDoubleCase([LignPos, ColPos, _, _], [LigneDeux,ColDeux,ChanceDeux,AccesDeux]),
    deplacementPossible([LigneDeux,ColDeux,ChanceDeux,AccesDeux],[LignTarget, ColTarget, Chance, Acces]).




/* SE DEPLACER D'UNE CASE A UNE AUTRE

bougerCycliste nous permet de check si le  déplacement est possible selon un nombre de mouvement autorisé, la fonction est récursive et check a chaque fois qu'un mouvement est possible.
La fonction renvoie True si le chemin de la Case de départ et la Case visée est accessible en un nombre de mouvement limité.

bougerCycliste(Case Départ, Nombre de mouvement, Case Visée)

*/

bougerCycliste(Case, 0, Case).
bougerCycliste([LignPos, ColPos, _, _], NbMouvement,[LignTarget, ColTarget, Chance, Acces]):-
    NbMouvement2 is NbMouvement-1, NbMouvement2 >= 0,
    deplacementPossible([LignPos, ColPos, _, _], [LignTargetTemp, ColTargetTemp, _, _]),
    bougerCycliste([LignTargetTemp, ColTargetTemp, _, _], NbMouvement2, [LignTarget, ColTarget, Chance, Acces]).


bougerCycliste((LignPos, ColPos), NbMouvement,(LignTarget, ColTarget)):-
    bougerCycliste([LignPos, ColPos, _, _], NbMouvement,[LignTarget, ColTarget, _, _]).

bougerCyclisteUnique((LignPos, ColPos), NbMouvement, UniqueOutcomes) :-
    setof((LignTarget, ColTarget), bougerCycliste((LignPos, ColPos), NbMouvement, (LignTarget, ColTarget)), UniqueOutcomes).


/**********************************************************************/

% Vérifie si c'est une case supplemantaire
% Entrées : Ligne
is_case_supplementaire(Ligne) :-
    Ligne >= 103,
    Ligne =< 112.


% Vérifie si une case est présente dans le plateau
% Entrées : Ligne, Colonne
case_presente(Ligne, Colonne) :-
    plateau(Plateau),
    member([Ligne, Colonne, _, true], Plateau),
    writeln('Case presente : Ligne ' + Ligne + ', Colonne ' + Colonne).


% Vérifie si une case est une case chance
% Entrées : Ligne, Colonne
case_chance(Ligne, Colonne) :-
    plateau(Plateau),
    member([Ligne, Colonne, true, _], Plateau),
    writeln('Case chance : Ligne ' + Ligne + ', Colonne ' + Colonne).

% Vérifie si une case est une case chance, et détermine la nouvelle colonne en conséquence.
% Entrées : Ligne, Colonne
% Sorties : NewColonne
case_chance2(Ligne,Colonne,NewColonne) :-
    (case_chance(Ligne, Colonne) % Vérifier si c'est une case chance
        -> NewColonne is 2
        ; writeln('Pas une case chance, on reste colonne 1'),
            NewColonne is 1
    ).

% Vérifie si une case est disponible (aucun cycliste présent)
% Entrées : Ligne, Colonne
case_disponible(Ligne, Colonne) :-
    Players = ["Belgique", "Italie", "Hollande", "Allemagne"],
    Cyclists = [1, 2, 3],
    forall(
        member(PlayerId, Players),
        forall(
            member(CyclistId, Cyclists),
            (
                get_cyclist_position(PlayerId, CyclistId, LigneCycliste, ColonneCycliste),
                (LigneCycliste \= Ligne ; ColonneCycliste \= Colonne),
                !
            )
        )
    ),
    writeln('Case disponible : Ligne ' + Ligne + ', Colonne ' + Colonne).


% Vérifie si une case est disponible (aucun cycliste présent)
% Entrées : Ligne, Colonne
case_disponible2(Ligne, Colonne) :-
    (case_disponible(Ligne, Colonne) % Vérifier si la case est disponible
        -> writeln('Case disponible')
        ; writeln('Case non disponible')
    ).

% Vérifie si une case est disponible, présente sur le plateau, et accessible dans l'une des 4 colonnes possibles
% Entrées : LigneArrivee, ColonneChoix, Chute
case_disponible_et_presente(LigneArrivee, 1, Chute,ColonneChoix, Disponible) :-
    % Vérifier pour la première colonne
    ColonneArrive1 is 1,
    (case_disponible(LigneArrivee, ColonneArrive1), case_presente(LigneArrivee, ColonneArrive1)
        -> ColonneChoix is ColonneArrive1, Chute is 0, writeln('Youpi ' + ColonneArrive1), Disponible is 1
        ;   % Vérifier pour la deuxième colonne
            ColonneArrive2 is 2,
            (case_disponible(LigneArrivee, ColonneArrive2), case_presente(LigneArrivee, ColonneArrive2)
                -> ColonneChoix is ColonneArrive2, Chute is 0, writeln('Youpi ' + ColonneArrive2), Disponible is 1
                ;   % Vérifier pour la troisième colonne
                    ColonneArrive3 is 3,
                    (case_disponible(LigneArrivee, ColonneArrive3), case_presente(LigneArrivee, ColonneArrive3)
                        -> ColonneChoix is ColonneArrive3, Chute is 0, writeln('Youpi ' + ColonneArrive3), Disponible is 1
                        ;   % Vérifier pour la quatrième colonne
                            ColonneArrive4 is 4,
                            (case_disponible(LigneArrivee, ColonneArrive4), case_presente(LigneArrivee, ColonneArrive4)
                                -> ColonneChoix is ColonneArrive4, Chute is 0, writeln('Youpi ' + ColonneArrive4), Disponible is 1
                                ;   writeln('KO'), Chute is 1, Disponible is 0
                            )
                    )
            )
    ).

case_disponible_et_presente(LigneArrivee, 2, Chute,ColonneChoix, Disponible) :-
    % Vérifier pour la première colonne
    ColonneArrive1 is 2,
    (case_disponible(LigneArrivee, ColonneArrive1), case_presente(LigneArrivee, ColonneArrive1)
        -> ColonneChoix is ColonneArrive1, Chute is 0, writeln('Youpi ' + ColonneArrive1), Disponible is 1
        ;   % Vérifier pour la deuxième colonne
            ColonneArrive2 is 2,
            (case_disponible(LigneArrivee, ColonneArrive2), case_presente(LigneArrivee, ColonneArrive2)
                -> ColonneChoix is ColonneArrive2, Chute is 0, writeln('Youpi ' + ColonneArrive2), Disponible is 1
                ;   % Vérifier pour la troisième colonne
                    ColonneArrive3 is 3,
                    (case_disponible(LigneArrivee, ColonneArrive3), case_presente(LigneArrivee, ColonneArrive3)
                        -> ColonneChoix is ColonneArrive3, Chute is 0, writeln('Youpi ' + ColonneArrive3), Disponible is 1
                        ;   % Vérifier pour la quatrième colonne
                            ColonneArrive4 is 4,
                            (case_disponible(LigneArrivee, ColonneArrive4), case_presente(LigneArrivee, ColonneArrive4)
                                -> ColonneChoix is ColonneArrive4, Chute is 0, writeln('Youpi ' + ColonneArrive4), Disponible is 1
                                ;   writeln('KO dans case_disponible_et_presente'), Chute is 1, Disponible is 0
                            )
                    )
            )
    ).


avancer_cycliste(PlayerId, CyclisteId, Card, ColonneChoix, Chute) :-
    get_cyclist_position(PlayerId, CyclisteId, LigneActuelle, ColonneActuelle),
    LigneArrivee is LigneActuelle + Card,
    case_chance2(LigneArrivee,1,ColonneArrive ),
    writeln('Nouvelle Colonne apres case chance ('  + LigneArrivee + ', ' + ColonneArrive +')'),
    case_disponible_et_presente(LigneArrivee, ColonneArrive, Chute, ColonneChoix, Disponible),
    ( Disponible = 1
    -> writeln('OK')
    ; writeln('KO avancer_cycliste')
    ),
    writeln('Le cycliste ' + PlayerId + ' - ' + CyclisteId + ' avancera a la case (' + LigneArrivee + ', ' + ColonneChoix + ').'). 


