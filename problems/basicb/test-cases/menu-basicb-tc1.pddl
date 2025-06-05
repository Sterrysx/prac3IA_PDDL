(define (problem menubasicb-tc1)
  (:domain menubasicb)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    sopa_de_marisc amanida_quinoa macarrons_forn escalivada_verdures sopa_de_cigrons sopa_miso cigrons_saltejats crema_de_carxofa crema_espinacs fajitas_verdures - primer
    pollastre_a_la_planxa filet_porc sopa_ajo sopa_de_galets estofat_soja orata_forno tataki_verdures parrillada_verdures truita_verdures cuixa_anec  - segon
  )

  (:init
    (incompatible sopa_de_marisc parrillada_verdures)
            (incompatible sopa_de_cigrons parrillada_verdures)
            (incompatible amanida_quinoa cuixa_anec)
            (incompatible crema_espinacs orata_forno)
            (incompatible crema_de_carxofa filet_porc)
            (incompatible fajitas_verdures pollastre_a_la_planxa)
            (incompatible escalivada_verdures pollastre_a_la_planxa)
            (incompatible amanida_quinoa filet_porc)
  )

  (:goal
    (forall (?d - dia)
      (diaAmbMenuAsignat ?d))
  )
)