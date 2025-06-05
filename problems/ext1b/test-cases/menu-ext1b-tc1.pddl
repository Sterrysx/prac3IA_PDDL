(define (problem menuext1b-tc1)
  (:domain menuext1b)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    amanida_de_cogombre crema_espinacs crema_de_carxofa amanida_de_tomaquet amanida_catalana estofat_llenties truita_potatge sopa_de_peix cigrons_saltejats tallarins_carbonara - primer
    parrillada_verdures wok_verdures crema_de_limon crema_taronja sopa_ajo sopa_de_galets cuixa_anec estofat_cigrons tataki_verdures curry_verdures  - segon
  )

  (:init
    (incompatible crema_de_carxofa cuixa_anec)
            (incompatible tallarins_carbonara crema_de_limon)
            (incompatible sopa_de_peix parrillada_verdures)
            (incompatible crema_espinacs cuixa_anec)
            (incompatible sopa_de_peix tataki_verdures)
            (incompatible sopa_de_peix wok_verdures)
            (incompatible amanida_catalana cuixa_anec)
            (incompatible amanida_de_tomaquet cuixa_anec)
  )

  (:goal
    (forall (?d - dia)
      (and (primerAsignat ?d) (segonAsignat ?d)))
  )
)