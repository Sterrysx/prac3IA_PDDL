(define (problem menubasicb-tc2)
  (:domain menubasicb)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    hummus estofat_llenties brocoli_allada escalivada_verdures amanida_asiatica cigrons_saltejats verdures_amb_salsa crema_de_bolets amanida_fasols raviolis_ricotta - primer
    salmo_grillat crema_de_limon crema_avellana crema_taronja cuixa_anec orata_forno wok_verdures sopa_de_galets pollastre_a_la_planxa hamburguesa_mongeta  - segon
  )

  (:init
    (incompatible raviolis_ricotta crema_avellana)
            (incompatible escalivada_verdures pollastre_a_la_planxa)
            (incompatible crema_de_bolets salmo_grillat)
            (incompatible verdures_amb_salsa pollastre_a_la_planxa)
            (incompatible brocoli_allada sopa_de_galets)
            (incompatible amanida_fasols salmo_grillat)
            (incompatible brocoli_allada cuixa_anec)
            (incompatible amanida_asiatica cuixa_anec)
  )

  (:goal
    (forall (?d - dia)
      (diaAmbMenuAsignat ?d))
  )
)