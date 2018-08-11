#lang racket
(require racket/tcp)

(provide server-name)
(provide porta-jogo)

(provide espera-conexao-em)
(provide get-in)
(provide get-out)
(provide tenta-conectar)
(provide envia-mensagem)

(displayln "Carregando biblioteca de conexao.\n")

(define server-name "localhost")
(define porta-jogo 45002)

(define (espera-conexao-em porta)
    (define listener (tcp-listen porta))
    (define-values (in out) (tcp-accept listener))
    (cons in out))

(define (get-in portas) (car portas))
(define (get-out portas) (cdr portas))

(define (envia-mensagem msg out)
 ;;;;   (printf "Enviando msg ~a na porta ~a \n" msg out)
    (write msg out)
    (flush-output out) )
 ;;;;   (printf "Mensagem enviada.\n"))

(define (tenta-conectar server porta)
    (with-handlers ([exn:fail? (lambda (exn) (displayln "Não foi possível conectar no servidor."))])
        (printf "Tentando conectar na porta ~a\n" porta)
        (define-values (sin sout) (tcp-connect server-name porta))
        (printf "Conectado em ~a\n" porta)
        (cons sin sout)))
