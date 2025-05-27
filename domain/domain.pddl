;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  MENU SETMANAL -- DOMINI BASIC (ext.0-3)                        ;;
;;  Sense fluents numerics                                        ;;
;;  Dona suport complet a les extensions 1-3                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (domain menu-setmanal)
  (:requirements :adl :typing :equality)

  ;;-------------------------------------------------------------------
  ;;  TIPUS
  ;;-------------------------------------------------------------------
  (:types
      dia
      tipus
      plat
      primer - plat
      segon  - plat)

  ;;-------------------------------------------------------------------
  ;;  PREDICATS
  ;;-------------------------------------------------------------------
  (:predicates
      ;; estatics
      (plat-tipus            ?p - plat   ?t - tipus)
      (incompatible          ?p - primer ?s - segon)
      (dia-seguent           ?d - dia    ?d2 - dia)

      ;; dinamics
      (dia-actual            ?d - dia)
      (necessita-primer      ?d - dia)
      (necessita-segon       ?d - dia)

      (primer-assignat       ?d - dia ?p - primer)
      (segon-assignat        ?d - dia ?s - segon)
      (usat                  ?pl - plat)               ; ext-1

      (tipus-primer-anterior ?t - tipus)               ; ext-2
      (tipus-segon-anterior  ?t - tipus)               ; ext-2

      ;; plats obligatoris (ext-3)
      (primer-obligatori     ?d - dia ?p - primer)
      (segon-obligatori      ?d - dia ?s - segon)

      (planificacio-completa))

  ;;-------------------------------------------------------------------
  ;;  ACCIONS
  ;;-------------------------------------------------------------------

  ;; -- triar PRIMER sense obligacio --
  (:action tria-primer-lliure
    :parameters (?p - primer
                 ?d - dia
                 ?t - tipus
                 ?tp - tipus)
    :precondition (and
        (dia-actual ?d)
        (necessita-primer ?d)
        (plat-tipus ?p ?t)
        (tipus-primer-anterior ?tp)
        (not (= ?t ?tp))
        (not (usat ?p))
        (forall (?r - primer) (not (primer-obligatori ?d ?r))))
    :effect (and
        (primer-assignat ?d ?p)
        (not (necessita-primer ?d))
        (necessita-segon ?d)
        (usat ?p)))

  ;; -- triar PRIMER obligatori --
  (:action tria-primer-obligatori
    :parameters (?p - primer
                 ?d - dia
                 ?t - tipus
                 ?tp - tipus)
    :precondition (and
        (dia-actual ?d) (necessita-primer ?d)
        (plat-tipus ?p ?t)
        (tipus-primer-anterior ?tp) (not (= ?t ?tp))
        (not (usat ?p))
        (primer-obligatori ?d ?p))
    :effect (and
        (primer-assignat ?d ?p)
        (not (necessita-primer ?d))
        (necessita-segon ?d)
        (usat ?p)))

  ;; -- triar SEGON sense obligacio --
  (:action tria-segon-lliure
    :parameters (?s  - segon
                 ?d  - dia
                 ?pf - primer
                 ?ts  - tipus
                 ?tps - tipus)
    :precondition (and
        (dia-actual ?d) (necessita-segon ?d)
        (primer-assignat ?d ?pf)
        (plat-tipus ?s ?ts)
        (tipus-segon-anterior ?tps)
        (not (= ?ts ?tps))
        (not (incompatible ?pf ?s))
        (not (usat ?s))
        (forall (?r - segon) (not (segon-obligatori ?d ?r))))
    :effect (and
        (segon-assignat ?d ?s)
        (not (necessita-segon ?d))
        (usat ?s)))

  ;; -- triar SEGON obligatori --
  (:action tria-segon-obligatori
    :parameters (?s  - segon
                 ?d  - dia
                 ?pf - primer
                 ?ts  - tipus
                 ?tps - tipus)
    :precondition (and
        (dia-actual ?d) (necessita-segon ?d)
        (primer-assignat ?d ?pf)
        (plat-tipus ?s ?ts)
        (tipus-segon-anterior ?tps)
        (not (= ?ts ?tps))
        (not (incompatible ?pf ?s))
        (not (usat ?s))
        (segon-obligatori ?d ?s))
    :effect (and
        (segon-assignat ?d ?s)
        (not (necessita-segon ?d))
        (usat ?s)))

  ;; -- finalitzar dia (dilluns-dijous) --
  (:action finalitza-dia
    :parameters (?d  - dia
                 ?dn - dia
                 ?pf - primer ?ps - segon
                 ?tf - tipus  ?ts - tipus)
    :precondition (and
        (dia-actual ?d)
        (primer-assignat ?d ?pf) (plat-tipus ?pf ?tf)
        (segon-assignat  ?d ?ps) (plat-tipus ?ps ?ts)
        (dia-seguent ?d ?dn))
    :effect (and
        (not (dia-actual ?d)) (dia-actual ?dn)
        (tipus-primer-anterior ?tf)
        (tipus-segon-anterior  ?ts)
        (necessita-primer ?dn)))

  ;; -- acabar setmana (divendres) --
  (:action fi-setmana
    :parameters (?d  - dia ?pf - primer ?ps - segon)
    :precondition (and
        (dia-actual ?d)
        (primer-assignat ?d ?pf)
        (segon-assignat  ?d ?ps)
        (forall (?x - dia) (not (dia-seguent ?d ?x))))
    :effect (and
        (planificacio-completa)
        (not (dia-actual ?d))))
)
