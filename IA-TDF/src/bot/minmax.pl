:- use_module(library(clpfd)).
:- consult('etat.pl').

% PlayerWhoPlay 



/******* MAX MAX *******/
% State : Etat
% BestNoeud : Meilleur noeud 
% ValueNoeud : Valeur noeud actuel
% Depth : profondeur


maxmax(State, BestNoeud, ValueNoeud, Depth) :-
    Depth > 0,
    %bagof(ChildNoeud, move(State, ChildNoeud, Depth), ChildNoeudList),
    move(State, ChildNoeudList, Depth),
    NewDepth is Depth - 1,
    bestmove(ChildNoeudList, BestNoeud, ValueNoeud, NewDepth), !
    ;
    writeln("State "+State),
    evaluate([_,_,_,_,State], ValueNoeud),
    writeln("TEST maxmax ValueNoeud "+ValueNoeud). 

/***********************/



/******* BEST MOVE *******/
bestmove([], _, _, _).

best([Node], Node, Value, Depth) :-
    maxmax(Node, _, Value, Depth), !. 

bestmove([ChildNoeud | ChildNoeudList], BestNoeud, Value, Depth) :-
    writeln("TEST ChildNoeud 1 "+ChildNoeud),
    writeln("TEST ChildNoeudList 2 "+ChildNoeudList),
    maxmax(ChildNoeud, _, FirstValue, Depth),
    writeln("TEST bestmove 2 "+FirstValue),
    bestmove(ChildNoeudList, SecondNode, SecondValue, Depth),
    %writeln("TEST bestmove 3 "+SecondValue),
    betterof(ChildNoeud, ValueNoeud, SecondNoeud, ValueSecondNoeud, BestNoeud, BestValue).


/**************************/


/******* BETTER OF *******/
betterof(PremierNoeud, ValuePremierNoeud, SecondNoeud, ValueSecondNoeud, PremierNoeud, ValuePremierNoeud) :-
   % writeln("TEST PremierNoeud "+ValuePremierNoeud),
   % writeln("TEST TempBestValue "+ValuePremierNoeud),
    ValuePremierNoeud #> ValueSecondNoeud.

betterof(_, _, SecondNoeud, ValueSecondNoeud, SecondNoeud, ValueSecondNoeud).


/*************************/



/******* EVALUATE *******/
% evaluate(State, Value) : renvoie la valeur d'un état donné suivant une heuristique
% State : l'état actuel du jeu
% Value : [Val1, Val2, Val3, Val4]
%
% Chute : val - 20                          OK
% Case chance : Val - 3                     OK
% Ligne arrivé (102) : Val + 20             OK
% Case supplémentaire (103 - 112): Val      OK
% Case vierge : Val                         OK      
% Case 89 - 102 : Val + 2                   OK

evaluate([Belgique, Italie, Hollande, Allemagne, PlayerCurrent], [Val1, Val2, Val3, Val4]) :-
    stateInit("Belgique", [Be1, Be2, Be3], Cards1),
    stateInit("Italie", [It1, It2, It3], Cards2),
    stateInit("Hollande", [Hol1, Hol2, Hol3], Cards3),
    stateInit("Allemagne", [All1, All2, All3], Cards4),
   % player_eval([Be1,Be2,Be3], Cards1, Val1),
   % player_eval([It1, It2, It3], Cards2, Val2),
   % player_eval([Hol1, Hol2, Hol3], Cards3, Val3),
   % player_eval([All1, All2, All3], Cards4, Val4),
    writeln("PlayerCurrent " +PlayerCurrent),
    stateInit(PlayerCurrent, [C1, C2, C3], Cards), %ICI il récupère les éléments de base, mais nous nous voulons qu'il récupère son state
    writeln("Cards " +C1),
    (PlayerCurrent = "Belgique"
        -> player_eval([C1, C2, C3], Cards, Val1),
            player_eval([It1, It2, It3], Cards2, Val2),
            player_eval([Hol1, Hol2, Hol3], Cards3, Val3),
            player_eval([All1, All2, All3], Cards4, Val4),
            writeln("OK")
        ; writeln("KO")
    ),
    writeln("BELGIQUE "+Val1).


  
