(define (problem menuext1b-tc3)
  (:domain menuext1b)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    brocoli_allada macarrons_forn escalivada_verdures estofat_llenties sopa_de_marisc cigrons_saltejats crema_espinacs tallarins_carbonara crema_de_carabasso amanida_de_cogombre - primer
    sopa_de_pedra crema_de_limon parrillada_verdures sopa_ajo sopa_ceba faves_estofades truita_verdures crema_de_xocolata curry_verdures turbot_planxa  - segon
  )

  (:init
    (incompatible escalivada_verdures sopa_de_pedra)
            (incompatible sopa_de_marisc truita_verdures)
            (incompatible crema_espinacs turbot_planxa)
            (incompatible amanida_de_cogombre turbot_planxa)
            (incompatible crema_de_carabasso turbot_planxa)
            (incompatible macarrons_forn crema_de_limon)
            (incompatible brocoli_allada sopa_ajo)
            (incompatible sopa_de_marisc curry_verdures)
  )

  (:goal
    (forall (?d - dia)
      (and (primerAsignat ?d) (segonAsignat ?d)))
  )
)