
(define (problem menu-auto-ext3-4)
  (:domain menu-setmanal)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    amanida carn crema llegums pasta peix sopa verdures - tipus
    amanida_catalana botifarra_brasa crema_de_carbassa tallarins_carbonara verdures_a_la_planxa  - primer
    bacalla_amb_tomate estofat_cigrons sopa_de_galets tortellinis_carne xai_rostit   - segon)

  (:init
    (dia-seguent dilluns dimarts)
(dia-seguent dimarts dimecres)
(dia-seguent dimecres dijous)
(dia-seguent dijous divendres)
(plat-tipus crema_de_carbassa crema)
(plat-tipus tallarins_carbonara pasta)
(plat-tipus amanida_catalana amanida)
(plat-tipus verdures_a_la_planxa verdures)
(plat-tipus botifarra_brasa carn)
(plat-tipus estofat_cigrons llegums)
(plat-tipus bacalla_amb_tomate peix)
(plat-tipus sopa_de_galets sopa)
(plat-tipus tortellinis_carne pasta)
(plat-tipus xai_rostit carn)
(tipus-primer-anterior sopa)
(tipus-segon-anterior  peix)
(dia-actual dilluns)
(necessita-primer dilluns)
(necessita-primer dimarts)
(necessita-primer dimecres)
(necessita-primer dijous)
(necessita-primer divendres)
(primer-obligatori dimarts tallarins_carbonara)
(primer-obligatori dimecres amanida_catalana))

  (:goal (planificacio-completa))

)
