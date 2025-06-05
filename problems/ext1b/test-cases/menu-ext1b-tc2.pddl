(define (problem menuext1b-tc2)
  (:domain menuext1b)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    tallarins_carbonara amanida_de_cogombre gnocchi_pesto crema_espinacs cigrons_saltejats amanida_catalana crema_de_carabasso crema_de_carxofa macarrons_forn brocoli_allada - primer
    crema_catalana botifarra_a_la_planxa xai_rostit estofat_cigrons sopa_ajo filet_porc bacalla_amb_tomaquet crema_taronja sopa_de_pedra tataki_verdures  - segon
  )

  (:init
    (incompatible brocoli_allada botifarra_a_la_planxa)
            (incompatible gnocchi_pesto crema_taronja)
            (incompatible crema_espinacs filet_porc)
            (incompatible amanida_de_cogombre bacalla_amb_tomaquet)
            (incompatible macarrons_forn crema_catalana)
            (incompatible amanida_de_cogombre filet_porc)
            (incompatible crema_espinacs botifarra_a_la_planxa)
            (incompatible crema_espinacs xai_rostit)
  )

  (:goal
    (forall (?d - dia)
      (and (primerAsignat ?d) (segonAsignat ?d)))
  )
)