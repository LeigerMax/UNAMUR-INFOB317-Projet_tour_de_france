:- use_module(library(lists)).
:- use_module(library(http/websocket)).
:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).



/* --------------------------------------------------------------------- */
/*                                                                       */
/*        PRODUIRE_REPONSE(L_Mots,L_Lignes_reponse) :                    */
/*                                                                       */
/*        Input : une liste de mots L_Mots representant la question      */
/*                de l'utilisateur                                       */
/*        Output : une liste de liste de mots correspondant a la         */
/*                 reponse fournie par le bot                            */
/*                                                                       */
/*        NB Pour l'instant le predicat retourne dans tous les cas       */
/*            [  [je, ne, sais, pas, '.'],                               */
/*               [les, etudiants, vont, m, '\'', aider, '.'],            */
/*               ['vous le verrez !']                                    */
/*            ]                                                          */
/*                                                                       */
/*        Je ne doute pas que ce sera le cas ! Et vous souhaite autant   */
/*        d'amusement a coder le predicat que j'ai eu a ecrire           */
/*        cet enonce et ce squelette de solution !                       */
/*                                                                       */
/*        J.-M. Jacquet, janvier 2022                                    */
/*                                                                       */
/* --------------------------------------------------------------------- */


/*                      !!!    A MODIFIER   !!!                          */

produire_reponse([fin],[L1]) :-
   L1 = [merci, de, m, '\'', avoir, consulte], !.    


produire_reponse(L,Rep) :-
   mFind(M,L,Variant),
   replace(L,Variant,M, NewPhrase),
   clause(regle_rep(M,_,Pattern,Rep),Body),
   match_pattern(Pattern,NewPhrase),
   call(Body), !.

produire_reponse(_,[L1,L2,L3]) :-
   L1 = [je, ne, sais, pas, '.'],
   L2 = [les, etudiants, vont, m, '\'', aider, '.' ],
   L3 = ['vous le verrez !'].

%produire_reponse(L_Mots,L_Lignes_reponse):-



match_pattern(Pattern,Lmots) :-
   sublist(Pattern,Lmots).

match_pattern(LPatterns,Lmots) :-
   match_pattern_dist([100|LPatterns],Lmots).

match_pattern_dist([],_).
match_pattern_dist([N,Pattern|Lpatterns],Lmots) :-
   pFind(Pattern,Lmots,Variant),
   replace(Lmots,Variant,Pattern,NewPhrase),
   within_dist(N,Pattern,NewPhrase,Lmots_rem),
   match_pattern_dist(Lpatterns,Lmots_rem).

within_dist(_,Pattern,Lmots,Lmots_rem) :-
   prefixrem(Pattern,Lmots,Lmots_rem).
within_dist(N,Pattern,[_|Lmots],Lmots_rem) :-
   N > 1, Naux is N-1,
  within_dist(Naux,Pattern,Lmots,Lmots_rem).


sublist(SL,L) :- 
   prefix(SL,L), !.
sublist(SL,[_|T]) :- sublist(SL,T).

sublistrem(SL,L,Lr) :- 
   prefixrem(SL,L,Lr), !.
sublistrem(SL,[_|T],Lr) :- sublistrem(SL,T,Lr).

prefixrem([],L,L).
prefixrem([H|T],[H|L],Lr) :- prefixrem(T,L,Lr).


% ----------------------------------------------------------------%

nb_coureurs(3).
nb_equipes(4).

/* --------------------------------------------------------------------- */
/*                                                                       */
/*                               Mots-clé                                */
/*                                                                       */
/* --------------------------------------------------------------------- */

mclef(but,10).
mclef(carte,10).
mclef(commence,10).
mclef(chance,10).
mclef(chute,10).
mclef(descente,10).
mclef(depasser,10).

mclef(deplacer,10).
mclef(deplacer,9).
mclef(deplacer,8).
mclef(deplacer,7).
mclef(deplacer,6).
mclef(deplacer,5).

mclef(equipe,5).
mclef(help,5).
mclef(montee,10).
mclef(score,10).


mclef(plateau, 10).
mclef(plateau, 11).
mclef(plateau, 12).

mclef(point,10).



/* --------------------------------------------------------------------- */
/*                                                                       */
/*                             Phrase réponse                            */
/*                                                                       */
/* --------------------------------------------------------------------- */

