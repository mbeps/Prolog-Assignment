% Case 1: a goal node is found.
search(Paths, Solution):-
	choose([Node|Nodes], Paths, _),
	goal(Node),
	reverse([Node|Nodes], Solution).

% Case 2: carry on searching.
search(Paths, Solution):-
	choose(Path, Paths, RestOfPaths),
	findall([NewNode|Path], expands(Path, NewNode), Expansions),
	combine(Expansions, RestOfPaths, NewPaths),
	search(NewPaths, Solution).

/*
 expands(+Path, ?NewNode).
 -- Path: is a list of nodes of the form Path=[Node|Nodes], where
    Node is the node we want to expand and Nodes is a list
    of remaining nodes already expanded and containing the root.
 -- NewNode: is a constant representing the node we want to go to,
    as there is an link to it from where we are currently.
*/
expands([Node|_], NewNode):-
	arc(Node, NewNode).

/**
 * Finds all possible paths from A to E, using the `choose/3` predicate.
 * If A = C, then B = D, and E is returned.
 * Otherwise, the path consisting of the remaining options is returned.
*/
choose([A|B],[[C|D]|E], RestOfPaths):-
	A=C, 
	B=D, 
	RestOfPaths = E.

/**
 * Combines 2 list into one list, `Expansion` and `RestOfPaths` are combined into `NewPaths`.
*/
combine(Expansions, RestOfPaths, NewPaths):-
	append(Expansions, RestOfPaths, NewPaths).

/* Representation of a tree */
/* choose initial state a   */
arc(a, b).
arc(a, f).
arc(b, c).
arc(b, d).
arc(b, e).
arc(f, g).
arc(f, i).
arc(i, j).
arc(i, k).

/* the goal */
goal(i).