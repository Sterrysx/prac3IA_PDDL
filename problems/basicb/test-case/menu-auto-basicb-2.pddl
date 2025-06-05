      (define (problem menu-basicb-2)
        (:domain menubasicb)

          (:objects
  dilluns dimarts dimecres dijous divendres - dia
  sopa_de_marisc amanida_catalana crema_de_carxofa carpaccio_vedella tallarins_carbonara verdures_amb_salsa crema_de_carabasso sopa_de_peix estofat_llenties amanida_de_cogombre botifarra_brasa tataki_salmo - primer
  crema_catalana tortellinis_carne tataki_verdures truita_de_llenties sopa_de_peix amanida_de_remolatxa botifarra_a_la_planxa parrillada_verdures pollastre_a_la_planxa estofat_cigrons faves_estofades crema_de_limon - segon
)

        (:init
      (incompatible sopa_de_marisc tortellinis_carne)
      (incompatible sopa_de_marisc tataki_verdures)
      (incompatible sopa_de_marisc parrillada_verdures)
      (incompatible amanida_catalana botifarra_a_la_planxa)
      (incompatible amanida_catalana pollastre_a_la_planxa)
      (incompatible crema_de_carxofa botifarra_a_la_planxa)
      (incompatible crema_de_carxofa pollastre_a_la_planxa)
      (incompatible carpaccio_vedella tataki_verdures)
      (incompatible carpaccio_vedella sopa_de_peix)
      (incompatible carpaccio_vedella parrillada_verdures)
      (incompatible tallarins_carbonara crema_catalana)
      (incompatible tallarins_carbonara amanida_de_remolatxa)
      (incompatible tallarins_carbonara crema_de_limon)
      (incompatible verdures_amb_salsa sopa_de_peix)
      (incompatible verdures_amb_salsa botifarra_a_la_planxa)
      (incompatible verdures_amb_salsa pollastre_a_la_planxa)
      (incompatible crema_de_carabasso botifarra_a_la_planxa)
      (incompatible crema_de_carabasso pollastre_a_la_planxa)
      (incompatible sopa_de_peix tortellinis_carne)
      (incompatible sopa_de_peix tataki_verdures)
      (incompatible sopa_de_peix parrillada_verdures)
      (incompatible estofat_llenties tortellinis_carne)
      (incompatible amanida_de_cogombre botifarra_a_la_planxa)
      (incompatible amanida_de_cogombre pollastre_a_la_planxa)
      (incompatible botifarra_brasa tataki_verdures)
      (incompatible botifarra_brasa sopa_de_peix)
      (incompatible botifarra_brasa parrillada_verdures)
      (incompatible tataki_salmo crema_catalana)
      (incompatible tataki_salmo botifarra_a_la_planxa)
      (incompatible tataki_salmo pollastre_a_la_planxa)
      (incompatible tataki_salmo crema_de_limon)
        )

          (:goal
    (forall (?d - dia) (diaAmbMenuAsignat ?d))
)

      )