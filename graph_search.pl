/* 

CS2910 Assignment 1

    File: tree_search.pl

*/ 

/**
 * search(+Paths, -Solution).
 * -- Paths: is a list of lists containing the paths currently being searched.
 *    e.g. If Paths = [[c,b,a],[d,b,a]], the list represents two brances of the
 *    tree rooted at a and shown below:
 *           a
 *           |
 *           b
 *         /   \
 *        c     d
 *    i.e. the first element of the first list is the latest node being explored
 *    by the search for the path represented by that list.
 * -- Solution: is a path from the initial to goal state e.g. [a,b,d], 
 *    where a is the initial state and d is the goal state.
 *
 * To call the search we could use a query of the form:
 *
 * ? search([[a]], S).
 *
 * where [[a]] represents the root of the tree above (initial state of search).
*/


% Case 1: a goal node is found.
search(Paths, Solution):-
	choose([Node|Nodes], Paths, _),
	goal(Node),
	reverse([Node|Nodes], Solution, []).  % Reverse the path to get the correct order. List is checked for duplicates.

% Case 2: carry on searching.
search(Paths, Solution):-
	choose(Path, Paths, RestOfPaths),
	findall([NewNode|Path], expands(Path, NewNode), Expansions),
	combine(Expansions, RestOfPaths, NewPaths),
	search(NewPaths, Solution).

/**
 *  * expands(+Path, ?NewNode).
 * -- Path: is a list of nodes of the form Path=[Node|Nodes], where
 *    Node is the node we want to expand and Nodes is a list
 *    of remaining nodes already expanded and containing the root.
 * -- NewNode: is a constant representing the node we want to go to,
 *    as there is an link to it from where we are currently.
*/

expands([Node|_], NewNode):-
	arc(Node, NewNode).

/**
 *  * *Predicates to define in separate files for breadth_first and depth_first*
 *
 * choose(?Path, +Paths, ?RestPaths).
 * -- Path: is a list containing path for the search to consider.
 * -- Paths: is a list of lists (paths) that we need to select the Path from.
 * -- RestPaths: are the paths that remain from Paths once we select Path.
 *
*/

% NEED TO DEFINE THIS PREDICATE YOURSELVES FOR TASK 1 OF COURSEWORK.
% Breadth-First Search
choose([A|B],[[C|D]|E], RestOfPaths):-
	A=C, 
	B=D, 
	RestOfPaths = E.

% Depth-First Search
combine(Expansions, RestOfPaths, NewPaths):-
	append(RestOfPaths, NewPaths, Expansions).

/**
 *  * combine(+Expansions, +RestOfPaths, ?NewPaths).
 * -- Expansions: is a list of lists containing possible new paths to consider.
 * -- RestOfPaths: are the rest of the paths that need that remain unexplored.
 * -- NewPaths: are the Expansions and the RestOfPaths merged. NOTE: for
 *    breadth-first the NewPaths is FIFO, while for depth-first is a LIFO.
*/

% NEED TO DEFINE THIS PREDICATE YOURSELVES FOR TASK 1 OF COURSEWORK.
combine(Expansions, RestOfPaths, NewPaths):-
	append(Expansions, RestOfPaths, NewPaths).
