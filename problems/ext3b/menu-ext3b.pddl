(define (problem menuext3b)

  (:domain menuext3b)

  (:objects
    dilluns dimarts dimecres dijous divendres DummyD - dia
    amanidavera cremacamp paellaval amanidarusa pastamediterranea - primer
    fabada salmonplanxa polloroast llengadoplanxa lasanya - segon
    vegetal peix carn pasta DummyT - tipus 
  )

  (:init
    (incompatible paellaval salmonplanxa)
    (incompatible amanidarusa fabada)
    (incompatible cremacamp polloroast)
    (platTipus amanidavera vegetal) 
    (platTipus fabada vegetal) 
    (platTipus amanidarusa vegetal) 
    (platTipus salmonplanxa peix) 
    (platTipus paellaval peix) 
    (platTipus llengadoplanxa peix)
    (platTipus lasanya pasta)
    (platTipus pastamediterranea pasta)
    (platTipus cremacamp vegetal)
    (platTipus polloroast carn)
    
    ;; Required dishes on specific days
    (platObligatori paellaval dijous)      ; Paella must be served on Thursday
    (platObligatori lasanya dimarts)        ; Lasagna must be served on Tuesday

    (diaAnt DummyD  dilluns)
    (diaAnt dilluns  dimarts)
    (diaAnt dimarts  dimecres)
    (diaAnt dimecres dijous)
    (diaAnt dijous divendres)

    (primerAsignat DummyD)
    (segonAsignat DummyD)

    (diaPrimerTipus DummyD DummyT)
    (diaSegonTipus DummyD DummyT)
  )

  (:goal 
    (forall (?d - dia)
      (and   (primerAsignat ?d ) (segonAsignat ?d ))
    )
  )
)
