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
  )

  (:action assignarPrimer
      :parameters (?d - dia ?p - primer)
      :precondition (and 
        (not (primerAsignat ?d)) 
        (not (usat ?p))
        ;; Check against both first and second dish types from the one previous day
        (exists (?dant - dia)
          (and 
            (diaAnt ?dant ?d)
            (primerAsignat ?dant)
            (segonAsignat ?dant)
            (forall (?t - tipus)
              (imply
                (or (diaPrimerTipus ?dant ?t)
                    (diaSegonTipus ?dant ?t))
                (not (platTipus ?p ?t))
              )
            )
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
        ;; Check against both first and second dish types from the one previous day
        (exists (?dant - dia)
          (and 
            (diaAnt ?dant ?d)
            (primerAsignat ?dant)
            (segonAsignat ?dant)
            (forall (?t - tipus)
              (imply
                (or (diaPrimerTipus ?dant ?t)
                    (diaSegonTipus ?dant ?t))
                (not (platTipus ?s ?t))
              )
            )
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
