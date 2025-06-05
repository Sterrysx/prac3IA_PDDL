(define (problem menubasicb-tc1)
  (:domain menubasicb)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    sopa_de_cigrons truita_potatge sopa_de_marisc crema_espinacs escalivada_verdures crema_de_carbassa amanida_quinoa crema_de_carxofa fajitas_verdures amanida_fasols - primer
    sopa_ajo filet_porc orata_forno sopa_ceba llenguado_amb_lima crema_catalana crema_avellana bacalla_amb_tomaquet sopa_de_galets cuixa_anec  - segon
  )

  (:init
    (incompatible fajitas_verdures cuixa_anec)
            (incompatible amanida_quinoa orata_forno)
            (incompatible escalivada_verdures sopa_ajo)
            (incompatible amanida_quinoa cuixa_anec)
            (incompatible crema_espinacs cuixa_anec)
            (incompatible crema_de_carxofa bacalla_amb_tomaquet)
            (incompatible escalivada_verdures cuixa_anec)
            (incompatible fajitas_verdures sopa_ajo)
  )

  (:goal
    (forall (?d - dia)
      (diaAmbMenuAsignat ?d))
  )
)