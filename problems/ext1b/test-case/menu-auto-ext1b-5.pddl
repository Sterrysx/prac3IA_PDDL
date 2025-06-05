(define (problem menu-ext1b-5)
        (:domain menuext1b)

          (:objects
  dilluns dimarts dimecres dijous divendres - dia
  sopa_verdures fajitas_verdures tallarins_carbonara brocoli_allada amanida_asiatica crema_de_carxofa truita_potatge amanida_de_tomaquet sopa_de_peix amanida_catalana penne_arrabiata raviolis_ricotta - primer
  sopa_de_peix orata_forno wok_verdures crema_catalana crema_de_xocolata faves_estofades estofat_cigrons crema_de_limon parrillada_verdures truita_verdures estofat_soja pollastre_a_la_planxa - segon
)

        (:init
  (incompatible sopa_verdures wok_verdures)
  (incompatible sopa_verdures parrillada_verdures)
  (incompatible sopa_verdures truita_verdures)
  (incompatible fajitas_verdures sopa_de_peix)
  (incompatible fajitas_verdures pollastre_a_la_planxa)
  (incompatible tallarins_carbonara crema_catalana)
  (incompatible tallarins_carbonara crema_de_xocolata)
  (incompatible tallarins_carbonara crema_de_limon)
  (incompatible brocoli_allada sopa_de_peix)
  (incompatible brocoli_allada pollastre_a_la_planxa)
  (incompatible amanida_asiatica orata_forno)
  (incompatible amanida_asiatica pollastre_a_la_planxa)
  (incompatible crema_de_carxofa orata_forno)
  (incompatible crema_de_carxofa pollastre_a_la_planxa)
  (incompatible truita_potatge orata_forno)
  (incompatible amanida_de_tomaquet orata_forno)
  (incompatible amanida_de_tomaquet pollastre_a_la_planxa)
  (incompatible sopa_de_peix wok_verdures)
  (incompatible sopa_de_peix parrillada_verdures)
  (incompatible sopa_de_peix truita_verdures)
  (incompatible amanida_catalana orata_forno)
  (incompatible amanida_catalana pollastre_a_la_planxa)
  (incompatible penne_arrabiata crema_catalana)
  (incompatible penne_arrabiata crema_de_xocolata)
  (incompatible penne_arrabiata crema_de_limon)
  (incompatible raviolis_ricotta crema_catalana)
  (incompatible raviolis_ricotta crema_de_xocolata)
  (incompatible raviolis_ricotta crema_de_limon)
        )

          (:goal (and
  (forall (?d - dia)
    (and (primerAsignat ?d) (segonAsignat ?d))
  )))

      )