regle_rep(but,5,
   [[quel], 3, [but], 4, [jeu]],
   [[dans, ce, jeu, les, joueurs, participent, aux, etapes, en, equipe, de, trois, coureurs, le, but, de, chaque,
   equipe, est, "d'obtenir", le, meilleur, score, possible, et, le, classement, est, tenu,
   par, joueur, et, par,equipe, chaque, tour, se, compose, de, plusieurs, etapes, et, le,
   coureur, le, plus, rapide, sur, "l'ensemble", des, etapes, porte, le, maillot, jaune, le, 
   joueur, dont, "l'equipe", obtient, le, meilleur, temps, remporte, le, plus, de, points, au,
   classement, general, et, est, declare, vainqueur, du, tour
   ]]
  ).


% ----------------------------------------------------------------%

regle_rep(carte,10,
   [ [ combien ], 4, [ carte ] ],
   [ [ "Le", jeu, est, compose, de, 96, cartes, secondes, numerotees, de, 1, "à", "12.", "Une", fois, que, toutes, les, cartes, du, paquet, ont, "été" ,jouees, le, paquet, est, melange, "à", "nouveau."] ] ).

% ----------------------------------------------------------------%


regle_rep(commence,5,
  [ [ commence ], 4 , [ partie ] ],
  [ [ des, X, equipes, "c'est", au, joueur, ayant, la, plus, haute, carte, secondes, de, "commencer." ] ] ):-

     nb_equipes(X).

% ----------------------------------------------------------------%

regle_rep(chance,10,
  [ [quoi], 2 ,[chance] ],
  [ ["Lorsqu'une", case, chance, est, atteinte, un, chiffre, est, selectionne, de, maniere, aleatoire, dans, la, plage, de, -3, a, "3.", si, le, chiffre, est, negatif, le, cycliste, recule, 
  du, nombre, de, cases, "indique.", "S'il", est, positif, il, avance, du, nombre, de, cases, "correspondant.", enfin, si, le, chiffre, est, 0, le, cycliste, reste, sur, "place."] ]).

% ----------------------------------------------------------------%

regle_rep(chute,10,
  [ [ comment ], 2 ,[ chute ], 3 ,[ arriver ] ],
  [ [une, chute, se, produit ,lorsque, deux, joueurs, entrent, en, contact, sur, la, meme, case, ce, qui, entraine, 
  une, chute, des, deux, joueurs, ainsi, que, des, cases, autour, "d'eux", ., de, plus, tout, contact, avec, un, joueur, 
  provoque, egalement, une, chute ] ]).

% ----------------------------------------------------------------%

regle_rep(descente,10, 
  [ [descente] ],
  [ [la, regle, "n'est", pas, implementee, dans, notre, version, du, "jeu."] ]).

% ----------------------------------------------------------------%

regle_rep(depasser,5, 
  [ [ depasser ], 5, [ groupe ]],
  [ [ oui, il, est, permis, de, depasser, par, le, "bas-cote", de, la, route, pour, autant, que, le, coureur, arrive, sur, une, case, non, "occupee.", si, ce, "n'est", pas, le, cas, le, coureur, chute, et, entraine, dans, sa, chute, le, groupe, de, coureurs, "qu'il", voulait ,"depasser."] ]).
   

% ----------------------------------------------------------------%

regle_rep(deplacer,10,
  [ [ deplacer ], 2, [ coureur ], 4 ,[ occupee ] ],
  [ [ non, ce "n'est", pas, un, mouvement, "autorise." ]]).

regle_rep(deplacer,8,
  [ [ deplacer ], 2, [ coureur ], 3 ,[ diagonal ] ], 
  [ [ oui, "c'est", "possible.", les, deplacements, se, font, toujours, de, "l'avant.", et, cela, fonctionne, donc, sur, une, case, "diagonale." ]]).
   
 regle_rep(deplacer,8,
  [ [ deplacer ], 2, [ coureur ], 3 ,[ adjacente ] ], 
  [ [ oui, "c'est", "possible.", les, deplacements, se, font, toujours, de, "l'avant.", et, cela, fonctionne, donc, sur, une, case, "adjacente." ]]).
 
 regle_rep(deplacer,8,
  [ [ deplacer ], 2, [ coureur ], 3,[ arriere ] ],
  [ [ non, ce, "n'est", pas, un, mouvement, "autorise." ]]).
   
 regle_rep(deplacer,6,
  [ [ deplacer ], 5 ,[ double ]], 
  [ [ les, double, case, comptent, pour, deux, "cases.", elles, sont, disponibles, dans, les, virages, et , permettent, de, faire, le, choix, entre, une, case, chance, ou, un, chemin, plus, "long." ]]).

