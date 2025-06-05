(define (problem menu-basicb-3)
        (:domain menubasicb)

          (:objects
  dilluns dimarts dimecres dijous divendres - dia
  amanida_fasols sopa_verdures raviolis_ricotta amanida_asiatica sopa_de_marisc amanida_de_tomaquet verdures_amb_salsa crema_espinacs hummus gnocchi_pesto sopa_de_cigrons penne_arrabiata - primer
  sopa_de_galets faves_estofades crema_de_xocolata crema_de_limon truita_de_llenties sopa_de_peix sopa_ajo parrillada_verdures estofat_soja crema_taronja botifarra_a_la_planxa sopa_ceba - segon
)

        (:init
  (incompatible sopa_verdures parrillada_verdures)
  (incompatible raviolis_ricotta crema_de_xocolata)
  (incompatible raviolis_ricotta crema_de_limon)
  (incompatible raviolis_ricotta crema_taronja)
  (incompatible amanida_asiatica botifarra_a_la_planxa)
  (incompatible sopa_de_marisc parrillada_verdures)
  (incompatible amanida_de_tomaquet botifarra_a_la_planxa)
  (incompatible verdures_amb_salsa sopa_de_galets)
  (incompatible verdures_amb_salsa sopa_de_peix)
  (incompatible verdures_amb_salsa sopa_ajo)
  (incompatible verdures_amb_salsa botifarra_a_la_planxa)
  (incompatible verdures_amb_salsa sopa_ceba)
  (incompatible crema_espinacs botifarra_a_la_planxa)
  (incompatible gnocchi_pesto crema_de_xocolata)
  (incompatible gnocchi_pesto crema_de_limon)
  (incompatible gnocchi_pesto crema_taronja)
  (incompatible sopa_de_cigrons parrillada_verdures)
  (incompatible penne_arrabiata crema_de_xocolata)
  (incompatible penne_arrabiata crema_de_limon)
  (incompatible penne_arrabiata crema_taronja)
        )

          ( :goal (forall (?d - dia) (diaAmbMenuAsignat ?d) ) )

      )