#lang racket
(require racket/tcp)

(provide server-name)
(provide portas-jogo)
(provide conecta-em)
(provide porta-jogo)
(provide espera-conexao-em)
(provide get-in)
(provide get-out)
(provide tenta-conectar)

(provide  porta-distribuidor)

(define server-name "localhost")
(define portas-jogo '(39055 39002 39003 39004 39005 39006))
(define porta-jogo 45002)
(define  porta-distribuidor 45241)

(define (conecta-em servername porta) 
    (define-values (in out) (tcp-connect servername porta))
    (cons in out))

(define (espera-conexao-em porta)
    (define listener (tcp-listen porta))
    (define-values (in out) (tcp-accept listener))
    (cons in out))

(define (get-in portas) (car portas))
(define (get-out portas) (cdr portas))





(define (tenta-conectar server lista-de-portas)
    (cond [(null? lista-de-portas) (display "Não há vagas nesse servidor. Tente outro.\n ")]
        [else 
            (with-handlers ([exn:fail? (lambda (exn) (tenta-conectar server (cdr lista-de-portas)))]) ; se não conseguir conectar, tenta conectar na proxima porta.
                (printf "Tentando conectar na porta ~a\n" (car lista-de-portas))
                (define-values (sin sout) (tcp-connect server-name (car lista-de-portas)))
                (printf "Conectado em ~a\n" (car lista-de-portas))
                (cons sin sout))]))
