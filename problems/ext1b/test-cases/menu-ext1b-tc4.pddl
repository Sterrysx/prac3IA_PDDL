(define (problem menuext1b-tc4)
  (:domain menuext1b)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    sopa_de_marisc crema_de_carabasso crema_espinacs amanida_catalana hummus amanida_de_cogombre sopa_de_cigrons macarrons_forn crema_de_carxofa sopa_de_peix - primer
    sopa_ceba tataki_verdures llenguado_amb_lima cuixa_anec pollastre_a_la_planxa truita_verdures botifarra_a_la_planxa sopa_de_pedra truita_de_llenties sopa_de_galets  - segon
  )

  (:init
    (incompatible amanida_de_cogombre pollastre_a_la_planxa)
            (incompatible crema_espinacs llenguado_amb_lima)
            (incompatible amanida_de_cogombre cuixa_anec)
            (incompatible crema_espinacs pollastre_a_la_planxa)
            (incompatible amanida_catalana llenguado_amb_lima)
            (incompatible crema_de_carxofa botifarra_a_la_planxa)
            (incompatible crema_de_carxofa llenguado_amb_lima)
            (incompatible sopa_de_cigrons tataki_verdures)
  )

  (:goal
    (forall (?d - dia)
      (and (primerAsignat ?d) (segonAsignat ?d)))
  )
)