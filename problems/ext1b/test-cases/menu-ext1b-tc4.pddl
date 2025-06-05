(define (problem menuext1b-tc4)
  (:domain menuext1b)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    sopa_de_peix brocoli_allada sopa_de_cigrons amanida_de_cogombre amanida_quinoa sopa_verdures crema_de_carxofa crema_espinacs crema_de_carabasso truita_potatge - primer
    tataki_verdures bacalla_amb_tomaquet wok_verdures parrillada_verdures faves_estofades cuixa_anec llenguado_amb_lima estofat_soja truita_de_llenties xai_rostit  - segon
  )

  (:init
    (incompatible truita_potatge bacalla_amb_tomaquet)
            (incompatible brocoli_allada cuixa_anec)
            (incompatible crema_espinacs bacalla_amb_tomaquet)
            (incompatible sopa_verdures wok_verdures)
            (incompatible sopa_verdures parrillada_verdures)
            (incompatible amanida_quinoa cuixa_anec)
            (incompatible amanida_quinoa bacalla_amb_tomaquet)
            (incompatible sopa_verdures tataki_verdures)
  )

  (:goal
    (forall (?d - dia)
      (and (primerAsignat ?d) (segonAsignat ?d)))
  )
)