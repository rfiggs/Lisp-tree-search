;This file implements the breadth first and depth first search algorithms


;(defun test ()
;    (cond
;        ( (not (and (boundp '*open*) (boundp '*closed*)))
;            (list (defvar *open* nil) (defvar *closed* nil))
;        )
;        (T
;            nil
;        )
;    )
;)

;Function: make-globals
;Description: creates the global *open* and *closed* lists
;these lists contain nodes in the following format
;((state)(parent-state))
;Parameters:
;start, the state to start the search from
(defun make-globals (start)
    (and
        (or (boundp '*open*) (defvar *open* (list start)))
        (or (boundp '*closed*) (defvar *closed* nil))
    )
)

;Function: breadth-first-search
;Description: uses the global *open* and *closed* lists
;to find a path to the goal from the start
;Parameters:
;goal, the target that state we are trying to achieve
;iteration, the current number of nodes looked at
;moves, a function that takes a stat as a parameter returns the child states
(defun breadth-first-search (goal iteration moves)
    (cond
        ((equal 0 (length *open*))
            nil
        )
        ((equal goal (car (car *open*)))
            (car *open*)
        )
        (T
            (cond
                (()

                )
                (T

                )
            )
        )
    )
)

;Function: breadth-first
;Description: sets up the open and closed lists then calls
;the recursive function breadth-first-search to find a path to the goal state
;Parameters:
;start, a list containing the start state
;goal, a list containing the goal state
;moves, a function that takes a state and returns its valid children.
;Returns:
;the path from the start state to goal if it exists, otherwise nil
(defun breadth-first (start goal moves)
    (cond
        ;if the global variables are correctly made then call
        ;breath-first-search which is the recursive function that finds the path
        ((make-globals start)
            (breadth-first-search goal 0 moves)
        )
        ;something went wrong creating the variables
        (T
            nil
        )
    )
)
