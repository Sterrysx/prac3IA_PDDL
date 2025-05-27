
(define (problem menu-auto-ext3-5)
  (:domain menu-setmanal)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    amanida carn crema llegums pasta peix sopa - tipus
    carpaccio_vedella crema_de_carabasso crema_de_carxofa macarrons_forn sopa_de_peix  - primer
    botifarra_a_la_planxa espaguetis_marisc estofat_cigrons salmo_grillat sopa_de_pedra   - segon)

  (:init
    (dia-seguent dilluns dimarts)
(dia-seguent dimarts dimecres)
(dia-seguent dimecres dijous)
(dia-seguent dijous divendres)
(plat-tipus macarrons_forn pasta)
(plat-tipus crema_de_carxofa crema)
(plat-tipus carpaccio_vedella carn)
(plat-tipus sopa_de_peix sopa)
(plat-tipus crema_de_carabasso crema)
(plat-tipus espaguetis_marisc pasta)
(plat-tipus salmo_grillat peix)
(plat-tipus estofat_cigrons llegums)
(plat-tipus botifarra_a_la_planxa carn)
(plat-tipus sopa_de_pedra sopa)
(tipus-primer-anterior amanida)
(tipus-segon-anterior  carn)
(dia-actual dilluns)
(necessita-primer dilluns)
(necessita-primer dimarts)
(necessita-primer dimecres)
(necessita-primer dijous)
(necessita-primer divendres)
(segon-obligatori dijous botifarra_a_la_planxa)
(segon-obligatori dimarts salmo_grillat))

  (:goal (planificacio-completa))

)
