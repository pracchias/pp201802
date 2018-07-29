#lang racket
(require racket/tcp)
(require "conexao.rkt")


(define hostname-servidor "localhost")

(define-values (sin sout) (tcp-connect hostname-servidor porta-servidor))



(display "Tentando enviar uma mensagem.\n")
(envia-mensagem '"Uma mensagem grande e complicada." sout)
(display "Mensagem Enviada.\n")
(display "Tentando ler...\n")
(displayln (read-line sin))
(display "Sucesso!...\n")

(display (endereco-conexao sin))
(printf "\nPorta ~a " (get-porta-servidor sin))
(printf "Endereco ~a\n " (get-endereco-servidor sin))