(define (problem menubasicb-tc1)
  (:domain menubasicb)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    penne_arrabiata gnocchi_pesto macarrons_forn tallarins_carbonara hummus brocoli_allada estofat_llenties sopa_verdures sopa_de_peix amanida_de_cogombre - primer
    wok_verdures truita_de_llenties sopa_ceba faves_estofades truita_verdures crema_de_xocolata parrillada_verdures bacalla_amb_tomaquet sopa_de_pedra estofat_cigrons  - segon
  )

  (:init
    (incompatible sopa_de_peix wok_verdures)
            (incompatible hummus bacalla_amb_tomaquet)
            (incompatible sopa_verdures wok_verdures)
            (incompatible sopa_verdures parrillada_verdures)
            (incompatible macarrons_forn crema_de_xocolata)
            (incompatible estofat_llenties bacalla_amb_tomaquet)
            (incompatible gnocchi_pesto crema_de_xocolata)
            (incompatible brocoli_allada sopa_de_pedra)
  )

  (:goal
    (forall (?d - dia)
      (diaAmbMenuAsignat ?d))
  )
)