regle_rep(deplacer,5,
  [ [ carte ], 2, [ deplacer ] ],
  [ [ les, cartes, comportent, un, certain, nombre, de, "secondes,", le, nombre, de, seconde, determine, le, nombre, de, case, que, le, coureur, peut, "avancer." ]]).

% ----------------------------------------------------------------%

regle_rep(equipe,5,
  [ [ combien ], 3, [ coureurs ], 5, [ equipe ] ],
  [ [ chaque, equipe, compte, X, "coureurs." ] ]) :-

     nb_coureurs(X).

% ----------------------------------------------------------------%

regle_rep(help,10,
  [ [ help ] ],
  [ [voici, quelques, exemples, de, questions, que, vous, pouvez, me, "poser.", "Qui", commence, la, "partie ?", "Quelle", est, le, but, du, "jeu ?" ] ] ).


% ----------------------------------------------------------------%

regle_rep(montee,10,
  [ [montee]  ],
  [ [les, cases, situees, en, montee, sont, marquees, par, des, fleches, "rouges.", pour, determiner, la, vitesse, "d'un", coureur, en, montee, divisez, par, deux, la, valeur, 
  de, la, carte, jouee, et, arrondissez, au, plus, "bas.", un, coureur, en, montee, ne, peut, pas, profiter, du, phenomene, "d'aspiration." ] ]).

% ----------------------------------------------------------------%

regle_rep(plateau,10,
  [ [ commence ], 2, [ plateau ] ],
  [ [ le, plateau, commence, a, la, case, 0, pour, tout, les, "joueurs." ]]).
  
regle_rep(plateau,11,
  [ [ termine ], 2, [ plateau ] ],
  [ [ le, plateau, se, termine, a, la, case, 103, pour, tout, les, "joueurs.", les, cases, suivant, cette, case, sont, des, cases, "bonus." ]]).

regle_rep(plateau,12, 
  [ [ plateau ], 2, [ divise ] ],
  [ [ quand, le, plateau, se, divise, en, deux, vous, etes, libre, de, choisir, le, chemin, qui, vous ,avantage, le, "mieux." ]]).

% ----------------------------------------------------------------%

regle_rep(score,10,
  [ [comment],3, [ score ] ],
  [ [ "Le", calcul, du, score, "s'effectue", de, la, maniere, suivante, ":", chaque, cycliste, possede, un, nombre, de, points, et, les, points, de, chaque, cycliste, "d'une", equipe, sont, "additionnes.", "L'eéquipe", qui,
   obtient, le, moins, de, points, remporte, la, "partie." ] ] ).

% ----------------------------------------------------------------%

regle_rep(point,10,
  [ [comment],4, [ point ] ],
  [ [ "A", chaque, fois, "qu'un", cycliste, joue, son, tour, il, gagne, 10, points, "supplementaires."] ] ).


/* --------------------------------------------------------------------- */
/*                                                                       */
/*          CONVERSION D'UNE QUESTION DE L'UTILISATEUR EN                */
/*                        LISTE DE MOTS                                  */
/*                                                                       */
/* --------------------------------------------------------------------- */

% lire_question(L_Mots) 

lire_question(LMots) :- read_atomics(LMots).



/*****************************************************************************/
% my_char_type(+Char,?Type)
%    Char is an ASCII code.
%    Type is whitespace, punctuation, numeric, alphabetic, or special.

my_char_type(46,period) :- !.
my_char_type(X,alphanumeric) :- X >= 65, X =< 90, !.
my_char_type(X,alphanumeric) :- X >= 97, X =< 123, !.
my_char_type(X,alphanumeric) :- X >= 48, X =< 57, !.
my_char_type(X,whitespace) :- X =< 32, !.
my_char_type(X,punctuation) :- X >= 33, X =< 47, !.
my_char_type(X,punctuation) :- X >= 58, X =< 64, !.
my_char_type(X,punctuation) :- X >= 91, X =< 96, !.
my_char_type(X,punctuation) :- X >= 123, X =< 126, !.
my_char_type(_,special).


/*****************************************************************************/
% lower_case(+C,?L)
%   If ASCII code C is an upper-case letter, then L is the
%   corresponding lower-case letter. Otherwise L=C.

lower_case(X,Y) :-
	X >= 65,
	X =< 90,
	Y is X + 32, !.

lower_case(X,X).


