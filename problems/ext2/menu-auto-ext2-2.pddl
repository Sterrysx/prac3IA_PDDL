
(define (problem menu-auto-ext2-2)
  (:domain menu-setmanal)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    amanida carn crema llegums peix sopa verdures - tipus
    botifarra_brasa crema_de_carxofa llobarro_forn sopa_de_peix tataki_salmo  - primer
    amanida_de_espinacs faves_estofades llenguado_amb_lima salmo_grillat sopa_de_galets   - segon)

  (:init
    (dia-seguent dilluns dimarts)
(dia-seguent dimarts dimecres)
(dia-seguent dimecres dijous)
(dia-seguent dijous divendres)
(plat-tipus tataki_salmo peix)
(plat-tipus sopa_de_peix sopa)
(plat-tipus crema_de_carxofa crema)
(plat-tipus llobarro_forn peix)
(plat-tipus botifarra_brasa carn)
(plat-tipus llenguado_amb_lima peix)
(plat-tipus sopa_de_galets sopa)
(plat-tipus amanida_de_espinacs amanida)
(plat-tipus salmo_grillat peix)
(plat-tipus faves_estofades llegums)
(tipus-primer-anterior carn)
(tipus-segon-anterior  verdures)
(dia-actual dilluns)
(necessita-primer dilluns)
(necessita-primer dimarts)
(necessita-primer dimecres)
(necessita-primer dijous)
(necessita-primer divendres))

  (:goal (planificacio-completa))

)
