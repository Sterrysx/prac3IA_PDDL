(define (domain menuext5b)
  (:requirements :strips :adl :typing :equality :fluents)
  (:types 
    dia plat tipus - object
    primer segon - plat
  )
  (:functions
    (minCalories)        ; Minimum calories required per day 
    (maxCalories)        ; Maximum calories allowed per day
    (calories ?p - plat) ; Calories for each dish
    (preu ?p - plat)     ; Price of each dish
    (costDiari)          ; Total cost for the current day
    (costTotal)          ; Total cost for all days
  )
  (:predicates 
      (assignatP ?d - dia ?p - primer)
      (assignatS ?d - dia ?s - segon)
      (primerAsignat ?d - dia)
      (segonAsignat ?d - dia)
      (incompatible ?p1 - plat ?p2 - plat)
      (diaPrimerTipus ?d - dia ?t - tipus)
      (diaSegonTipus ?d - dia ?t - tipus)
      (usat ?p - plat)
      (platTipus ?p - plat ?t - tipus)
      (diaAnt ?dant - dia ?dact - dia)
      (platObligatori ?p - plat ?d - dia)
  )

  (:action assignarPrimer
      :parameters (?d - dia ?p - primer)
      :precondition (and 
        (not (primerAsignat ?d)) 
        (not (usat ?p))
        (exists (?dant - dia)
          (and 
            (diaAnt ?dant ?d)
            (primerAsignat ?dant)
            (segonAsignat ?dant)
            (not (exists (?t - tipus)
              (and 
                (or (diaPrimerTipus ?dant ?t)
                    (diaSegonTipus ?dant ?t))
                (platTipus ?p ?t)
              )
            ))
          )
        )
        (or 
          (platObligatori ?p ?d)
          (and 
            (not (exists (?p2 - primer) 
              (platObligatori ?p2 ?d)))
            (not (exists (?d2 - dia) 
              (and 
                (not (= ?d2 ?d))
                (platObligatori ?p ?d2)
              )))
          )
        )
      )
      :effect (and 
        (assignatP ?d ?p) 
        (primerAsignat ?d) 
        (usat ?p)
        (increase (costTotal) (preu ?p))
        (increase (costDiari) (preu ?p))
        (forall (?t - tipus) 
          (when (platTipus ?p ?t) 
            (diaPrimerTipus ?d ?t)
          )
        )
      )
  )

  (:action assignarSegon
      :parameters (?d - dia ?p - primer ?s - segon)
      :precondition (and 
        (assignatP ?d ?p)
        (not (segonAsignat ?d))
        (not (usat ?s))
        (not (incompatible ?p ?s))
        ; Check calories constraints using the sum of both dishes
        (>= (+ (calories ?p) (calories ?s)) (minCalories))
        (<= (+ (calories ?p) (calories ?s)) (maxCalories))
        (exists (?dant - dia)
          (and 
            (diaAnt ?dant ?d)
            (primerAsignat ?dant)
            (segonAsignat ?dant)
            (not (exists (?t - tipus)
              (and 
                (or (diaPrimerTipus ?dant ?t)
                    (diaSegonTipus ?dant ?t))
                (platTipus ?s ?t)
              )
            ))
          )
        )
        (or 
          (platObligatori ?s ?d)
          (and 
            (not (exists (?s2 - segon) 
              (platObligatori ?s2 ?d)))
            (not (exists (?d2 - dia) 
              (and 
                (not (= ?d2 ?d))
                (platObligatori ?s ?d2)
              )))
          )
        )
      )
      :effect (and 
        (assignatS ?d ?s)
        (segonAsignat ?d)
        (usat ?s)
        (increase (costTotal) (preu ?s))
        (increase (costDiari) (preu ?s))
        (forall (?t - tipus) 
          (when (platTipus ?s ?t) 
            (diaSegonTipus ?d ?t)
          )
        )
      )
  )
)
