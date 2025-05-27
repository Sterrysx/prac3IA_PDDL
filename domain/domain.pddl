;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  WEEKLY-MENU ― BASIC DOMAIN  (ext.0-3)                           ;;
;;  – No numeric fluents –                                          ;;
;;  – Fully supports extensions 1-3                                 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (domain weekly-menu)
  (:requirements :adl :typing :equality)

  ;;-------------------------------------------------------------------
  ;;  TYPES
  ;;-------------------------------------------------------------------
  (:types
      dia
      tipo
      plato
      primer  - plato
      segundo - plato)

  ;;-------------------------------------------------------------------
  ;;  PREDICATES
  ;;-------------------------------------------------------------------
  (:predicates
      ;; static
      (dish-type        ?p - plato  ?t - tipo)
      (incompatible     ?p - primer ?s - segundo)
      (next-day         ?d - dia    ?d2 - dia)

      ;; dynamic
      (current-day      ?d - dia)
      (needs-first      ?d - dia)
      (needs-second     ?d - dia)

      (assigned-first   ?d - dia ?p - primer)
      (assigned-second  ?d - dia ?s - segundo)
      (used             ?pl - plato)                ; ext-1

      (prev-first-type  ?t - tipo)                  ; ext-2
      (prev-second-type ?t - tipo)                  ; ext-2

      ;; forced dishes (ext-3)
      (require-first    ?d - dia ?p - primer)
      (require-second   ?d - dia ?s - segundo)

      (planning-done))

  ;;-------------------------------------------------------------------
  ;;  ACTIONS
  ;;-------------------------------------------------------------------

  ;; ――― choose FIRST course (no requirement) ―――
  (:action choose-first-free
    :parameters (?p  - primer
                 ?d  - dia
                 ?t  - tipo
                 ?tp - tipo)
    :precondition (and
        (current-day ?d)
        (needs-first ?d)
        (dish-type ?p ?t)
        (prev-first-type ?tp)              ;; yesterday’s first-type
        (not (= ?t ?tp))                   ;; ext-2
        (not (used ?p))                    ;; ext-1
        (forall (?r - primer) (not (require-first ?d ?r))))
    :effect (and
        (assigned-first ?d ?p)
        (not (needs-first ?d))
        (needs-second ?d)
        (used ?p)))

  ;; ――― choose FIRST course (forced) ―――
  (:action choose-first-required
    :parameters (?p  - primer
                 ?d  - dia
                 ?t  - tipo
                 ?tp - tipo)
    :precondition (and
        (current-day ?d) (needs-first ?d)
        (dish-type ?p ?t)
        (prev-first-type ?tp) (not (= ?t ?tp))
        (not (used ?p))
        (require-first ?d ?p))
    :effect (and
        (assigned-first ?d ?p)
        (not (needs-first ?d))
        (needs-second ?d)
        (used ?p)))

  ;; ――― choose SECOND course (no requirement) ―――
  (:action choose-second-free
    :parameters (?s   - segundo
                 ?d   - dia
                 ?pf  - primer
                 ?ts  - tipo
                 ?tps - tipo)
    :precondition (and
        (current-day ?d) (needs-second ?d)
        (assigned-first ?d ?pf)
        (dish-type ?s ?ts)
        (prev-second-type ?tps)            ;; yesterday’s second-type
        (not (= ?ts ?tps))                 ;; ext-2
        (not (incompatible ?pf ?s))
        (not (used ?s))                    ;; ext-1
        (forall (?r - segundo) (not (require-second ?d ?r))))
    :effect (and
        (assigned-second ?d ?s)
        (not (needs-second ?d))
        (used ?s)))

  ;; ――― choose SECOND course (forced) ―――
  (:action choose-second-required
    :parameters (?s   - segundo
                 ?d   - dia
                 ?pf  - primer
                 ?ts  - tipo
                 ?tps - tipo)
    :precondition (and
        (current-day ?d) (needs-second ?d)
        (assigned-first ?d ?pf)
        (dish-type ?s ?ts)
        (prev-second-type ?tps)
        (not (= ?ts ?tps))
        (not (incompatible ?pf ?s))
        (not (used ?s))
        (require-second ?d ?s))
    :effect (and
        (assigned-second ?d ?s)
        (not (needs-second ?d))
        (used ?s)))

  ;; ――― close an ordinary day (Mon-Thu) ―――
  (:action finalize-day
    :parameters (?d  - dia
                 ?dn - dia
                 ?pf - primer ?ps - segundo
                 ?tf - tipo   ?ts - tipo)
    :precondition (and
        (current-day ?d)
        (assigned-first  ?d ?pf) (dish-type ?pf ?tf)
        (assigned-second ?d ?ps) (dish-type ?ps ?ts)
        (next-day ?d ?dn))
    :effect (and
        (not (current-day ?d)) (current-day ?dn)
        (prev-first-type  ?tf)             ;; remember today’s types
        (prev-second-type ?ts)
        (needs-first ?dn)))

  ;; ――― finish the week (Friday) ―――
  (:action finish-planning
    :parameters (?d  - dia ?pf - primer ?ps - segundo)
    :precondition (and
        (current-day ?d)
        (assigned-first  ?d ?pf)
        (assigned-second ?d ?ps)
        (forall (?x - dia) (not (next-day ?d ?x))))
    :effect (and
        (planning-done)
        (not (current-day ?d))))
)
