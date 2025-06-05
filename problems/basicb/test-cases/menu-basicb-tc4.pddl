(define (problem menubasicb-tc4)
  (:domain menubasicb)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    hummus sopa_de_marisc crema_espinacs sopa_de_peix estofat_llenties tallarins_carbonara sopa_verdures amanida_quinoa amanida_de_tomaquet escalivada_verdures - primer
    bacalla_amb_tomate crema_avellana xai_rostit sopa_de_pedra truita_verdures botifarra_a_la_planxa crema_de_xocolata filet_porc wok_verdures tataki_verdures  - segon
  )

  (:init
    (incompatible amanida_de_tomaquet xai_rostit)
            (incompatible amanida_de_tomaquet filet_porc)
            (incompatible escalivada_verdures filet_porc)
            (incompatible amanida_quinoa filet_porc)
            (incompatible sopa_de_peix wok_verdures)
            (incompatible crema_espinacs xai_rostit)
            (incompatible amanida_de_tomaquet botifarra_a_la_planxa)
            (incompatible sopa_verdures tataki_verdures)
  )

  (:goal
    (forall (?d - dia)
      (diaAmbMenuAsignat ?d))
  )
)