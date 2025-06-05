(define (problem menuext1b-tc4)
  (:domain menuext1b)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    amanida_catalana sopa_de_marisc crema_de_carabasso cigrons_saltejats penne_arrabiata sopa_de_cigrons crema_de_carbassa truita_potatge raviolis_ricotta amanida_quinoa - primer
    faves_estofades truita_de_llenties crema_de_limon sopa_de_galets truita_verdures parrillada_verdures cuixa_ànec llenguado_amb_lima filet_porc estofat_soja  - segon
  )

  (:init
    (incompatible crema_de_carbassa filet_porc)
            (incompatible amanida_catalana cuixa_ànec)
            (incompatible crema_de_carbassa llenguado_amb_lima)
            (incompatible penne_arrabiata crema_de_limon)
            (incompatible crema_de_carbassa cuixa_ànec)
            (incompatible amanida_quinoa llenguado_amb_lima)
            (incompatible amanida_catalana llenguado_amb_lima)
            (incompatible sopa_de_cigrons parrillada_verdures)
  )

  (:goal
    (forall (?d - dia)
      (and (primerAsignat ?d) (segonAsignat ?d)))
  )
)