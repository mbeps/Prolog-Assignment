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

% Question B
/**
 * The function first calls itself with a path that is one step shorter than the current path, and a new empty list. 
 * If the function is able to find a solution in the new list, it returns the solution. If not, the function recursively calls itself with the updated path and list.
*/
dldfs(Path, D, Solution) :-
    dldfs_helper(Path, D, [], Solution). % Call dldfs_helper with an empty path, depth, and an empty solution

/**
 * Helper function used to find the goal state for a given path. 
 * The function takes a path and a number of steps as input, and then returns the goal state for that path.
*/
dldfs_helper(Path, 0, _, Path) :-
    goal(Path). 

/**
 * It takes a path, a distance, and a list of visited nodes, and finds a solution for the distance remaining. 
 * If the distance remaining is 0, the function returns the solution. 
 * If the distance remaining is not 0, the function recurses, taking a new path and a new distance.
*/
dldfs_helper(Path, D, Visited, Solution) :-
    D > 0, % Check if the distance is greater than 0
    member(Node, Path), % Check if the node is in the path
    \+ member(Node, Visited), % Check if the node is not in the visited list
    append(Path, [Node], NewPath), % Add the node to the path
    NewD is D - 1, % Decrement the distance
    dldfs_helper(NewPath, NewD, [Node|Visited], Solution). % Call dldfs_helper with the new path and the new distance

% Question C
/**
 * The code above finds a path from a given starting point to a given destination, and records the path in a history list. 
 * If the destination is reached, the code also prints a solution.
*/
idsh(Path, D, History, Solution) :-
    dldfs(Path, D, Solution), % Call dldfs with the path and the depth
    \+ member(Solution, History). % Check if the solution is not in the history list

/**
 * Finds a solution to the shortest path problem, given a path and a distance to the goal. 
 * If the distance to the goal is less than the maximum distance, the function finds a new solution by adding one step to the path and recursively calling the function. 
 * If the distance to the goal is greater than the maximum distance, the function returns the last solution in the history list.
*/
idsh(Path, D, History, Solution) :-
    D < Max, % Check if the distance is less than the maximum distance
    D1 is D + 1, % Increment the distance
    idsh(Path, D1, [Solution|History], Solution). % Call idsh with the path, the new distance, and the solution and the history list