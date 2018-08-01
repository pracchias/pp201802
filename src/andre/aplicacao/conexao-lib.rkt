#lang racket
(require racket/tcp)

(provide server-name)
(provide portas-jogo)
(provide conecta-em)
(provide espera-conexao-em)
(provide get-in)
(provide get-out)

(provide  porta-distribuidor)

(define server-name "localhost")
(define portas-jogo '(39055 39002 39003 39004 39005 39006))
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
