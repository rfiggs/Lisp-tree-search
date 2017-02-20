;This file implements the breadth first and depth first search algorithms

(defun testfun (x)
    (list
        (cond
            ((> 100 (+ x 1)) (+ x 1))
        )
        (cond
            ((< 0 (- x 1)) (- x 1))
        )
        3
    )
)

;Function: make-globals
;Description: creates the global *open* and *closed* lists
;these lists contain nodes in the following format
;((state)(parent-state))
;Parameters:
;start, the state to start the search from
(defun make-globals (start)
    (and
        (defparameter *open* (list (list start nil)))
        (defparameter *closed* nil)
    )
)

;Function: top-state
;Description: retrieves the state of the top node on the given list
;Parameters:
;node-list: the list of nodes from which to get the top state
;Return: state of the top node on the list
(defun top-state (node-list)
    (car (car node-list))
)

;Function: make-children
;Description: this function returns a list of nodes where each nodes state
;is generated by the given function and the parent state is the given state.
;this function will also remove any states that are already in the *open* or *closed* lists
;Parameters:
;parent-state: this is the state that is passed to the generator function
;it is also used as the parent state for the nodes
;moves: a function that takes a single state as a parameter
;and returns a list of child states
;Return: a list of child nodes for the given state
(defun make-children (parent-state moves)
    (mapcar
        (lambda (x) (list x parent-state))
        (remove nil (remove-if (lambda (x) (or (member x (mapcar #'car *open*)) (member x (mapcar #'car *closed*))))
            (eval (list moves parent-state))
        ))

    )
)

;Function: print-node
;Description: prints out a node
;Parameters: the node to print
;Return: nil
(defun print-node (node)
    (format t "~&Evaluating Node: ~a" node)
)

;Function: solution-path
;Description: returns a list containing the path from root state to goal state
;uses the *closed* list
;Parameters:
;node, the goal node
;Return: a list of states from root to node
(defun solution-path (node)
    (cond
        ((equal node nil)
            nil
        )
        ((equal (second node) nil)
            (list (car node))
        )
        (t
            (append
                (solution-path (elt *closed* (position (second node) (mapcar #'car *closed*))))
                (list (car node))
            )
        )
    )
)

;Function: print-solution
;Description: prints the length of *open* and *closed* and the solution path
;Parameters:
;path, a list of states from start to goal
;Return: nil
(defun print-solution (path)
    (cond
        ((format t "~&Length of *open*: ~a" (length *open*)))
        ((format t "~&Length of *closed*: ~a" (length *closed*)))
        ((format t "~&Solution Path: ~a" path))
        (t
            path
        )
    )

)

;Function: breadth-first-search
;Description: uses the global *open* and *closed* lists
;to find a path to the goal from the start
;Parameters:
;goal, the target that state we are trying to achieve
;iteration, the current number of nodes looked at
;moves, a function that takes a state as a parameter and  returns the child states
(defun breadth-first-search (goal iteration moves)
    (cond
        ((> 0 (length *open*))
            nil
        )
        ((print-node (car *open*)))
        ((member (top-state *open*) (mapcar #'car *closed*))
            (and
                (setf *open* (cdr *open*))
                (breadth-first-search goal (+ 1 iteration) moves)
            )
        )
        ((equal goal (top-state *open*))
            (car *open*)
        )
        (T
            (and
                (setf *closed* (cons (car *open*) *closed*))
                (setf *open* (append
                    (cdr *open*)
                    (make-children (top-state *open*) moves)
                ))
                (breadth-first-search goal (+ 1 iteration) moves)
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
            (print-solution (solution-path (breadth-first-search goal 0 moves)))
        )
        ;something went wrong creating the variables
        (T
            nil
        )
    )
)

;Function: depth-first-search
;Description: uses the global *open* and *closed* lists
;to find a path to the goal from the start
;Parameters:
;goal, the target that state we are trying to achieve
;iteration, the current number of nodes looked at
;moves, a function that takes a state as a parameter and  returns the child states
(defun depth-first-search (goal iteration moves)
    (cond
        ((> 0 (length *open*))
            nil
        )
        ((print-node (car *open*)))
        ((member (top-state *open*) (mapcar #'car *closed*))
            (and
                (setf *open* (cdr *open*))
                (breadth-first-search goal (+ 1 iteration) moves)
            )
        )
        ((equal goal (top-state *open*))
            (car *open*)
        )
        (T
            (and
                (setf *closed* (cons (car *open*) *closed*))
                (setf *open* (append
                    (make-children (top-state *open*) moves)
                    (cdr *open*)
                ))
                (breadth-first-search goal (+ 1 iteration) moves)
            )
        )
    )
)


;Function: depth-first
;Description: sets up the open and closed lists then calls
;the recursive function depth-first-search to find a path to the goal state
;Parameters:
;start, a list containing the start state
;goal, a list containing the goal state
;moves, a function that takes a state and returns its valid children.
;Returns:
;the path from the start state to goal if it exists, otherwise nil
(defun depth-first (start goal moves)
    (cond
        ;if the global variables are correctly made then call
        ;depth-first-search which is the recursive function that finds the path
        ((make-globals start)
            (depth-first-search goal 0 moves)
        )
        ;something went wrong creating the variables
        (T
            nil
        )
    )
)

;This is the state representation for the farmer goat and cabbage puzzle.