/*****************************************************************************/
% read_lc_string(-String)
%  Reads a line of input into String as a list of ASCII codes,
%  with all capital letters changed to lower case.

read_lc_string(String) :-
	get0(FirstChar),
	lower_case(FirstChar,LChar),
	read_lc_string_aux(LChar,String).

read_lc_string_aux(10,[]) :- !.  % end of line

read_lc_string_aux(-1,[]) :- !.  % end of file

read_lc_string_aux(LChar,[LChar|Rest]) :- read_lc_string(Rest).


/*****************************************************************************/
% extract_word(+String,-Rest,-Word) (final version)
%  Extracts the first Word from String; Rest is rest of String.
%  A word is a series of contiguous letters, or a series
%  of contiguous digits, or a single special character.
%  Assumes String does not begin with whitespace.

extract_word([C|Chars],Rest,[C|RestOfWord]) :-
	my_char_type(C,Type),
	extract_word_aux(Type,Chars,Rest,RestOfWord).

extract_word_aux(special,Rest,Rest,[]) :- !.
   % if Char is special, dont read more chars.

extract_word_aux(Type,[C|Chars],Rest,[C|RestOfWord]) :-
	my_char_type(C,Type), !,
	extract_word_aux(Type,Chars,Rest,RestOfWord).

extract_word_aux(_,Rest,Rest,[]).   % if previous clause did not succeed.


/*****************************************************************************/
% remove_initial_blanks(+X,?Y)
%   Removes whitespace characters from the
%   beginning of string X, giving string Y.

remove_initial_blanks([C|Chars],Result) :-
	my_char_type(C,whitespace), !,
	remove_initial_blanks(Chars,Result).

remove_initial_blanks(X,X).   % if previous clause did not succeed.


/*****************************************************************************/
% digit_value(?D,?V)
%  Where D is the ASCII code of a digit,
%  V is the corresponding number.

digit_value(48,0).
digit_value(49,1).
digit_value(50,2).
digit_value(51,3).
digit_value(52,4).
digit_value(53,5).
digit_value(54,6).
digit_value(55,7).
digit_value(56,8).
digit_value(57,9).


/*****************************************************************************/
% string_to_number(+S,-N)
%  Converts string S to the number that it
%  represents, e.g., "234" to 234.
%  Fails if S does not represent a nonnegative integer.

string_to_number(S,N) :-
	string_to_number_aux(S,0,N).

string_to_number_aux([D|Digits],ValueSoFar,Result) :-
	digit_value(D,V),
	NewValueSoFar is 10*ValueSoFar + V,
	string_to_number_aux(Digits,NewValueSoFar,Result).

string_to_number_aux([],Result,Result).


/*****************************************************************************/
% string_to_atomic(+String,-Atomic)
%  Converts String into the atom or number of
%  which it is the written representation.

string_to_atomic([C|Chars],Number) :-
	string_to_number([C|Chars],Number), !.

string_to_atomic(String,Atom) :- name(Atom,String).
  % assuming previous clause failed.


/*****************************************************************************/
% extract_atomics(+String,-ListOfAtomics) (second version)
%  Breaks String up into ListOfAtomics
%  e.g., " abc def  123 " into [abc,def,123].

extract_atomics(String,ListOfAtomics) :-
   remove_initial_blanks(String,NewString),
   extract_atomics_aux(NewString,ListOfAtomics).

   extract_atomics_aux([C|Chars],[A|Atomics]) :-
   extract_word([C|Chars],Rest,Word),
   string_to_atomic(Word,A),       % <- this is the only change
   extract_atomics(Rest,Atomics).

extract_atomics_aux([],[]).

string_to_atom_list(String, AtomList) :-
   split_string(String, " ", "", Words),
   maplist(atom_string, AtomList, Words).


/*****************************************************************************/
% clean_string(+String,-Cleanstring)
%  removes all punctuation characters from String and return Cleanstring

clean_string([C|Chars],L) :-
	my_char_type(C,punctuation),
	clean_string(Chars,L), !.
clean_string([C|Chars],[C|L]) :-
	clean_string(Chars,L), !.
clean_string([C|[]],[]) :-
	my_char_type(C,punctuation), !.
clean_string([C|[]],[C]).


/*****************************************************************************/
% read_atomics(-ListOfAtomics)
%  Reads a line of input, removes all punctuation characters, and converts
%  it into a list of atomic terms, e.g., [this,is,an,example].

