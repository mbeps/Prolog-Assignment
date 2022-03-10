% Question A
/**
 * recursive helper function to solve a problem of finding a path through a directed graph, where each edge in the graph is labeled with a number. 
 * The function dfs_helper(Path, [], Solution) simply checks whether the current path is already in the Solution list, and if not, it calls itself recursively with the next edge in the Path list.
*/
dfs(Path, Solution) :-
    dfs_helper(Path, [], Solution). % Call dfs_helper with an empty path and an empty solution

/**
 * Function that helps to find a path to a goal. 
 * The first argument is the path to the goal, the second is a list of predicates that must be true along the way, and the third is the path to the goal.
*/
dfs_helper(Path, _, Path) :-
    goal(Path). % If the path is the goal, return the path 

/**
 * Iterates through a path, checking if each node is in the path or not. 
 * If the node is not in the path, then it is added to the path and the dfs_helper function is called. 
 * The dfs_helper function recursively calls itself on the new path, adding any nodes that are not in the path to the path. 
 * The Solution variable is populated with the path to the solution.
*/
dfs_helper(Path, Visited, Solution) :-
    member(Node, Path), % Check if the node is in the path
    \+ member(Node, Visited), % Check if the node is not in the visited list
    append(Path, [Node], NewPath), % Add the node to the path
    dfs_helper(NewPath, [Node|Visited], Solution). % Call dfs_helper with the new path and the new visited list

