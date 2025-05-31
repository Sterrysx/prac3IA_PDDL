

(define (domain menuext1b)
  (:requirements :strips :adl)
  (:types 
    dia plat - object
    primer segon - plat
  )
  (:predicates 
      (assignatP ?d - dia ?p - primer )
      (assignatS ?d - dia ?p - segon )
      (primerAsignat ?d -dia)
      (segonAsignat ?d -dia)
      (incompatible ?p1 - plat ?p2 - plat)
      (usat ?p - plat)
  )

  (:action assignarPrimer
      :parameters (?d -dia ?p - primer)
      :precondition ( and (not (primerAsignat ?d)) (not(usat ?p )))
      :effect (and (assignatP ?d ?p) (primerAsignat ?d) (usat ?p))
  )
  (:action assignarSegon
      :parameters (?d -dia ?p - primer ?s - segon)
      :precondition ( and (assignatP ?d ?p) (not (segonAsignat ?d)) (not(usat ?s )) (not (incompatible ?p ?s)))
      :effect (and (assignatS ?d ?s) (segonAsignat ?d) (usat ?s))
  )
)