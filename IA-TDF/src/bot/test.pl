:- consult('minmax.pl').
:- consult('plateau.pl').
:- consult('gamebot.pl').
:- consult('etat.pl').

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





/**** TEST MAXMAX ****/

:- begin_tests(state_init).


    test(stateInit) :-
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

        set_player_cards("Belgique", [1, 2, 4 ,8]),
        set_player_cards("Italie", [4, 5, 6]),
        set_player_cards("Hollande", [7, 8, 9]),
        set_player_cards("Allemagne", [10, 11, 12]),

        %Val1 = 0, Val2 = 10, Val3 = 34, Val4 = 48,

        stateInit("Belgique", [Be1, Be2, Be3], Cards1),
        stateInit("Italie", [It1, It2, It3], Cards2),
        stateInit("Hollande", [Hol1, Hol2, Hol3], Cards3),
        stateInit("Allemagne", [All1, All2, All3], Cards4),

        player(Belgique, Vald). 

    :- end_tests(state_init).


    :- begin_tests(evaluate).

        % Test de cyclist_eval pour une case chance
        test(cyclist_eval_case_chance) :-
            set_cyclist_position("Belgique", 1, 0, 0), 
            set_cyclist_position("Belgique", 2, 0, 0), 
            set_cyclist_position("Belgique", 3, 0, 0),

            set_cyclist_position("Italie", 1, 0, 0), 
            set_cyclist_position("Italie", 2, 0, 0), 
            set_cyclist_position("Italie", 3, 0, 0),
    
            set_cyclist_position("Hollande", 1, 0, 0), 
            set_cyclist_position("Hollande", 2, 0, 0), 
            set_cyclist_position("Hollande", 3, 0, 0),
    
            set_cyclist_position("Allemagne", 1, 0, 0), 
            set_cyclist_position("Allemagne", 2, 0, 0), 
            set_cyclist_position("Allemagne", 3, 0, 0),

            set_player_cards("Belgique", [1, 2, 4 ,8]),
            set_player_cards("Italie", [4, 5, 6]),
            set_player_cards("Hollande", [7, 8, 9]),
            set_player_cards("Allemagne", [10, 11, 12]),

            Cards = [1, 2, 4 ,8],
            cyclist_eval((9, 1), Cards, Val),
            assertion(Val =:= 6). % Le résultat attendu est 9 - 3 = 6

    
        % Test de cyclist_eval pour une case non chance
        test(cyclist_eval_non_case_chance) :-
            set_cyclist_position("Belgique", 1, 0, 0), 
            set_cyclist_position("Belgique", 2, 0, 0), 
            set_cyclist_position("Belgique", 3, 0, 0),

            set_cyclist_position("Italie", 1, 0, 0), 
            set_cyclist_position("Italie", 2, 0, 0), 
            set_cyclist_position("Italie", 3, 0, 0),
    
            set_cyclist_position("Hollande", 1, 0, 0), 
            set_cyclist_position("Hollande", 2, 0, 0), 
            set_cyclist_position("Hollande", 3, 0, 0),
    
            set_cyclist_position("Allemagne", 1, 0, 0), 
            set_cyclist_position("Allemagne", 2, 0, 0), 
            set_cyclist_position("Allemagne", 3, 0, 0),

            Cards = [1, 2, 4 ,8],
            cyclist_eval((5, 2), Cards, Val),
            assertion(Val =:= 5). % Le résultat attendu est 0 car ce n'est pas une case chance
    
    
        % Test de player_eval pour un joueur avec des coureurs en case chance
        test(player_eval_case_chance) :-
            set_cyclist_position("Belgique", 1, 0, 0), 
            set_cyclist_position("Belgique", 2, 0, 0), 
            set_cyclist_position("Belgique", 3, 0, 0),

            set_cyclist_position("Italie", 1, 0, 0), 
            set_cyclist_position("Italie", 2, 0, 0), 
            set_cyclist_position("Italie", 3, 0, 0),
    
            set_cyclist_position("Hollande", 1, 0, 0), 
            set_cyclist_position("Hollande", 2, 0, 0), 
            set_cyclist_position("Hollande", 3, 0, 0),
    
            set_cyclist_position("Allemagne", 1, 0, 0), 
            set_cyclist_position("Allemagne", 2, 0, 0), 
            set_cyclist_position("Allemagne", 3, 0, 0),

            Cards = [1, 2, 4 ,8],
            player_eval([(9, 1), (4, 2), (11, 1)], Cards, Val),
            assertion(Val =:= 6 + 4 + 8). % Le résultat attendu est la somme des évaluations des coureurs


        % Test de player_eval pour un joueur avec des coureurs en case non chance
        test(player_eval_non_case_chance) :-
            set_cyclist_position("Belgique", 1, 0, 0), 
            set_cyclist_position("Belgique", 2, 0, 0), 
            set_cyclist_position("Belgique", 3, 0, 0),

            set_cyclist_position("Italie", 1, 0, 0), 
            set_cyclist_position("Italie", 2, 0, 0), 
            set_cyclist_position("Italie", 3, 0, 0),
    
            set_cyclist_position("Hollande", 1, 0, 0), 
            set_cyclist_position("Hollande", 2, 0, 0), 
            set_cyclist_position("Hollande", 3, 0, 0),
    
            set_cyclist_position("Allemagne", 1, 0, 0), 
            set_cyclist_position("Allemagne", 2, 0, 0), 
            set_cyclist_position("Allemagne", 3, 0, 0),

            Cards = [1, 2, 4 ,8],
            player_eval([(5, 2), (5, 3), (6, 1)], Cards, Val),
            assertion(Val =:= 16). % Le résultat attendu est 16 car ce ne sont pas des cases chance

        % Test de player_eval pour un joueur avec un cycliste sur la  case 102
        test(player_eval_case_102) :-
            set_cyclist_position("Belgique", 1, 0, 0), 
            set_cyclist_position("Belgique", 2, 0, 0), 
            set_cyclist_position("Belgique", 3, 0, 0),

            set_cyclist_position("Italie", 1, 0, 0), 
            set_cyclist_position("Italie", 2, 0, 0), 
            set_cyclist_position("Italie", 3, 0, 0),
    
            set_cyclist_position("Hollande", 1, 0, 0), 
            set_cyclist_position("Hollande", 2, 0, 0), 
            set_cyclist_position("Hollande", 3, 0, 0),
    
            set_cyclist_position("Allemagne", 1, 0, 0), 
            set_cyclist_position("Allemagne", 2, 0, 0), 
            set_cyclist_position("Allemagne", 3, 0, 0),

            Cards = [1, 2, 4 ,8],
            cyclist_eval((102, 1), Cards, Val),
            assertion(Val =:= 122). % Le résultat attendu est 122 car se trouve à la case 102
        
        % Test de player_eval pour un joueur avec un cycliste sur une case supplémentaire 
        test(player_eval_case_supp) :-
            set_cyclist_position("Belgique", 1, 0, 0), 
            set_cyclist_position("Belgique", 2, 0, 0), 
            set_cyclist_position("Belgique", 3, 0, 0),

            set_cyclist_position("Italie", 1, 0, 0), 
            set_cyclist_position("Italie", 2, 0, 0), 
            set_cyclist_position("Italie", 3, 0, 0),
    
            set_cyclist_position("Hollande", 1, 0, 0), 
            set_cyclist_position("Hollande", 2, 0, 0), 
            set_cyclist_position("Hollande", 3, 0, 0),
    
            set_cyclist_position("Allemagne", 1, 0, 0), 
            set_cyclist_position("Allemagne", 2, 0, 0), 
            set_cyclist_position("Allemagne", 3, 0, 0),

            Cards = [1, 2, 4 ,8],
            cyclist_eval((105, 1), Cards, Val),
            assertion(Val =:= 105). % Le résultat attendu est 105 car se trouve à la case 105

        test(player_eval_case_chute) :-
            set_cyclist_position("Belgique", 1, 4, 3), 
            set_cyclist_position("Belgique", 2, 4, 2), 
            set_cyclist_position("Belgique", 3, 4, 1),

            set_cyclist_position("Italie", 1, 0, 0), 
            set_cyclist_position("Italie", 2, 0, 0), 
            set_cyclist_position("Italie", 3, 0, 0),
    
            set_cyclist_position("Hollande", 1, 0, 0), 
            set_cyclist_position("Hollande", 2, 0, 0), 
            set_cyclist_position("Hollande", 3, 0, 0),
    
            set_cyclist_position("Allemagne", 1, 0, 0), 
            set_cyclist_position("Allemagne", 2, 0, 0), 
            set_cyclist_position("Allemagne", 3, 0, 0),

            Cards = [1, 2, 4 ,8],
            cyclist_eval((4, 1), Cards, Val),
            assertion(Val =:= -16). % Le résultat attendu est -16 car chute



        test(global) :-
            set_cyclist_position("Belgique", 1, 4, 1), 
            set_cyclist_position("Belgique", 2, 4, 2), 
            set_cyclist_position("Belgique", 3, 4, 3),
    
            set_cyclist_position("Italie", 1, 11, 1), 
            set_cyclist_position("Italie", 2, 11, 2), 
            set_cyclist_position("Italie", 3, 102, 1),
    
            set_cyclist_position("Hollande", 1, 105, 1), 
            set_cyclist_position("Hollande", 2, 1, 1), 
            set_cyclist_position("Hollande", 3, 6, 2),
    
            set_cyclist_position("Allemagne", 1, 9, 1), 
            set_cyclist_position("Allemagne", 2, 88, 1), 
            set_cyclist_position("Allemagne", 3, 100, 1),
    
            set_player_cards("Belgique", [1, 2, 4 ,8, 2]),
            set_player_cards("Italie", [4, 5, 6, 12, 4]),
            set_player_cards("Hollande", [7, 8, 9, 5, 9]),
            set_player_cards("Allemagne", [10, 11, 12, 1, 4]),
    
    
           % stateInit("Belgique", [Be1, Be2, Be3], Cards1),
           % stateInit("Italie", [It1, It2, It3], Cards2),
           % stateInit("Hollande", [Hol1, Hol2, Hol3], Cards3),
           % stateInit("Allemagne", [All1, All2, All3], Cards4),
    
            %player(Belgique,Val1).
            player([Belgique, Italie, Hollande, Allemagne, 1], [Val1, Val2, Val3, Val4]),
            writeln("FIN "+Val1),
            writeln("FIN "+Val2),
            writeln("FIN "+Val3),
            writeln("FIN "+Val4).



    :- end_tests(evaluate).
