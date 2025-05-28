
(define (problem menu-auto-ext2-3)
  (:domain menu-setmanal)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    amanida carn crema llegums pasta sopa verdures - tipus
    amanida_de_cogombre carpaccio_vedella croquetes_carn estofat_llenties sopa_de_marisc  - primer
    crema_de_limon espaguetis_marisc faves_estofades pennes_amb_pesto truita_verdures   - segon)

  (:init
    (dia-seguent dilluns dimarts)
(dia-seguent dimarts dimecres)
(dia-seguent dimecres dijous)
(dia-seguent dijous divendres)
(plat-tipus amanida_de_cogombre amanida)
(plat-tipus sopa_de_marisc sopa)
(plat-tipus croquetes_carn carn)
(plat-tipus estofat_llenties llegums)
(plat-tipus carpaccio_vedella carn)
(plat-tipus faves_estofades llegums)
(plat-tipus crema_de_limon crema)
(plat-tipus espaguetis_marisc pasta)
(plat-tipus truita_verdures verdures)
(plat-tipus pennes_amb_pesto pasta)
(tipus-primer-anterior llegums)
(tipus-segon-anterior  verdures)
(dia-actual dilluns)
(necessita-primer dilluns)
(necessita-primer dimarts)
(necessita-primer dimecres)
(necessita-primer dijous)
(necessita-primer divendres))

  (:goal (planificacio-completa))

)
