(define (problem menuext5b)
  (:domain menuext5b)
  (:objects
    dilluns dimarts dimecres dijous divendres DummyD - dia
    amanidavera cremacamp paellaval amanidarusa pastamediterranea
    sopapeix gazpacho truitapatates arrosverdures ramen - primer
    fabada salmonplanxa polloroast llengadoplanxa lasanya 
    bistec hamburguesa llucplanxa paellaverdures vedella - segon
    vegetal peix carn pasta DummyT - tipus 
  )
  (:init
    ; Regular constraints
    (incompatible paellaval salmonplanxa)
    (incompatible amanidarusa fabada)
    (incompatible cremacamp polloroast)
    (incompatible sopapeix llucplanxa)
    (incompatible gazpacho vedella)
    (incompatible ramen bistec)
    
    ; Type assignments
    (platTipus amanidavera vegetal) 
    (platTipus fabada vegetal) 
    (platTipus amanidarusa vegetal) 
    (platTipus salmonplanxa peix) 
    (platTipus paellaval peix) 
    (platTipus llengadoplanxa peix)
    (platTipus lasanya pasta)
    (platTipus pastamediterranea pasta)
    (platTipus cremacamp vegetal)
    (platTipus polloroast carn)
    ; New first courses types
    (platTipus sopapeix peix)
    (platTipus gazpacho vegetal)
    (platTipus truitapatates vegetal)
    (platTipus arrosverdures vegetal)
    (platTipus ramen pasta)
    ; New second courses types
    (platTipus bistec carn)
    (platTipus hamburguesa carn)
    (platTipus llucplanxa peix)
    (platTipus paellaverdures vegetal)
    (platTipus vedella carn)
    
    ; Day sequence
    (diaAnt DummyD dilluns)
    (diaAnt dilluns dimarts)
    (diaAnt dimarts dimecres)
    (diaAnt dimecres dijous)
    (diaAnt dijous divendres)
    
    ; Dummy day initialization
    (primerAsignat DummyD)
    (segonAsignat DummyD)
    (diaPrimerTipus DummyD DummyT)
    (diaSegonTipus DummyD DummyT)
    
    ; Required dishes
    (platObligatori paellaval dijous)
    (platObligatori lasanya dimarts)
    
    ; Global calorie constraints
    (= (minCalories) 1000)
    (= (maxCalories) 1500)
    
    ; Initialize cost counters
    (= (costDiari) 0)
    (= (costTotal) 0)
    
    ; Calorie values for first courses
    (= (calories amanidavera) 300)
    (= (calories cremacamp) 400)
    (= (calories paellaval) 600)
    (= (calories amanidarusa) 450)
    (= (calories pastamediterranea) 550)
    (= (calories sopapeix) 350)
    (= (calories gazpacho) 200)
    (= (calories truitapatates) 450)
    (= (calories arrosverdures) 400)
    (= (calories ramen) 500)
    
    ; Calorie values for second courses
    (= (calories fabada) 800)
    (= (calories salmonplanxa) 500)
    (= (calories polloroast) 600)
    (= (calories llengadoplanxa) 400)
    (= (calories lasanya) 700)
    (= (calories bistec) 650)
    (= (calories hamburguesa) 750)
    (= (calories llucplanxa) 350)
    (= (calories paellaverdures) 450)
    (= (calories vedella) 700)

    ; Prices for first courses
    (= (preu amanidavera) 4)
    (= (preu cremacamp) 3)
    (= (preu paellaval) 7)
    (= (preu amanidarusa) 5)
    (= (preu pastamediterranea) 6)
    (= (preu sopapeix) 6)
    (= (preu gazpacho) 3)
    (= (preu truitapatates) 4)
    (= (preu arrosverdures) 5)
    (= (preu ramen) 6)

    ; Prices for second courses
    (= (preu fabada) 8)
    (= (preu salmonplanxa) 9)
    (= (preu polloroast) 8)
    (= (preu llengadoplanxa) 7)
    (= (preu lasanya) 7)
    (= (preu bistec) 9)
    (= (preu hamburguesa) 8)
    (= (preu llucplanxa) 8)
    (= (preu paellaverdures) 6)
    (= (preu vedella) 9)
  )
  
  (:goal (and
    (forall (?d - dia)
      (and 
        (primerAsignat ?d)
        (segonAsignat ?d)
      )
    ))
  )

  (:metric minimize (costTotal))
)
