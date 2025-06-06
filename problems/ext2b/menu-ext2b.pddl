(define (problem menuext2b)

  (:domain menuext2b)

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