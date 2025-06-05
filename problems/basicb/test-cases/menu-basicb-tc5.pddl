(define (problem menubasicb-tc5)
  (:domain menubasicb)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    sopa_de_peix gnocchi_pesto cigrons_saltejats verdures_a_la_planxa crema_de_carxofa amanida_de_cogombre sopa_miso penne_arrabiata amanida_catalana crema_de_carbassa - primer
    bacalla_amb_tomaquet orata_forno wok_verdures botifarra_a_la_planxa turbot_planxa parrillada_verdures crema_taronja sopa_ceba filet_porc llenguado_amb_lima  - segon
  )

  (:init
    (incompatible crema_de_carxofa bacalla_amb_tomaquet)
            (incompatible sopa_de_peix wok_verdures)
            (incompatible crema_de_carxofa turbot_planxa)
            (incompatible verdures_a_la_planxa filet_porc)
            (incompatible crema_de_carxofa llenguado_amb_lima)
            (incompatible cigrons_saltejats orata_forno)
            (incompatible cigrons_saltejats llenguado_amb_lima)
            (incompatible amanida_catalana llenguado_amb_lima)
  )

  (:goal
    (forall (?d - dia)
      (diaAmbMenuAsignat ?d))
  )
)