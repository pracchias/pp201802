#lang racket
(require "conexao-lib.rkt")

; Lop ocorre no servidorr
(define (loop-do-jogo baralho mao mao-dealer in out)
    (pergunta-jogador out)
    (define resposta-jogador (pega-resposta in))
    (cond [(respondeu-comprar? resposta-jogador)
                (define carta-comprada (car baralho))
                (define nova-mao (cons topo mao))
                (define novo-bar (cdr baralho))
                (avisa-jogador mao out)
                (loop-do-jogo novo-bar nova-mao mao-dealer in out)]
           [(respondeu-nao-comprar resposta-jogador)
                (define (loop-dealer baralho mao mao-dealer out)
                (cond [(dealer-compra? mao-dealer)
                    (define carta-comprada (car baralho))
                    (define nova-mao (cons topo mao-dealer))
                    (define novo-bar (cdr baralho))
                    (loop-dealer novo-bar mao mao-dealer out)]
                    [else ;dealer nao compra
                        (avalia-vitoria mao mao-dealer out)]))]))
      
(define (main)
    (define sockets (espera-conexao porta-jogo))
    (define baralho (novo-baralho))
    (define mao-jogador (cons (fist baralho) (second baralho)))
    (define mao-dealer (cons (third baralho) (fourth baralho)))
    (define novo-baralho (cdr (cdr (cdr (cdr baralho)))))

    (loop-do-jogo 
        (novo-baralho) 
        (mao-jogador)
        (nova-dealer) 
        (get-in sockets) 
        (get-out sockets)))


; Informa ao jogador qual é sua mão.
(define (avisa-jogador mao out)
    (write "Suas cartas são:" out)
    (write mao out)
    (write "\n")
    (flush-output out))

; Informa ao jogador qual é sua mão.
(define (pergunta-jogar out)
	; mandar mensagem ao jogador
	; esperar resposta
)

; Informa ao servidor qual foi a resposta do jogador
(define (pega-resposta in))

; Retorna true se a resposta do jogador foi no sentido de comprar uma carta.
(respondeu-comprar? resposta-jogador)

; Retorna true se o jogador já parou de comprar cartas
(respondeu-nao-comprar resposta-jogador)
(define (avalia-vitoria mao mao-dealer out))
      
