(define (problem menuext1b-tc3)
  (:domain menuext1b)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    sopa_de_peix brocoli_allada sopa_de_marisc hummus cigrons_saltejats amanida_de_tomaquet amanida_catalana penne_arrabiata macarrons_forn sopa_verdures - primer
    parrillada_verdures pollastre_a_la_planxa hamburguesa_mongeta estofat_soja llenguado_amb_lima filet_porc crema_taronja wok_verdures tataki_verdures orata_forno  - segon
  )

  (:init
    (incompatible sopa_verdures wok_verdures)
            (incompatible sopa_de_peix wok_verdures)
            (incompatible sopa_de_marisc parrillada_verdures)
            (incompatible amanida_de_tomaquet filet_porc)
            (incompatible amanida_catalana llenguado_amb_lima)
            (incompatible cigrons_saltejats orata_forno)
            (incompatible hummus orata_forno)
            (incompatible amanida_de_tomaquet pollastre_a_la_planxa)
  )

  (:goal
    (forall (?d - dia)
      (and (primerAsignat ?d) (segonAsignat ?d)))
  )
)