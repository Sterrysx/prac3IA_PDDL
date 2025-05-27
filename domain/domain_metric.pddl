;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  WEEKLY-MENU ― METRIC DOMAIN  (ext.4-5)
;;  – Adds numeric fluents & optimisation –                       
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (domain weekly-menu-metric)
  (:requirements :adl :typing :equality :fluents)

  ;;-------------------------------------------------------------------
  ;;  TYPES
  ;;-------------------------------------------------------------------
  (:types dia tipo plato primer - plato segundo - plato)

  ;;-------------------------------------------------------------------
  ;;  NUMERIC FLUENTS
  ;;-------------------------------------------------------------------
  (:functions
      (calories ?p - plato)          ; static per dish
      (price    ?p - plato)          ; static per dish
      (current-calories)             ; running total for the day
      (total-cost)                   ; optimisation target (ext-5)
  )

  ;;-------------------------------------------------------------------
  ;;  PREDICATES  (same semantics as basic domain)
  ;;-------------------------------------------------------------------
  (:predicates
      (dish-type        ?p - plato ?t - tipo)
      (incompatible     ?p - primer ?s - segundo)
      (next-day         ?d - dia    ?d2 - dia)

      (current-day      ?d - dia)
      (needs-first      ?d - dia)
      (needs-second     ?d - dia)

      (assigned-first   ?d - dia ?p - primer)
      (assigned-second  ?d - dia ?s - segundo)
      (used             ?pl - plato)

      (prev-first-type  ?t - tipo)
      (prev-second-type ?t - tipo)

      (require-first    ?d - dia ?p - primer)
      (require-second   ?d - dia ?s - segundo)

      (planning-done)
  )

  ;;-------------------------------------------------------------------
  ;;  ACTIONS  (identical control-flow, with numeric effects)
  ;;-------------------------------------------------------------------

  (:action choose-first-free
    :parameters (?p  - primer ?d - dia ?t - tipo ?tp - tipo)
    :precondition (and
        (current-day ?d) (needs-first ?d)
        (dish-type ?p ?t) (prev-first-type ?tp)
        (not (= ?t ?tp)) (not (used ?p))
        (forall (?r - primer) (not (require-first ?d ?r)))
    )
    :effect (and
        (increase (current-calories) (calories ?p))
        (increase (total-cost)       (price    ?p))
        (assigned-first ?d ?p)
        (not (needs-first ?d)) (needs-second ?d)
        (used ?p)
    )
  )

  (:action choose-first-required
    :parameters (?p - primer ?d - dia ?t - tipo ?tp - tipo)
    :precondition (and
        (current-day ?d) (needs-first ?d)
        (dish-type ?p ?t) (prev-first-type ?tp)
        (not (= ?t ?tp)) (not (used ?p))
        (require-first ?d ?p)
    )
    :effect (and
        (increase (current-calories) (calories ?p))
        (increase (total-cost)       (price    ?p))
        (assigned-first ?d ?p)
        (not (needs-first ?d)) (needs-second ?d)
        (used ?p)
    )
  )

  (:action choose-second-free
    :parameters (?s - segundo ?d - dia ?pf - primer)
    :precondition (and
        (current-day ?d) (needs-second ?d)
        (assigned-first ?d ?pf)
        (not (incompatible ?pf ?s))
        (not (used ?s))
        (forall (?r - segundo) (not (require-second ?d ?r)))
    )
    :effect (and
        (increase (current-calories) (calories ?s))
        (increase (total-cost)       (price    ?s))
        (assigned-second ?d ?s)
        (not (needs-second ?d))
        (used ?s)
    )
  )

  (:action choose-second-required
    :parameters (?s - segundo ?d - dia ?pf - primer)
    :precondition (and
        (current-day ?d) (needs-second ?d)
        (assigned-first ?d ?pf)
        (not (incompatible ?pf ?s))
        (not (used ?s))
        (require-second ?d ?s)
    )
    :effect (and
        (increase (current-calories) (calories ?s))
        (increase (total-cost)       (price    ?s))
        (assigned-second ?d ?s)
        (not (needs-second ?d))
        (used ?s)
    )
  )

  (:action finalize-day
    :parameters (?d  - dia  ?dn - dia
                 ?pf - primer ?ps - segundo
                 ?tf - tipo   ?ts - tipo)
    :precondition (and
        (current-day ?d)
        (assigned-first  ?d ?pf) (dish-type ?pf ?tf)
        (assigned-second ?d ?ps) (dish-type ?ps ?ts)
        (next-day ?d ?dn)
        ;; ext-4: daily calories in range
        (>= (current-calories) 1000)
        (<= (current-calories) 1500)
    )
    :effect (and
        (assign (current-calories) 0)
        (not (current-day ?d)) (current-day ?dn)
        (prev-first-type  ?tf)
        (prev-second-type ?ts)
        (needs-first ?dn)
    )
  )

  (:action finish-planning
    :parameters (?d - dia ?pf - primer ?ps - segundo)
    :precondition (and
        (current-day ?d)
        (assigned-first  ?d ?pf)
        (assigned-second ?d ?ps)
        (forall (?x - dia) (not (next-day ?d ?x)))
        (>= (current-calories) 1000)
        (<= (current-calories) 1500)
    )
    :effect (and
        (planning-done)
        (not (current-day ?d))
    )
  )
)
