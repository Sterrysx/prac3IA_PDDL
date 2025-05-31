(define (domain menu-basicb)
(:requirements :strips :adl)
(:types 
    dia plat - object
    primer segon - plat
)
(:predicates 
    (assignat ?d - dia ?p - primer ?s - segon)
    (incompatible ?p1 - plat ?p2 - plat)
    (diaAmbMenuAsignat ?d - dia)
)
(:action AssignarMenu
    :parameters (?d -dia ?p - primer ?s - segon )
    :precondition (not (incompatible ?p ?s))
    :effect (and (assignat ?d ?p ?s) (diaAmbMenuAsignat ?d))
)
)