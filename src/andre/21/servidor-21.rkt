#lang racket
(require "conexao-lib.rkt")

(require "blackjack-msgs.rkt")
(require "blackjack-rules.rkt")

(define (aguarda-jogador)
    (define portas (espera-conexao-em porta-jogo))
    (inicia-jogo (get-in portas) (get-out portas)))



(define (inicia-jogo entrada saida)
    (define-values (baralho mao-jogador mao-dealer) (distribui-cartas))
    (define estado-jogo 'running)
    (envia-mensagem (prepara-mensagem mao-jogador mao-dealer estado-jogo) saida)
    (processa-resposta entrada saida baralho mao-jogador mao-dealer estado-jogo))
    ;(displayln "Fim do teste1"))
    
(define (distribui-cartas)    
    (define baralho (novo-baralho))
    
    (define mao-jogador (list (first baralho) (second baralho)))
    (define mao-dealer (list (third baralho) (fourth baralho)))
    (define baralho-apos-compras (cdr (cdr (cdr (cdr baralho)))))
    (values baralho-apos-compras mao-jogador mao-dealer))

(define (processa-resposta entrada saida  baralho mao-jogador mao-dealer estado-jogo)
    (define resposta (read entrada))
    (printf "Mensagem recebida: ~a\n" resposta)
    (cond [(respondeu-hit? resposta) (processa-hit entrada saida baralho mao-jogador mao-dealer estado-jogo)]
        [(respondeu-stop? resposta) (processa-stop entrada saida baralho mao-jogador mao-dealer estado-jogo)]
        [(respondeu-sair? resposta) (processa-sair entrada saida)]
        [else (display "Mensagem nao reconhecida: ") (write resposta) (displayln)]))


(define (processa-hit entrada saida baralho mao-jogador mao-dealer estado-jogo)
    (displayln "Processando Hit")
    (define-values (novo-baralho nova-mao) (comprar baralho mao-jogador))
    (define novo-estado (if (mao-estourou? nova-mao) 'jogador-estourou 'running))
    (envia-dados-jogador saida nova-mao mao-dealer novo-estado)
    (processa-resposta entrada saida novo-baralho nova-mao mao-dealer novo-estado))
    
(define (processa-stop entrada saida baralho mao-jogador mao-dealer estado-jogo)
    (displayln "Processando Stop")
    (define-values (novo-baralho nova-mao-dealer estado-dealer) (ia-dealer baralho mao-dealer))

    (define novo-estado 
        (cond [(mao-estourou? mao-dealer) 'jogador-ganhou]
             [(compara estado-dealer 'dealer-parou) (compara-maos mao-jogador nova-mao-dealer)]
             [else 'jogador-parou]))

    (envia-dados-jogador saida mao-jogador nova-mao-dealer novo-estado)
    (processa-resposta entrada saida novo-baralho mao-jogador nova-mao-dealer novo-estado))


; Volta a esperar outro jogador.
(define (processa-sair entrada saida)
    (display "Fechando portas... ")
    (close-input-port entrada)
    (close-output-port saida)
    (displayln "Portas fechadas. Encerrando servidor.")
    (exit))

;;; (define (loop-respostas entrada saida mao-jogador mao-dealer estado-jogo)
;;;     (displayln "Aguardando resposta... ")
;;;     (define resposta (read entrada))
;;;     (display "Resposta recebida: ")
;;;     (write resposta)
;;;     (displayln "")
;;;     (envia-dados-jogador saida mao-jogador mao-dealer estado-jogo)
;;;     (loop-respostas entrada saida mao-jogador mao-dealer estado-jogo))

(define (envia-dados-jogador saida mao-jogador mao-dealer estado-jogo)
    (envia-mensagem (prepara-mensagem mao-jogador mao-dealer estado-jogo) saida))

(define (prepara-mensagem mao-jogador mao-dealer estado-jogo)
    (display "Enviando mao-jogador: ")
    (write mao-jogador) (displayln " ")
    (display "Enviando mao-dealer: ")
    (write mao-dealer) (displayln " ")
    (display "Enviando estado-do-jogo: ")
    (write estado-jogo) (displayln " ")
    
    (list mao-jogador mao-dealer estado-jogo))

(displayln "Iniciando servidor.")
(aguarda-jogador)    
(displayln "Finalizando servidor.")