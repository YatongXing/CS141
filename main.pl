% 1) my_length
my_length([], 0).
my_length([_|T], R) :-
  my_length(T, R1),
  R is R1 + 1.

% 2) my_member
my_member(X, [X|_]).
my_member(X, [_|T]) :- my_member(X, T).

% 3) my_append
my_append([], L2, L2).
my_append([H|T], L2, [H|R]) :- my_append(T, L2, R).

% 4) my_reverse
my_reverse(L, R) :- my_rev_acc(L, [], R).
my_rev_acc([], Acc, Acc).
my_rev_acc([H|T], Acc, R) :- my_rev_acc(T, [H|Acc], R).

% 5) my_nth
my_nth([], _, []).
my_nth(L, 1, L).
my_nth([_|T], N, R) :- 
  N1 is N - 1,
  my_nth(T, N1, R).

% 6) my_remove
my_remove(_, [], []).
my_remove(X, [H|T], R) :-
  ( H == X
  -> my_remove(X, T, R)
  ; R = [H|R1], my_remove(X, T, R1)
  ).

% 7) my_subst
my_subst(_, _, [], []).
my_subst(X, Y, [H|T], R) :-
  ( X == H
  -> R = [Y|R1], my_subst(X, Y, T, R1)
  ; R = [H|R1], my_subst(X, Y, T, R1)
  ).

/* 
my_subst(_, _, [], []).
my_subst(X, Y, [H|T], [Y|R]) :-
    H == X, !, 
    my_subst(X, Y, T, R).
my_subst(X, Y, [H|T], [H|R]) :-
    my_subst(X, Y, T, R).
*/

% 8) my_subset
my_subset(_, [], []).
my_subset(P, [H|T], [H|R]) :-
  call(P, H), !,
  my_subset(P, T, R).
my_subset(P, [_|T], R) :-
  my_subset(P, T, R).

& 9) my_add
my_add(N1, N2, R) :- 
  add_digits(N1, N2, 0, R1), 
  fix_zero(R1, R).

add_digits([], [], 0, []).
add_digits([], [], C, [C]) :- C > 0.
add_digits([A|TA], [], C, [D|TR]) :-
  S is A + C,
  D is S mod 10,
  C1 is S // 10,
  add_digits(TA, [], C1, TR).
add_digits([], [B|TB], C, [D|TR]) :-
  S is B + C,
  D is S mod 10,
  C1 is S // 10,
  add_digits([], TB, C1, TR).
add_digits([A|TA], [B|TB], C, [D|TR]) :-
  S is A + B + C,
  D is S mod 10,
  C1 is S // 10,
  add_digits(TA, TB, C1, TR).

fix_zero([], [0]).
fix_zero(L, L).

% 10) my_merge
my_merge([], L2, L2).
my_merge(L1, [], L1).
my_merge([H1|T1], [H2|T2], [H1|R]) :-
  H1 =< H2, !,
  my_merge(T1, [H2|T2], R).
my_merge([H1|T1], [H2|T2], [H2|R]) :-
  my_merge([H1|T1], T2, R).

% 11) my_sublist
my_sublist([], _) :- !.
my_sublist(Sub, L) :-
  starts_with(Sub, L), !.
my_sublist(Sub, [_|T]) :-
  my_sublist(Sub, T).

starts_with([], _).
starts_with([H|TP], [H|TL]) :- starts_with(TP, TL).

% 12) my_assoc
my_assoc(_, [], _) :- fail.
my_assoc(A, [A, H|_], H) :- !.
my_assoc(A, [_B, _C|T], R) :- my_assoc(A, T, R).

% 13) my_replace
my_replace(_, [], []).
my_replace(L, [H|T], [R1|R]) :-
  my_assoc(H, L, R1), !,
  my_replace(L, T, R).
my_replace(L, [H|T], [H|R]) :-
  my_replace(L, T, R).

  
