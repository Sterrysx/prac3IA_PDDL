(define (problem menubasicb-tc3)
  (:domain menubasicb)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    crema_de_carabasso estofat_llenties crema_de_carxofa amanida_asiatica cigrons_saltejats gnocchi_pesto macarrons_forn crema_espinacs verdures_a_la_planxa amanida_quinoa - primer
    faves_estofades sopa_ceba tataki_verdures sopa_de_galets curry_verdures orata_forno botifarra_a_la_planxa turbot_planxa xai_rostit truita_verdures  - segon
  )

  (:init
    (incompatible amanida_asiatica orata_forno)
            (incompatible crema_de_carxofa orata_forno)
            (incompatible amanida_asiatica botifarra_a_la_planxa)
            (incompatible amanida_quinoa turbot_planxa)
            (incompatible crema_de_carabasso turbot_planxa)
            (incompatible crema_de_carabasso xai_rostit)
            (incompatible verdures_a_la_planxa botifarra_a_la_planxa)
            (incompatible verdures_a_la_planxa xai_rostit)
  )

  (:goal
    (forall (?d - dia)
      (diaAmbMenuAsignat ?d))
  )
)