read_atomics(ListOfAtomics) :-
	read_lc_string(String),
	clean_string(String,Cleanstring),
	extract_atomics(Cleanstring,ListOfAtomics).



/* --------------------------------------------------------------------- */
/*                                                                       */
/*        ECRIRE_REPONSE : ecrit une suite de lignes de texte            */
/*                                                                       */
/* --------------------------------------------------------------------- */

ecrire_reponse(L) :-
   nl, write('TBot :'),
   ecrire_li_reponse(L,1,1).

% ecrire_li_reponse(Ll,M,E)
% input : Ll, liste de listes de mots (tout en minuscules)
%         M, indique si le premier caractere du premier mot de 
%            la premiere ligne doit etre mis en majuscule (1 si oui, 0 si non)
%         E, indique le nombre d espaces avant ce premier mot 

ecrire_li_reponse([],_,_) :- 
    nl.

ecrire_li_reponse([Li|Lls],Mi,Ei) :- 
   ecrire_ligne(Li,Mi,Ei,Mf),
   ecrire_li_reponse(Lls,Mf,2).

% ecrire_ligne(Li,Mi,Ei,Mf)
% input : Li, liste de mots a ecrire
%         Mi, Ei booleens tels que decrits ci-dessus
% output : Mf, booleen tel que decrit ci-dessus a appliquer 
%          a la ligne suivante, si elle existe

ecrire_ligne([],M,_,M) :- 
   nl.

ecrire_ligne([M|L],Mi,Ei,Mf) :-
   ecrire_mot(M,Mi,Maux,Ei,Eaux),
   ecrire_ligne(L,Maux,Eaux,Mf).

% ecrire_mot(M,B1,B2,E1,E2)
% input : M, le mot a ecrire
%         B1, indique s il faut une majuscule (1 si oui, 0 si non)
%         E1, indique s il faut un espace avant le mot (1 si oui, 0 si non)
% output : B2, indique si le mot suivant prend une majuscule
%          E2, indique si le mot suivant doit etre precede d un espace

ecrire_mot('.',_,1,_,1) :-
   write('. '), !.
ecrire_mot('\'',X,X,_,0) :-
   write('\''), !.
ecrire_mot(',',X,X,E,1) :-
   espace(E), write(','), !.
ecrire_mot(M,0,0,E,1) :-
   espace(E), write(M).
ecrire_mot(M,1,0,E,1) :-
   name(M,[C|L]),
   D is C - 32,
   name(N,[D|L]),
   espace(E), write(N).

espace(0).
espace(N) :- N>0, Nn is N-1, write(' '), espace(Nn).

/* --------------------------------------------------------------------- */
/*                                                                       */
/*                           CALCUL DISTANCE                             */
/*                                                                       */
/* --------------------------------------------------------------------- */

% DÃ©finition de la fonction min/3
min(X, Y, X) :- X =< Y.
min(X, Y, Y) :- X > Y.

% Cas de base : si le premier argument est une liste vide, la distance est la longueur de la deuxiÃ¨me liste.
levenshtein_distance([], Y, Distance) :- length(Y, Distance).

% Cas de base : si le deuxiÃ¨me argument est une liste vide, la distance est la longueur de la premiÃ¨re liste.
levenshtein_distance(X, [], Distance) :- length(X, Distance).

% Cas rÃ©cursif : comparaison des deux premiers Ã©lÃ©ments des listes X et Y.
levenshtein_distance([X|Xs], [Y|Ys], Distance) :-
    % Si les Ã©lÃ©ments sont identiques, on continue avec les listes restantes.
    (X == Y -> levenshtein_distance(Xs, Ys, Distance)
    % Si les Ã©lÃ©ments sont diffÃ©rents, on a trois options possibles :
    ; levenshtein_distance(Xs, [Y|Ys], Distance1), % 1. On insÃ¨re un caractÃ¨re dans la premiÃ¨re liste.
      levenshtein_distance([X|Xs], Ys, Distance2), % 2. On supprime un caractÃ¨re de la deuxiÃ¨me liste.
      levenshtein_distance(Xs, Ys, Distance3),     % 3. On substitue un caractÃ¨re de la premiÃ¨re liste avec un caractÃ¨re de la deuxiÃ¨me liste.
      % On calcule rÃ©cursivement la distance pour chaque option, et on prend le minimum.
      min_list([Distance1, Distance2, Distance3], Min),
      Distance is Min + 1
    ).

