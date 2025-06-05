(define (problem menubasicb-tc4)
  (:domain menubasicb)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    hummus penne_arrabiata amanida_catalana crema_de_carxofa sopa_verdures raviolis_ricotta tallarins_carbonara escalivada_verdures sopa_miso crema_de_carbassa - primer
    sopa_de_peix curry_verdures crema_de_limon crema_taronja estofat_cigrons parrillada_verdures truita_de_llenties bacalla_amb_tomaquet estofat_soja hamburguesa_mongeta  - segon
  )

  (:init
    (incompatible tallarins_carbonara crema_de_limon)
            (incompatible sopa_verdures curry_verdures)
            (incompatible sopa_miso parrillada_verdures)
            (incompatible sopa_miso curry_verdures)
            (incompatible penne_arrabiata crema_de_limon)
            (incompatible raviolis_ricotta crema_de_limon)
            (incompatible penne_arrabiata crema_taronja)
            (incompatible raviolis_ricotta crema_taronja)
  )

  (:goal
    (forall (?d - dia)
      (diaAmbMenuAsignat ?d))
  )
)