#lang racket
(require racket/tcp)
 (require racket/vector)

(require "conexao-lib.rkt")

    ;;; Um jogador deve iniciar o servidor e passar seu endereço para os outros.
    ;;; O servidor irá:
    ;;; 1) Aceitar conexões a diferentes portas. 
    ;;; 2) Responder aos jogadores numa conexão com sucesso.


; Configuracoes
; em conexao-lib
(define num-of-players 2)



(define (espera-conexoes restantes portas portas-dos-jogadores)
    (cond   [(> restantes 0) 
                (define lista-com-jogador-conectado (list portas-dos-jogadores (espera-conexao-em (car portas))))
                (printf "Jogador conectado.\n")
                (printf "IO: ~a\n" lista-com-jogador-conectado)
                (espera-conexoes (- restantes 1) (cdr portas)  lista-com-jogador-conectado)]
            [else 
                (printf "Todos os jogadores conectados: ~a" portas-dos-jogadores)
                (list->vector portas-dos-jogadores)]))



(define (send-hello portas) (write "Ola Jogador!" (get-out portas)) (flush-output (get-out portas)))



(define (teste)
     (define teste-cust (make-custodian))
        (parameterize ([current-custodian teste-cust])
        (printf "Esperando conexão em ~a " (first portas-jogo))
        
        (define conexao1  (espera-conexao-em (first portas-jogo)))
        (display "Conexão 1 recebida.\n")

        (thread (lambda () 
                    (sleep 3)
                    (send-hello conexao1)))

        (printf "Esperando conexão em ~a " (second portas-jogo))
        (define conexao2  (espera-conexao-em (second portas-jogo)))
        (display "Conexão 2 recebida.\n")

        (define jogadores (list conexao1 conexao2))
        (for-each send-hello jogadores)
        (custodian-shutdown-all teste-cust)))   




(define (send-currend-port esperando in-out) (write esperando (get-out in-out)(flush-output (get-out in-out))))

(define (distribuidor portas-restantes)
    (cond [ 
        (null? portas-restantes) (display "TODAS AS PORTAS USADAS")
        ] 
        [else 
        (define conexao (espera-conexao-em porta-distribuidor))
        (display "Conexão recebida. Distribuindo porta. ")
        (send-currend-port (car portas-restantes conexao))
        (close-input-port (get-in conexao))
        (close-output-port (get-out conexao))
        (printf "Porta distribuida ~a " (car portas-restantes))
        (distribuidor (cdr portas-restantes))]))
    




(display "Iniciando servidor v1.\n")
(display "iniciando thread distribuidora.")

(thread (lambda () (distribuidor portas-jogo)))
(teste)

(display "Finalizando servidor.\n")
