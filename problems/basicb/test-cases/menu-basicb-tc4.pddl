(define (problem menubasicb-tc4)
  (:domain menubasicb)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    sopa_verdures escalivada_verdures crema_de_carbassa amanida_de_tomaquet verdures_a_la_planxa crema_de_carxofa verdures_amb_salsa amanida_asiatica amanida_quinoa amanida_catalana - primer
    crema_avellana sopa_de_galets parrillada_verdures botifarra_a_la_planxa crema_catalana llenguado_amb_lima sopa_ajo hamburguesa_mongeta salmo_grillat estofat_cigrons  - segon
  )

  (:init
    (incompatible crema_de_carxofa llenguado_amb_lima)
            (incompatible verdures_amb_salsa botifarra_a_la_planxa)
            (incompatible amanida_de_tomaquet llenguado_amb_lima)
            (incompatible crema_de_carxofa botifarra_a_la_planxa)
            (incompatible amanida_quinoa salmo_grillat)
            (incompatible escalivada_verdures sopa_de_galets)
            (incompatible verdures_amb_salsa sopa_de_galets)
            (incompatible sopa_verdures parrillada_verdures)
  )

  (:goal
    (forall (?d - dia)
      (diaAmbMenuAsignat ?d))
  )
)