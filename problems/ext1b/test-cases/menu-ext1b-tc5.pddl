(define (problem menuext1b-tc5)
  (:domain menuext1b)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    amanida_fasols truita_potatge raviolis_ricotta crema_de_carbassa crema_de_carabasso estofat_llenties tallarins_carbonara amanida_quinoa amanida_de_cogombre sopa_de_peix - primer
    curry_verdures cuixa_anec sopa_ceba crema_catalana orata_forno truita_de_llenties wok_verdures parrillada_verdures turbot_planxa estofat_cigrons  - segon
  )

  (:init
    (incompatible crema_de_carbassa cuixa_anec)
            (incompatible sopa_de_peix parrillada_verdures)
            (incompatible amanida_de_cogombre orata_forno)
            (incompatible sopa_de_peix wok_verdures)
            (incompatible amanida_fasols turbot_planxa)
            (incompatible tallarins_carbonara crema_catalana)
            (incompatible crema_de_carabasso orata_forno)
            (incompatible sopa_de_peix curry_verdures)
  )

  (:goal
    (forall (?d - dia)
      (and (primerAsignat ?d) (segonAsignat ?d)))
  )
)