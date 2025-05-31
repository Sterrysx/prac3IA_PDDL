(define (problem menubasicb)
  (:domain menubasicb)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    amanidavera cremacamp paellaval amanidarusa pastamediterranea - primer
    fabada salmonplanxa polloroast llengadoplanxa lasanya - segon
  )

  (:init
    (incompatible paellaval salmonplanxa)
    (incompatible amanidarusa fabada)
    (incompatible cremacamp polloroast)
  )

  (:goal 
    (forall (?d - dia)
      (diaAmbMenuAsignat ?d)
    )
  )
)