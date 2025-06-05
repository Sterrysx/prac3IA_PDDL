(define (problem menuext1b-tc2)
  (:domain menuext1b)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    hummus crema_de_carxofa penne_arrabiata gnocchi_pesto amanida_de_tomaquet cigrons_saltejats macarrons_forn crema_espinacs tallarins_carbonara estofat_llenties - primer
    crema_de_xocolata turbot_planxa wok_verdures pollastre_a_la_planxa filet_porc truita_verdures sopa_de_galets faves_estofades salmo_grillat botifarra_a_la_planxa  - segon
  )

  (:init
    (incompatible crema_de_carxofa turbot_planxa)
            (incompatible crema_espinacs pollastre_a_la_planxa)
            (incompatible crema_espinacs filet_porc)
            (incompatible amanida_de_tomaquet pollastre_a_la_planxa)
            (incompatible hummus salmo_grillat)
            (incompatible estofat_llenties salmo_grillat)
            (incompatible estofat_llenties turbot_planxa)
            (incompatible crema_de_carxofa pollastre_a_la_planxa)
  )

  (:goal
    (forall (?d - dia)
      (and (primerAsignat ?d) (segonAsignat ?d)))
  )
)