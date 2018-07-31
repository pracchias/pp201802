#lang racket 

(require "conexao.rkt")

(displayln "\nIniciando servidor. Versao 0.1\n")
(define porta-servidor 8080)


(define (serve port-no)
   (define listener (tcp-listen port-no))
    (define (loop)
        (display " main-loop ")
        (define-values (in out) (tcp-accept listener))
        (file-stream-buffer-mode out 'none)
        (thread (lambda () (acolhe-conexao in out)))
        (loop))
    (loop))


(define (processa-entrada texto out)
            (envia-mensagem texto out)
            (displayln texto out)
            (flush-output (current-output-port)))


(define (acolhe-conexao in out)
    (nova-conexao in)
    (loop-de-processo in out))

(define (loop-de-processo in out)
    (processa-entrada (read-line in) out)
    (loop-de-processo in out))

(define (nova-conexao porta) 
    (imprime-endereco-e-porta-cliente porta))
    
(serve porta-servidor)
