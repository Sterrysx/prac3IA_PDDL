
(define (problem menu-auto-ext2-5)
  (:domain menu-setmanal)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    amanida carn crema llegums pasta peix sopa - tipus
    carpaccio_vedella crema_de_carabasso hummus macarrons_forn sopa_de_marisc  - primer
    amanida_de_remolatxa botifarra_a_la_planxa crema_de_limon sopa_de_peix xai_rostit   - segon)

  (:init
    (dia-seguent dilluns dimarts)
(dia-seguent dimarts dimecres)
(dia-seguent dimecres dijous)
(dia-seguent dijous divendres)
(plat-tipus crema_de_carabasso crema)
(plat-tipus macarrons_forn pasta)
(plat-tipus sopa_de_marisc sopa)
(plat-tipus carpaccio_vedella carn)
(plat-tipus hummus llegums)
(plat-tipus amanida_de_remolatxa amanida)
(plat-tipus sopa_de_peix sopa)
(plat-tipus botifarra_a_la_planxa carn)
(plat-tipus crema_de_limon crema)
(plat-tipus xai_rostit carn)
(tipus-primer-anterior pasta)
(tipus-segon-anterior  peix)
(dia-actual dilluns)
(necessita-primer dilluns)
(necessita-primer dimarts)
(necessita-primer dimecres)
(necessita-primer dijous)
(necessita-primer divendres))

  (:goal (planificacio-completa))

)
