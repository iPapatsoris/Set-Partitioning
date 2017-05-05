% Expanded with 'other' variables to also modify a second list according to sort
quicksort([], [], [], []).
quicksort([X|Tail], Sorted, [OtherX|OtherTail], OtherSorted) :-
    split(X, Tail, Small, Big, OtherTail, OtherSmall, OtherBig),
    quicksort(Small, SortedSmall, OtherSmall, OtherSortedSmall),
    quicksort(Big, SortedBig, OtherBig, OtherSortedBig),
    append(SortedSmall, [X|SortedBig], Sorted),
    append(OtherSortedSmall, [OtherX|OtherSortedBig], OtherSorted).

split(_, [], [], [], [], [], []).
split(X, [Y|Tail], [Y|Small], Big, [OtherY|OtherTail], [OtherY|OtherSmall], OtherBig) :-
    X > Y,
    !,
    split(X, Tail, Small, Big, OtherTail, OtherSmall, OtherBig).
split(X, [Y|Tail], Small, [Y|Big], [OtherY|OtherTail], OtherSmall, [OtherY|OtherBig]) :-
    split(X, Tail, Small, Big, OtherTail, OtherSmall, OtherBig).
