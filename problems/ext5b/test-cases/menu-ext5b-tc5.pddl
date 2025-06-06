(define (problem menuext5b-tc5)
          (:domain menuext5b)

          (:objects
            dilluns dimarts dimecres dijous divendres DummyD - dia
crema_de_bolets amanida_quinoa sopa_miso hummus gnocchi_pesto escalivada_verdures amanida_de_tomaquet raviolis_ricotta sopa_de_marisc crema_de_carbassa - primer
truita_de_llenties hamburguesa_mongeta sopa_de_pedra turbot_planxa filet_porc crema_catalana estofat_soja sopa_de_peix botifarra_a_la_planxa curry_verdures - segon
DummyT amanida carn crema llegums pasta peix sopa verdures - tipus
          )

          (:init
            (incompatible crema_de_carbassa filet_porc)
    (incompatible raviolis_ricotta crema_catalana)
    (incompatible amanida_de_tomaquet botifarra_a_la_planxa)
    (incompatible escalivada_verdures sopa_de_pedra)
    (incompatible crema_de_bolets botifarra_a_la_planxa)
    (incompatible sopa_miso curry_verdures)
    (incompatible crema_de_bolets filet_porc)
    (incompatible sopa_de_marisc curry_verdures)
    (platTipus crema_de_bolets crema)
    (platTipus amanida_quinoa amanida)
    (platTipus sopa_miso sopa)
    (platTipus hummus llegums)
    (platTipus gnocchi_pesto pasta)
    (platTipus escalivada_verdures verdures)
    (platTipus amanida_de_tomaquet amanida)
    (platTipus raviolis_ricotta pasta)
    (platTipus sopa_de_marisc sopa)
    (platTipus crema_de_carbassa crema)
    (platTipus truita_de_llenties llegums)
    (platTipus hamburguesa_mongeta llegums)
    (platTipus sopa_de_pedra sopa)
    (platTipus turbot_planxa peix)
    (platTipus filet_porc carn)
    (platTipus crema_catalana crema)
    (platTipus estofat_soja llegums)
    (platTipus sopa_de_peix sopa)
    (platTipus botifarra_a_la_planxa carn)
    (platTipus curry_verdures verdures)
    (diaAnt DummyD dilluns)
    (diaAnt dilluns dimarts)
    (diaAnt dimarts dimecres)
    (diaAnt dimecres dijous)
    (diaAnt dijous divendres)
    (primerAsignat DummyD)
(segonAsignat  DummyD)
(diaPrimerTipus DummyD DummyT)
(diaSegonTipus  DummyD DummyT)
    (platObligatori crema_de_bolets divendres)
    (platObligatori botifarra_a_la_planxa dimarts)
    (= (minCalories) 1000)
    (= (maxCalories) 1500)
    (= (calories crema_de_bolets) 390)
    (= (calories amanida_quinoa) 360)
    (= (calories sopa_miso) 500)
    (= (calories hummus) 530)
    (= (calories gnocchi_pesto) 740)
    (= (calories escalivada_verdures) 350)
    (= (calories amanida_de_tomaquet) 270)
    (= (calories raviolis_ricotta) 680)
    (= (calories sopa_de_marisc) 560)
    (= (calories crema_de_carbassa) 350)
    (= (calories truita_de_llenties) 620)
    (= (calories hamburguesa_mongeta) 670)
    (= (calories sopa_de_pedra) 500)
    (= (calories turbot_planxa) 790)
    (= (calories filet_porc) 900)
    (= (calories crema_catalana) 440)
    (= (calories estofat_soja) 700)
    (= (calories sopa_de_peix) 520)
    (= (calories botifarra_a_la_planxa) 880)
    (= (calories curry_verdures) 580)
    (= (preu crema_de_bolets) 4)
    (= (preu amanida_quinoa) 4)
    (= (preu sopa_miso) 5)
    (= (preu hummus) 4)
    (= (preu gnocchi_pesto) 5)
    (= (preu escalivada_verdures) 3)
    (= (preu amanida_de_tomaquet) 3)
    (= (preu raviolis_ricotta) 5)
    (= (preu sopa_de_marisc) 6)
    (= (preu crema_de_carbassa) 3)
    (= (preu truita_de_llenties) 5)
    (= (preu hamburguesa_mongeta) 5)
    (= (preu sopa_de_pedra) 5)
    (= (preu turbot_planxa) 8)
    (= (preu filet_porc) 8)
    (= (preu crema_catalana) 4)
    (= (preu estofat_soja) 5)
    (= (preu sopa_de_peix) 6)
    (= (preu botifarra_a_la_planxa) 7)
    (= (preu curry_verdures) 5)
    (= (costDiari) 0)
    (= (costTotal) 0)
          )

          (:goal
            (forall (?d - dia)
              (and (primerAsignat ?d) (segonAsignat ?d)))
          )
  (:metric minimize (costTotal))
        )