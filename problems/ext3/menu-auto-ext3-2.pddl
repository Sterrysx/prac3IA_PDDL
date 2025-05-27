
(define (problem menu-auto-ext3-2)
  (:domain menu-setmanal)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    amanida carn crema pasta peix - tipus
    amanida_catalana botifarra_brasa crema_de_carbassa raviolis_ricotta tallarins_carbonara  - primer
    amanida_de_remolatxa bacalla_amb_tomate crema_catalana crema_de_limon tortellinis_carne   - segon)

  (:init
    (dia-seguent dilluns dimarts)
(dia-seguent dimarts dimecres)
(dia-seguent dimecres dijous)
(dia-seguent dijous divendres)
(plat-tipus tallarins_carbonara pasta)
(plat-tipus amanida_catalana amanida)
(plat-tipus botifarra_brasa carn)
(plat-tipus crema_de_carbassa crema)
(plat-tipus raviolis_ricotta pasta)
(plat-tipus bacalla_amb_tomate peix)
(plat-tipus crema_catalana crema)
(plat-tipus crema_de_limon crema)
(plat-tipus amanida_de_remolatxa amanida)
(plat-tipus tortellinis_carne pasta)
(tipus-primer-anterior amanida)
(tipus-segon-anterior  pasta)
(dia-actual dilluns)
(necessita-primer dilluns)
(necessita-primer dimarts)
(necessita-primer dimecres)
(necessita-primer dijous)
(necessita-primer divendres)
(segon-obligatori dimecres crema_de_limon))

  (:goal (planificacio-completa))

)
