% Case 1: a goal node is found.
/**
 * Chooses a node in the `Path` list. 
 * Then, it checks whether the node is a goal node. 
 * If it is, the list of nodes is reversed so that the goal node is at the beginning.
*/
search(Paths, Solution):-
	choose([Node|Nodes], Paths, _), % Choose a node in the list of paths.
	goal(Node), % Check whether the node is a goal node.
	reverse([Node|Nodes], Solution). % Reverse the list of nodes so that the goal node is at the beginning.

% Case 2: carry on searching.
/**
 * Chooses a node in the `Path` list. 
 * It then uses `findall` to find all the nodes in the path that can be expanded. 
 * It combines the expansions into a new path and then searches for the new path in the `Solution` list.
*/
search(Paths, Solution):-
	choose(Path, Paths, RestOfPaths), % Choose a node in the list of paths.
	findall([NewNode|Path], expands(Path, NewNode), Expansions), % Find all the nodes in the path that can be expanded.
	combine(Expansions, RestOfPaths, NewPaths), % Combine the expansions into a new list of paths.
	search(NewPaths, Solution). % Search for the new list of paths.

/*
 expands(+Path, ?NewNode).
 -- Path: is a list of nodes of the form Path=[Node|Nodes], where
    Node is the node we want to expand and Nodes is a list
    of remaining nodes already expanded and containing the root.
 -- NewNode: is a constant representing the node we want to go to,
    as there is an link to it from where we are currently.
*/
expands([Node|_], NewNode):-
	arc(Node, NewNode). % Check whether there is an arc from the current node to the new node.

/**
 * Finds all possible paths from A to E, using the `choose/3` predicate.
 * If A = C, then B = D, and E is returned.
 * Otherwise, the path consisting of the remaining options is returned.
*/
choose([A|B],[[C|D]|E], RestOfPaths):-
	A=C, % If A = C, then B = D, and E is returned.
	B=D, 
	RestOfPaths = E.

/*
 * Combines 2 list into one list, `RestOfPaths` and `NewPaths` are combined into `Expansions`.
 * This creates a Depth-First Search.
*/
combine(Expansions, RestOfPaths, NewPaths):-
	append(RestOfPaths, NewPaths, Expansions). % Combine the lists.

% DATA
arc(a, b).
arc(a, f).
arc(b, c).
arc(b, d).
arc(b, e).
arc(f, g).
arc(f, i).
arc(i, j).
arc(i, k).

% GOAL
goal(i).