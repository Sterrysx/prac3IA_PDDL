(define (problem menuext1b-tc4)
  (:domain menuext1b)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    gnocchi_pesto amanida_asiatica brocoli_allada verdures_amb_salsa sopa_de_marisc fajitas_verdures raviolis_ricotta crema_de_carabasso crema_de_carxofa crema_de_bolets - primer
    truita_de_llenties bacalla_amb_tomaquet tataki_verdures xai_rostit estofat_cigrons crema_taronja salmo_grillat crema_de_xocolata pollastre_a_la_planxa curry_verdures  - segon
  )

  (:init
    (incompatible fajitas_verdures xai_rostit)
            (incompatible crema_de_bolets xai_rostit)
            (incompatible sopa_de_marisc curry_verdures)
            (incompatible crema_de_carabasso bacalla_amb_tomaquet)
            (incompatible crema_de_carxofa salmo_grillat)
            (incompatible crema_de_carxofa pollastre_a_la_planxa)
            (incompatible amanida_asiatica xai_rostit)
            (incompatible brocoli_allada pollastre_a_la_planxa)
  )

  (:goal
    (forall (?d - dia)
      (and (primerAsignat ?d) (segonAsignat ?d)))
  )
)