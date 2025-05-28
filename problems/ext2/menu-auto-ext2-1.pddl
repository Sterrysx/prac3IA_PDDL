
(define (problem menu-auto-ext2-1)
  (:domain menu-setmanal)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    amanida carn llegums pasta peix sopa verdures - tipus
    amanida_de_cogombre croquetes_carn hummus llobarro_forn tataki_salmo  - primer
    espaguetis_marisc estofat_cigrons faves_estofades parrillada_verdures sopa_de_pedra   - segon)

  (:init
    (dia-seguent dilluns dimarts)
(dia-seguent dimarts dimecres)
(dia-seguent dimecres dijous)
(dia-seguent dijous divendres)
(plat-tipus hummus llegums)
(plat-tipus llobarro_forn peix)
(plat-tipus amanida_de_cogombre amanida)
(plat-tipus croquetes_carn carn)
(plat-tipus tataki_salmo peix)
(plat-tipus estofat_cigrons llegums)
(plat-tipus sopa_de_pedra sopa)
(plat-tipus parrillada_verdures verdures)
(plat-tipus espaguetis_marisc pasta)
(plat-tipus faves_estofades llegums)
(tipus-primer-anterior verdures)
(tipus-segon-anterior  amanida)
(dia-actual dilluns)
(necessita-primer dilluns)
(necessita-primer dimarts)
(necessita-primer dimecres)
(necessita-primer dijous)
(necessita-primer divendres))

  (:goal (planificacio-completa))

)
