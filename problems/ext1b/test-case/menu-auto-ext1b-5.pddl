      (define (problem menu-ext1b-5)
        (:domain menuext1b)

          (:objects
  dilluns dimarts dimecres dijous divendres - dia
  sopa_de_cigrons amanida_de_tomaquet amanida_de_cogombre tallarins_carbonara escalivada_verdures tataki_salmo verdures_amb_salsa sopa_de_marisc ceviche_tonyina crema_de_carbassa hummus estofat_llenties - primer
  parrillada_verdures estofat_cigrons tataki_verdures llenguado_amb_lima sopa_de_galets faves_estofades xai_rostit sopa_de_pedra crema_catalana amanida_de_remolatxa pennes_amb_pesto bacalla_amb_tomate - segon
)

        (:init
      (incompatible sopa_de_cigrons parrillada_verdures)
      (incompatible sopa_de_cigrons tataki_verdures)
      (incompatible sopa_de_cigrons pennes_amb_pesto)
      (incompatible amanida_de_tomaquet llenguado_amb_lima)
      (incompatible amanida_de_tomaquet xai_rostit)
      (incompatible amanida_de_tomaquet bacalla_amb_tomate)
      (incompatible amanida_de_cogombre llenguado_amb_lima)
      (incompatible amanida_de_cogombre xai_rostit)
      (incompatible amanida_de_cogombre bacalla_amb_tomate)
      (incompatible tallarins_carbonara crema_catalana)
      (incompatible tallarins_carbonara amanida_de_remolatxa)
      (incompatible escalivada_verdures sopa_de_galets)
      (incompatible escalivada_verdures xai_rostit)
      (incompatible escalivada_verdures sopa_de_pedra)
      (incompatible tataki_salmo xai_rostit)
      (incompatible tataki_salmo crema_catalana)
      (incompatible verdures_amb_salsa sopa_de_galets)
      (incompatible verdures_amb_salsa xai_rostit)
      (incompatible verdures_amb_salsa sopa_de_pedra)
      (incompatible sopa_de_marisc parrillada_verdures)
      (incompatible sopa_de_marisc tataki_verdures)
      (incompatible sopa_de_marisc pennes_amb_pesto)
      (incompatible ceviche_tonyina xai_rostit)
      (incompatible ceviche_tonyina crema_catalana)
      (incompatible crema_de_carbassa llenguado_amb_lima)
      (incompatible crema_de_carbassa xai_rostit)
      (incompatible crema_de_carbassa bacalla_amb_tomate)
      (incompatible hummus llenguado_amb_lima)
      (incompatible hummus pennes_amb_pesto)
      (incompatible hummus bacalla_amb_tomate)
      (incompatible estofat_llenties llenguado_amb_lima)
      (incompatible estofat_llenties pennes_amb_pesto)
      (incompatible estofat_llenties bacalla_amb_tomate)
        )

          (:goal (and
  (forall (?d - dia)
    (and (primerAsignat ?d) (segonAsignat ?d))
  )))

      )