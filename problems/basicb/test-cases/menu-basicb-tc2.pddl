(define (problem menubasicb-tc2)
  (:domain menubasicb)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    estofat_llenties crema_espinacs tallarins_carbonara escalivada_verdures sopa_verdures brocoli_allada amanida_de_tomaquet verdures_a_la_planxa amanida_catalana verdures_amb_salsa - primer
    tataki_verdures truita_verdures xai_rostit crema_de_limon sopa_ajo truita_de_llenties orata_forno salmo_grillat estofat_cigrons crema_avellana  - segon
  )

  (:init
    (incompatible sopa_verdures truita_verdures)
            (incompatible tallarins_carbonara crema_avellana)
            (incompatible crema_espinacs salmo_grillat)
            (incompatible amanida_de_tomaquet orata_forno)
            (incompatible crema_espinacs xai_rostit)
            (incompatible brocoli_allada sopa_ajo)
            (incompatible escalivada_verdures xai_rostit)
            (incompatible crema_espinacs orata_forno)
  )

  (:goal
    (forall (?d - dia)
      (diaAmbMenuAsignat ?d))
  )
)