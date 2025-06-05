      (define (problem menu-ext1b-1)
        (:domain menuext1b)

          (:objects
  dilluns dimarts dimecres dijous divendres - dia
  amanida_de_tomaquet amanida_de_cogombre crema_de_carbassa crema_de_carabasso crema_de_carxofa carpaccio_vedella verdures_amb_salsa croquetes_carn tataki_salmo macarrons_forn sopa_de_cigrons sopa_de_marisc - primer
  sopa_de_peix salmo_grillat amanida_cesar crema_catalana tataki_verdures parrillada_verdures pennes_amb_pesto faves_estofades espaguetis_marisc sopa_de_pedra amanida_de_espinacs sopa_de_galets - segon
)

        (:init
      (incompatible amanida_de_tomaquet salmo_grillat)
      (incompatible amanida_de_cogombre salmo_grillat)
      (incompatible crema_de_carbassa salmo_grillat)
      (incompatible crema_de_carabasso salmo_grillat)
      (incompatible crema_de_carxofa salmo_grillat)
      (incompatible carpaccio_vedella sopa_de_peix)
      (incompatible carpaccio_vedella tataki_verdures)
      (incompatible carpaccio_vedella parrillada_verdures)
      (incompatible carpaccio_vedella sopa_de_pedra)
      (incompatible carpaccio_vedella sopa_de_galets)
      (incompatible verdures_amb_salsa sopa_de_peix)
      (incompatible verdures_amb_salsa sopa_de_pedra)
      (incompatible verdures_amb_salsa sopa_de_galets)
      (incompatible croquetes_carn sopa_de_peix)
      (incompatible croquetes_carn tataki_verdures)
      (incompatible croquetes_carn parrillada_verdures)
      (incompatible croquetes_carn sopa_de_pedra)
      (incompatible croquetes_carn sopa_de_galets)
      (incompatible tataki_salmo crema_catalana)
      (incompatible macarrons_forn amanida_cesar)
      (incompatible macarrons_forn crema_catalana)
      (incompatible macarrons_forn amanida_de_espinacs)
      (incompatible sopa_de_cigrons tataki_verdures)
      (incompatible sopa_de_cigrons parrillada_verdures)
      (incompatible sopa_de_cigrons pennes_amb_pesto)
      (incompatible sopa_de_cigrons espaguetis_marisc)
      (incompatible sopa_de_marisc tataki_verdures)
      (incompatible sopa_de_marisc parrillada_verdures)
      (incompatible sopa_de_marisc pennes_amb_pesto)
      (incompatible sopa_de_marisc espaguetis_marisc)
        )

          (:goal (and
  (forall (?d - dia)
    (and (primerAsignat ?d) (segonAsignat ?d))
  )))

      )