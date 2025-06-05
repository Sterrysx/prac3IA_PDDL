(define (problem menuext1b-tc2)
  (:domain menuext1b)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    sopa_de_cigrons macarrons_forn amanida_asiatica amanida_fasols brocoli_allada sopa_miso cigrons_saltejats crema_de_carbassa sopa_de_marisc amanida_de_cogombre - primer
    sopa_de_peix faves_estofades parrillada_verdures crema_avellana crema_catalana crema_de_xocolata sopa_de_galets salmo_grillat orata_forno truita_de_llenties  - segon
  )

  (:init
    (incompatible amanida_fasols salmo_grillat)
            (incompatible crema_de_carbassa salmo_grillat)
            (incompatible macarrons_forn crema_avellana)
            (incompatible sopa_miso parrillada_verdures)
            (incompatible amanida_asiatica salmo_grillat)
            (incompatible crema_de_carbassa orata_forno)
            (incompatible brocoli_allada sopa_de_galets)
            (incompatible cigrons_saltejats orata_forno)
  )

  (:goal
    (forall (?d - dia)
      (and (primerAsignat ?d) (segonAsignat ?d)))
  )
)