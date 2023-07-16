:- consult('gamebot.pl').

/***** Return carte plus grande *****/
get_max_card([], null).
get_max_card([Card|Rest], Max) :-
    get_max_card(Rest, MaxRest),
    compare_cards(Card, MaxRest, Max).

compare_cards(Card, null, Card).
compare_cards(Card, MaxRest, Max) :-
    Card > MaxRest,
    Max = Card.
compare_cards(Card, MaxRest, Max) :-
    Card =< MaxRest,
    Max = MaxRest.

% Prédicat pour obtenir la plus grande carte d'un joueur
get_max_card(PlayerId, MaxCard) :-
    get_player_cards(PlayerId, Cards),
    get_max_card(Cards, MaxCard).
