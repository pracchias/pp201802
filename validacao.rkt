#lang racket

;pega o naipe da carta
(define (naipe carta)
  (cdr carta ))

;pegar valor da carta
(define (valor carta)
  (caar carta))

;Apenas um exemplo de mao
;(define mao
;  '(((2)(Copas))((2)(Paus))((2)(Espadas))
;  ((4)(Copas))((5)(Copas))((6)(Copas))
;  ((9)(Ouros))((10)(Ouros))((11)(Ouros))))

;Ordena a mao do jogador na ordem desejada para analisar sua validade
(define (ordem mao sequencia mao_org)
  (cond [(= 9 (length mao_org)) (reverse mao_org)]
        [else (ordem mao (cdr sequencia)
                         (cons (list-ref mao (car sequencia)) mao_org))]))

;Verifica em trios se a mão do jogador é valida para a batida
(define (check mao)
  (cond [(= 0 (length mao)) #t]
        [(or (sequencia? mao) (igual? mao)) (check (cdddr mao))]
        [else #f]))

;Verifica se o trio possui o mesmo valor de carta
(define (igual? trio)
  (cond [(and (= (valor (list-ref trio 1)) (valor (list-ref trio 2)))
              (= (valor (list-ref trio 1)) (valor (list-ref trio 0)))) #t]
        [else #f]))

;Verifica se o trio é uma sequencia
(define (sequencia? trio)
  (if (and (equal? (naipe (list-ref trio 0)) (naipe (list-ref trio 1)))
           (equal? (naipe (list-ref trio 1)) (naipe (list-ref trio 2))))
       (cond [(and (= (valor (list-ref trio 0)) (- (valor(list-ref trio 1)) 1))
                   (= (valor (list-ref trio 1)) (- (valor(list-ref trio 2)) 1))) #t]
             [else #f])
        #f))

;Converte uma sequencia de numeros em uma lista
(define (num->list n)
  (local
    ((define (num->list n)
       (map (lambda (c)
              (char->num c))
            (string->list (number->string n))))
    (define (char->num c)
      (- (char->integer c) 48)))
    (num->list n)))

;Valida se a mão do jogador seguindo na sequencia dita
(define (validar mao sequencia)
  (if (= 8 (length (num->list sequencia)))
        (check(ordem mao (cons 0 (num->list sequencia)) '()))
        (check(ordem mao (num->list sequencia) '()))))

;Exemplo
;(validar mao 012354678)
