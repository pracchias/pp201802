#lang racket


(define (loop-do-jogo baralho mao mao-dealer)
    (pergunta-jogar)
    (define resposta-jogador (pega-resposta))
    (cond [(respondeu-comprar? resposta-jogador)
                (define carta-comprada (car baralho))
                (define nova-mao (cons topo mao))
                (define novo-bar (cdr baralho))
                (loop-do-jogo novo-bar nova-mao mao-dealer)]
           [(respondeu-nao-comprar resposta-jogador)
                (define (loop-dealer baralho mao mao-dealer)
                (cond [(dealer-compra? mao-dealer)
                    (define carta-comprada (car baralho))
                    (define nova-mao (cons topo mao-dealer))
                    (define novo-bar (cdr baralho))
                    (loop-dealer novo-bar mao mao-dealer)]
                    [else ;dealer nao compra
                        (avalia-vitoria mao mao-dealer)]))]))


            