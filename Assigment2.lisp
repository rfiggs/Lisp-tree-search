;This file implements the breadth first and depth first search algorithms

(defun testfun (x) (+  x 1))

;Function: make-globals
;Description: creates the global *open* and *closed* lists
;these lists contain nodes in the following format
;((state)(parent-state))
;Parameters:
;start, the state to start the search from
(defun make-globals (start)
    (and
        (defparameter *open* (list (list start 'root)))
        (defparameter *closed* (list nil))
    )
)

;this function returns the state of top node in the open list
(defun current-state () (car (car *open*)))


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
        ((member (current-state) (mapcar #'car *closed*))
            (and
                (setf *open* (cdr *open*))
                (breadth-first-search goal (+ 1 iteration) moves)
            )
        )
        ((equal goal (current-state))
            (car *open*)
        )
        (T
            (and
                (setf *closed* (cons (car *open*) *closed*))
                (setf *open* (append
                    (cdr *open*)
                    (mapcar
                        (lambda (x) (list (list x) (list (current-state))))
                        (mapcar moves (list (current-state)))
                    )
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
            (breadth-first-search goal 0 moves)
        )
        ;something went wrong creating the variables
        (T
            (and (write 'somethingwrong))
        )
    )
)
