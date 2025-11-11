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