lDistance(X, Y, Distance) :-
   string_chars(X, Xs),
   string_chars(Y, Ys),
   levenshtein_distance(Xs, Ys, Distance).



/* --------------------------------------------------------------------- */
/*                                                                       */
/*                     VERIFICATION DISTANCE                             */
/*                                                                       */
/* --------------------------------------------------------------------- */

verif_distance(X, Y) :- 
   distance_degree(X, Y, Len),
   (Len >= 75 ; (Len < 75, !, fail)).


/* --------------------------------------------------------------------- */
/*                                                                       */
/*                            TROUVE MCLEF                               */
/*                                                                       */
/* --------------------------------------------------------------------- */

mSelecter(L,M1,_,Mchoice):-
   mclef(M1,_),
   member(M1,L),
   Mchoice = M1.

mSelecter(L, M1, M2, Mchoice):-
   mclef(M1,P1),
   mclef(M2,P2),
   member(M1,L),
   member(M2,L),
   (P1 < P2, Mchoice = M1 ; (P2 < P1, Mchoice = M2)).
 

 % Définition des synonymes pour les mots-clés
synonymes(chance, [opportunite]).
synonymes(but, [objectif]).
synonymes(commence, [debute, demarre]).
synonymes(chute, [crash, carambolage]).
synonymes(depasser, [devancer, distancer]).
synonymes(deplacer, [bouger, mouvoir]).
synonymes(equipe, [team]).
synonymes(help, [aide]).
synonymes(score, [classement]).
synonymes(plateau, [map]).

% Modification du prédicat mFind/3 pour rechercher des synonymes
mFind(M, L, Variant) :-
   mclef(M,_),
   (member(Variant,L), verif_distance(Variant, M)) ;  % Vérification du mot lui-même
   (synonymes(M, Synonymes), member(Synonym, Synonymes), member(Variant, L), verif_distance(Variant, Synonym)).  % Vérification des synonymes


/*
mFind(M, L, Variant) :-
   mclef(M,_),
   member(Variant,L), 
   verif_distance(Variant, M).*/

pFind([P], Lmots, Variant) :-
   member(Variant,Lmots),
   verif_distance(P,Variant).
   

/* --------------------------------------------------------------------- */
/*                                                                       */
/*                  REMPLACE VARIANT PAR M                               */
/*                                                                       */
/* --------------------------------------------------------------------- */
replace([], _, [], []).
replace([Word|T], Old, [New], [New|T2]) :-
   Word == Old,
   replace(T, Old, New, T2).
replace([Word|T], Old, [New], [Word|T2]) :-
   Word \== Old,
   replace(T, Old, New, T2).


replace([], _, _, []).
replace([Word|T], Old, New, [New|T2]) :-
    Word == Old,
    replace(T, Old, New, T2).
replace([Word|T], Old, New, [Word|T2]) :-
    Word \== Old,
    replace(T, Old, New, T2).

/* --------------------------------------------------------------------- */
/*                                                                       */
/*                  COMPTE ET TRANSFORME EN %                            */
/*                                                                       */
/* --------------------------------------------------------------------- */

count_chars(Word, Count) :-
   atom_chars(Word, Chars),
   length(Chars, Count).

distance_degree(Word1,Word2,Degree) :-
   count_chars(Word1,Count),
   count_chars(Word2,Count2),
   lDistance(Word1,Word2,Dist),
   Degree is (1-(Dist/max(Count,Count2)))*100.


/* --------------------------------------------------------------------- */
/*                                                                       */
/*                            TEST DE FIN                                */
/*                                                                       */
/* --------------------------------------------------------------------- */

fin(L) :- member(fin,L).


/* --------------------------------------------------------------------- */
/*                                                                       */
/*                         BOUCLE PRINCIPALE                             */
/*                                                                       */
/* --------------------------------------------------------------------- */

tourdefrance :- 

   nl, nl, nl,
   write('Bonjour, je suis TBot, le bot explicateur du Tour de France.'), nl,
   write('En quoi puis-je vous aider ?'), 
   nl, nl, 

   repeat,
      write('Vous : '), ttyflush,
      lire_question(L_Mots),
      produire_reponse(L_Mots,L_ligne_reponse),
      ecrire_reponse(L_ligne_reponse),
   fin(L_Mots), !.
   

/* --------------------------------------------------------------------- */
/*                                                                       */
/*             ACTIVATION DU PROGRAMME APRES COMPILATION                 */
/*                                                                       */
/* --------------------------------------------------------------------- */


