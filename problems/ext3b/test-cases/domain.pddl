(define (domain menuext3b)
  (:requirements :strips :adl)
  (:types 
    dia plat tipus - object
    primer segon - plat
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
      (platObligatori ?p - plat ?d - dia)  ; New predicate for required dishes on specific days
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
        (forall (?t - tipus) 
          (when (platTipus ?s ?t) 
            (diaSegonTipus ?d ?t)
          )
        )
      )
  )
)
