#lang racket
(require racket/tcp)





(provide porta-servidor)

(provide envia-mensagem)

(provide endereco-conexao) 
(provide get-porta-cliente)
(provide get-endereco-cliente)
(provide get-porta-servidor)
(provide get-endereco-servidor)


(provide imprime-endereco-e-porta-servidor)
(provide imprime-endereco-e-porta-cliente)


; ----------------------------------------------

(define porta-servidor 8080)


(define (envia-mensagem mensagem out) 
    (display mensagem out)
    (newline out)
    (flush-output out))



(define (endereco-conexao  conexao)
    (define-values (aLocal aRemoto bLocal bRemoto) (tcp-addresses conexao #t))
    (vector aLocal aRemoto bLocal bRemoto))

(define (get-porta-servidor conexao) 
    (vector-ref (endereco-conexao conexao) 3))

(define (get-endereco-servidor conexao) 
    (vector-ref (endereco-conexao conexao) 1))
    
(define (get-porta-cliente conexao) 
    (vector-ref (endereco-conexao conexao) 1))

(define (get-endereco-cliente conexao) 
    (vector-ref (endereco-conexao conexao) 3))

(define (imprime-endereco-e-porta-servidor conexao)
    (printf "\nServidor: Endereco: ~a Porta: ~a\n" 
    (get-endereco-servidor conexao) 
    (get-porta-servidor conexao)))

(define (imprime-endereco-e-porta-cliente conexao)
    (printf "\nCliente: Endereco: ~a Porta: ~a\n" 
        (get-endereco-cliente conexao) 
        (get-porta-cliente conexao)))

        