(define (domain menu-ext3b)
(:requirements :strips :adl)
(:types 
    dia plat tipus rol - object
    primer segon - rol
)
(:predicates 
    (assignat ?d - dia ?r - rol ?p - plat)
    (es_tipus ?p - plat ?t - tipus)
    (es_rol ?p - plat ?r - rol)
    (incompatible ?p1 - plat ?p2 - plat)
    (utilitzat ?p - plat)
    (consecutiu ?d1 - dia ?d2 - dia)
)
(:action assignar-primer
    :parameters (?d - dia ?p - plat)
    :precondition (and (es_rol ?p primer) (not (utilitzat ?p)))
    :effect (and (assignat ?d primer ?p) (utilitzat ?p))
)
(:action assignar-segon
    :parameters (?d - dia ?p - plat ?pp - plat)
    :precondition (and (es_rol ?p segon) (not (utilitzat ?p))
                      (assignat ?d primer ?pp)
                      (not (incompatible ?pp ?p)))
    :effect (and (assignat ?d segon ?p) (utilitzat ?p))
)
)
