(define (problem menubasicb-tc1)
  (:domain menubasicb)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    crema_de_carbassa raviolis_ricotta escalivada_verdures sopa_verdures sopa_de_peix macarrons_forn gnocchi_pesto fajitas_verdures sopa_de_cigrons crema_de_bolets - primer
    pollastre_a_la_planxa parrillada_verdures xai_rostit cuixa_ànec crema_avellana hamburguesa_mongeta filet_porc sopa_ajo estofat_soja llenguado_amb_lima  - segon
  )

  (:init
    (incompatible crema_de_bolets filet_porc)
            (incompatible crema_de_carbassa pollastre_a_la_planxa)
            (incompatible escalivada_verdures filet_porc)
            (incompatible crema_de_carbassa llenguado_amb_lima)
            (incompatible crema_de_bolets xai_rostit)
            (incompatible sopa_verdures parrillada_verdures)
            (incompatible escalivada_verdures xai_rostit)
            (incompatible escalivada_verdures cuixa_ànec)
  )

  (:goal
    (forall (?d - dia)
      (diaAmbMenuAsignat ?d))
  )
)