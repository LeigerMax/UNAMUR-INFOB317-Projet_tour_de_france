:- use_module(library(random)).
:- consult('etat.pl').



/***** CARTE *****/

% Récupère la plus grande carte
% Entrées : [Card]
% Sorties : Max
get_max_card([], null).
get_max_card([Card|Rest], Max) :-
    get_max_card(Rest, MaxRest),
    compare_cards_max(Card, MaxRest, Max).

% Récupère la plus grande carte d'un joueur
% Entrées : PlayerId
% Sorties : MaxCard
get_max_card(PlayerId, MaxCard) :-
    get_player_cards(PlayerId, Cards),
    get_max_card(Cards, MaxCard).


% Récupère la plus petite carte
% Entrées : [Card]
% Sorties : MinCard
get_min_card([], null).
get_min_card([Card|Rest], Min) :-
    get_min_card(Rest, MinRest),
    compare_cards_min(Card, MinRest, Min).

% Récupère la plus grande carte d'un joueur
% Entrées : PlayerId
% Sorties : MinCard
get_min_card(PlayerId, MinCard) :-
    get_player_cards(PlayerId, Cards),
    get_min_card(Cards, MaxCard).

% Compare les cartes (max)
% Entrées : Card
% Sorties : Max
compare_cards_max(Card, null, Card).

compare_cards_max(Card, MaxRest, Max) :-
    Card > MaxRest,
    Max = Card.
compare_cards_max(Card, MaxRest, Max) :-
    Card =< MaxRest,
    Max = MaxRest.

% Compare les cartes (min)
% Entrées : Card
% Sorties : Min
compare_cards_min(Card, null, Card).
compare_cards_min(Card, MinRest, Min) :-
    Card < MinRest,
    Min = Card.
compare_cards_min(Card, MinRest, Min) :-
    Card >= MinRest,
    Min = MinRest.


get_card_play([], null, _, _, ColonneChoix).


% Vérifie si le paquet est vide
% Entrées : []
% Sorties : true si paquet vide
paquet_vide([]).

% Si toutes les cartes ont été jouer, on joue la plus petite du paquet
% Entrées : PlayerId, CyclistId, [Card],CardsSave
% Sorties : Card, ColonneChoix
get_card_play(PlayerId, CyclistId, [], Card, ColonneChoix, CardsSave) :- % Cas où il ne reste qu'une seule carte
    get_min_card(CardsSave, MinCard), % Obtenir la plus petite carte
    writeln('Carte minimale : ' + MinCard),
    Card = MinCard,
    ColonneChoix is 1.


% Joue la meilleur carte
% Entrées : PlayerId, CyclistId, [Card]
% Sorties : Card, ColonneChoix
get_card_play(PlayerId, CyclistId, Cards, Card, ColonneChoix, CardsSave) :-
    get_cyclist_position(PlayerId, CyclistId, Ligne, Colonne),
    (is_case_supplementaire(Ligne) % Vérifier si le joueur est dans une case spéciale
    ->  get_min_card(Cards, MinCard), % Obtenir la plus petite carte
        writeln('Carte minimale : ' + MinCard),
        Card = MinCard,
        ColonneChoix is 1
    ;
        get_max_card(Cards, MaxCard), % Obtenir la plus grande carte
        writeln('Carte maximale : ' + MaxCard),
        avancer_cycliste(PlayerId, CyclistId, MaxCard, ColonneChoix, Chute), % Vérifier si la carte provoque une chute 
        (Chute = 1
        ->  (remove_card(MaxCard, Cards, RestCards), % Retirer la carte MaxCard de la liste Cards
             get_card_play(PlayerId, CyclistId, RestCards, Card, ColonneChoix, CardsSave)) % Essayer la carte suivante
        ;   writeln('La carte ne provoque pas de chute et pas une case chance.'), Card = MaxCard)). % La carte sélectionnée ne provoque pas de chute


% Retire un élément de la liste
% Entrées : Element, Liste, NouvelleListe
% Sorties : NouvelleListe avec Element retiré
remove_card(Element, [Element|Rest], Rest).
remove_card(Element, [X|Rest], [X|NewRest]) :-
    remove_card(Element, Rest, NewRest).




% Prédicat pour générer un nombre aléatoire entre Min et Max
random_between(Min, Max, RandomNum) :-
    random(Min, Max, RandomNum).

% Prédicat pour générer une liste de 3 chiffres aléatoires entre 1 et 12
generate_random_list(List) :-
    generate_random_number_list(3, 1, 12, List).

% Prédicat récursif pour générer une liste de N chiffres aléatoires entre Min et Max
generate_random_number_list(0, _, _, []).
generate_random_number_list(N, Min, Max, [RandomNum | Rest]) :-
    N > 0,
    random_between(Min, Max, RandomNum),
    NewN is N - 1,
    generate_random_number_list(NewN, Min, Max, Rest).