player_eval([Coureur1, Coureur2, Coureur3], Cards, Val):-
    cyclist_eval(Coureur1, Cards, Val1),
    cyclist_eval(Coureur2, Cards, Val2),
    cyclist_eval(Coureur3, Cards, Val3),
    Val is Val1 + Val2 + Val3.


% Exclure les lignes comprises entre 89 et 102
exclude_lines(Ligne) :- Ligne >= 89, Ligne =< 102.


% Ligne 102
cyclist_eval((102, Colonne), Cards, Val) :- 
    Val is 102 + 20.

% Case supplémentaire
cyclist_eval((Ligne, Colonne), Cards, Val) :- 
    is_case_supplementaire(Ligne),
    Val is Ligne.

% Case chance
cyclist_eval((Ligne, Colonne), Cards, Val) :-
    case_chance(Ligne, Colonne),
    Val is Ligne - 3. % Exemple d'évaluation pour une "case chance"

% Ligne entre 89 et 102.
cyclist_eval((Ligne, _), _, Val) :- 
    Ligne >= 89,
    Ligne =< 102,
    Val is Ligne + 2.

% Chute
cyclist_eval((Ligne, Colonne), Cards, Val) :- 
    \+ case_disponible_et_presente(Ligne),
    Val is Ligne -20.
    
    
% Global 
cyclist_eval((Ligne, Colonne), Cards, Val) :-
    \+ case_chance(Ligne, Colonne), 
    \+ is_case_supplementaire(Ligne), 
    \+ exclude_lines(Ligne), 
    case_disponible_et_presente(Ligne), 
    Ligne =\= 102, 
    Val is Ligne. 


/*************************/


/********* MOVE **********/
move(State, ChildNoeud, Depth) :- 
    get_player_cards(State, Cards),
    move(State, Cards, ChildNoeud1, NewCards1, Depth),
    move(State, NewCards1, ChildNoeud2, NewCards2, Depth),
    move(State, NewCards2, ChildNoeud3, NewCards3, Depth),
    move(State, NewCards3, ChildNoeud4, NewCards4, Depth),
    move(State, NewCards4, ChildNoeud5, NewCards5, Depth),
    append([[ChildNoeud1], [ChildNoeud2], [ChildNoeud3], [ChildNoeud4], [ChildNoeud5]], ChildNoeud).

take_card([Card | Cards], Card).
take_card([_,Cards], Card) :-
    take_card(Cards,Card).


get_player_cards(PlayerId, Cards).

move(State, Cards, NewState, NewCards, Depth) :- 
    take_card(Cards,Card),
    avancer_cycliste2(State,Cards, 1, Card, NewState, NewCards). 


avancer_cycliste2(State,Cards, SelectedCyclist, Card, NewState, NewCards) :-
    get_cyclist_position(State, SelectedCyclist, LigneAvant, ColonneAvant),
    NewLigne is LigneAvant + Card,
    NewColonne is 1,
    \+ is_case_supplementaire(NewLigne),
    %set_cyclist_position(State, SelectedCyclist, NewLigne, NewColonne),
    remove_card3(Cards, NewCards2),
    % Mettre à jour le nouvel état en fonction des nouveaux coureurs et cartes
    get_cyclist_position(State, 1, NewLigne1, NewColonne1),
    get_cyclist_position(State, 2, NewLigne2, NewColonne2),
    get_cyclist_position(State, 3, NewLigne3, NewColonne3),
   
    NewState = [State, [(NewLigne, NewColonne), (NewLigne2, NewColonne2), (NewLigne3, NewColonne3)], NewCards2],
    NewCards = NewCards2,
    writeln("NewState "+NewState).


