;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  SOLVABLE test for extensions 0-3                                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (problem menu-test1)
  (:domain weekly-menu)

  ;;-------------------------------------------------------------------
  ;;  OBJECTS
  ;;-------------------------------------------------------------------
  (:objects
     ;; weekdays
     lun mar mie jue vie                                       - dia

     ;; dish categories
     ensalada crema sopa pasta carne pescado                   - tipo

     ;; first-course dishes
     ensaladaverano cremaagur paellavalencia
     ensaladarusa pastamediterranea                            - primer

     ;; second-course dishes
     fabada asturiansalmon polloasado
     lenguadoplancha lasagna                                   - segundo)

  ;;-------------------------------------------------------------------
  ;;  INITIAL STATE
  ;;-------------------------------------------------------------------
  (:init
    ;; day order
    (next-day lun mar) (next-day mar mie)
    (next-day mie jue) (next-day jue vie)

    ;; dish-type mapping – FIRSTS
    (dish-type ensaladaverano     ensalada)
    (dish-type cremaagur          crema)
    (dish-type paellavalencia     sopa)
    (dish-type ensaladarusa       ensalada)
    (dish-type pastamediterranea  pasta)

    ;; dish-type mapping – SECONDS
    (dish-type fabada             carne)
    (dish-type asturiansalmon     pescado)
    (dish-type polloasado         carne)
    (dish-type lenguadoplancha    pescado)
    (dish-type lasagna            pasta)

    ;; sample incompatibility
    (incompatible paellavalencia asturiansalmon)

    ;; seed “yesterday’s types” for ext-2
    (prev-first-type  pasta)
    (prev-second-type ensalada)

    ;; Monday starts
    (current-day lun)
    (needs-first  lun)

    ;; queue rest of week (activated day-by-day)
    (needs-first  mar) (needs-first  mie)
    (needs-first  jue) (needs-first  vie))

  ;;-------------------------------------------------------------------
  ;;  GOAL
  ;;-------------------------------------------------------------------
  (:goal (planning-done))
)
