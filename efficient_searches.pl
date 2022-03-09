% Implement dfs/2 (depth-first search) – this strategy takes a single path as input and then expands that path with a new node until the goal is found, in which case the solution is returned in the second argument. Query your program with: ?- dfs([a], X).

dfs(Path, Solution) :-
    dfs_helper(Path, [], Solution).

dfs_helper(Path, _, Path) :-
    goal(Path).

dfs_helper(Path, Visited, Solution) :-
    member(Node, Path),
    \+ member(Node, Visited),
    append(Path, [Node], NewPath),
    dfs_helper(NewPath, [Node|Visited], Solution).

% Depth-first search is not complete for infinite spaces, so the depth-limited search has been proposed to deal with this problem. Implement dldfs/3 (depth-limited depth-first search) – this strategy takes a single path as input in its first argument and then expands it with a new node until the goal is found, provided the length of the path does not exceed a depth limit D (> 0) specified in the second argument. When a solution is found within the limit, it should be output in the predicate’s third argument. Test your program with a range of queries of the form: ?- dldfs([a], D, X).