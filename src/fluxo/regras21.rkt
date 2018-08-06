#lang racket


;; 1) Começa 2 cartas.
;; 2) Dealer começa 2 cartas.lang
;; 3) Pede cartas
;; 4) A = 1 ou 10
;; 5) Para quando quiser
;; 6) Se somar mais que 21 perde
;; 7) Quem tiver o maior valor vence
;; 8) Quando o jogador para de comprar carta, oo dealer compra


;; Compra até ter 17 ou mais.
;; Somou 17 ou mais E não tem A VALENDO 10, ele para.
;; Somou 17 ou mais, TEM A VALENDO 10, ele compra mais uma.

; Muda o baralho do servidor.
(define atualiiza-baralho baralho)

; Dá uma carta nova ao jogador
(define (comprar baralho mao)
    (atualiza-baralho (cdr baralho))
    (define  nova-mao (adiciona-na-mao (car baralho) mao))
    (mostra-valor-da-mao mao))

(define (adiciona-na-mao carta mao)
    (cons carta mao))


; Informa que o jogador não vai mais comprar cartas
(define (parar) )


; Melhorar: CONSIDERAR o A COMO 1 ou 10.
(define (mostra-valor-da-mao mao)
    (mostra-jogadoor  (valor-da-mao mao)))

; Calcula o valor da mão como 1 ou 10
(define (valor-da-mao mao)
    (define (soma carta1 carta2)
       (+ (get-valor carta1) (get-valor carta2)))
    (define valor (fold soma 0 mao))
    (cond 
        [(and (< valor 4) (tem-2-as? mao) (+ valor 18))]
        [(and (< valor 12) (tem-as? mao)) (+ valor 9)]
        [(estourou? mao) (perdeu-estouro)]
        [else valor]))

(define (perdeu-estouro)
     (informa-jogador "Você estourou :(")
      (novo-jooggo))

(define (estourou? mao)
    (> (valor-da-mao mao) 21))


(define (dealer-compra mao-dealer) (comprar baralho mao-dealer))
(define (dealer-para) (avaliia-vencedor))
(define (dealer-tem-menos-que-17?) (< 18 (9valor-da-mao mao-dealler)))
(define (dealer-tem-a-valendo-10?) (tem-as? mao-ddealer))
(define (dealer-continua-comprando?)
    (or (dealer-tem-menos-que-17?) (dealer-tem-a-valendo-10?) )))