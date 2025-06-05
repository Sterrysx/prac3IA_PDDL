(define (problem menuext1b-tc1)
  (:domain menuext1b)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    verdures_a_la_planxa sopa_verdures amanida_asiatica hummus sopa_de_marisc truita_potatge amanida_de_tomaquet crema_de_carxofa sopa_de_cigrons amanida_de_cogombre - primer
    filet_porc salmo_grillat cuixa_anec botifarra_a_la_planxa crema_de_limon estofat_cigrons orata_forno curry_verdures crema_avellana sopa_ceba  - segon
  )

  (:init
    (incompatible amanida_de_cogombre filet_porc)
            (incompatible amanida_asiatica filet_porc)
            (incompatible amanida_de_cogombre orata_forno)
            (incompatible crema_de_carxofa salmo_grillat)
            (incompatible amanida_de_tomaquet cuixa_anec)
            (incompatible amanida_de_cogombre botifarra_a_la_planxa)
            (incompatible amanida_de_tomaquet botifarra_a_la_planxa)
            (incompatible amanida_de_tomaquet salmo_grillat)
  )

  (:goal
    (forall (?d - dia)
      (and (primerAsignat ?d) (segonAsignat ?d)))
  )
)