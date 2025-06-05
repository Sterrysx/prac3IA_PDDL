(define (problem menubasicb-tc5)
  (:domain menubasicb)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    amanida_quinoa tallarins_carbonara escalivada_verdures sopa_de_peix gnocchi_pesto crema_de_carxofa crema_espinacs sopa_de_cigrons truita_potatge fajitas_verdures - primer
    wok_verdures sopa_ajo faves_estofades turbot_planxa bacalla_amb_tomaquet sopa_de_peix estofat_cigrons orata_forno sopa_ceba filet_porc  - segon
  )

  (:init
    (incompatible amanida_quinoa turbot_planxa)
            (incompatible crema_de_carxofa orata_forno)
            (incompatible crema_espinacs turbot_planxa)
            (incompatible sopa_de_peix wok_verdures)
            (incompatible escalivada_verdures sopa_de_peix)
            (incompatible fajitas_verdures sopa_ajo)
            (incompatible sopa_de_cigrons wok_verdures)
            (incompatible truita_potatge orata_forno)
  )

  (:goal
    (forall (?d - dia)
      (diaAmbMenuAsignat ?d))
  )
)