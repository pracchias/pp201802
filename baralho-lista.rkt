#lang racket

;Uso de lista ao invés de array, devido a facilidade do manuseio da mesma.

(define (baralho)
  '((A - Copas) (A - Espadas) (A - Ouros) (A - Paus)
           (2 - Copas) (2 - Espadas) (2 - Ouros) (2 - Paus)
           (3 - Copas) (3 - Espadas) (3 - Ouros) (3 - Paus)
           (4 - Copas) (4 - Espadas) (4 - Ouros) (4 - Paus)
           (5 - Copas) (5 - Espadas) (5 - Ouros) (5 - Paus)
           (6 - Copas) (6 - Espadas) (6 - Ouros) (6 - Paus)
           (7 - Copas) (7 - Espadas) (7 - Ouros) (7 - Paus)
           (8 - Copas) (8 - Espadas) (8 - Ouros) (8 - Paus)
           (9 - Copas) (9 - Espadas) (9 - Ouros) (9 - Paus)
           (10 - Copas) (10 - Espadas) (10 - Ouros) (10 - Paus)
           (J - Copas) (J - Espadas) (J - Ouros) (J - Paus)
           (Q - Copas) (Q - Espadas) (Q - Ouros) (Q - Paus)
           (K - Copas) (K - Espadas) (K - Ouros) (K - Paus)
           (A - Copas) (A - Espadas) (A - Ouros) (A - Paus)
           (2 - Copas) (2 - Espadas) (2 - Ouros) (2 - Paus)
           (3 - Copas) (3 - Espadas) (3 - Ouros) (3 - Paus)
           (4 - Copas) (4 - Espadas) (4 - Ouros) (4 - Paus)
           (5 - Copas) (5 - Espadas) (5 - Ouros) (5 - Paus)
           (6 - Copas) (6 - Espadas) (6 - Ouros) (6 - Paus)
           (7 - Copas) (7 - Espadas) (7 - Ouros) (7 - Paus)
           (8 - Copas) (8 - Espadas) (8 - Ouros) (8 - Paus)
           (9 - Copas) (9 - Espadas) (9 - Ouros) (9 - Paus)
           (10 - Copas) (10 - Espadas) (10 - Ouros) (10 - Paus)
           (J - Copas) (J - Espadas) (J - Ouros) (J - Paus)
           (Q - Copas) (Q - Espadas) (Q - Ouros) (Q - Paus)
           (K - Copas) (K - Espadas) (K - Ouros) (K - Paus)))

(define (baralho-mesa n-jogadores monte)
  (cond [(<= n-jogadores 4 ) monte]
        [else (baralho-mesa (- n-jogadores 4) (append monte (baralho)))]))

