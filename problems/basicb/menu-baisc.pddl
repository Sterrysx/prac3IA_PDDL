(define (problem menu-basicb)
  (:domain menu-basicb)

  (:objects
    dilluns dimarts dimecres dijous divendres - dia
    amanida sopa pasta carn peix - tipus
    amanidavera cremacamp paellaval amanidarusa pastamediterranea - plat
    fabada salmonplanxa polloroast llengadoplanxa lasanya - plat
    primer segon - rol
  )

  (:init
    (es_rol amanidavera primer)
    (es_rol cremacamp primer)
    (es_rol paellaval primer)
    (es_rol amanidarusa primer)
    (es_rol pastamediterranea primer)
    (es_rol fabada segon)
    (es_rol salmonplanxa segon)
    (es_rol polloroast segon)
    (es_rol llengadoplanxa segon)
    (es_rol lasanya segon)

    (es_tipus amanidavera amanida)
    (es_tipus cremacamp sopa)
    (es_tipus paellaval pasta)
    (es_tipus amanidarusa amanida)
    (es_tipus pastamediterranea pasta)
    (es_tipus fabada carn)
    (es_tipus salmonplanxa peix)
    (es_tipus polloroast carn)
    (es_tipus llengadoplanxa peix)
    (es_tipus lasanya pasta)

    (consecutiu dilluns dimarts)
    (consecutiu dimarts dimecres)
    (consecutiu dimecres dijous)
    (consecutiu dijous divendres)

    (incompatible paellaval salmonplanxa)
    (incompatible amanidarusa fabada)
    (incompatible cremacamp polloroast)
  )

  (:goal (and
    (assignat dilluns primer amanidavera)
    (assignat dilluns segon llengadoplanxa)
    (assignat dimarts primer cremacamp)  
    (assignat dimarts segon salmonplanxa)
    (assignat dimecres primer paellaval)
    (assignat dimecres segon polloroast)
    (assignat dijous primer amanidarusa)
    (assignat dijous segon lasanya)
    (assignat divendres primer pastamediterranea)
    (assignat divendres segon fabada)
  ))
)