      (define (problem menu-basicb-5)
        (:domain menubasicb)

          (:objects
  dilluns dimarts dimecres dijous divendres - dia
  hummus escalivada_verdures tallarins_carbonara sopa_de_peix ceviche_tonyina croquetes_carn botifarra_brasa crema_de_carabasso sopa_de_marisc amanida_de_tomaquet crema_de_carbassa raviolis_ricotta - primer
  salmo_grillat parrillada_verdures sopa_de_peix estofat_cigrons xai_rostit faves_estofades pollastre_a_la_planxa tortellinis_carne sopa_de_galets amanida_de_espinacs truita_verdures llenguado_amb_lima - segon
)

        (:init
      (incompatible hummus salmo_grillat)
      (incompatible hummus tortellinis_carne)
      (incompatible hummus llenguado_amb_lima)
      (incompatible escalivada_verdures sopa_de_peix)
      (incompatible escalivada_verdures xai_rostit)
      (incompatible escalivada_verdures pollastre_a_la_planxa)
      (incompatible escalivada_verdures sopa_de_galets)
      (incompatible tallarins_carbonara amanida_de_espinacs)
      (incompatible sopa_de_peix parrillada_verdures)
      (incompatible sopa_de_peix tortellinis_carne)
      (incompatible sopa_de_peix truita_verdures)
      (incompatible ceviche_tonyina xai_rostit)
      (incompatible ceviche_tonyina pollastre_a_la_planxa)
      (incompatible croquetes_carn parrillada_verdures)
      (incompatible croquetes_carn sopa_de_peix)
      (incompatible croquetes_carn sopa_de_galets)
      (incompatible croquetes_carn truita_verdures)
      (incompatible botifarra_brasa parrillada_verdures)
      (incompatible botifarra_brasa sopa_de_peix)
      (incompatible botifarra_brasa sopa_de_galets)
      (incompatible botifarra_brasa truita_verdures)
      (incompatible crema_de_carabasso salmo_grillat)
      (incompatible crema_de_carabasso xai_rostit)
      (incompatible crema_de_carabasso pollastre_a_la_planxa)
      (incompatible crema_de_carabasso llenguado_amb_lima)
      (incompatible sopa_de_marisc parrillada_verdures)
      (incompatible sopa_de_marisc tortellinis_carne)
      (incompatible sopa_de_marisc truita_verdures)
      (incompatible amanida_de_tomaquet salmo_grillat)
      (incompatible amanida_de_tomaquet xai_rostit)
      (incompatible amanida_de_tomaquet pollastre_a_la_planxa)
      (incompatible amanida_de_tomaquet llenguado_amb_lima)
      (incompatible crema_de_carbassa salmo_grillat)
      (incompatible crema_de_carbassa xai_rostit)
      (incompatible crema_de_carbassa pollastre_a_la_planxa)
      (incompatible crema_de_carbassa llenguado_amb_lima)
      (incompatible raviolis_ricotta amanida_de_espinacs)
        )

          (:goal
    (forall (?d - dia) (diaAmbMenuAsignat ?d))
)

      )