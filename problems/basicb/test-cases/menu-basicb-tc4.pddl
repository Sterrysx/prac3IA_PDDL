(define (problem menubasicb-tc4)
  (:domain menubasicb)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    penne_arrabiata estofat_llenties sopa_de_cigrons amanida_quinoa cigrons_saltejats verdures_amb_salsa sopa_miso macarrons_forn crema_espinacs gnocchi_pesto - primer
    hamburguesa_mongeta crema_de_limon sopa_de_pedra estofat_soja sopa_de_peix crema_avellana estofat_cigrons sopa_ceba parrillada_verdures salmo_grillat  - segon
  )

  (:init
    (incompatible penne_arrabiata crema_avellana)
            (incompatible gnocchi_pesto crema_avellana)
            (incompatible penne_arrabiata crema_de_limon)
            (incompatible sopa_de_cigrons parrillada_verdures)
            (incompatible estofat_llenties salmo_grillat)
            (incompatible macarrons_forn crema_de_limon)
            (incompatible amanida_quinoa salmo_grillat)
            (incompatible verdures_amb_salsa sopa_de_peix)
  )

  (:goal
    (forall (?d - dia)
      (diaAmbMenuAsignat ?d))
  )
)