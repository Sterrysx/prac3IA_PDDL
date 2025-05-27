;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  MENU SETMANAL -- DOMINI METRIC (ext.4-5)                       ;;
;;  Fluents numerics i minimitzacio de cost                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (domain menu-setmanal-metric)
  (:requirements :adl :typing :equality :fluents)

  ;;-------------------------------------------------------------------
  ;;  TIPUS
  ;;-------------------------------------------------------------------
  (:types dia tipus plat primer - plat segon - plat)

  ;;-------------------------------------------------------------------
  ;;  FLUENTS NUMERICS
  ;;-------------------------------------------------------------------
  (:functions
      (calories ?p - plat)
      (preu     ?p - plat)
      (calories-actuals)
      (cost-total))

  ;;-------------------------------------------------------------------
  ;;  PREDICATS
  ;;-------------------------------------------------------------------
  (:predicates
      (plat-tipus            ?p - plat ?t - tipus)
      (incompatible          ?p - primer ?s - segon)
      (dia-seguent           ?d - dia    ?d2 - dia)

      (dia-actual            ?d - dia)
      (necessita-primer      ?d - dia)
      (necessita-segon       ?d - dia)

      (primer-assignat       ?d - dia ?p - primer)
      (segon-assignat        ?d - dia ?s - segon)
      (usat                  ?pl - plat)

      (tipus-primer-anterior ?t - tipus)
      (tipus-segon-anterior  ?t - tipus)

      (primer-obligatori     ?d - dia ?p - primer)
      (segon-obligatori      ?d - dia ?s - segon)

      (planificacio-completa))

  ;;-------------------------------------------------------------------
  ;;  ACCIONS (iguals al domini basic pero amb efectes numerics)
  ;;-------------------------------------------------------------------

  (:action tria-primer-lliure
    :parameters (?p - primer ?d - dia ?t - tipus ?tp - tipus)
    :precondition (and
        (dia-actual ?d) (necessita-primer ?d)
        (plat-tipus ?p ?t) (tipus-primer-anterior ?tp)
        (not (= ?t ?tp)) (not (usat ?p))
        (forall (?r - primer) (not (primer-obligatori ?d ?r))))
    :effect (and
        (increase (calories-actuals) (calories ?p))
        (increase (cost-total)       (preu     ?p))
        (primer-assignat ?d ?p)
        (not (necessita-primer ?d)) (necessita-segon ?d)
        (usat ?p)))

  (:action tria-primer-obligatori
    :parameters (?p - primer ?d - dia ?t - tipus ?tp - tipus)
    :precondition (and
        (dia-actual ?d) (necessita-primer ?d)
        (plat-tipus ?p ?t) (tipus-primer-anterior ?tp)
        (not (= ?t ?tp)) (not (usat ?p))
        (primer-obligatori ?d ?p))
    :effect (and
        (increase (calories-actuals) (calories ?p))
        (increase (cost-total)       (preu     ?p))
        (primer-assignat ?d ?p)
        (not (necessita-primer ?d)) (necessita-segon ?d)
        (usat ?p)))

  (:action tria-segon-lliure
    :parameters (?s - segon ?d - dia ?pf - primer
                 ?ts - tipus ?tps - tipus)
    :precondition (and
        (dia-actual ?d) (necessita-segon ?d)
        (primer-assignat ?d ?pf)
        (plat-tipus ?s ?ts) (tipus-segon-anterior ?tps)
        (not (= ?ts ?tps))
        (not (incompatible ?pf ?s))
        (not (usat ?s))
        (forall (?r - segon) (not (segon-obligatori ?d ?r))))
    :effect (and
        (increase (calories-actuals) (calories ?s))
        (increase (cost-total)       (preu     ?s))
        (segon-assignat ?d ?s)
        (not (necessita-segon ?d))
        (usat ?s)))

  (:action tria-segon-obligatori
    :parameters (?s - segon ?d - dia ?pf - primer
                 ?ts - tipus ?tps - tipus)
    :precondition (and
        (dia-actual ?d) (necessita-segon ?d)
        (primer-assignat ?d ?pf)
        (plat-tipus ?s ?ts) (tipus-segon-anterior ?tps)
        (not (= ?ts ?tps))
        (not (incompatible ?pf ?s))
        (not (usat ?s))
        (segon-obligatori ?d ?s))
    :effect (and
        (increase (calories-actuals) (calories ?s))
        (increase (cost-total)       (preu     ?s))
        (segon-assignat ?d ?s)
        (not (necessita-segon ?d))
        (usat ?s)))

  (:action finalitza-dia
    :parameters (?d  - dia ?dn - dia
                 ?pf - primer ?ps - segon
                 ?tf - tipus  ?ts - tipus)
    :precondition (and
        (dia-actual ?d)
        (primer-assignat ?d ?pf) (plat-tipus ?pf ?tf)
        (segon-assignat  ?d ?ps) (plat-tipus ?ps ?ts)
        (dia-seguent ?d ?dn)
        (>= (calories-actuals) 1000)
        (<= (calories-actuals) 1500))
    :effect (and
        (assign (calories-actuals) 0)
        (not (dia-actual ?d)) (dia-actual ?dn)
        (tipus-primer-anterior ?tf)
        (tipus-segon-anterior  ?ts)
        (necessita-primer ?dn)))

  (:action fi-setmana
    :parameters (?d - dia ?pf - primer ?ps - segon)
    :precondition (and
        (dia-actual ?d)
        (primer-assignat ?d ?pf)
        (segon-assignat  ?d ?ps)
        (forall (?x - dia) (not (dia-seguent ?d ?x)))
        (>= (calories-actuals) 1000)
        (<= (calories-actuals) 1500))
    :effect (and
        (planificacio-completa)
        (not (dia-actual ?d))))
)
