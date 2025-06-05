(define (problem menubasicb-tc5)
  (:domain menubasicb)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    penne_arrabiata amanida_de_tomaquet sopa_de_marisc crema_de_bolets escalivada_verdures amanida_catalana sopa_de_cigrons macarrons_forn sopa_miso verdures_a_la_planxa - primer
    sopa_ajo filet_porc pollastre_a_la_planxa faves_estofades sopa_de_pedra curry_verdures botifarra_a_la_planxa truita_de_llenties bacalla_amb_tomaquet sopa_de_peix  - segon
  )

  (:init
    (incompatible amanida_catalana bacalla_amb_tomaquet)
            (incompatible escalivada_verdures sopa_de_pedra)
            (incompatible crema_de_bolets bacalla_amb_tomaquet)
            (incompatible verdures_a_la_planxa filet_porc)
            (incompatible verdures_a_la_planxa sopa_ajo)
            (incompatible verdures_a_la_planxa sopa_de_peix)
            (incompatible verdures_a_la_planxa botifarra_a_la_planxa)
            (incompatible escalivada_verdures sopa_ajo)
  )

  (:goal
    (forall (?d - dia)
      (diaAmbMenuAsignat ?d))
  )
)