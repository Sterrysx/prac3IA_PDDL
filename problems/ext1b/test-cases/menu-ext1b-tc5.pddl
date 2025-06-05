(define (problem menuext1b-tc5)
  (:domain menuext1b)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    macarrons_forn amanida_de_tomaquet crema_de_bolets truita_potatge verdures_a_la_planxa amanida_fasols sopa_verdures gnocchi_pesto crema_espinacs sopa_de_marisc - primer
    crema_de_limon tataki_verdures estofat_soja curry_verdures sopa_ceba hamburguesa_mongeta filet_porc turbot_planxa truita_verdures llenguado_amb_lima  - segon
  )

  (:init
    (incompatible sopa_de_marisc curry_verdures)
            (incompatible sopa_verdures curry_verdures)
            (incompatible amanida_de_tomaquet llenguado_amb_lima)
            (incompatible truita_potatge llenguado_amb_lima)
            (incompatible amanida_fasols llenguado_amb_lima)
            (incompatible crema_espinacs filet_porc)
            (incompatible verdures_a_la_planxa filet_porc)
            (incompatible crema_espinacs turbot_planxa)
  )

  (:goal
    (forall (?d - dia)
      (and (primerAsignat ?d) (segonAsignat ?d)))
  )
)