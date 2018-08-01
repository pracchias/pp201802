#lang racket
(require racket/tcp)

(define porta-servidor 8080)
(define hostname-servidor "localhost")

(define-values (cin cout) (tcp-connect hostname-servidor porta-servidor))


    ;;; ((displayln "definindo valores de cin e cout")
    ;;; (displayln "tentando se conectar.")
    ;;; (define-values 
    ;;;     (start-in start-out) 
    ;;;     (tcp-connect hostname-servidor porta-servidor))
    ;;; (displayln "Conectado no servidor")
    ;;; (displayln "[C] Conectado ao cliente." start-out)
    ;;; (define listener (tcp-listen port-no 5 #t))
    ;;; (tcp-accept listener)))
    


(define (envia-mensagem)
    (display (read) cout)
    (flush-output cout)
    (display "... mensagem enviada."))

(define (recebe-mensagem)
    (if (byte-ready? cin) 
        (imprime (read-line cin))
        (imprime ".")))

(define (imprime msg) (displayln msg))

(define (loop-recebe)
    ((recebe-mensagem)
    (sleep 0.5)
    (loop-recebe)))

(define (receiver-t)
    (thread loop-recebe))

(define (main)
    (envia-mensagem)
    (main))

(define (start) 
    (receiver-t)
    (main))

(display "Iniciando cliente")
(start)    