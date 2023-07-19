:- consult('minimax.pl').
:- consult('plateau.pl').
:- consult('gamebot.pl').

/* --------------------------------------------------------------------- */
/*                                                                       */
/*                                Tests                                  */
/*                                                                       */
/* --------------------------------------------------------------------- */

:- begin_tests(max_card).


/**** TEST CARTE ****/

% Test case 1: La plus grande carte est 12
test(get_max_card_1) :-
    set_player_cards(italie, [11, 8, 12, 3, 1]),
    get_max_card(italie, 12).

% Test case 2: La plus grande carte est 12
test(get_max_card_2) :-
    set_player_cards(italie, [12, 8, 11, 5, 6]),
    get_max_card(italie, 12).

% Test case 3: La plus grande carte est 10
test(get_max_card_3) :-
    set_player_cards(italie, [2, 3, 10, 7, 4]),
    get_max_card(italie, 10).

% Test case 4: Aucune carte, la plus grande carte est null
test(get_max_card_4) :-
    set_player_cards(italie, []),
    get_max_card(italie, null).

:- end_tests(max_card).


/**** TEST POSITION ****/
:- begin_tests(check_colonne_cyclistes).

test(case_presente_valide) :-
    case_presente(1, 1).

test(case_presente_invalide) :-
    \+ case_presente(2, 4).


test(cycliste_position_valide_1) :-
    set_cyclist_position("Belgique", 1, 2, 2),  % Position valide
    set_cyclist_position("Hollande", 3, 1, 3),  % Position valide
    set_cyclist_position("Hollande", 2, 10, 2).  % Position valide

test(cycliste_position_invalide_1) :-
    \+ set_cyclist_position("Italie", 1, 10, 1). %Position invalide

test(cycliste_position_invalide_2) :-
    \+  set_cyclist_position("Italie", 2, 1, 4). %Position invalide
 

:- end_tests(check_colonne_cyclistes).


/**** Cyclistes ****/
:- begin_tests(position).

test(position_valide_1) :-
    set_cyclist_position("Hollande", 1, 1, 1), 
    set_cyclist_position("Hollande", 2, 1, 2), 
    set_cyclist_position("Hollande", 3, 1, 3).


test(position_invalide_1) :-
    set_cyclist_position("Belgique", 1, 2, 1), 
    set_cyclist_position("Belgique", 2, 2, 2), 
    set_cyclist_position("Belgique", 3, 2, 3), 
    \+ set_cyclist_position("Italie", 1, 2, 4).

:- end_tests(position).


:- begin_tests(chute).
test(chute_valide_1) :-
    set_cyclist_position("Belgique", 1, 4, 1), 
    set_cyclist_position("Belgique", 2, 4, 2), 
    set_cyclist_position("Belgique", 3, 4, 3),

    set_cyclist_position("Italie", 1, 0, 0), 
    set_cyclist_position("Italie", 2, 0, 0), 
    set_cyclist_position("Italie", 3, 0, 0),

    set_cyclist_position("Hollande", 1, 0, 0), 
    set_cyclist_position("Hollande", 2, 0, 0), 
    set_cyclist_position("Hollande", 3, 0, 0),

    set_cyclist_position("Allemagne", 1, 0, 0), 
    set_cyclist_position("Allemagne", 2, 0, 0), 
    set_cyclist_position("Allemagne", 3, 0, 0),
    
    get_card_play("Italie", 1,[5,2,1,2,2],_).

test(chute_valide_2) :-
    set_cyclist_position("Belgique", 1, 4, 1), 
    set_cyclist_position("Belgique", 2, 4, 2), 
    set_cyclist_position("Belgique", 3, 5, 1),

    set_cyclist_position("Italie", 1, 0, 0), 
    set_cyclist_position("Italie", 2, 0, 0), 
    set_cyclist_position("Italie", 3, 0, 0),

    set_cyclist_position("Hollande", 1, 0, 0), 
    set_cyclist_position("Hollande", 2, 0, 0), 
    set_cyclist_position("Hollande", 3, 0, 0),

    set_cyclist_position("Allemagne", 1, 0, 0), 
    set_cyclist_position("Allemagne", 2, 0, 0), 
    set_cyclist_position("Allemagne", 3, 0, 0),
    
    get_card_play("Italie", 1,[4,2,1,2,2],_).

test(chute_valide_3) :-
    set_cyclist_position("Belgique", 1, 4, 1), 
    set_cyclist_position("Belgique", 2, 4, 2), 
    set_cyclist_position("Belgique", 3, 4, 3),

    set_cyclist_position("Italie", 1, 5, 1), 
    set_cyclist_position("Italie", 2, 5, 2), 
    set_cyclist_position("Italie", 3, 5, 3),

    set_cyclist_position("Hollande", 1, 0, 0), 
    set_cyclist_position("Hollande", 2, 0, 0), 
    set_cyclist_position("Hollande", 3, 0, 0),

    set_cyclist_position("Allemagne", 1, 0, 0), 
    set_cyclist_position("Allemagne", 2, 0, 0), 
    set_cyclist_position("Allemagne", 3, 0, 0),
    
    get_card_play("Hollande", 1,[5,4,1,2,2],_).

test(chute_valide_4) :-
    set_cyclist_position("Belgique", 1, 24, 1), 
    set_cyclist_position("Belgique", 2, 24, 2), 
    set_cyclist_position("Belgique", 3, 4, 3),

    set_cyclist_position("Italie", 1, 5, 1), 
    set_cyclist_position("Italie", 2, 5, 2), 
    set_cyclist_position("Italie", 3, 5, 3),

    set_cyclist_position("Hollande", 1, 20, 1), 
    set_cyclist_position("Hollande", 2, 0, 0), 
    set_cyclist_position("Hollande", 3, 0, 0),

    set_cyclist_position("Allemagne", 1, 0, 0), 
    set_cyclist_position("Allemagne", 2, 0, 0), 
    set_cyclist_position("Allemagne", 3, 0, 0),
    
    get_card_play("Hollande", 1,[3,4,1,2,2],_).

test(chute_invalide_1) :-
    set_cyclist_position("Belgique", 1, 4, 1), 
    set_cyclist_position("Belgique", 2, 4, 2), 
    set_cyclist_position("Belgique", 3, 4, 3),

    set_cyclist_position("Italie", 1, 0, 0), 
    set_cyclist_position("Italie", 2, 0, 0), 
    set_cyclist_position("Italie", 3, 0, 0),

    set_cyclist_position("Hollande", 1, 0, 0), 
    set_cyclist_position("Hollande", 2, 0, 0), 
    set_cyclist_position("Hollande", 3, 0, 0),

    set_cyclist_position("Allemagne", 1, 0, 0), 
    set_cyclist_position("Allemagne", 2, 0, 0), 
    set_cyclist_position("Allemagne", 3, 0, 0),
    
     get_card_play("Italie", 1,[4,2,1,2,2],_).

    

:- end_tests(chute).

