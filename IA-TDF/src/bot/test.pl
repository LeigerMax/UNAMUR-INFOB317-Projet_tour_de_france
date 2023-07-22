:- consult('minimax.pl').
:- consult('plateau.pl').
:- consult('gamebot.pl').

/* --------------------------------------------------------------------- */
/*                                                                       */
/*                                Tests                                  */
/*                                                                       */
/* --------------------------------------------------------------------- */

/**** TEST CARTE ****/

:- begin_tests(get_card_play).

    test(get_card_play_valide_1) :-
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
        
        get_card_play("Italie", 1,[4,2,1,2,2], _, _, [4,2,1,2,2]). % Doit jouer carte 2 et se rendre (2,1)



    test(get_card_play_valide_2) :-
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

        get_card_play("Italie", 1,[4,2,1,2,2],_ ,_ , [4,2,1,2,2]). %Doit jouer carte 9 et se rendre (4,3)

    test(get_card_play_valide_3) :-
        set_cyclist_position("Belgique", 1, 11, 2), 
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
        
        get_card_play("Italie", 1,[4,11,1,2,2],_ ,_ , [4,11,1,2,2]). %Doit jouer carte 4 et se rendre (4,1)

    test(get_card_play_valide_4) :-
        set_cyclist_position("Belgique", 1, 4, 3), 
        set_cyclist_position("Belgique", 2, 4, 2), 
        set_cyclist_position("Belgique", 3, 4, 1),

        set_cyclist_position("Italie", 1, 0, 0), 
        set_cyclist_position("Italie", 2, 1, 1), 
        set_cyclist_position("Italie", 3, 0, 0),

        set_cyclist_position("Hollande", 1, 0, 0), 
        set_cyclist_position("Hollande", 2, 0, 0), 
        set_cyclist_position("Hollande", 3, 0, 0),

        set_cyclist_position("Allemagne", 1, 0, 0), 
        set_cyclist_position("Allemagne", 2, 0, 0), 
        set_cyclist_position("Allemagne", 3, 0, 0),
        
        get_card_play("Italie", 1,[1,4,4],_ ,_ ,[1,4,4]). % Doit jouer carte 1 et se rendre (1,2) 

    test(get_card_play_valide_5) :-
        set_cyclist_position("Belgique", 1, 4, 3), 
        set_cyclist_position("Belgique", 2, 4, 2), 
        set_cyclist_position("Belgique", 3, 4, 1),

        set_cyclist_position("Italie", 1, 0, 0), 
        set_cyclist_position("Italie", 2, 1, 1), 
        set_cyclist_position("Italie", 3, 0, 0),

        set_cyclist_position("Hollande", 1, 0, 0), 
        set_cyclist_position("Hollande", 2, 0, 0), 
        set_cyclist_position("Hollande", 3, 0, 0),

        set_cyclist_position("Allemagne", 1, 0, 0), 
        set_cyclist_position("Allemagne", 2, 0, 0), 
        set_cyclist_position("Allemagne", 3, 0, 0),
        
        get_card_play("Italie", 1,[9,2],_ ,_, [9,2]). % Doit jouer carte 9 et se rendre (9,2)


    test(get_card_play_valide_6) :-
        set_cyclist_position("Belgique", 1, 4, 3), 
        set_cyclist_position("Belgique", 2, 4, 2), 
        set_cyclist_position("Belgique", 3, 5, 1),

        set_cyclist_position("Italie", 1, 0, 0), 
        set_cyclist_position("Italie", 2, 1, 1), 
        set_cyclist_position("Italie", 3, 0, 0),

        set_cyclist_position("Hollande", 1, 0, 0), 
        set_cyclist_position("Hollande", 2, 0, 0), 
        set_cyclist_position("Hollande", 3, 0, 0),

        set_cyclist_position("Allemagne", 1, 0, 0), 
        set_cyclist_position("Allemagne", 2, 0, 0), 
        set_cyclist_position("Allemagne", 3, 0, 0),
        
        get_card_play("Italie", 1, [4,2],_ ,_ ,[4,2]). % Doit jouer carte 4 et se rendre (4,1)

