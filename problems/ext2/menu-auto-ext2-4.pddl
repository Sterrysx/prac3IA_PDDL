
(define (problem menu-auto-ext2-4)
  (:domain menu-setmanal)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    amanida carn llegums pasta peix sopa verdures - tipus
    botifarra_brasa ceviche_tonyina estofat_llenties sopa_de_peix tallarins_carbonara  - primer
    amanida_de_remolatxa bacalla_amb_tomate sopa_de_pedra truita_de_llenties truita_verdures   - segon)

  (:init
    (dia-seguent dilluns dimarts)
(dia-seguent dimarts dimecres)
(dia-seguent dimecres dijous)
(dia-seguent dijous divendres)
(plat-tipus botifarra_brasa carn)
(plat-tipus tallarins_carbonara pasta)
(plat-tipus sopa_de_peix sopa)
(plat-tipus ceviche_tonyina peix)
(plat-tipus estofat_llenties llegums)
(plat-tipus truita_de_llenties llegums)
(plat-tipus truita_verdures verdures)
(plat-tipus bacalla_amb_tomate peix)
(plat-tipus sopa_de_pedra sopa)
(plat-tipus amanida_de_remolatxa amanida)
(tipus-primer-anterior pasta)
(tipus-segon-anterior  pasta)
(dia-actual dilluns)
(necessita-primer dilluns)
(necessita-primer dimarts)
(necessita-primer dimecres)
(necessita-primer dijous)
(necessita-primer divendres))

  (:goal (planificacio-completa))

)
