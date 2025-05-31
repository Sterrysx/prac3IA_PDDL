(define (problem menuext4b)
  (:domain menuext4b)
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
    
    ; Calorie values for first courses
    (= (calories amanidavera) 300)
    (= (calories cremacamp) 400)
    (= (calories paellaval) 600)
    (= (calories amanidarusa) 450)
    (= (calories pastamediterranea) 550)
    ; New first courses calories
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
    ; New second courses calories
    (= (calories bistec) 650)
    (= (calories hamburguesa) 750)
    (= (calories llucplanxa) 350)
    (= (calories paellaverdures) 450)
    (= (calories vedella) 700)
  )
  
  (:goal (and
    (forall (?d - dia)
      (and 
        (primerAsignat ?d)
        (segonAsignat ?d)
      )
    ))
  )
)
