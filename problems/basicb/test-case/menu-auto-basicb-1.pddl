      (define (problem menu-basicb-1)
        (:domain menubasicb)

          (:objects
  dilluns dimarts dimecres dijous divendres - dia
  cigrons_saltejats crema_de_carbassa amanida_catalana sopa_de_marisc sopa_de_cigrons estofat_llenties crema_de_carabasso escalivada_verdures amanida_de_tomaquet macarrons_forn sopa_de_peix verdures_a_la_planxa - primer
  amanida_cesar amanida_de_espinacs sopa_de_pedra sopa_de_galets bacalla_amb_tomate parrillada_verdures salmo_grillat truita_verdures xai_rostit crema_catalana faves_estofades espaguetis_marisc - segon
)

        (:init
      (incompatible cigrons_saltejats bacalla_amb_tomate)
      (incompatible cigrons_saltejats salmo_grillat)
      (incompatible cigrons_saltejats espaguetis_marisc)
      (incompatible crema_de_carbassa bacalla_amb_tomate)
      (incompatible crema_de_carbassa salmo_grillat)
      (incompatible crema_de_carbassa xai_rostit)
      (incompatible amanida_catalana bacalla_amb_tomate)
      (incompatible amanida_catalana salmo_grillat)
      (incompatible amanida_catalana xai_rostit)
      (incompatible sopa_de_marisc parrillada_verdures)
      (incompatible sopa_de_marisc truita_verdures)
      (incompatible sopa_de_marisc espaguetis_marisc)
      (incompatible sopa_de_cigrons parrillada_verdures)
      (incompatible sopa_de_cigrons truita_verdures)
      (incompatible sopa_de_cigrons espaguetis_marisc)
      (incompatible estofat_llenties bacalla_amb_tomate)
      (incompatible estofat_llenties salmo_grillat)
      (incompatible estofat_llenties espaguetis_marisc)
      (incompatible crema_de_carabasso bacalla_amb_tomate)
      (incompatible crema_de_carabasso salmo_grillat)
      (incompatible crema_de_carabasso xai_rostit)
      (incompatible escalivada_verdures sopa_de_pedra)
      (incompatible escalivada_verdures sopa_de_galets)
      (incompatible escalivada_verdures xai_rostit)
      (incompatible amanida_de_tomaquet bacalla_amb_tomate)
      (incompatible amanida_de_tomaquet salmo_grillat)
      (incompatible amanida_de_tomaquet xai_rostit)
      (incompatible macarrons_forn amanida_cesar)
      (incompatible macarrons_forn amanida_de_espinacs)
      (incompatible macarrons_forn crema_catalana)
      (incompatible sopa_de_peix parrillada_verdures)
      (incompatible sopa_de_peix truita_verdures)
      (incompatible sopa_de_peix espaguetis_marisc)
      (incompatible verdures_a_la_planxa sopa_de_pedra)
      (incompatible verdures_a_la_planxa sopa_de_galets)
      (incompatible verdures_a_la_planxa xai_rostit)
        )

          (:goal
    (forall (?d - dia) (diaAmbMenuAsignat ?d))
)

      )