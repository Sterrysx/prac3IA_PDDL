(define (problem menubasicb-tc3)
  (:domain menubasicb)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    tallarins_carbonara crema_de_carxofa gnocchi_pesto hummus sopa_miso sopa_de_cigrons sopa_de_marisc sopa_verdures crema_de_bolets truita_potatge - primer
    hamburguesa_mongeta cuixa_anec truita_de_llenties bacalla_amb_tomaquet estofat_cigrons parrillada_verdures estofat_soja xai_rostit crema_de_xocolata wok_verdures  - segon
  )

  (:init
    (incompatible hummus bacalla_amb_tomaquet)
            (incompatible sopa_miso wok_verdures)
            (incompatible crema_de_carxofa bacalla_amb_tomaquet)
            (incompatible crema_de_bolets cuixa_anec)
            (incompatible crema_de_carxofa xai_rostit)
            (incompatible tallarins_carbonara crema_de_xocolata)
            (incompatible sopa_verdures parrillada_verdures)
            (incompatible crema_de_bolets bacalla_amb_tomaquet)
  )

  (:goal
    (forall (?d - dia)
      (diaAmbMenuAsignat ?d))
  )
)