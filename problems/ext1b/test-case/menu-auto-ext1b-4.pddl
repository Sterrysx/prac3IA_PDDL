      (define (problem menu-ext1b-4)
        (:domain menuext1b)

          (:objects
  dilluns dimarts dimecres dijous divendres - dia
  verdures_amb_salsa escalivada_verdures sopa_de_peix macarrons_forn croquetes_carn raviolis_ricotta botifarra_brasa tataki_salmo llobarro_forn amanida_de_cogombre crema_de_carbassa carpaccio_vedella - primer
  amanida_de_espinacs pennes_amb_pesto amanida_cesar estofat_cigrons salmo_grillat sopa_de_galets faves_estofades truita_verdures parrillada_verdures tortellinis_carne tataki_verdures bacalla_amb_tomate - segon
)

        (:init
      (incompatible verdures_amb_salsa sopa_de_galets)
      (incompatible escalivada_verdures sopa_de_galets)
      (incompatible sopa_de_peix pennes_amb_pesto)
      (incompatible sopa_de_peix truita_verdures)
      (incompatible sopa_de_peix parrillada_verdures)
      (incompatible sopa_de_peix tortellinis_carne)
      (incompatible sopa_de_peix tataki_verdures)
      (incompatible macarrons_forn amanida_de_espinacs)
      (incompatible macarrons_forn amanida_cesar)
      (incompatible croquetes_carn sopa_de_galets)
      (incompatible croquetes_carn truita_verdures)
      (incompatible croquetes_carn parrillada_verdures)
      (incompatible croquetes_carn tataki_verdures)
      (incompatible raviolis_ricotta amanida_de_espinacs)
      (incompatible raviolis_ricotta amanida_cesar)
      (incompatible botifarra_brasa sopa_de_galets)
      (incompatible botifarra_brasa truita_verdures)
      (incompatible botifarra_brasa parrillada_verdures)
      (incompatible botifarra_brasa tataki_verdures)
      (incompatible amanida_de_cogombre salmo_grillat)
      (incompatible amanida_de_cogombre bacalla_amb_tomate)
      (incompatible crema_de_carbassa salmo_grillat)
      (incompatible crema_de_carbassa bacalla_amb_tomate)
      (incompatible carpaccio_vedella sopa_de_galets)
      (incompatible carpaccio_vedella truita_verdures)
      (incompatible carpaccio_vedella parrillada_verdures)
      (incompatible carpaccio_vedella tataki_verdures)
        )

          (:goal (and
  (forall (?d - dia)
    (and (primerAsignat ?d) (segonAsignat ?d))
  )))

      )