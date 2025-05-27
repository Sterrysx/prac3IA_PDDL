
(define (problem menu-auto-ext3-3)
  (:domain menu-setmanal)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    carn llegums pasta peix sopa - tipus
    estofat_llenties macarrons_forn raviolis_ricotta sopa_de_cigrons tallarins_carbonara  - primer
    estofat_cigrons faves_estofades llenguado_amb_lima pennes_amb_pesto xai_rostit   - segon)

  (:init
    (dia-seguent dilluns dimarts)
(dia-seguent dimarts dimecres)
(dia-seguent dimecres dijous)
(dia-seguent dijous divendres)
(plat-tipus tallarins_carbonara pasta)
(plat-tipus sopa_de_cigrons sopa)
(plat-tipus macarrons_forn pasta)
(plat-tipus estofat_llenties llegums)
(plat-tipus raviolis_ricotta pasta)
(plat-tipus faves_estofades llegums)
(plat-tipus llenguado_amb_lima peix)
(plat-tipus estofat_cigrons llegums)
(plat-tipus xai_rostit carn)
(plat-tipus pennes_amb_pesto pasta)
(tipus-primer-anterior carn)
(tipus-segon-anterior  carn)
(dia-actual dilluns)
(necessita-primer dilluns)
(necessita-primer dimarts)
(necessita-primer dimecres)
(necessita-primer dijous)
(necessita-primer divendres)
(primer-obligatori dijous estofat_llenties)
(primer-obligatori dimecres macarrons_forn))

  (:goal (planificacio-completa))

)
