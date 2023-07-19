:- consult('gamebot.pl').



/***** CARTE *****/
/*
get_max_card([], null).
get_max_card([Card | Rest], Max) :-
    (chute_possible(Card) % Vérifier si la carte provoque une chute
    ->  (writeln('Chute possible !'), get_max_card(Rest, Max)) % Afficher un message si une chute est possible
    ;   (get_max_card(Rest, MaxRest), % Récupérer la plus grande carte du reste de la liste
         compare_cards(Card, MaxRest, Max))).
*/

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


%TODO: Il faudra vérifier ici que le bot prend la bonne carte afin de ne pas provoquer de chute 
get_card_play([], null).
get_card_play(PlayerId, CyclistId, Cards, Card) :-
    get_max_card(Cards, MaxCard), % Obtenir la plus grande carte
    writeln('Carte maximale : ' + MaxCard),
    avancer_cycliste(PlayerId, CyclistId, MaxCard, Chute), % Vérifier si la carte provoque une chute
    (Chute = 1
    ->  (Cards = [_|RestCards], get_card_play(PlayerId, CyclistId, RestCards, Card)) % Essayer la carte suivante
    ;   writeln('La carte ne provoque pas de chute.'), Card = MaxCard). % La carte sélectionnée ne provoque pas de chute


