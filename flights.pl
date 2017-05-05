:- lib(ic).
:- lib(branch_and_bound).
:- compile(flight_data).
:- compile(preprocess).

flights(I, Pairings, Cost) :-
	get_flight_data(I, N, Pp, Cc),
	preprocess(Pp, Cc, P, C).
/*	defineVars(C, TotalPairings, Solution),
	constrain(1, P, Solution, N),
	defineCosts(Solution, C, CostList),
	Cost #= sum(CostList),
	bb_min(search(Solution, 0, first_fail, indomain, complete, []), Cost, _),
	map(Solution, P, C, Pairings).*/

defineVars(C, TotalPairings, Solution) :-
	length(C, TotalPairings),
	length(Solution, TotalPairings),
	Solution #:: [0,1].

constrain(Flight, _, _, TotalFlights) :-
	Flight is TotalFlights+1.
constrain(Flight, Pairings, Vars, TotalFlights) :-
	Flight =< TotalFlights,
	associateFlightWithPairings(Flight, Pairings, Vars, RelevantPairings),
	sum(RelevantPairings) #= 1,
	NextFlight is Flight+1,
	constrain(NextFlight, Pairings, Vars, TotalFlights).

% Get list of pairings current flight belongs to
associateFlightWithPairings(_, [], [], []).
associateFlightWithPairings(Flight, [P|Pairings], [X|Vars], [X|RestRelevant]) :-
	member(Flight, P),
	!,
	associateFlightWithPairings(Flight, Pairings, Vars, RestRelevant).
associateFlightWithPairings(Flight, [P|Pairings], [X|Vars], RestRelevant) :-
	associateFlightWithPairings(Flight, Pairings, Vars, RestRelevant).

defineCosts([], [], []).
defineCosts([X|Vars], [Cost|Costs], [Cost*X|Cs]) :-
	defineCosts(Vars, Costs, Cs).

map([], [], [], []).
map([X|Vars], [P|Pairings], [C|Costs], [P / C|Rest]) :-
	X =:= 1,
	map(Vars, Pairings, Costs, Rest).
map([X|Vars], [_|Pairings], [_|Costs], P) :-
	X =:= 0,
	map(Vars, Pairings, Costs, P).
