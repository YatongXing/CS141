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
simplify_plus(0, Y, Y) :- !.
simplify_plus(X, 0, X) :- !.
simplify_plus(X, Y, R) :-
    integer(X), integer(Y), !,
    R is X + Y.
simplify_plus(X, Y, X+Y).

simplify(X-Y, R) :-
    simplify(X, XR),
    simplify(Y, YR),
    simplify_minus(XR, YR, R).
simplify_minus(X, 0, X) :- !.
simplify_minus(X, X, 0) :- !.
simplify_minus(X, Y, R) :-
    integer(X), integer(Y), !,
    R is X - Y.
simplify_minus(X, Y, X-Y).

simplify(X*Y, R) :-
    simplify(X, XR),
    simplify(Y, YR),
    simplify_times(XR, YR, R).
simplify_times(0, _, 0) :- !.
simplify_times(_, 0, 0) :- !.
simplify_times(1, Y, Y) :- !.
simplify_times(X, 1, X) :- !.
simplify_times(X, Y, R) :-
    integer(X), integer(Y), !,
    R is X * Y.
simplify_times(X, Y, X*Y).

simplify(X/Y, R) :-
    simplify(X, XR),
    simplify(Y, YR),
    simplify_div(XR, YR, R).
simplify_div(0, _, 0) :- !.
simplify_div(X, 1, X) :- !.
simplify_div(X, X, 1) :- !.
simplify_div(X, Y, R) :-
    integer(X), integer(Y), !,
    R is X / Y.
simplify_div(X, Y, X/Y).

simplify(X^Y, R) :-
    simplify(X, XR),
    simplify(Y, YR),
    simplify_pow(XR, YR, R).
simplify_pow(_, 0, 1) :- !.
simplify_pow(X, 1, X) :- !.
simplify_pow(X, X, 1) :- !.
simplify_pow(X, Y, R) :-
    integer(X), integer(Y), !,
    R is X ^ Y.
simplify_pow(X, Y, X^Y).

simplify(-X, R) :-
    simplify(X, XR),
    (   integer(XR) ->   X is -XR
    ;   R = -XR
    ).

%

% 7.2 simplify(E, S)

