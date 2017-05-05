optSubsumedSets([], [], [], []).
optSubsumedSets([P|Pairings], [C|Costs], PrunedPairings, PrunedCosts) :-
    checkForSubsumption(P, C, Pairings, Costs),
    !,
    optSubsumedSets(Pairings, Costs, PrunedPairings, PrunedCosts).
optSubsumedSets([P|Pairings], [C|Costs], [P|PrunedPairings], [C|PrunedCosts]) :-
    optSubsumedSets(Pairings, Costs, PrunedPairings, PrunedCosts).

checkForSubsumption(Set, Cost, [P|_], [C|_]) :-
    Cost >= C,
    identical(Set, P),
    !.
checkForSubsumption(Set, Cost, [P|Pairings], [C|Costs]) :-
    Cost >= C,
    subset(P, Set),
    subtract(Set, P, Subset),
    !,
    checkForSubsumption(Subset, Cost-C, Pairings, Costs).
checkForSubsumption(Set, Cost, [_|Pairings], [_|Costs]) :-
    checkForSubsumption(Set, Cost, Pairings, Costs).
