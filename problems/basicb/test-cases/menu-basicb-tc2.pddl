(define (problem menubasicb-tc2)
  (:domain menubasicb)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    truita_potatge hummus sopa_de_cigrons verdures_a_la_planxa macarrons_forn estofat_llenties sopa_verdures penne_arrabiata cigrons_saltejats crema_de_carxofa - primer
    crema_taronja turbot_planxa crema_de_limon orata_forno faves_estofades sopa_de_peix sopa_de_galets crema_de_xocolata botifarra_a_la_planxa cuixa_anec  - segon
  )

  (:init
    (incompatible macarrons_forn crema_de_limon)
            (incompatible macarrons_forn crema_de_xocolata)
            (incompatible verdures_a_la_planxa cuixa_anec)
            (incompatible penne_arrabiata crema_taronja)
            (incompatible hummus orata_forno)
            (incompatible penne_arrabiata crema_de_limon)
            (incompatible verdures_a_la_planxa sopa_de_peix)
            (incompatible crema_de_carxofa orata_forno)
  )

  (:goal
    (forall (?d - dia)
      (diaAmbMenuAsignat ?d))
  )
)