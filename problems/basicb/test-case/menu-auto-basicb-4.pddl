      (define (problem menu-basicb-4)
        (:domain menubasicb)

          (:objects
  dilluns dimarts dimecres dijous divendres - dia
  verdures_a_la_planxa cigrons_saltejats amanida_de_tomaquet estofat_llenties crema_de_carxofa llobarro_forn sopa_de_cigrons escalivada_verdures botifarra_brasa sopa_de_peix crema_de_carabasso tallarins_carbonara - primer
  tataki_verdures salmo_grillat sopa_de_galets pennes_amb_pesto amanida_de_remolatxa truita_verdures truita_de_llenties faves_estofades pollastre_a_la_planxa crema_de_limon parrillada_verdures crema_catalana - segon
)

        (:init
      (incompatible verdures_a_la_planxa sopa_de_galets)
      (incompatible verdures_a_la_planxa pollastre_a_la_planxa)
      (incompatible cigrons_saltejats salmo_grillat)
      (incompatible cigrons_saltejats pennes_amb_pesto)
      (incompatible amanida_de_tomaquet salmo_grillat)
      (incompatible amanida_de_tomaquet pollastre_a_la_planxa)
      (incompatible estofat_llenties salmo_grillat)
      (incompatible estofat_llenties pennes_amb_pesto)
      (incompatible crema_de_carxofa salmo_grillat)
      (incompatible crema_de_carxofa pollastre_a_la_planxa)
      (incompatible llobarro_forn pollastre_a_la_planxa)
      (incompatible llobarro_forn crema_de_limon)
      (incompatible llobarro_forn crema_catalana)
      (incompatible sopa_de_cigrons tataki_verdures)
      (incompatible sopa_de_cigrons pennes_amb_pesto)
      (incompatible sopa_de_cigrons truita_verdures)
      (incompatible sopa_de_cigrons parrillada_verdures)
      (incompatible escalivada_verdures sopa_de_galets)
      (incompatible escalivada_verdures pollastre_a_la_planxa)
      (incompatible botifarra_brasa tataki_verdures)
      (incompatible botifarra_brasa sopa_de_galets)
      (incompatible botifarra_brasa truita_verdures)
      (incompatible botifarra_brasa parrillada_verdures)
      (incompatible sopa_de_peix tataki_verdures)
      (incompatible sopa_de_peix pennes_amb_pesto)
      (incompatible sopa_de_peix truita_verdures)
      (incompatible sopa_de_peix parrillada_verdures)
      (incompatible crema_de_carabasso salmo_grillat)
      (incompatible crema_de_carabasso pollastre_a_la_planxa)
      (incompatible tallarins_carbonara amanida_de_remolatxa)
      (incompatible tallarins_carbonara crema_de_limon)
      (incompatible tallarins_carbonara crema_catalana)
        )

          (:goal
    (forall (?d - dia) (diaAmbMenuAsignat ?d))
)

      )