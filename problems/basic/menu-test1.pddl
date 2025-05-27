;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  TEST SOLUBLE per a extensions 0-3                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (problem menu-test1)
  (:domain menu-setmanal)

  ;;-------------------------------------------------------------------
  ;;  OBJECTES
  ;;-------------------------------------------------------------------
  (:objects
     ;; dies de la setmana
     dilluns dimarts dimecres dijous divendres                  - dia

     ;; categories de plats
     amanida crema sopa pasta carn peix                         - tipus

     ;; primers plats
     amanidavera cremacamp paellaval
     amanidarusa pastamediterranea                              - primer

     ;; segons plats
     fabada salmonplanxa polloroast
     llengadoplanxa lasanya                                     - segon)

  ;;-------------------------------------------------------------------
  ;;  ESTAT INICIAL
  ;;-------------------------------------------------------------------
  (:init
    ;; ordre dels dies
    (dia-seguent dilluns dimarts) (dia-seguent dimarts dimecres)
    (dia-seguent dimecres dijous) (dia-seguent dijous divendres)

    ;; mapping plat-tipus -- primers
    (plat-tipus amanidavera      amanida)
    (plat-tipus cremacamp        crema)
    (plat-tipus paellaval        sopa)
    (plat-tipus amanidarusa      amanida)
    (plat-tipus pastamediterranea pasta)

    ;; mapping plat-tipus -- segons
    (plat-tipus fabada           carn)
    (plat-tipus salmonplanxa     peix)
    (plat-tipus polloroast       carn)
    (plat-tipus llengadoplanxa   peix)
    (plat-tipus lasanya          pasta)

    ;; incompatibilitat exemple
    (incompatible paellaval salmonplanxa)

    ;; tipus del dia anterior (ext-2)
    (tipus-primer-anterior pasta)
    (tipus-segon-anterior amanida)

    ;; inici de la planificacio
    (dia-actual dilluns)
    (necessita-primer dilluns)

    ;; cua de la resta de dies
    (necessita-primer dimarts)
    (necessita-primer dimecres)
    (necessita-primer dijous)
    (necessita-primer divendres))

  ;;-------------------------------------------------------------------
  ;;  OBJECTIU
  ;;-------------------------------------------------------------------
  (:goal (planificacio-completa))
)
