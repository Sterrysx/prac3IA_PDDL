(define (problem menu-ext1b-1)
        (:domain menuext1b)

          (:objects
  dilluns dimarts dimecres dijous divendres - dia
  amanida_fasols penne_arrabiata sopa_miso fajitas_verdures sopa_de_marisc sopa_de_cigrons crema_de_carxofa amanida_quinoa tallarins_carbonara macarrons_forn amanida_de_tomaquet amanida_de_cogombre - primer
  parrillada_verdures crema_taronja crema_avellana estofat_cigrons sopa_de_pedra truita_de_llenties filet_porc turbot_planxa crema_de_xocolata botifarra_a_la_planxa tataki_verdures cuixa_ànec - segon
)

        (:init
  (incompatible amanida_fasols turbot_planxa)
  (incompatible penne_arrabiata crema_taronja)
  (incompatible penne_arrabiata crema_avellana)
  (incompatible penne_arrabiata crema_de_xocolata)
  (incompatible sopa_miso parrillada_verdures)
  (incompatible sopa_miso tataki_verdures)
  (incompatible fajitas_verdures sopa_de_pedra)
  (incompatible fajitas_verdures filet_porc)
  (incompatible fajitas_verdures botifarra_a_la_planxa)
  (incompatible fajitas_verdures cuixa_ànec)
  (incompatible sopa_de_marisc parrillada_verdures)
  (incompatible sopa_de_marisc tataki_verdures)
  (incompatible sopa_de_cigrons parrillada_verdures)
  (incompatible sopa_de_cigrons tataki_verdures)
  (incompatible crema_de_carxofa filet_porc)
  (incompatible crema_de_carxofa turbot_planxa)
  (incompatible crema_de_carxofa botifarra_a_la_planxa)
  (incompatible crema_de_carxofa cuixa_ànec)
  (incompatible amanida_quinoa filet_porc)
  (incompatible amanida_quinoa turbot_planxa)
  (incompatible amanida_quinoa botifarra_a_la_planxa)
  (incompatible amanida_quinoa cuixa_ànec)
  (incompatible tallarins_carbonara crema_taronja)
  (incompatible tallarins_carbonara crema_avellana)
  (incompatible tallarins_carbonara crema_de_xocolata)
  (incompatible macarrons_forn crema_taronja)
  (incompatible macarrons_forn crema_avellana)
  (incompatible macarrons_forn crema_de_xocolata)
  (incompatible amanida_de_tomaquet filet_porc)
  (incompatible amanida_de_tomaquet turbot_planxa)
  (incompatible amanida_de_tomaquet botifarra_a_la_planxa)
  (incompatible amanida_de_tomaquet cuixa_ànec)
  (incompatible amanida_de_cogombre filet_porc)
  (incompatible amanida_de_cogombre turbot_planxa)
  (incompatible amanida_de_cogombre botifarra_a_la_planxa)
  (incompatible amanida_de_cogombre cuixa_ànec)
        )

          (:goal (and
  (forall (?d - dia)
    (and (primerAsignat ?d) (segonAsignat ?d))
  )))

      )