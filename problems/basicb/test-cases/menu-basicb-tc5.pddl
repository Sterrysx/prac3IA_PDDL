(define (problem menubasicb-tc5)
  (:domain menubasicb)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    amanida_de_tomaquet crema_espinacs crema_de_carbassa crema_de_bolets amanida_quinoa sopa_verdures crema_de_carxofa amanida_catalana fajitas_verdures raviolis_ricotta - primer
    sopa_de_galets sopa_ajo estofat_cigrons botifarra_a_la_planxa crema_catalana crema_avellana truita_verdures llenguado_amb_lima salmo_grillat crema_taronja  - segon
  )

  (:init
    (incompatible crema_de_carbassa botifarra_a_la_planxa)
            (incompatible amanida_catalana botifarra_a_la_planxa)
            (incompatible fajitas_verdures sopa_de_galets)
            (incompatible amanida_catalana salmo_grillat)
            (incompatible amanida_quinoa llenguado_amb_lima)
            (incompatible crema_de_carbassa salmo_grillat)
            (incompatible amanida_quinoa botifarra_a_la_planxa)
            (incompatible raviolis_ricotta crema_avellana)
  )

  (:goal
    (forall (?d - dia)
      (diaAmbMenuAsignat ?d))
  )
)