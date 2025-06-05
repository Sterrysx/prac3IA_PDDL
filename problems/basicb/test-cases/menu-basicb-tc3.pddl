(define (problem menubasicb-tc3)
  (:domain menubasicb)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    tallarins_carbonara amanida_de_cogombre sopa_verdures truita_potatge amanida_catalana verdures_a_la_planxa cigrons_saltejats crema_de_carabasso verdures_amb_salsa sopa_de_cigrons - primer
    hamburguesa_mongeta faves_estofades sopa_de_pedra curry_verdures crema_taronja crema_de_xocolata parrillada_verdures sopa_de_galets tataki_verdures crema_de_limon  - segon
  )

  (:init
    (incompatible sopa_de_cigrons curry_verdures)
            (incompatible sopa_verdures tataki_verdures)
            (incompatible verdures_amb_salsa sopa_de_pedra)
            (incompatible sopa_de_cigrons tataki_verdures)
            (incompatible sopa_verdures parrillada_verdures)
            (incompatible tallarins_carbonara crema_de_limon)
            (incompatible verdures_amb_salsa sopa_de_galets)
            (incompatible sopa_de_cigrons parrillada_verdures)
  )

  (:goal
    (forall (?d - dia)
      (diaAmbMenuAsignat ?d))
  )
)