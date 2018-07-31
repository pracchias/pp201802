#lang racket
(require racket/tcp)

(define porta-servidor 8080)
(define hostname "localhost")


(define (serve port-no)
  (define main-cust (make-custodian))
  (parameterize ([current-custodian main-cust])
    (define listener (tcp-listen port-no 5 #t))
    (define (loop)
      (redirect listener)
      (loop))
    (thread loop))
  (lambda ()
    (custodian-shutdown-all main-cust)))


(define (redirect listener)
    (printf "Redirecionando listener ~a\n" listener)
    (define-values (cliente-in cliente-out) (tcp-accept listener))
    (printf "Conectado ao cliente.")
    (start-msgs cliente-out)
    

    ;;; (define-values 
    ;;;     (end-local 
    ;;;     end-remoto
    ;;;     porta-local
    ;;;     porta-remota) 
    ;;;     (tcp-address cliente-in #t))
    ;(display (tcp-address listener))
    
    ;;; (define redir-custodian (make-custodian))
    ;;; (parameterize ([current-custodian redir-custodian])
        
    ;;; (define-values (in out) (tcp-connect end-remoto porta-remota))
    ;;; (define (loop)
    ;;;     (handle in out)
    ;;;     (loop))
    ;;; (thread loop)))
)

;;; (define (handle in out)
;;;     (display (string-upcase (read in)) out)
;;;     (flush-output out))

(define stop (serve porta-servidor))

(define (send-msg out)
    (display "s" out)
    (display "s")
    (flush-output out))

(define (start-msgs out) 
    (display "Iniciando procedimento de envio de mensagens")
    (thread (lambda ()
        (define (l)
            ((send-msg out)
            (sleep 0.5)
            (l)))
        (l))))

(serve porta-servidor)
