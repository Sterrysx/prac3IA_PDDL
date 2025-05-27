
(define (problem menu-auto-ext3-1)
  (:domain menu-setmanal)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    carn crema llegums pasta sopa verdures - tipus
    carpaccio_vedella estofat_llenties raviolis_ricotta sopa_de_marisc verdures_a_la_planxa  - primer
    crema_de_limon parrillada_verdures pollastre_a_la_planxa sopa_de_pedra truita_de_llenties   - segon)

  (:init
    (dia-seguent dilluns dimarts)
(dia-seguent dimarts dimecres)
(dia-seguent dimecres dijous)
(dia-seguent dijous divendres)
(plat-tipus sopa_de_marisc sopa)
(plat-tipus carpaccio_vedella carn)
(plat-tipus raviolis_ricotta pasta)
(plat-tipus verdures_a_la_planxa verdures)
(plat-tipus estofat_llenties llegums)
(plat-tipus truita_de_llenties llegums)
(plat-tipus crema_de_limon crema)
(plat-tipus pollastre_a_la_planxa carn)
(plat-tipus parrillada_verdures verdures)
(plat-tipus sopa_de_pedra sopa)
(tipus-primer-anterior carn)
(tipus-segon-anterior  verdures)
(dia-actual dilluns)
(necessita-primer dilluns)
(necessita-primer dimarts)
(necessita-primer dimecres)
(necessita-primer dijous)
(necessita-primer divendres)
(segon-obligatori dimecres pollastre_a_la_planxa))

  (:goal (planificacio-completa))

)
