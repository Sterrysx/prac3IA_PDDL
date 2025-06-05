(define (problem menuext1b-tc5)
  (:domain menuext1b)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    raviolis_ricotta amanida_de_tomaquet estofat_llenties amanida_quinoa tallarins_carbonara crema_de_carbassa brocoli_allada amanida_fasols truita_potatge sopa_miso - primer
    truita_verdures orata_forno faves_estofades crema_de_xocolata crema_taronja bacalla_amb_tomaquet crema_de_limon curry_verdures hamburguesa_mongeta filet_porc  - segon
  )

  (:init
    (incompatible raviolis_ricotta crema_de_limon)
            (incompatible amanida_fasols bacalla_amb_tomaquet)
            (incompatible sopa_miso truita_verdures)
            (incompatible truita_potatge orata_forno)
            (incompatible estofat_llenties orata_forno)
            (incompatible estofat_llenties bacalla_amb_tomaquet)
            (incompatible amanida_de_tomaquet filet_porc)
            (incompatible crema_de_carbassa bacalla_amb_tomaquet)
  )

  (:goal
    (forall (?d - dia)
      (and (primerAsignat ?d) (segonAsignat ?d)))
  )
)