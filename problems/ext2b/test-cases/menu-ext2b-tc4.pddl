(define (problem menuext2b-tc4)
          (:domain menuext2b)

          (:objects
            dilluns dimarts dimecres dijous divendres DummyD - dia
fajitas_verdures hummus amanida_asiatica sopa_de_cigrons amanida_quinoa crema_de_carxofa verdures_amb_salsa amanida_fasols cigrons_saltejats gnocchi_pesto - primer
pollastre_a_la_planxa sopa_de_peix filet_porc sopa_de_galets llenguado_amb_lima hamburguesa_mongeta truita_de_llenties estofat_soja estofat_cigrons faves_estofades - segon
DummyT amanida carn crema llegums pasta peix sopa verdures - tipus
          )

          (:init
            (incompatible verdures_amb_salsa sopa_de_peix)
    (incompatible amanida_quinoa pollastre_a_la_planxa)
    (incompatible amanida_fasols llenguado_amb_lima)
    (incompatible amanida_quinoa llenguado_amb_lima)
    (incompatible fajitas_verdures sopa_de_peix)
    (incompatible fajitas_verdures filet_porc)
    (incompatible crema_de_carxofa pollastre_a_la_planxa)
    (incompatible verdures_amb_salsa pollastre_a_la_planxa)
    (platTipus fajitas_verdures verdures)
    (platTipus hummus llegums)
    (platTipus amanida_asiatica amanida)
    (platTipus sopa_de_cigrons sopa)
    (platTipus amanida_quinoa amanida)
    (platTipus crema_de_carxofa crema)
    (platTipus verdures_amb_salsa verdures)
    (platTipus amanida_fasols llegums)
    (platTipus cigrons_saltejats llegums)
    (platTipus gnocchi_pesto pasta)
    (platTipus pollastre_a_la_planxa carn)
    (platTipus sopa_de_peix sopa)
    (platTipus filet_porc carn)
    (platTipus sopa_de_galets sopa)
    (platTipus llenguado_amb_lima peix)
    (platTipus hamburguesa_mongeta llegums)
    (platTipus truita_de_llenties llegums)
    (platTipus estofat_soja llegums)
    (platTipus estofat_cigrons llegums)
    (platTipus faves_estofades llegums)
    (diaAnt DummyD dilluns)
    (diaAnt dilluns dimarts)
    (diaAnt dimarts dimecres)
    (diaAnt dimecres dijous)
    (diaAnt dijous divendres)
    (primerAsignat DummyD)
(segonAsignat  DummyD)
(diaPrimerTipus DummyD DummyT)
(diaSegonTipus  DummyD DummyT)
          )

          (:goal
            (forall (?d - dia)
              (and (primerAsignat ?d) (segonAsignat ?d)))
          )
        )