% Prédicat pour retirer une carte d'une liste de cartes
remove_card2(Card, Cards, NewCards) :-
    writeln("Cards" + Cards),
    (   select(Card, Cards, NewCards)
    -> writeln("La carte est  presente dans la liste " + Card)
    ;   writeln("La carte n'est pas presente dans la liste." + Card)
    ).

remover( _, [], []).
remover( R, [R|T], T).
remover( R, [H|T], [H|T2]) :- 
    H \= R, 
    remover( R, T, T2).

remove_card3([_|Rest], Rest).

/*
remove_card2(Element, [Element|Rest], Rest).
remove_card2(Element, [X|Rest], [X|NewRest]) :-
    remove_card2(Element, Rest, NewRest).
*/
/*************************/

/********* MOVE **********/

/*
    move(State, ChildNoeud, Depth) :- 
        get_player_cards(State, Cards),
        move(State, Cards, ChildNoeud, _, Depth),
        writeln("ChildNoeud "+ChildNoeud).

    take_card([Card | Cards], Card).
    take_card([_,Cards], Card) :-
        take_card(Cards,Card).


    get_player_cards(PlayerId, Cards).


    get_cyclists_list(State, CyclistsList) :-
        get_cyclist_position(State, 1, Ligne1, Colonne1),
        get_cyclist_position(State, 2, Ligne2, Colonne2),
        get_cyclist_position(State, 3, Ligne3, Colonne3),
        CyclistsList = [(1,Ligne1, Colonne1), (2,Ligne2, Colonne2), (3,Ligne3, Colonne3)].

    % Prédicat pour sélectionner le coureur avec la ligne la plus petite dans la liste CyclistsList
    select_cyclist_with_smallest_line(CyclistsList, SelectedCyclist) :-
        get_lines(CyclistsList, Lines),
        min_list(Lines, MinLine),
        get_cyclist_position(State, SelectedCyclist, MinLine, _).


    % Prédicat pour extraire les lignes de la liste des coureurs
    get_lines([], []).
    get_lines([(_,Line, _) | Rest], [Line | LinesRest]) :-
        get_lines(Rest, LinesRest).



    move(State, Cards, NewState, NewCards, Depth) :- 
        writeln("State  "+State),
        take_card(Cards,Card),
        get_cyclists_list(State, CyclistsList),
        writeln("CyclistsList "+CyclistsList),
        select_cyclist_with_smallest_line(CyclistsList, SelectedCyclist),
        writeln("SelectedCyclist "+SelectedCyclist),
        avancer_cycliste2(State,Cards, SelectedCyclist, Card, NewState, NewCards).

    avancer_cycliste2(State,Cards, SelectedCyclist, Card, NewState, NewCards) :-
        get_cyclist_position(State, SelectedCyclist, LigneAvant, ColonneAvant),
        NewLigne is LigneAvant + Card,
        NewColonne is 1,
        \+ is_case_supplementaire(NewLigne),
        set_cyclist_position(State, SelectedCyclist, NewLigne, NewColonne),
        remove_card2(Card, Cards, NewCards),
        % Mettre à jour le nouvel état en fonction des nouveaux coureurs et cartes
        get_cyclist_position(State, 1, NewLigne1, NewColonne1),
        get_cyclist_position(State, 2, NewLigne2, NewColonne2),
        get_cyclist_position(State, 3, NewLigne3, NewColonne3),
        NewState = [State, [(NewLigne1, NewColonne1), (NewLigne2, NewColonne2), (NewLigne3, NewColonne3)], NewCards],
        writeln("NewState "+NewState).


    % Prédicat pour retirer une carte d'une liste de cartes
    remove_card2(Card, [Card|Rest], Rest).
    remove_card2(Card, [X|Rest], [X|NewRest]) :-
        remove_card(Card, Rest, NewRest).
    */
/*************************/