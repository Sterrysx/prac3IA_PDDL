(define (problem menubasicb-tc3)
  (:domain menubasicb)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    amanida_fasols penne_arrabiata escalivada_verdures raviolis_ricotta hummus amanida_catalana amanida_asiatica fajitas_verdures truita_potatge crema_de_bolets - primer
    xai_rostit curry_verdures filet_porc crema_de_xocolata llenguado_amb_lima truita_verdures cuixa_ànec sopa_ajo bacalla_amb_tomate sopa_de_peix  - segon
  )

  (:init
    (incompatible amanida_asiatica cuixa_ànec)
            (incompatible hummus bacalla_amb_tomate)
            (incompatible fajitas_verdures filet_porc)
            (incompatible escalivada_verdures filet_porc)
            (incompatible raviolis_ricotta crema_de_xocolata)
            (incompatible amanida_catalana filet_porc)
            (incompatible fajitas_verdures cuixa_ànec)
            (incompatible truita_potatge bacalla_amb_tomate)
  )

  (:goal
    (forall (?d - dia)
      (diaAmbMenuAsignat ?d))
  )
)