(define (problem menuext1b-tc3)
  (:domain menuext1b)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    tallarins_carbonara gnocchi_pesto sopa_de_cigrons estofat_llenties sopa_verdures macarrons_forn sopa_miso crema_de_carxofa amanida_fasols amanida_quinoa - primer
    crema_de_xocolata salmo_grillat faves_estofades cuixa_anec sopa_ceba llenguado_amb_lima botifarra_a_la_planxa turbot_planxa estofat_soja estofat_cigrons  - segon
  )

  (:init
    (incompatible amanida_fasols salmo_grillat)
            (incompatible amanida_fasols llenguado_amb_lima)
            (incompatible crema_de_carxofa turbot_planxa)
            (incompatible crema_de_carxofa llenguado_amb_lima)
            (incompatible estofat_llenties salmo_grillat)
            (incompatible amanida_quinoa botifarra_a_la_planxa)
            (incompatible crema_de_carxofa salmo_grillat)
            (incompatible macarrons_forn crema_de_xocolata)
  )

  (:goal
    (forall (?d - dia)
      (and (primerAsignat ?d) (segonAsignat ?d)))
  )
)