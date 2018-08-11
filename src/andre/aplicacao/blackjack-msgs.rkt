#lang racket
(require "conexao-lib.rkt")


(provide respondeu-hit?)
(provide respondeu-stop?)
(provide respondeu-sair?)

(provide compara)

(provide jogo-acabou?)
(provide jogador-parou? )
(provide jogador-venceu? )
(provide dealer-venceu?)
(provide jogador-estourou?)

(provide get-estado)
(provide get-cartas-jogador)
(provide get-cartas-dealer)


(define (respondeu-hit? resposta) 
	(or (compara resposta 'hit) (compara resposta "hit")))

(define (respondeu-stop? resposta)
	(or (compara resposta 'stop) (compara resposta "stop")))

(define (respondeu-sair? resposta)
	(or (compara resposta 'sair) (compara resposta "sair")))

(define (compara resposta esperado)
	(equal? resposta esperado))

(define (jogador-parou? mensagem)
	(compara (get-estado mensagem) 'jogador-parou))

(define (jogador-venceu? mensagem) 
		(compara (get-estado mensagem) 'jogador-venceu))

(define (jogador-estourou? mensagem) 
	(compara (get-estado mensagem) 'jogador-estourou))

(define (dealer-venceu? mensagem) 
		(compara (get-estado mensagem) 'dealer-venceu))

(define (jogo-acabou? mensagem) 
	(define state (get-estado mensagem))
	(or
		(compara state 'jogador-venceu) 
		(compara state 'jogador-estourou)
		(compara state 'dealer-venceu)))


(define (get-cartas-jogador mensagem) (first mensagem))    

(define (get-cartas-dealer mensagem)  (second mensagem))

(define (get-estado mensagem)         (third mensagem))