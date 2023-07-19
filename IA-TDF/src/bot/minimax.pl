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


get_min_card([Card], Card).
get_min_card([Card | Rest], MinCard) :-
    get_min_card(Rest, MinRest),
    (Card < MinRest
    -> MinCard = Card
    ; MinCard = MinRest).




%TODO: Il faudra vérifier ici que le bot prend la bonne carte afin de ne pas provoquer de chute 
get_card_play([], null).
get_card_play(PlayerId, CyclistId, Cards, Card) :-
    get_cyclist_position(PlayerId, CyclistId, Ligne, Colonne),
    (is_case_supplementaire(Ligne) % Vérifier si le joueur est dans une case spéciale
    ->  get_min_card(Cards, MinCard), % Obtenir la plus petite carte
    writeln('Carte minimale : ' + MinCard),
    Card = MinCard 
    ;
    get_max_card(Cards, MaxCard), % Obtenir la plus grande carte
    writeln('Carte maximale : ' + MaxCard),
    avancer_cycliste(PlayerId, CyclistId, MaxCard, Chute), % Vérifier si la carte provoque une chute
    (Chute = 1
    ->  (Cards = [_|RestCards], get_card_play(PlayerId, CyclistId, RestCards, Card)) % Essayer la carte suivante
    ;   writeln('La carte ne provoque pas de chute.'), Card = MaxCard)). % La carte sélectionnée ne provoque pas de chute

/*
get_card_play(PlayerId, CyclistId, Cards, Card) :-
    get_player_position(PlayerId, CyclistId, Ligne, Colonne),
    (is_case_supplementaire(Ligne) % Vérifier si le joueur est dans une case spéciale
    ->  get_min_card(Cards, MinCard), % Obtenir la plus petite carte
        writeln('Carte minimale : ' + MinCard),
        Card = MinCard % La carte sélectionnée ne provoque pas de chute
    ;   get_max_card(Cards, MaxCard), % Obtenir la plus grande carte
        writeln('Carte maximale : ' + MaxCard),
        avancer_cycliste(PlayerId, CyclistId, MaxCard, Chute), % Vérifier si la carte provoque une chute
        (Chute = 1
        ->  (RestCards = [_|Rest], get_card_play(PlayerId, CyclistId, Rest, Card)) % Essayer la carte suivante
        ;   writeln('La carte ne provoque pas de chute.'), Card = MaxCard)). % La carte sélectionnée ne provoque pas de chute
*/

is_case_supplementaire(Ligne) :-
    Ligne >= 103,
    Ligne =< 112.
