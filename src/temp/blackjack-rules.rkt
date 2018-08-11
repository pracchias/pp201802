#lang racket

(require "blackjack-msgs.rkt")
(require "baralho.rkt")

(provide novo-baralho)
(provide comprar)
(provide ia-dealer)
(provide compara-maos)
(provide mao-estourou?)
(provide valor-da-mao)

; Baralho para testes.
(define (novo-baralho) (baralho))
(define carta-nula '(0 00))

; Retorna um baralho e uma mão após a ocorrencia de uma compra
(define (comprar baralho mao)
    (define nova-mao (cons (first baralho) mao))
    (define novo-baralho (cdr baralho))
    (values novo-baralho nova-mao))

; Calcula o valor da mão como 1 ou 10
(define (valor-da-mao mao)
  ;  (display "Obtendo o valor da mão: ") (write mao) (displayln "")
    (define (soma carta1 carta2)
       (+ (get-valor carta1) (get-valor carta2)))
    (define valor (foldl soma carta-nula mao))
    (cond
        [(and (< valor 4) (tem-2-as? mao)) (+ valor 18)]
        [(and (< valor 12) (tem-as? mao)) (+ valor 9)]
        [else valor]))

(define (valor-da-mao-as-vale-1 mao)
    (define (soma carta1 carta2)
       (+ (get-valor carta1) (get-valor carta2)))
    (define valor (foldl soma carta-nula mao))
    valor)

; Calcula o valor de uma carta
(define (get-valor carta)
   ;(display "Calculando valor da carta ") (write carta) (displayln "")
    (define num (get-num carta))
    (cond [(number? num) num] ; se for um numero, o valor é o proprio numero
        [(eq? num 'A) 1]         ; se for um as, o valor é A. Esse valor é corrigido para 10 ao se analisar a mao.
        [else 10]))    ; se for uma outra figura, o valor é 10.

; Pega o valor de uma carta
(define (get-num carta)
;    (display "Obtendo NUM da carta ") (write carta) (displayln "...")
;    (car carta))
  ;  (cond [(list? carta)
      (cond [(list? carta)
            (cond [(eq? (car carta) 'J) 10]
                  [(eq? (car carta) 'Q) 10]
                  [(eq? (car carta) 'K) 10]
                  [(eq? (car carta) 'A) 1]
                  [(number? (car carta)) (car carta)]
    ;      [(string? carta)
    ;        (define valor (substring carta 1))
    ;        (if (string->number valor) (string->number valor) valor)]
    ;    [(number? carta) carta]
        [else "VALOR NAO ENCONTRADO."])]
          [else carta]))


; Diz se a mão já estourou
(define (mao-estourou? mao)
    (> (valor-da-mao mao) 21))

; Diz se existe um Ás na Mão
(define (tem-as? mao)
    (define (eh-As carta) (= 1 (get-valor carta)))
    (> (length (filter-map eh-As mao)) 1))

(define (tem-2-as? mao)
    (define (eh-As carta) (= 1 (get-valor carta)))
    (> (length (filter-map eh-As mao)) 2))

(define (dealer-tem-menos-que-17? mao-dealer)
    ;(printf "~a: valor = ~a\n" mao-dealer (valor-da-mao mao-dealer))
    ;(printf "Comprar? ~a\n" (< (valor-da-mao mao-dealer) 18))
    (< (valor-da-mao mao-dealer) 18))

(define (dealer-tem-a-valendo-10? mao-dealer)
    (and (tem-as? mao-dealer)
        (not (= (valor-da-mao mao-dealer) (valor-da-mao-as-vale-1 mao-dealer)))))

(define (dealer-continua-comprando? mao-dealer)
    (or (dealer-tem-menos-que-17? mao-dealer) (dealer-tem-a-valendo-10? mao-dealer) ))


(define (ia-dealer baralho mao-dealer)
    (display "Iniciando IA. Ia ira comprar? ")
    (displayln (dealer-continua-comprando? mao-dealer))
    (cond [(dealer-continua-comprando? mao-dealer)
                (define-values
                    (novo-baralho nova-mao)
                    (comprar baralho mao-dealer))
                (values novo-baralho nova-mao 'running)]
        [else (values baralho mao-dealer 'dealer-parou)]))


(define (compara-maos mao-jogador mao-dealer)
    (define v-jogador (valor-da-mao mao-jogador))
    (define v-dealer (valor-da-mao mao-dealer))
    (cond [(> v-jogador 21) 'dealer-venceu]
        [(> v-dealer 21) 'jogador-venceu]
        [(< v-jogador v-dealer) 'dealer-venceu]
        [(> v-jogador v-dealer) 'jogador-venceu]
        [(= v-jogador v-dealer) 'empate]))