:- end_tests(get_card_play).


:- begin_tests(get_max_min_card).

    test(get_max_card_1) :-
        set_player_cards(italie, [11, 8, 12, 3, 1]),
        get_max_card(italie, 12).

    test(get_max_card_2) :-
        set_player_cards(italie, [12, 8, 11, 5, 6]),
        get_max_card(italie, 12).

    test(get_max_card_3) :-
        set_player_cards(italie, [2, 3, 10, 7, 4]),
        get_max_card(italie, 10).

    test(get_max_card_4) :-
        set_player_cards(italie, []),
        get_max_card(italie, null).

    test(get_min_card_1) :-
        set_player_cards(italie, [4, 2, 10, 7, 4]),
        get_min_card(italie, 2).
        
:- end_tests(get_max_min_card).



/**** TEST CASE ****/

:- begin_tests(check_case_chance).

    test(case_chance_valide) :-
        case_chance(9, 1).

    test(case_chance_invalide) :-
        \+ case_chance(1, 2).

    test(case_chance_invalide) :-
        \+ case_chance(5, 1).

:- end_tests(check_case_chance).

:- begin_tests(check_case_presente).

    test(case_presente_valide) :-
        case_presente(1, 1).

    test(case_presente_invalide) :-
        \+ case_presente(2, 4).

    test(case_presente_invalide) :-
        \+ case_presente(10, 1).

:- end_tests(check_case_presente).


:- begin_tests(case_supplementaire).

    test(case_supplementaire_valide_1) :-
        is_case_supplementaire(105).

    test(case_supplementaire_valide_2) :-
        set_cyclist_position("Belgique", 1, 111, 1), 
        set_cyclist_position("Belgique", 2, 100, 1), 
        set_cyclist_position("Belgique", 3, 110, 1),

        set_cyclist_position("Italie", 1, 0, 0), 
        set_cyclist_position("Italie", 2, 0, 0), 
        set_cyclist_position("Italie", 3, 0, 0),

        set_cyclist_position("Hollande", 1, 0, 0), 
        set_cyclist_position("Hollande", 2, 0, 0), 
        set_cyclist_position("Hollande", 3, 0, 0),

        set_cyclist_position("Allemagne", 1, 0, 0), 
        set_cyclist_position("Allemagne", 2, 0, 0), 
        set_cyclist_position("Allemagne", 3, 0, 0),

        get_card_play("Belgique", 1, [8,2,10,2,1], _, _),
        get_card_play("Belgique", 2, [8,2,10,2,1], _, _),
        get_card_play("Belgique", 3, [8,2,10,2,1], _, _).

        test(case_supplementaire_invalide_1) :-
            \+ is_case_supplementaire(50).

:- end_tests(case_supplementaire).


/**** TEST POSITION ****/

:- begin_tests(set_cyclist_position).

    test(position_valide_1) :-
        set_cyclist_position("Hollande", 1, 1, 1), 
        set_cyclist_position("Hollande", 2, 1, 2), 
        set_cyclist_position("Hollande", 3, 1, 3).

    test(position_valide_2) :-
        set_cyclist_position("Belgique", 1, 2, 1), 
        set_cyclist_position("Belgique", 2, 2, 2), 
        set_cyclist_position("Belgique", 3, 2, 3), 
        set_cyclist_position("Belgique", 1, 5, 1).

    %test(position_invalide_1) :-
    %    \+  set_cyclist_position("Italie", 2, 1, 4). 


:- end_tests(set_cyclist_position).



:- begin_tests(tests).



test(get_card_play_valide_2) :-
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
    
    avancer_cycliste("Italie",1,4,_,_).

:- end_tests(tests).