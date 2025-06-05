(define (problem menuext1b-tc1)
  (:domain menuext1b)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    macarrons_forn verdures_amb_salsa fajitas_verdures crema_de_bolets crema_de_carxofa brocoli_allada truita_potatge sopa_de_marisc escalivada_verdures crema_de_carbassa - primer
    turbot_planxa crema_de_limon sopa_de_peix crema_catalana hamburguesa_mongeta orata_forno filet_porc tataki_verdures crema_taronja crema_de_xocolata  - segon
  )

  (:init
    (incompatible escalivada_verdures filet_porc)
            (incompatible macarrons_forn crema_catalana)
            (incompatible brocoli_allada filet_porc)
            (incompatible crema_de_carxofa orata_forno)
            (incompatible brocoli_allada sopa_de_peix)
            (incompatible crema_de_carxofa filet_porc)
            (incompatible crema_de_carbassa orata_forno)
            (incompatible crema_de_carbassa turbot_planxa)
  )

  (:goal
    (forall (?d - dia)
      (and (primerAsignat ?d) (segonAsignat ?d)))
  )
)