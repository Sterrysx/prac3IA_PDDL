(define (problem menuext1b-tc5)
  (:domain menuext1b)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    cigrons_saltejats brocoli_allada verdures_amb_salsa crema_espinacs amanida_de_cogombre sopa_miso macarrons_forn truita_potatge fajitas_verdures amanida_asiatica - primer
    parrillada_verdures hamburguesa_mongeta sopa_de_galets tataki_verdures sopa_ajo cuixa_ànec sopa_de_peix crema_taronja wok_verdures crema_avellana  - segon
  )

  (:init
    (incompatible fajitas_verdures sopa_de_peix)
            (incompatible brocoli_allada cuixa_ànec)
            (incompatible brocoli_allada sopa_ajo)
            (incompatible verdures_amb_salsa cuixa_ànec)
            (incompatible brocoli_allada sopa_de_peix)
            (incompatible sopa_miso parrillada_verdures)
            (incompatible amanida_de_cogombre cuixa_ànec)
            (incompatible macarrons_forn crema_taronja)
  )

  (:goal
    (forall (?d - dia)
      (and (primerAsignat ?d) (segonAsignat ?d)))
  )
)