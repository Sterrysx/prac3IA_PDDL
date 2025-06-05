(define (problem menubasicb-tc2)
  (:domain menubasicb)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    estofat_llenties amanida_asiatica sopa_miso macarrons_forn amanida_de_cogombre sopa_de_cigrons cigrons_saltejats truita_potatge crema_de_bolets amanida_de_tomaquet - primer
    estofat_soja turbot_planxa salmo_grillat sopa_ajo crema_de_xocolata hamburguesa_mongeta curry_verdures orata_forno botifarra_a_la_planxa crema_avellana  - segon
  )

  (:init
    (incompatible amanida_asiatica orata_forno)
            (incompatible crema_de_bolets orata_forno)
            (incompatible truita_potatge turbot_planxa)
            (incompatible estofat_llenties orata_forno)
            (incompatible truita_potatge orata_forno)
            (incompatible amanida_de_tomaquet salmo_grillat)
            (incompatible amanida_asiatica turbot_planxa)
            (incompatible truita_potatge salmo_grillat)
  )

  (:goal
    (forall (?d - dia)
      (diaAmbMenuAsignat ?d))
  )
)