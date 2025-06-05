(define (problem menuext1b-tc3)
  (:domain menuext1b)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    sopa_miso amanida_quinoa raviolis_ricotta tallarins_carbonara amanida_asiatica amanida_de_tomaquet amanida_fasols crema_espinacs crema_de_carabasso amanida_de_cogombre - primer
    sopa_de_galets sopa_de_peix parrillada_verdures xai_rostit cuixa_ànec estofat_soja wok_verdures estofat_cigrons orata_forno curry_verdures  - segon
  )

  (:init
    (incompatible amanida_de_cogombre orata_forno)
            (incompatible crema_de_carabasso cuixa_ànec)
            (incompatible amanida_de_tomaquet xai_rostit)
            (incompatible crema_de_carabasso orata_forno)
            (incompatible amanida_asiatica xai_rostit)
            (incompatible amanida_quinoa cuixa_ànec)
            (incompatible amanida_quinoa xai_rostit)
            (incompatible sopa_miso wok_verdures)
  )

  (:goal
    (forall (?d - dia)
      (and (primerAsignat ?d) (segonAsignat ?d)))
  )
)