(define (problem menuext1b-tc1)
  (:domain menuext1b)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    amanida_catalana sopa_verdures verdures_a_la_planxa penne_arrabiata tallarins_carbonara sopa_de_marisc gnocchi_pesto crema_de_carbassa sopa_de_peix amanida_de_tomaquet - primer
    filet_porc truita_de_llenties sopa_de_peix parrillada_verdures truita_verdures bacalla_amb_tomate curry_verdures estofat_cigrons llenguado_amb_lima sopa_ajo  - segon
  )

  (:init
    (incompatible crema_de_carbassa llenguado_amb_lima)
            (incompatible crema_de_carbassa filet_porc)
            (incompatible amanida_catalana llenguado_amb_lima)
            (incompatible sopa_de_peix parrillada_verdures)
            (incompatible amanida_catalana filet_porc)
            (incompatible amanida_de_tomaquet filet_porc)
            (incompatible verdures_a_la_planxa sopa_de_peix)
            (incompatible verdures_a_la_planxa filet_porc)
  )

  (:goal
    (forall (?d - dia)
      (and (primerAsignat ?d) (segonAsignat ?d)))
  )
)