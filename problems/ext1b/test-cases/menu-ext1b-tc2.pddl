(define (problem menuext1b-tc2)
  (:domain menuext1b)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    verdures_a_la_planxa sopa_de_peix crema_de_carbassa fajitas_verdures estofat_llenties truita_potatge amanida_catalana amanida_de_cogombre sopa_de_cigrons cigrons_saltejats - primer
    crema_de_xocolata wok_verdures sopa_de_peix llenguado_amb_lima xai_rostit sopa_ajo crema_avellana estofat_soja crema_de_limon truita_verdures  - segon
  )

  (:init
    (incompatible crema_de_carbassa xai_rostit)
            (incompatible amanida_catalana xai_rostit)
            (incompatible fajitas_verdures sopa_de_peix)
            (incompatible verdures_a_la_planxa sopa_ajo)
            (incompatible verdures_a_la_planxa xai_rostit)
            (incompatible amanida_de_cogombre xai_rostit)
            (incompatible crema_de_carbassa llenguado_amb_lima)
            (incompatible fajitas_verdures xai_rostit)
  )

  (:goal
    (forall (?d - dia)
      (and (primerAsignat ?d) (segonAsignat ?d)))
  )
)