% 7.1 eval(E, V)
eval(C, C) :- integer(C).
eval(X+Y, R) :-
    eval(X, XR),
    eval(Y, YR),
    R is XR + YR.
eval(X-Y, R) :-
    eval(X, XR),
    eval(Y, YR),
    R is XR - YR.
eval(X*Y, R) :-
    eval(X, XR),
    eval(Y, YR),
    R is XR * YR.
eval(X/Y, R) :-
    eval(X, XR),
    eval(Y, YR),
    R is XR / YR.
eval(X^Y, R) :-
    eval(X, XR),
    eval(Y, YR),
    R is XR ^ YR.
eval(-X, R) :-
    eval(X, XR),
    R is -XR.

% 7.2 simplify(E, S)
simplify(C, C) :- integer(C), !.
simplify(X, X) :- atom(X), !.

simplify(X+Y, R) :-
    simplify(X, XR),
    simplify(Y, YR),
    simplify_plus(XR, YR, R).

simplify(X-Y, R) :-
    simplify(X, XR),
    simplify(Y, YR),
    simplify_minus(XR, YR, R).

simplify(X*Y, R) :-
    simplify(X, XR),
    simplify(Y, YR),
    simplify_times(XR, YR, R).

simplify(X/Y, R) :-
    simplify(X, XR),
    simplify(Y, YR),
    simplify_div(XR, YR, R).

simplify(X^Y, R) :-
    simplify(X, XR),
    simplify(Y, YR),
    simplify_pow(XR, YR, R).

simplify(-(-X), R) :- !,
    simplify(X, R).

simplify(-X, R) :-
    simplify(X, XR),
    (   integer(XR)
    ->  R is -XR
    ;   R = -XR
    ).

% +
simplify_plus(0, Y, Y) :- !.
simplify_plus(X, 0, X) :- !.
simplify_plus(X, -Y, R) :- !,
    simplify_minus(X, Y, R).

simplify_plus(X, Y, R) :-
    integer(X), integer(Y), !,
    R is X + Y.
simplify_plus(X, Y, X+Y).

% -
simplify_minus(X, 0, X) :- !.
simplify_minus(X, X, 0) :- !.
simplify_minus(X, -Y, R) :- !,
    simplify_plus(X, Y, R).
simplify_minus(0, X, -X) :- !.

% X - (-N/Den) ->  X + (N/Den)
simplify_minus(X, N/Den, R) :-
    integer(N), N < 0, !,
    N1 is -N,
    simplify_plus(X, N1/Den, R).

simplify_minus(X, Y, R) :-
    integer(X), integer(Y), !,
    R is X - Y.
simplify_minus(X, Y, X-Y).

% *
simplify_times(0, _, 0) :- !.
simplify_times(_, 0, 0) :- !.
simplify_times(1, Y, Y) :- !.
simplify_times(X, 1, X) :- !.

simplify_times(X, Y, R) :-
    integer(X), integer(Y), !,
    R is X * Y.

% N1*(N2*E) -> (N1*N2)*E
simplify_times(N1, N2*E, R) :-
    integer(N1), integer(N2), !,
    N is N1 * N2,
    simplify_times(N, E, R).

% (N2*E)*N1
simplify_times(N2*E, N1, R) :-
    integer(N1), integer(N2), !,
    N is N1 * N2,
    simplify_times(N, E, R).

simplify_times(X, Y, X*Y).

% /
simplify_div(0, _, 0) :- !.
simplify_div(X, 1, X) :- !.
simplify_div(X, X, 1) :- !.

simplify_div(X*Y, X, Y) :- !.
simplify_div(Y*X, X, Y) :- !.

% N*X / X^P  ->  N / X^(P-1),  P > 0
simplify_div(N*X, X^P, R) :-
    integer(N), integer(P),
    P > 0, !,
    E is P - 1,
    ( E =:= 0
    -> R = N
    ;  R = N / X^E
    ).

% N*X^K / X^P
simplify_div(N*X^K, X^P, R) :-
    integer(N), integer(K), integer(P),
    K > 0, P >= K, !,
    E is P - K,
    ( E =:= 0 
    -> R = N 
    ; R = N / X^E 
    ).

simplify_div(-X, -Y, R) :- !,
    simplify_div(X, Y, R).

simplify_div(-X, Y, R) :- !,
    simplify_div(X, Y, R1),
    simplify(-R1, R).

simplify_div(X, -Y, R) :- !,
    simplify_div(X, Y, R1),
    simplify(-R1, R).

simplify_div(X, Y, R) :-
    integer(X), integer(Y), !,
    R is X / Y.

simplify_div(X, Y, X/Y).

% ^
simplify_pow(_, 0, 1) :- !.
simplify_pow(X, 1, X) :- !.

% (Base^P)^N  ->  Base^(P*N)
simplify_pow(Base^P, N, Base^E) :-
    integer(P), integer(N), !,
    E is P * N.

simplify_pow(X, Y, R) :-
    integer(X), integer(Y), !,
    R is X ^ Y.

simplify_pow(X, Y, X^Y).

% 7.3  deriv(E,D)
deriv(E, D) :-
    deriv_raw(E, D0),
	simplify(D0, D).

deriv_raw(x, 1) :- !.
deriv_raw(C, 0) :- integer(C), !.
deriv_raw(-U, -DU) :- deriv_raw(U, DU), !.

% d/dx (U+V) = dU + dV
deriv_raw(U+V, DU+DV) :-
    deriv_raw(U, DU),
    deriv_raw(V, DV), !.

% d/dx (U-V) = dU - dV
deriv_raw(U-V, DU-DV) :-
    deriv_raw(U, DU),
    deriv_raw(V, DV), !.

% d/dx (U*V) = U*dV + V*dU
deriv_raw(U*V, U*DV + V*DU) :-
    deriv_raw(U, DU),
    deriv_raw(V, DV), !.

% d/dx (U/V) = (V*dU - U*dV) / V^2
deriv_raw(U/V, (V*DU - U*DV) / V^2) :-
    deriv_raw(U, DU),
    deriv_raw(V, DV), !.

% d/dx (U^N) = N*U^(N-1)*dU
deriv_raw(U^N, N*U^(N1)*DU) :-
    integer(N),
    N1 is N - 1,
    deriv_raw(U, DU), !.

% 7.4  party_seating(L)
guest(P) :- male(P).
guest(P) :- female(P).

party_seating(L) :-
    findall(P, guest(P), Guests),
    length(Guests, 10),
    perm(Guests, L),
    valid_seating(L),
    !.

% permutation using select/3
perm([], []).
perm(List, [H|T]) :-
    select(H, List, Rest),
    perm(Rest, T).

select(X, [X|Xs], Xs).
select(X, [Y|Ys], [Y|Zs]) :-
    select(X, Ys, Zs).

% check all adjacent pairs (circular table)
valid_seating([First|Rest]) :-
    check_adjacent([First|Rest], First).

% end of list: check last with First for circular adjacency
check_adjacent([Last], First) :-
    ok_pair(Last, First).
check_adjacent([A,B|Rest], First) :-
    ok_pair(A, B),
    check_adjacent([B|Rest], First).

% constraints between two adjacent people A,B
ok_pair(A, B) :-
    speaks(A, L),
    speaks(B, L),
    \+ (female(A), female(B)).
