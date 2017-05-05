% For identical pairings, keep the one with the lowest cost and discard the others.
% We could also discard pairings that can be constructed from smaller ones with a lower total cost,
% but this is not implemented.
preprocess([], [], [], []).
preprocess([P|Pairings], [C|Costs], [P|NewPairings], [MinC|NewCosts]) :-
	minCost(P, C, Pairings, Costs, MinC),
	deleteDuplicates(P, Pairings, Costs, TrimmedPairings, TrimmedCosts),
	preprocess(TrimmedPairings, TrimmedCosts, NewPairings, NewCosts).

% Get min cost among a pairing's duplicates
minCost(P, MinC, [], [], MinC).
minCost(P, C, [CurP|Pairings], [CurC|Costs], MinC) :-
	identical(P, CurP),
	!,
	min(CurC, C, MinC),
	minCost(P, MinC, Pairings, Costs, MinC).
minCost(P, C, [CurP|Pairings], [CurC|Costs], MinC) :-
	minCost(P, C, Pairings, Costs, MinC).

identical([], []).
identical([X|L1], [X|L2]) :-
	identical(L1, L2).

min(A, B, A) :-
	A < B.
min(A, B, B).

% Delete duplicates of P
deleteDuplicates(_, [], [], [], []).
deleteDuplicates(P, [P|Pairings], [CurC|Costs], TrimmedPairings, TrimmedCosts) :-
	!,
	deleteDuplicates(P, Pairings, Costs, TrimmedPairings, TrimmedCosts).
deleteDuplicates(P, [CurP|Pairings], [CurC|Costs], [CurP|TrimmedPairings], [CurC|TrimmedCosts]) :-
	deleteDuplicates(P, Pairings, Costs, TrimmedPairings, TrimmedCosts).
