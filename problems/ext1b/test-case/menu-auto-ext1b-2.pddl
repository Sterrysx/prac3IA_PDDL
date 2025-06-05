(define (problem menu-ext1b-2)
        (:domain menuext1b)

          (:objects
  dilluns dimarts dimecres dijous divendres - dia
  tallarins_carbonara crema_de_bolets raviolis_ricotta amanida_catalana estofat_llenties amanida_fasols amanida_asiatica verdures_a_la_planxa verdures_amb_salsa fajitas_verdures sopa_de_peix truita_potatge - primer
  sopa_ajo filet_porc sopa_de_pedra cuixa_ànec crema_catalana hamburguesa_mongeta estofat_soja sopa_ceba bacalla_amb_tomate parrillada_verdures truita_de_llenties crema_taronja - segon
)

        (:init
  (incompatible tallarins_carbonara crema_catalana)
  (incompatible tallarins_carbonara crema_taronja)
  (incompatible crema_de_bolets filet_porc)
  (incompatible crema_de_bolets cuixa_ànec)
  (incompatible crema_de_bolets bacalla_amb_tomate)
  (incompatible raviolis_ricotta crema_catalana)
  (incompatible raviolis_ricotta crema_taronja)
  (incompatible amanida_catalana filet_porc)
  (incompatible amanida_catalana cuixa_ànec)
  (incompatible amanida_catalana bacalla_amb_tomate)
  (incompatible estofat_llenties bacalla_amb_tomate)
  (incompatible amanida_fasols bacalla_amb_tomate)
  (incompatible amanida_asiatica filet_porc)
  (incompatible amanida_asiatica cuixa_ànec)
  (incompatible amanida_asiatica bacalla_amb_tomate)
  (incompatible verdures_a_la_planxa sopa_ajo)
  (incompatible verdures_a_la_planxa filet_porc)
  (incompatible verdures_a_la_planxa sopa_de_pedra)
  (incompatible verdures_a_la_planxa cuixa_ànec)
  (incompatible verdures_a_la_planxa sopa_ceba)
  (incompatible verdures_amb_salsa sopa_ajo)
  (incompatible verdures_amb_salsa filet_porc)
  (incompatible verdures_amb_salsa sopa_de_pedra)
  (incompatible verdures_amb_salsa cuixa_ànec)
  (incompatible verdures_amb_salsa sopa_ceba)
  (incompatible fajitas_verdures sopa_ajo)
  (incompatible fajitas_verdures filet_porc)
  (incompatible fajitas_verdures sopa_de_pedra)
  (incompatible fajitas_verdures cuixa_ànec)
  (incompatible fajitas_verdures sopa_ceba)
  (incompatible sopa_de_peix parrillada_verdures)
  (incompatible truita_potatge bacalla_amb_tomate)
        )

          (:goal (and
  (forall (?d - dia)
    (and (primerAsignat ?d) (segonAsignat ?d))
  )))

      )