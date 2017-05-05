optMultipleSets([], [], [], []).
optMultipleSets([P|Pairings], [C|Costs], [P|NewPairings], [MinC|NewCosts]) :-
	minCost(P, C, Pairings, Costs, MinC),
	deleteDuplicates(P, Pairings, Costs, TrimmedPairings, TrimmedCosts),
	optMultipleSets(TrimmedPairings, TrimmedCosts, NewPairings, NewCosts).

% Get min cost among a pairing's duplicates
minCost(_, MinC, [], [], MinC).
minCost(P, C, [CurP|Pairings], [CurC|Costs], MinC) :-
	identical(P, CurP),
	!,
	min(CurC, C, NewC),
	minCost(P, NewC, Pairings, Costs, MinC).
minCost(P, C, [_|Pairings], [_|Costs], MinC) :-
	minCost(P, C, Pairings, Costs, MinC).

identical([], []).
identical([X|L1], [X|L2]) :-
	identical(L1, L2).

% Delete duplicates of P
deleteDuplicates(_, [], [], [], []).
deleteDuplicates(P, [P|Pairings], [_|Costs], TrimmedPairings, TrimmedCosts) :-
	!,
	deleteDuplicates(P, Pairings, Costs, TrimmedPairings, TrimmedCosts).
deleteDuplicates(P, [CurP|Pairings], [CurC|Costs], [CurP|TrimmedPairings], [CurC|TrimmedCosts]) :-
	deleteDuplicates(P, Pairings, Costs, TrimmedPairings, TrimmedCosts).
