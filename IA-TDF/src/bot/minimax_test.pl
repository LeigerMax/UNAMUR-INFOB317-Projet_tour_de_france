/* --------------------------------------------------------------------- */
/*                                                                       */
/*                                Tests                                  */
/*                                                                       */
/* --------------------------------------------------------------------- */
:- begin_tests(max_card).

:- consult('minimax.pl').


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
